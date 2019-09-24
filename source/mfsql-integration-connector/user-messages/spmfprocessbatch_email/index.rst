spMFProcessBatch_Email
======================

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
      logging solution. It will typically be called as part of a context
      menu or scheduled SQL Job solution to notify a user of outcome of
      a process.

      Requires use `MFProcessBatch <page39223308.html#Bookmark50>`__ in
      solution.

      Requires use of MFSQL Process Batch on class tables.

Prepares and sends an e-mail indicating the outcome of a MFSQL Process
Batch. Can we used with `Context
Menu <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/52625447/Using+the+Context+Menu>`__
in asynchronous mode to notify user of process completion or status.

Message Subject based on
`MFProcessBatch <page39223308.html#Bookmark50>`__ entry and status

Message Recipient can come
`MFSettings <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/21200964/Utility+Tables>`__
table, or provided as input

See `spMFResultMessageForUI <page57774875.html#Bookmark70>`__ for an
explanation of how the HTML body of the e-mail is compiled. 

| 

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ======= ============================================================================
         Type    Description
         ======= ============================================================================
         Input   | 
                
                 .. container:: table-wrap
                
                    +-----------------------+-----------------------+-----------------------+
                    | @ProcessBatch_ID      | Required              | The MFSQL Process     |
                    |                       |                       | Batch number to       |
                    |                       |                       | perform calculations  |
                    |                       |                       | on                    |
                    +-----------------------+-----------------------+-----------------------+
                    | @RecipientEmail       | Optional              | If provided will be   |
                    |                       |                       | appended to           |
                    |                       |                       | EMAIL_TO_ADDR         |
                    +-----------------------+-----------------------+-----------------------+
                    | @,RecipientFromMFSett | Optional              | If provided will look |
                    | ingName               |                       | for specific setting  |
                    |                       |                       | name from             |
                    |                       |                       | `MFSettings <https:// |
                    |                       |                       | lamininsolutions.atla |
                    |                       |                       | ssian.net/wiki/pages/ |
                    |                       |                       | createpage.action?spa |
                    |                       |                       | ceKey=MFSQL&title=MFS |
                    |                       |                       | ettings&linkCreation= |
                    |                       |                       | true&fromPageId=57778 |
                    |                       |                       | 836>`__               |
                    |                       |                       | table and append      |
                    |                       |                       | value to              |
                    |                       |                       | EMAIL_TO_ADDR         |
                    +-----------------------+-----------------------+-----------------------+
                    | @ContextMenu_ID       | Optional              |  the recipient e-mail |
                    |                       |                       | will be derived from  |
                    |                       |                       | the person who        |
                    |                       |                       | executed the context  |
                    |                       |                       | menu item from the    |
                    |                       |                       | UI.                   |
                    +-----------------------+-----------------------+-----------------------+
                    |  @DetailLevel         |  Optional             |  Default(0) - Summary |
                    |                       |                       | Only                  |
                    |                       |                       | 1 - Include           |
                    |                       |                       | MFProcessBatchDetail  |
                    |                       |                       | for LogTypes in       |
                    |                       |                       | @LogTypes             |
                    |                       |                       | -1 - Lookup           |
                    |                       |                       | DetailLevel from      |
                    |                       |                       | MFSettings            |
                    +-----------------------+-----------------------+-----------------------+
                    |  @Logtypes            |  Optional             | Default - 'Message'   |
                    |                       |                       |                       |
                    |                       |                       |  If provided along    |
                    |                       |                       | with DetailLevel=2,   |
                    |                       |                       | the LogTypes provided |
                    |                       |                       | in CSV format will be |
                    |                       |                       | included in the       |
                    |                       |                       | e-mail                |
                    +-----------------------+-----------------------+-----------------------+
         Outputs .. container:: table-wrap
                
                    +-----------------------------------+-----------------------------------+
                    | Return                            | 1=Success                         |
                    |                                   |                                   |
                    |                                   | 2=Database mail has not beensetup |
                    |                                   |                                   |
                    |                                   | -1=Error                          |
                    +-----------------------------------+-----------------------------------+
         ======= ============================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         EXEC [dbo].[spMFProcessBatch_EMail] @ProcessBatch_ID = ?
                               , @RecipientEmail = ?
                               , @RecipientFromMFSettingName = ?

| 

| 
