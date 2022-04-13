Logging in custom procedures
============================

The logging tables MFprocessBatch and MFProcessBatchDetail are widely used for logging the Connector standard procedures.

These tables can also be used, in conjunction with the logging of the standard procedures to include operations in custom procedures. This is particularly relevant when a custom procedures controls many different operations.

ProcessBatch
------------

It is good practice to use the same ProcessBatch_ID for all the sub processes in a procedure. This is achieved by creating a new ProcessBatch_ID early on in the customer procedure, and then to pass through this id to all standard procedures that is called by the custom procedure.  This will ensure that all the detail steps will be grouped together with a single ProcessBatch_ID.

Call :doc:`/procedures/spMFProcessBatch_Upsert/`. This procedure outputs a new ProcessBatch_ID.  Check out the procedure documentation for more details on the recommended use of the parameters.

.. code:: sql

    DECLARE @ProcessBatch_ID INT ;

    EXEC [dbo].[spMFProcessBatch_Upsert]
               @ProcessBatch_ID = @ProcessBatch_ID OUTPUT
              ,@ProcessType = 'Create'
              ,@LogText = 'Procedure name'
              ,@LogStatus = 'Start'
              ,@debug = 0

Pass the ProcessBatch_ID into any standard procedure that have the parameter ProcessBatch_ID as one of its parameters.  If the this is not done, the standard procedure will create a new processBatch_ID for its own logging.  By passing this id through, all the standard procedure detail logging will be grouped together with one processbatch_ID.

Finally, call this procedure again at the end of the custom procedure to close the processbatch log and allow for the duration of the entire process to be calculated and updated in the MFProcessBatch table.
It is important to remember to remove the OUTPUT and to pass in the processBatch_ID of the custom procedure and the set the logstatus to 'Completed'. This triggers the duration calculation.

.. code:: sql

    DECLARE @ProcessBatch_ID INT ;

    EXEC [dbo].[spMFProcessBatch_Upsert]
               @ProcessBatch_ID = @ProcessBatch_ID
              ,@ProcessType = 'Debug'
              ,@LogText = 'Procedure Name'
              ,@LogStatus = 'Completed'
              ,@debug = 0

The result is in the MFProcessBatch table

.. code:: sql

    Select * from MFProcessBatch order by ProcessBatch_ID desc

If the logStatus = 'Message' and the logtype is either 'Completed' or 'Error' or 'Fail' a trigger on the MFprocessBatch table will call the procedure spMFInsertUserMessage to activate the :doc:`/mfsql-integration-connector/user-messages/index` functionality.

ProcessBatchDetail
------------------

The :doc:`/tables/tbMFProcessBatchDetail/` allows for logging sub process steps and is used in conjunction with MFProcessBatch.  By obtaining and then passing through the processbatch_id into the processbatchdetail one can tie all the sub processes together.

it is good practice to add a processbatchdetail entry in the MFProcessBatchDetail table when at the start and end of long running sub processes and to highlight the outcome of key steps in the process. This is accomplished with the :doc:`/procedures/spMFProcessBatchDetail_insert`.

Copy the following snippet into your custom procedure where ever a sub process must be logged. Read more in die documentation of :doc:`/procedures/spMFProcessBatchDetail_insert` about the use of the different parameters.

.. code:: sql

       SET @ProcedureStep = '';
       SET @LogTypeDetail = 'Status';
       SET @LogStatusDetail = '';
       SET @LogTextDetail = ''
       SET @LogColumnName = '';
       SET @LogColumnValue = '';

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

This procedure is extensively used in the standard procedures to log sub processes. Review these procedures to get more examples of using sub process logging in custom procedures.
