Prevent agent job to run
========================

When scheduling jobs it may be necessary to prevent an operation to executed before the previously called job has finished. This would require a mechanism for checking if job is running and if running, waits for
given 'WaitTime' and checks again, in a loop. If the job is not running, the process should complete.  This is particularly relevant when multiple users can call the same operation using the context menu actions in M-Files.

In the following example we use the process of updating all class tables on a regular basis as the use case.

This use case has 4 elements

  #.  procedure that performs the main operation - for example to update all class tables
  #.  secondary procedure to action the main procedure - this will be added to the context menu as the procedure that the users will action. This procedure executes a job
  #.  job agent call by secondary procedure to maintain the wait status - this job only executes if the next job is no longer running
  #. job agent that will call the main procedure. This is called by the previous job only when it is no longer running.

Following are several code examples to illustrate

 - creating the calling procedure
 - creating the agent job for controlling the wait status
 - creating the agent job to call the operating procedure

In addition, the procedure custom.DoUpdateReportingData, installed with the deployment package, is an example of a main procedure. This particular procedure updates all class tables.

Creating the procedure spMFStart_job_wait
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Copy the create script to a new query and execute to create the procedure spMFStart_job_wait.

Once the given job completes execution, this stored procedure will exit
with a return code for the status of the job being watched

Return Codes
Failed		= 0
Successful	= 1
Cancelled	= 3

The procedure below can be tested with these scripts

.. code:: SQL

		DECLARE @RetStatus int
		exec custom.Start_job_wait 'MFSQL_DoUpdateReportingData_OnDemand','00:00:01',@RetStatus OUTPUT
		select @RetStatus

or

.. code:: SQL

		exec custom.Start_job_wait 'zzzDBATest'

create custom.Start_job_wait script

