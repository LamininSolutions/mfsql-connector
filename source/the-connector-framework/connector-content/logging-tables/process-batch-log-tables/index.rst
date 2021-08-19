Process Batch log tables
========================

Two tables are used to log key events for key procedures. 
MFProcessBatch has a unique reference for each process.  A single record
is created when the process starts and updated with progress of the
process until completion.  The MFProcessBatchDetail records individual
records for key events of each MFProcessBatch.



MFProcessBatch Table
--------------------

   ================== ===================================================================================================================================================== =====
   Column             Usage                                                                                                                                                 Notes
   ================== ===================================================================================================================================================== =====
   [ProcessBatch_ID]  Identity column for process batch id
    [ProcessType]     Update Table, Synchronize Metadata,  (overall process being performed)
    [LogType]         | Status: for log types that indicate status of process to be reported to user;  System: for logtypes that are considered internal operations only;  
                      |   Debug: for log types that are only used for debugging purposes; Message: for log type that need to be reported back to user
    [LogText]         User message
    [Status]          Started, Completed, Failed
    [DurationSeconds] Auto calculated value for the end to end process duration in seconds
    [CreatedOn]       Default to GetDate()
    [CreatedOnUTC]    Default to GetUTCDate()
   ================== ===================================================================================================================================================== =====

|



MFProcessBatch Detail Table
---------------------------

.. container:: table-wrap

   ======================= ================================================================ ============================================================================================
   Column                  Usage                                                            Notes
   ======================= ================================================================ ============================================================================================
   [ProcessBatchDetail_ID] Identity column for ProcessBatch Detail
   [ProcessBatch_ID]       Related Process Batch ID                                         Each Process Batch Detail record is associated with a specific process batch
   [LogType]               System, Admin, User  (intended audience log)
   ProcedureRef            show procedure name
   [LogText]                default show procedure step
   [Status]                In Progress
   [DurationSeconds]       Auto calculated value for individual process duration in seconds
   [CreatedOn]             Default to GetDate()
   [CreatedOnUTC]          Default to GetUTCDate()
   [MFTableName]           Show name of table being process if relevant
   [Validation_ID]         Show id of validation code if relevant                           Reference Custom table for ERP integrations to show validation error code for ERP validation
   [ColumnName]            Show column name that value is related to                        examples: count; TotalAmount
   [ColumnValue]           Calculated value depending on sub process                        examples: number of records processed; total sum of column being updated
   [Update_ID])            MFUpdateHistory ID                                               ID relates to log of MFUpdateTable history record
   ======================= ================================================================ ============================================================================================
