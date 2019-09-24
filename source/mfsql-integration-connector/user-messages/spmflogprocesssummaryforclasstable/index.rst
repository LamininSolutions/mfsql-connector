spMFLogProcessSummaryForClassTable
==================================

| 

.. container:: confluence-information-macro has-no-icon confluence-information-macro-note

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ========= ========
         Module    Release#
         ========= ========
         Developer 3.1.2.38
         ========= ========

| 

.. container:: confluence-information-macro confluence-information-macro-note

   .. container:: confluence-information-macro-body

      This procedure to be used as part of an overall messaging and
      logging solution. It will typically be called towards the end of
      your processes against a specific MFClassTable.

      Requires use `MFProcessBatch <page39223308.html#Bookmark50>`__ in
      solution.

      Requires use of MFSQL Process Batch on class tables.

Calculate various totals, including error counts and update
MFProcessBatch and MFProcessBatchDetail LogText and Status.

Counts are performed on the MFClassTable based on MFSQL_Process_Batch
and Process_ID

Counts included:

-  Record Count
-  Deleted Count
-  Synchronization Error Count
-  M-Files Error Count
-  SQL Error Count
-  MFLog Count related to 

Based on any of the Error count being larger than 0, the LogStatusDetail
will be appended with 'w/Errors' text.

The LogTextDetail is set to the following value, with only displaying
the counts larger than 0:

.. container:: preformatted panel

   .. container:: preformattedContent panelContent

      ::

         #Records: @RecordCount | #Inserted: @InsertCount | #Updated: @UpdateCount | #Deleted: @DeletedCount | #Sync Errors: @SyncErrorCount | #MF Errors: @MFErrorCount | #SQL Errors: @SQLErrorCount | #MFLog Errors: @MFLogErrorCount

See `spMFResultMessageForUI <page57774875.html#Bookmark70>`__ for an
explanation of how the LogText is parsed out and displayed 

| 

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ======= ==============================================================================================
         Type    Description
         ======= ==============================================================================================
         Input   | 
                
                 .. container:: table-wrap
                
                    ================= ======== ================================================================
                    @ProcessBatch_ID  Required The MFSQL Process Batch number to perform calculations on
                    @MFTableName      Required The class table on which to base the record counts
                    @InsertCount      Optional Use to set #Inserted in LogText
                    @UpdateCount      Optional Use to set #Updated in LogText
                    @LogProcedureName Optional The calling stored procedure name
                    @LogProcedureStep Optional The step from the calling stored procedure to include in the Log
                    ================= ======== ================================================================
         Outputs .. container:: table-wrap
                
                    =================== =============================================
                    @LogTextDetailOUT   The LogText written to MFProcessBatchDetail
                    @LogStatusDetailOUT The LogStatus written to MFProcessBatchDetail
                    Return              1=Success
                    =================== =============================================
         ======= ==============================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

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

| 

.. container:: confluence-information-macro confluence-information-macro-warning

   Warning:

   .. container:: confluence-information-macro-body

      Relies on the usage of MFSQL_Process_Batch as a property in all
      M-Files classes that are part of your solution. Your solution code
      should also be written to set the MFSQL_Process_Batch to the
      ProcessBatch_ID for all operations where you set the Process_ID to
      1.

.. container:: confluence-information-macro confluence-information-macro-tip

   Tip:

   .. container:: confluence-information-macro-body

      Add the following properties to M-Files Classes: MFSQL Process
      Batch

| 
