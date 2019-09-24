spMFProcessBatchDetail_insert for process logging
=================================================

| 

The spMFProcessBatchDetail_Insert procedure will add a record to the
MFProcessBatchDetail table.  This procedure is executed for ispecific
procdure steps

The columns to be populated will depend on the nature of the sub
procedure that is monitored.

| 

.. container:: table-wrap

   ============== ============================================
   Type           Description
   ============== ============================================
   Procedure Name spMFProcessBatchDetail_Insert
   Inputs         | ProcessBatch_ID
                  | LogType
                  | LogText
                 
                  | LogStatus
                  | StartTime
                  | MFTableName
                  | Validation_ID
                  | ColumnName
                  | ColumnValue
                  | Update_ID
                  | LogProcedureName
                  | LogProcedureStep
                 
                  | ProcessBatchDetail)ID output
                  | debug = Debug Mode; 0 = No Debug (default)
                 
                  Debug: 1 =
   Outputs        1 = success
   ============== ============================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

           SET @ProcedureStep = 'Prepare Table';
                                    SET @LogTypeDetail = 'Status';
                                    SET @LogStatusDetail = 'Start';
                                    SET @LogTextDetail = 'For UpdateMethod ' + CAST(@UpdateMethod AS VARCHAR(10));
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
             , @ProcessBatchDetail_ID =   @ProcessBatchDetail_ID output
                                   , @debug = @debug

| 



Usage of columns in MFProcessBatchDetail
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. container:: table-wrap

   ===================== ====================================================================================================================================================================================================================================================================================================================
   Parameter             Application
   ===================== ====================================================================================================================================================================================================================================================================================================================
   ProcessBatch_ID       Set to ProcessBatch_ID output of the calling procedure
   Logtype               Type of logging: e.g.
                        
                         -  Status
                         -  Error
                         -  Message
   LogText               include inputs or outputs of logging step
   LogStatus             Indicate status of log e.g.
                        
                         -  Start
                         -  In Progress
                         -  Complete
   StartTime             Set to GETUTCDATE()
   MFTableName           use the table name for the for the specific process
   Validation_ID         Use this for a custom table with validation errors
   ColumnName            Show the name of the column for the value in ColumnValue
   ColumnValue           Show value such as count of records / count of errors etc
   Update_ID             Set to Update_ID output from from the calling procedure
   LogProcedureName      Set to the name of the procedure that is currently running
   LogProcedureStep      Set to a description of the procedure step that is currently being executed
   ProcessBatchDetail_ID Add ProcessBatchDetail_ID as parameter to allow for calculation of duration if provided based on input of a specific ID. Procedure will use input to override the passed int StartDate and get start date from the ID provided. This will allow calculation of DurationInSecords seconds on a detail procedure level
   ===================== ====================================================================================================================================================================================================================================================================================================================

| 

| 
