
Custom Procedure - DoVendorUpsert
=================================

This is a sample procedure for updating vendors from ERP

.. code:: sql

	set ansi_nulls on;
	go
	set quoted_identifier on;
	go

	alter procedure Custom.DoVendorUpsert
		@ID int = null
	  , @OutPut varchar(1000) output
	  , @ProcessBatch_ID int = null output
	  , @ObjectID int = null
	  , @ObjectType int = null
	  , @ObjectVer int = null
	  , @ClassID int = null
	  , @Debug smallint = 0
	as
	begin
		declare @MFClassTable nvarchar(128);
		declare @SQLQuery nvarchar(max);
		declare @Params nvarchar(max);

		begin try
			set nocount on;

			-------------------------------------------------------------
			-- CONSTANTS: MFSQL Class Table Specific
			-------------------------------------------------------------
			declare @MFTableName as nvarchar(128) = N'MFVendor';
			declare @ProcessType as nvarchar(50);

			set @ProcessType = isnull(@ProcessType, 'Update Vendor from ERP');

			declare @procedureName nvarchar(128) = N'custom.[DoVendorUpsert]';
			declare @ProcedureStep nvarchar(128);

			-------------------------------------------------------------
			-- CONSTATNS: MFSQL Global 
			-------------------------------------------------------------
			declare @UpdateMethod_1_MFilesToMFSQL tinyint = 1;
			declare @UpdateMethod_0_MFSQLToMFiles tinyint = 0;
			declare @Process_ID_1_Update tinyint = 1;
			declare @Process_ID_6_ObjIDs tinyint = 6; --marks records for refresh from M-Files by objID vs. in bulk
			declare @Process_ID_9_BatchUpdate tinyint = 9; --marks records previously set as 1 to 9 and update in batches of 250
			declare @Process_ID_Delete_ObjIDs int = -1; --marks records for deletion
			declare @Process_ID_2_SyncError tinyint = 2;
			declare @ProcessBatchSize int = 250;

			-------------------------------------------------------------
			-- VARIABLES: MFSQL Processing
			-------------------------------------------------------------
			declare @Update_ID int;
			declare @MFLastModified datetime;
			declare @Validation_ID int;

			-------------------------------------------------------------
			-- VARIABLES: T-SQL Processing
			-------------------------------------------------------------
			declare @rowcount as int = 0;
			declare @return_value as int = 0;
			declare @error as int = 0;

			-------------------------------------------------------------
			-- VARIABLES: DEBUGGING
			-------------------------------------------------------------
			declare @DefaultDebugText as nvarchar(256) = N'Proc: %s Step: %s';
			declare @DebugText as nvarchar(256) = N'';
			declare @Msg as nvarchar(256) = N'';
			declare @MsgSeverityInfo as tinyint = 10;
			declare @MsgSeverityObjectDoesNotExist as tinyint = 11;
			declare @MsgSeverityGeneralError as tinyint = 16;

			-------------------------------------------------------------
			-- VARIABLES: LOGGING
			-------------------------------------------------------------
			declare @LogType as nvarchar(50) = N'Status';
			declare @LogText as nvarchar(4000) = N'';
			declare @LogStatus as nvarchar(50) = N'Started';
			declare @LogTypeDetail as nvarchar(50) = N'System';
			declare @LogTextDetail as nvarchar(4000) = N'';
			declare @LogStatusDetail as nvarchar(50) = N'In Progress';
			declare @ProcessBatchDetail_IDOUT as int = null;
			declare @LogColumnName as nvarchar(128) = null;
			declare @LogColumnValue as nvarchar(256) = null;
			declare @count int = 0;
			declare @Now as datetime = getdate();
			declare @StartTime as datetime = getutcdate();
			declare @StartTime_Total as datetime = getutcdate();
			declare @RunTime_Total as decimal(18, 4) = 0;
			declare @Objids varchar(4000);
			declare @ActionName nvarchar(100);
			declare @Workflow_ID int
			declare @State_ID int
			-------------------------------------------------------------
			-- VARIABLES: DYNAMIC SQL
			-------------------------------------------------------------
			declare @sql nvarchar(max) = N'';
			declare @sqlParam nvarchar(max) = N'';

			-------------------------------------------------------------
			-- INTIALIZE PROCESS BATCH
			-------------------------------------------------------------
			set @ProcedureStep = N'Start Logging';
			set @LogText = N'Processing ' + @procedureName;
			set @output = ''

			exec dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID output
										   , @ProcessType = @ProcessType
										   , @LogType = N'Status'
										   , @LogText = @LogText
										   , @LogStatus = N'In Progress'
										   , @debug = @Debug;

			exec dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID
												 , @LogType = N'Debug'
												 , @LogText = @ProcessType
												 , @LogStatus = N'Started'
												 , @StartTime = @StartTime
												 , @MFTableName = @MFTableName
												 , @Validation_ID = @Validation_ID
												 , @ColumnName = null
												 , @ColumnValue = null
												 , @Update_ID = @Update_ID
												 , @LogProcedureName = @procedureName
												 , @LogProcedureStep = @ProcedureStep
												 -- , @ProcessBatchDetail_ID = @ProcessBatchDetail_IDOUT --v38
												 , @debug = 0;

			-------------------------------------------------------------
			-- BEGIN PROCESS
			-------------------------------------------------------------
			set @DebugText = N'Object id %i';
			set @DebugText = @DefaultDebugText + @DebugText;
			set @ProcedureStep = N'Get Object: ';

			if @Debug > 0
			begin
				raiserror(@DebugText, 10, 1, @procedureName, @ProcedureStep, @ObjectID);
			end;

			--- start of custom process for the action, this example updates keywords property on the object

			set @MFClassTable = N'MFVendor';

			declare @Name_or_Title nvarchar(100);
			declare @ExternalID int;
			declare @ActionType int;

			--get object from M-Files
			declare @MFLastUpdateDate smalldatetime
				  , @Update_IDOut     int;

			if @ObjectID is null
			   and @MFClassTable is not null
			begin
				exec dbo.spMFUpdateMFilesToMFSQL @MFTableName = @MFClassTable
											   , @MFLastUpdateDate = @MFLastUpdateDate output
											   , @UpdateTypeID = 0
											   , @Update_IDOut = @Update_IDOut output
											   , @ProcessBatch_ID = @ProcessBatch_ID
											   , @debug = 0;
			end;

			if @ObjectID is not null
			begin

				set @Objids = cast(@ObjectID as varchar(100));

				exec dbo.spMFUpdateTable @MFTableName = @MFClassTable
									   , @UpdateMethod = 1
									   , @ObjIDs = @Objids
									   , @Update_IDOut = @Update_IDOut output
									   , @ProcessBatch_ID = @ProcessBatch_ID
									   , @Debug = 0;


			end;
		
			select @Workflow_ID = mfid from dbo.MFWorkflow as mw where mw.Alias = 'WF.VendorApproval'
			select @State_ID = mfid from dbo.MFWorkflowState as mws where mws.Alias = 'WFS.VendorApproval.VendorApproved'

			select * from dbo.MFWorkflowState as mws 

			set @DebugText = N'';
			set @DebugText = @DefaultDebugText + @DebugText;
			set @ProcedureStep = N'Select Account to update';

			if @Debug > 0
			begin
				raiserror(@DebugText, 10, 1, @procedureName, @ProcedureStep);
			end;


		
				-------------------------------------------------------------
				-- Update changes from ERP including new vendors in ERP
				--Changes in ERP will take precedence of MF
				-------------------------------------------------------------
		  
				set @ProcedureStep = N'Update MF from ERP';

				if @Debug > 0
				begin
					raiserror(@DebugText, 10, 1, @procedureName, @ProcedureStep);
				end;


		-------------------------------------------------------------
				-- changes from ERP to SQL
				------------------------------------------------------------- 
				with cte
				as (select s.CompanyName
						 , s.Address
						 , s.City
						 , s.PostalCode
						 , s.SupplierID
					from NORTHWND.dbo.Suppliers as s
					inner join mfVendor mv
					on s.SupplierID = mv.Vendor_code
					except
					select mv.Name_Or_Title
						 , substring((mv.Address_Line_1 + ', ' + isnull(mv.Address_Line_2,'')), 1, 60)
						 , mv.City
						 , mv.Postal_Code
						 , mv.ExternalID
					from dbo.MFVendor as mv
					)
				update dbo.MFVendor
				set Process_ID = 1
				  , Name_Or_Title = cte.CompanyName
				  , Address_Line_1 = cte.Address
				  , City = cte.City
				  , Postal_Code = cte.PostalCode
				from dbo.MFVendor as mv
					inner join cte
						on cte.SupplierID = mv.Vendor_code;


										   SET @LogTypeDetail = 'Status';
										   SET @LogStatusDetail = 'debug';
										   SET @LogTextDetail = 'Update Vendor from ERP '  
										   SET @LogColumnName = 'Object';
										   SET @LogColumnValue = @objids;
				
										   EXECUTE @return_value = [dbo].[spMFProcessBatchDetail_Insert]
											@ProcessBatch_ID = @ProcessBatch_ID
										  , @LogType = @LogTypeDetail
										  , @LogText = @LogTextDetail
										  , @LogStatus = @LogStatusDetail
										  , @StartTime = @StartTime
										  , @MFTableName = @MFTableName
										  , @Validation_ID = @Validation_ID
										  , @ColumnName = @LogColumnName
										  , @ColumnValue = @LogColumnValue
										  , @Update_ID = @Update_ID
										  , @LogProcedureName = @ProcedureName
										  , @LogProcedureStep = @ProcedureStep
										  , @debug = @debug
		 
		 set @OutPut = @OutPut + ' action ' + @ActionName;



			if exists(select 1 from MFVendor where process_ID = 1 and objid = @objectID)
			begin
			set @objids = cast(@objectID as varchar(10))
			exec dbo.spMFUpdateTable @MFTableName = @MFClassTable
								  , @UpdateMethod = 0
								  ,@objids = @objids
								   , @Update_IDOut = @Update_ID output
								   , @ProcessBatch_ID = @ProcessBatch_ID
								   , @Debug = 0;

								   end


			-- logging end of process batch
			set @ProcedureStep = N'End Upsert Vendor';
			set @StartTime = getdate();

			exec dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID
										   , @ProcessType = @procedureName
										   , @LogType = N'Debug'
										   , @LogText = @OutPut
										   , @LogStatus = N'Completed'
										   , @debug = 0; 

			exec dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID
												 , @LogType = N'Message'
												 , @LogText = @OutPut
												 , @LogStatus = N'Success'
												 , @StartTime = @StartTime
												 , @MFTableName = @MFClassTable
												 , @Validation_ID = null
												 , @ColumnName = null
												 , @ColumnValue = null
												 , @Update_ID = null
												 , @LogProcedureName = @procedureName
												 , @LogProcedureStep = @ProcedureStep
												 , @debug = 0;


			--send confirmation email
			declare @RecipientEmail nvarchar(100);
			declare @RecipientFromMFSettingName nvarchar(100);

			select @RecipientFromMFSettingName = cast(Value as nvarchar(100)) from mfSettings where name = 'SupportEmailRecipient'

			select @RecipientEmail = mla.EmailAddress
			from dbo.MFContextMenu            as mcm
				inner join dbo.MFLoginAccount as mla
					on mcm.Last_Executed_By = mla.MFID;

					if @RecipientEmail is not null
					Begin
			exec dbo.spMFProcessBatch_EMail @ProcessBatch_ID = @ProcessBatch_ID
										  , @RecipientEmail = @RecipientEmail
										  , @RecipientFromMFSettingName = @RecipientFromMFSettingName
										  , @ContextMenu_ID = @ID
										  , @DetailLevel = 1
										  , @LogTypes = 'Message'
										  , @Debug = 0;
					end
		   

			-------------------------------------------------------------
			--END PROCESS
			-------------------------------------------------------------
			END_RUN:
			set @ProcedureStep = N'End';
			set @ProcessType = N'Completed';
			set @LogStatus = N'Completed';

			-------------------------------------------------------------
			-- Log End of Process
			-------------------------------------------------------------   
			exec dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID output
										   , @ProcessType = @ProcessType
										   , @LogType = N'Message'
										   , @LogText = @LogText
										   , @LogStatus = @LogStatus
										   , @debug = @Debug;

			set @StartTime = getutcdate();

			exec dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID
												 , @LogType = N'Debug'
												 , @LogText = @ProcessType
												 , @LogStatus = @LogStatus
												 , @StartTime = @StartTime
												 , @MFTableName = @MFTableName
												 , @Validation_ID = @Validation_ID
												 , @ColumnName = null
												 , @ColumnValue = null
												 , @Update_ID = @Update_ID
												 , @LogProcedureName = @procedureName
												 , @LogProcedureStep = @ProcedureStep
												 , @debug = 0;

		 
		 return 1;
		end try
		begin catch
			set @StartTime = getutcdate();
			set @LogStatus = N'Failed w/SQL Error';
			set @LogTextDetail = error_message();

			 --reset is process running
			update dbo.MFContextMenu
			set IsProcessRunning = 0
			where ID = @ID;

			--------------------------------------------------
			-- INSERTING ERROR DETAILS INTO LOG TABLE
			--------------------------------------------------
			insert into dbo.MFLog
			(
				SPName
			  , ErrorNumber
			  , ErrorMessage
			  , ErrorProcedure
			  , ErrorState
			  , ErrorSeverity
			  , ErrorLine
			  , ProcedureStep
			)
			values
			(@procedureName, error_number(), error_message(), error_procedure(), error_state(), error_severity()
		   , error_line(), @ProcedureStep);

			set @ProcedureStep = N'Catch Error';

			-------------------------------------------------------------
			-- Log Error
			-------------------------------------------------------------   
			exec dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID 
										   , @ProcessType = @ProcessType
										   , @LogType = N'Error'
										   , @LogText = @LogTextDetail
										   , @LogStatus = @LogStatus
										   , @debug = @Debug;

			set @StartTime = getutcdate();

			exec dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID
												 , @LogType = N'Error'
												 , @LogText = @LogTextDetail
												 , @LogStatus = @LogStatus
												 , @StartTime = @StartTime
												 , @MFTableName = @MFTableName
												 , @Validation_ID = @Validation_ID
												 , @ColumnName = null
												 , @ColumnValue = null
												 , @Update_ID = @Update_ID
												 , @LogProcedureName = @procedureName
												 , @LogProcedureStep = @ProcedureStep
												 , @debug = 0;

			return -1;
		end catch;
	end;
