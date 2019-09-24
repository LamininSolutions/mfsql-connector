spMFResultMessageForUI
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
      menu,  or by the
      `spMFProcessBatch_Email <page57778836.html#Bookmark73>`__
      procedure to notify a user of outcome of a process.

      Requires use `MFProcessBatch <page39223308.html#Bookmark50>`__ in
      solution.

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   .. container:: confluence-information-macro-body

      Format process messages based on logging in MFProcessBatch and
      MFProcessBatch_Detail for output to Context Menu UI, Mulit-Line
      Text Property/Field and/or HTML.

      When a single class table is part of a ProcessBatch_ID the message
      will be based on MFProcessBatch.LogText and Duration.

      When multiple class tables are part of a ProcessBatch_ID the
      message will look at MFProcessBatch_Detail where LogType='Message'
      to compile a stacked message based on the LogText detail and the
      detail duration.

      Regardless of what you include in the LogText the resulting
      message will always include the following elements:

      .. container:: preformatted panel

         .. container:: preformattedContent panelContent

            ::

               [ProcessType]: [Status]
               Class Name: [Class Name]
               [LogText] -- with new lines based on ' | ' token in text
               Process Batch#: [ProcessBatch_ID]
               Started On: [CreatedOn]
               Duration: [DurationSeconds] --formatted as 00:00:00 

      ::

         The HTML Message is formatted as a table including a header row with the following elements:

      .. container:: preformatted panel

         .. container:: preformattedContent panelContent

            ::

               M-Files Vault: [VaultName]

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ======= ================================================================================================================
         Type    Description
         ======= ================================================================================================================
         Input   | 
                
                 .. container:: table-wrap
                
                    +-----------------------+-----------------------+-----------------------+
                    | ProcessBatch_ID       | Required              | The process batch ID  |
                    |                       |                       | to base the message   |
                    |                       |                       | on                    |
                    +-----------------------+-----------------------+-----------------------+
                    | GetEmailContent       | Optional              | 0 (default)           |
                    |                       |                       |                       |
                    |                       |                       | 1=format              |
                    |                       |                       | EMailHTMLBodyOUT as   |
                    |                       |                       | HTML message          |
                    +-----------------------+-----------------------+-----------------------+
         Outputs .. container:: table-wrap
                
                    =================== =========================================================================================
                    MessageOUT          formatted with /n as new line token
                    MessageForMFilesOUT formatted with CHAR(10) as new line character
                    EMailHTMLBodyOUT    formatted as HTML table using the stylesheet as defined by DefaultEMailCSS in MFSettings.
                    Return              1=Success
                    =================== =========================================================================================
         ======= ================================================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         DECLARE @MessageOUT NVARCHAR(4000)
            , @MessageForMFilesOUT NVARCHAR(4000)
            , @EMailHTMLBodyOUT NVARCHAR(MAX);

         EXEC [dbo].[spMFResultMessageForUI] @Processbatch_ID = ?
                   , @MessageOUT = @MessageOUT OUTPUT
                   , @MessageForMFilesOUT = @MessageForMFilesOUT OUTPUT
                   , @GetEmailContent = ?
                   , @EMailHTMLBodyOUT = @EMailHTMLBodyOUT OUTPUT

| 

.. container:: confluence-information-macro confluence-information-macro-tip

   Tip: LogText Tokens

   .. container:: confluence-information-macro-body

      Add ' \| ' (includes spaces both sides of pipe (I) sign) to
      indicate a new-line token in the message

      Add ' \| \| ' in LogText to indicate two new lines, creating a
      spacer line in the resulting message

      *Example: #Records: 2 \| #Updated: 1 \| #Added: 1*

      Use with spMFLogProcessSummaryForClassTable to generate LogText
      based on various counts in the process.

| 
