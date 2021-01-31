
==================================
spMFLogProcessSummaryForClassTable
==================================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ProcessBatch\_ID int (optional)
    Referencing the ID of the ProcessBatch logging table
  @MFTableName nvarchar(100)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @IncludeStats bit
    - Reserved
  @IncludeAudit bit
    - Reserved
  @InsertCount int (optional)
    - Default = NULL
    - Use to set #Inserted in LogText
  @UpdateCount int (optional)
    - Default = NULL
    - Use to set #Updated in LogText
  @LogProcedureName nvarchar(100) (optional)
    - Default = NULL
    - The calling stored procedure name
  @LogProcedureStep nvarchar(100) (optional)
    - Default = NULL
    - The step from the calling stored procedure to include in the Log
  @LogTextDetailOUT nvarchar(4000) (output)
    - The LogText written to MFProcessBatchDetail
  @LogStatusDetailOUT nvarchar(50) (output)
    - The LogStatus written to MFProcessBatchDetail
  @debug tinyint
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

Calculate various totals, including error counts and update MFProcessBatch and MFProcessBatchDetail LogText and Status.

Additional Info
===============

Calculate various totals, including error counts and update MFProcessBatch and MFProcessBatchDetail LogText and Status.

Counts are performed on the MFClassTable based on MFSQL_Process_Batch and Process_ID

Counts included:

- Record Count
- Deleted Count
- Synchronization Error Count
- M-Files Error Count
- SQL Error Count
- MFLog Count related to

Based on any of the Error count being larger than 0, the LogStatusDetail will be appended with 'w/Errors' text.

The LogTextDetail is set to the following value, with only displaying the counts larger than 0:

.. code:: text

    #Records: @RecordCount | #Inserted: @InsertCount | #Updated: @UpdateCount | #Deleted: @DeletedCount | #Sync Errors: @SyncErrorCount | #MF Errors: @MFErrorCount | #SQL Errors: @SQLErrorCount | #MFLog Errors: @MFLogErrorCount

Add the following properties to M-Files Classes: MFSQL Process Batch



Prerequisites
=============

Requires use MFProcessBatch in solution.

Requires use of MFSQL Process Batch on class tables.

Warnings
========

This procedure to be used as part of an overall messaging and logging solution. It will typically be called towards the end of your processes against a specific MFClassTable.

Relies on the usage of MFSQL_Process_Batch as a property in all M-Files classes that are part of your solution. Your solution code should also be written to set the MFSQL_Process_Batch to the ProcessBatch_ID for all operations where you set the Process_ID to 1.

Examples
========

.. code:: sql

    DECLARE @LogTextDetailOUT NVARCHAR(4000)
       , @LogStatusDetailOUT NVARCHAR(50);

    EXEC [dbo].[spMFLogProcessSummaryForClassTable] @ProcessBatch_ID = ?
                 , @MFTableName = ?
                 , @InsertCount = ?
                 , @UpdateCount = ?
                 , @LogProcedureName = ?
                 , @LogProcedureStep = ?
                 , @LogTextDetailOUT = @LogTextDetailOUT OUTPUT
                 , @LogStatusDetailOUT = @LogStatusDetailOUT OUTPUT
                 , @debug = 0

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-08-22  LC         Update to include new deleted column
2020-08-02  LC         Update spmfclasstablestats column name
2019-08-30  JC         Added documentation
==========  =========  ========================================================

