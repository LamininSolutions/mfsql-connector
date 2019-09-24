spMFInsertUserMessage
=====================

| 

| 

.. container:: confluence-information-macro has-no-icon confluence-information-macro-note

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         =========== ========
         Module      Release#
         =========== ========
         Integration 3.1.2.38
         =========== ========

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   .. container:: confluence-information-macro-body

      Get a new-line formatted message from spMFResultMessageForUI for a
      given ProcessBatch_ID

      Get the class table and ColumnValue from MFProcessBatchDetail
      where the ColumnName = 'RecordCount'

      Insert record into MFUserMessages

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ======= =======================================================================
         Type    Description
         ======= =======================================================================
         Input   | 
                
                 .. container:: table-wrap
                
                    =============== ======== ===========================================
                    ProcessBatch_ID Required The process batch ID to base the message on
                    =============== ======== ===========================================
         Outputs .. container:: table-wrap
                
                    ====== =========
                    Return 1=Success
                    ====== =========
         ======= =======================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         EXEC [dbo].[spMFInsertUserMessage] @ProcessBatch_ID = ?

| 

.. container:: confluence-information-macro confluence-information-macro-warning

   Warning:

   .. container:: confluence-information-macro-body

      Relies on your code adding an entry to MFProcessBatchDetail with
      ColumnName='RecordCount' and ColumnValue= (record count)

.. container:: confluence-information-macro confluence-information-macro-tip

   Tip:

   .. container:: confluence-information-macro-body

      Use spMFLogProcessSummaryForClassTable as part of your integration
      code to calculate and create the 'RecordCount' record in
      MFProcessBatchDetail

| 
