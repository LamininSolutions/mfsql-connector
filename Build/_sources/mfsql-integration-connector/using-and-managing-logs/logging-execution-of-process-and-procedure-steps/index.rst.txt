Logging execution of Process and Procedure Steps
================================================

Summary of logging function
---------------------------

#. When procedure is called it will assess if the it was called directly or by another procedure. Procedures with a parameter @ProcessBatch_ID int = null would be a procedure that can be called by another procedures and pass through the ProcessBatch_ID. If the ProcessBatch_ID is null, then it is regarded as a new process with a separate ProcessBatch_ID, else the parameter passed through will be set as the ProcessBatch_ID for the underlying process.
#. The calling procedure will pass through the ProcessBatch_ID.  A new ProcessBatch_ID will be created in table MFProcessBatch if no ProcessBatch_ID is passed through (the @processBatch_ID is null) by calling :doc:`/procedures/spMFProcessBatch_Upsert`. This procedure will create a new log entry and return the new ProcessBatch_ID.
#. As part of processing through the procedures, records will be inserted into MFProcessBatchDetail on the execution of steps to record the outcome of these steps. This is done by calling :doc:`/procedures/spMFProcessBatchDetail_Insert`
#. When calling another procedure from with a procedure, the ProcessBatch_ID is passed through to the new procedure using the @ProcessBatch_ID parameter of the called procedure. This will allow the secondary procedure to form part of one procedure batch and enable all the logs in MFProcessBatchDetail to form part of the same batch.
#. On completion of the main procedure the process will be ended by calling :doc:`/procedures/spMFProcessBatch_Upsert` again passing in the current @ProcessBatch_id with a completion message. This will update the final entry in MFProcessBatch to record the outcome of the process. Usually a final log to the MFProcessBatchDetail is recorded at the same time.

When a context menu action is executed, the VAF will automatically create a new ProcessBatch_ID, and make an entry in both MFProcessBatch and MFProcessBatchDetail.  When the procedure is called by the action, it will pass through the ProcessBatch_ID to the called procedure, which in turn can then pass it through to any sub procedures called during the action operation. On completion of the context menu task the VAF will log a completion entry in both logging tables.

When checking MFProcessBatch table for the most recent logs during processing, one can observe if a process is still running or completed successfully.  When checking the detail processes in the MFProcessBatchDetail table for the specific ProcessBatch_ID, one can review the processes completed and the result of the different sub processes.

Logging for standard procedures
-------------------------------

All the main standard procedures in the Connector is setup to log entries to the logging tables. Interpreting the logs depends on the process originating the logging. The columns and how they are used are set out in the sections :doc:`/tables/tbMFProcessBatch` and :doc:`/tables/tbMFProcessBatchDetail`

The main purpose of the logs is to allow for backtracking on processes and to monitor and evaluate performance.  The helper procedure :doc:`/procedures/spMFGetProcedurePerformance` will produce a number of analytic tables to evaluate performance for a specific processbatch_ID.

Logging for custom procedures
-----------------------------

It is recommended to apply the logging mechanism to custom procedures also.  Guidance on using the logging is in the section :doc:`/mfsql-integration-connector/using-and-managing-logs/logging-in-custom-procedures/index`

Setting switch to use process logging
=====================================

MFSettings table contains a switch 'App_DetailLogging' set by default to
0.  To enable logging to MFProcessBatch and MFProcessBatchDetail the
switch must be set to 1.