.. code:: SQL

			IF ISNULL(OBJECT_ID('custom.Start_job_wait'), 0) = 0
				EXEC ( 'create procedure custom.Start_job_wait as print ''temporary procedure to hold location so we can use ALTER in the script''' )
			GO

			ALTER PROCEDURE [custom].[Start_job_wait]
			(
					@job_name			 sysname
				  , @WaitTime			 DATETIME = '00:00:05' -- this is parameter for check frequency
				  , @RunStatus INT	  = NULL OUTPUT
			  	  , @RunOutcomeMessage NVARCHAR(4000)	  = NULL OUTPUT
				  , @Debug INT = 0

				)
			AS
				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET NOCOUNT ON

				-- DECLARE @job_name	sysname
				DECLARE @job_id UNIQUEIDENTIFIER
				DECLARE @job_owner sysname
				DECLARE @return_value INT
				DECLARE @error INT


			--Createing TEMP TABLE
			CREATE TABLE [#xp_results]
					(
						[job_id]				UNIQUEIDENTIFIER NOT NULL
					  , [last_run_date]			INT				 NOT NULL
					  , [last_run_time]			INT				 NOT NULL
					  , [next_run_date]			INT				 NOT NULL
					  , [next_run_time]			INT				 NOT NULL
					  , [next_run_schedule_id]	INT				 NOT NULL
					  , [requested_to_run]		INT				 NOT NULL -- BOOL
					  , [request_source]		INT				 NOT NULL
					  , [request_source_id]		sysname			 COLLATE DATABASE_DEFAULT NULL
					  , [running]				INT				 NOT NULL -- BOOL
					  , [current_step]			INT				 NOT NULL
					  , [current_retry_attempt] INT				 NOT NULL
					  , [job_state]				INT				 NOT NULL
					)

			SELECT @job_id = [job_id]
				FROM   [msdb].[dbo].[sysjobs]
				WHERE  [name] = @job_name

			SELECT @job_owner = SUSER_SNAME()

			INSERT INTO [#xp_results]
			EXECUTE @return_value = [master].[sys].[xp_sqlagent_enum_jobs] 1, @job_owner, @job_id

			SET @error = @@ERROR
			IF @error <> 0 OR @return_value <> 0
			GOTO ErrorHandler

			-- Start the job if the job is not running
			IF NOT EXISTS ( SELECT TOP 1 * FROM [#xp_results] WHERE [running] = 1 )
					EXEC @return_value = [msdb].[dbo].[sp_start_job] @job_name = @job_name

			SET @error = @@ERROR
			IF @error <> 0 OR @return_value <> 0
					GOTO ErrorHandler

			-- Give 2 sec for think time.
			WAITFOR DELAY '00:00:02'

			DELETE FROM [#xp_results]
			INSERT INTO [#xp_results]
			EXECUTE [master].[sys].[xp_sqlagent_enum_jobs] 1, @job_owner, @job_id
				SET @error = @@ERROR
				IF @error <> 0 OR @return_value <> 0
			GOTO ErrorHandler

			WHILE EXISTS ( SELECT TOP 1 * FROM [#xp_results] WHERE [running] = 1 )
					BEGIN

			WAITFOR DELAY @WaitTime

			-- Information
						RAISERROR('... still running', 0, 1)WITH NOWAIT

						DELETE FROM [#xp_results]

						INSERT INTO [#xp_results]
						EXECUTE [master].[sys].[xp_sqlagent_enum_jobs] 1
																	 , @job_owner
																	 , @job_id

			END


			DECLARE @insance_id INT
					,	@message NVARCHAR(4000)
					,	@run_datetime DATETIME
					,   @run_duration VARCHAR(20)

			SELECT @insance_id = MAX(instance_id)
			FROM [msdb].[dbo].[sysjobhistory]
			WHERE [job_id] = @job_id
			AND [step_id] = 0

			SET @insance_id = ISNULL(@insance_id,-1)

			SELECT
					  @RunStatus	= [run_status]
					, @message		= [message]
					, @run_datetime = [msdb].[dbo].[agent_datetime]([run_date], [run_time])
					, @run_duration = STUFF(
										  STUFF(
											  REPLACE(STR([run_duration], 6, 0), ' ', '0'), 3
											, 0, ':'), 6, 0, ':')
				FROM  [msdb].[dbo].[sysjobhistory]
				WHERE [job_id] = @job_id AND [instance_id] = @insance_id

			SET @RunOutcomeMessage = ISNULL(@message,'') + '; Run Date: ' + CONVERT(VARCHAR(30),ISNULL(@run_datetime,'')) + '; Duration: ' + ISNULL(@run_duration,'')
			RAISERROR('... %s', 0, 1,@RunOutcomeMessage)WITH NOWAIT

			RETURN @RunStatus

			ErrorHandler:
			BEGIN
				SET @RunStatus = -1
							 RAISERROR(
								 '[ERROR]:%s job is either failed or not in good state. Please check'
							   , 16, 1, @job_name)WITH LOG

			RETURN @RunStatus
			END
			GO

Agent job MFSQL_WaitStatus_Jobs for starting job and wait
---------------------------------------------------------

The following script creates a SQL Agent Job to call the operating procedure  dbo.spMFStart_job_wait to prevent running an update if it is already in progress.

.. warning:: Update the variables in the script for login, server and database before executing the script

.. code:: sql

			USE [msdb]
			GO

			SET NOCOUNT ON

      --VARIABLES : adjust these settings for your server
			DECLARE @RunAsLogin NVARCHAR(100) = N''
			DECLARE @ServerName NVARCHAR(100) = N''
			DECLARE @DatabaseName NVARCHAR(100) = N''

			DECLARE @jobId BINARY(16)
			DECLARE @JobName NVARCHAR(100) = N'MFSQL_WaitStatus_Jobs'
			DECLARE @JobDescription NVARCHAR(100) = N'Scheduled job to run wait status jobs every hour during day time'
			DECLARE @StepName NVARCHAR(100) = N'UpdateReportData'
			DECLARE @Command NVARCHAR(Max) = N'
			DECLARE @RetStatus int
			exec custom.Start_job_wait ''MFSQL_DoUpdateReportingData_OnDemand'',''00:00:10''
			'

			IF NOT EXISTS (SELECT * FROM [dbo].[sysjobs] AS [s] WHERE name = @JobName)
			Begin
			EXEC  msdb.dbo.sp_add_job @job_name=@JobName,
					@enabled=1,
					@notify_level_eventlog=0,
					@notify_level_email=2,
					@notify_level_page=2,
					@delete_level=0,
					@description= @JobDescription,
					@category_name=N'[Uncategorized (Local)]',
					@owner_login_name=@RunAsLogin, @job_id = @jobId OUTPUT,
					@notify_email_operator_name=N'',
					@notify_page_operator_name=N''
			select @jobId ;

			EXEC msdb.dbo.sp_add_jobserver @job_name=@JobName, @server_name = @ServerName


			EXEC msdb.dbo.sp_add_jobstep @job_name=@JobName, @step_name= @StepName,
					@step_id=1,
					@cmdexec_success_code=0,
					@on_success_action=1,
					@on_fail_action=2,
					@retry_attempts=0,
					@retry_interval=0,
					@os_run_priority=0, @subsystem=N'TSQL',
					@command=@Command
					,
					@database_name=@DatabaseName,
					@flags=0

			DECLARE @schedule_id int
			EXEC msdb.dbo.sp_add_jobschedule @job_name=@JobName, @name=N'Run on hourly interval',
					@enabled=1,
					@freq_type=4,
					@freq_interval=1,
					@freq_subday_type=8,
					@freq_subday_interval=1,
					@freq_relative_interval=0,
					@freq_recurrence_factor=1,
					@active_start_date=20181119,
					@active_end_date=99991231,
					@active_start_time=700,
					@active_end_time=180000, @schedule_id = @schedule_id OUTPUT
			select @schedule_id

			END
			ELSE
			PRINT @JobName + ' job already exists'
			SELECT [s].[job_id] FROM [dbo].[sysjobs] AS [s] WHERE name = @JobName
			GO

Agent job MFSQL_DoUpdateReportingData_OnDemand for running main procedure
-------------------------------------------------------------------------


The following script creates a SQL Agent Job to call the main procedure. This job is called by MFSQL_WaitStatus_Jobs when the main procedure is no longer running

.. warning:: Update the variables in the script for login, server and database before executing the script

.. code:: sql

			USE [msdb]
			GO

			--VARIABLES : adjust these settings for your server
			DECLARE @RunAsLogin NVARCHAR(100) = N''
			DECLARE @ServerName NVARCHAR(100) = N''
			DECLARE @DatabaseName NVARCHAR(100) = N''

			DECLARE @jobId BINARY(16)
			DECLARE @JobName NVARCHAR(100) = N'MFSQL_DoUpdateReportingData_onDemand'
			DECLARE @JobDescription NVARCHAR(100) = N'Scheduled job to update Reporting Data on demand'
			DECLARE @StepName NVARCHAR(100) = N'UpdateReportData'
			DECLARE @Command NVARCHAR(Max) = N'
			DECLARE @Output          NVARCHAR(400)
			       ,@ProcessBatch_ID INT;

			EXEC custom.[DoUpdateReportingData] @ID = 1
			                                   ,@Output = @Output OUTPUT
			                                   ,@ProcessBatch_ID = @ProcessBatch_ID OUTPUT
			                                   ,@Debug = 0'

			IF NOT EXISTS (SELECT * FROM [dbo].[sysjobs] AS [s] WHERE name = @JobName)
			Begin
			EXEC  msdb.dbo.sp_add_job @job_name=@JobName,
					@enabled=1,
					@notify_level_eventlog=0,
					@notify_level_email=2,
					@notify_level_page=2,
					@delete_level=0,
					@description= @JobDescription,
					@category_name=N'[Uncategorized (Local)]',
					@owner_login_name=@RunAsLogin, @job_id = @jobId OUTPUT,
					@notify_email_operator_name=N'',
					@notify_page_operator_name=N''
			select @jobId ;

			EXEC msdb.dbo.sp_add_jobserver @job_name=@JobName, @server_name = @ServerName


			EXEC msdb.dbo.sp_add_jobstep @job_name=@JobName, @step_name= @StepName,
					@step_id=1,
					@cmdexec_success_code=0,
					@on_success_action=1,
					@on_fail_action=2,
					@retry_attempts=0,
					@retry_interval=0,
					@os_run_priority=0, @subsystem=N'TSQL',
					@command=@Command
					,
					@database_name=@DatabaseName,
					@flags=0

			DECLARE @schedule_id int
			EXEC msdb.dbo.sp_add_jobschedule @job_name=@JobName, @name=N'Run on demand',
					@enabled=0,
					@freq_type=4,
					@freq_interval=1,
					@freq_subday_type=1,
					@freq_subday_interval=1,
					@freq_relative_interval=0,
					@freq_recurrence_factor=1,
					@active_start_date=20181119,
					@active_end_date=99991231,
					@active_start_time=0,
					@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
			select @schedule_id

			END
			ELSE
			PRINT @JobName + ' job already exists'
			SELECT [s].[job_id] FROM [dbo].[sysjobs] AS [s] WHERE name = @JobName
			GO
