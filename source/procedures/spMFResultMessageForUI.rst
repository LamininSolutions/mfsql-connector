
======================
spMFResultMessageForUI
======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Processbatch\_ID int
    The process batch ID to base the message on
  @Detaillevel int
    - Default 0
    - the default will include only MFProcessBatch columns
    - set to 1 will include MFProcessBatchDetail columns
  @MessageOUT nvarchar(4000) (output)
    - Formatted with /n as new line token
  @MessageForMFilesOUT nvarchar(4000) (output)
    - Formatted with CHAR(10) as new line character
  @GetEmailContent bit (optional)
    - Default = 0
    - 1 = format EMailHTMLBodyOUT as HTML message 
  @EMailHTMLBodyOUT nvarchar(max) (output)
    - Formatted as HTML table using the stylesheet as defined by DefaultEMailCSS in MFSettings.
  @RecordCount int (output)
    fixme description
  @UserID int (output)
    fixme description
  @ClassTableList nvarchar(100) (output)
    fixme description
  @MessageTitle nvarchar(100) (output)
    fixme description
  @Debug int (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

Format process messages based on logging in MFProcessBatch and MFProcessBatch_Detail for output in different formats for use as a return message in the Context Menu UI, as a Multi-Line Text output or HTML format for inclusion in emails.

Additional Info
===============

The content of the output is defined by:
  - the ProcessBatch ID
  - if Detail level is set to 1 then the ProcessBatchDetail will be included

The procedure will format the output in three different formats:
  - Multiline text
  - for display in M-Files
  - in HTML format
  - if GetEmailContent is set to 0 (default) then HTML formatting will be ignored


When a single class table is part of a ProcessBatch_ID the message will be based on MFProcessBatch.LogText and Duration.

When multiple class tables are part of a ProcessBatch_ID the message will look at MFProcessBatch_Detail where LogType='Message' to compile a stacked message based on the LogText detail and the detail duration.

Regardless of what you include in the LogText the resulting message will always include the following elements:

.. code:: text

    [ProcessType]: [Status]
    Class Name: [Class Name]
    [LogText] -- with new lines based on ' | ' token in text
    Process Batch#: [ProcessBatch_ID]
    Started On: [CreatedOn]
    Duration: [DurationSeconds] --formatted as 00:00:00

The HTML Message is formatted as a table including a header row with the elements above formatted in HTML

Add ' | ' (includes spaces both sides of pipe (I) sign) to indicate a new-line token in the message

Add ' | | ' in LogText to indicate two new lines, creating a spacer line in the resulting message

Example: #Records: 2 | #Updated: 1 | #Added: 1

Use with spMFLogProcessSummaryForClassTable to generate LogText based on various counts in the process.

Prerequisites
=============

Is dependent on the deploying detail logging and requires MFProcessBatch id as input in solution.

Warnings
========

This procedure to be used as part of an overall messaging and logging solution. It will typically be called as part of a context menu,  or by the spMFProcessBatch_Email procedure to notify a user of outcome of a process.

Examples
========

Get formatted output for a processbatch id

.. code:: sql

    DECLARE @MessageOUT NVARCHAR(4000)
           ,@MessageForMFilesOUT NVARCHAR(4000)
           ,@EMailHTMLBodyOUT NVARCHAR(MAX);

    EXEC [dbo].[spMFResultMessageForUI] @Processbatch_ID = 3   
              ,@MessageOUT = @MessageOUT OUTPUT
              ,@MessageForMFilesOUT = @MessageForMFilesOUT OUTPUT
              ,@GetEmailContent = 1
              ,@EMailHTMLBodyOUT = @EMailHTMLBodyOUT OUTPUT

              Select @MessageOUT standardOutput, @MessageForMFilesOUT MFilesFormat, @EmailHTMLBodyOut EmailOutput

Get formatted output for Processbatch and ProcessBatchDetail

.. code:: sql

    DECLARE @MessageOUT NVARCHAR(4000)
           ,@MessageForMFilesOUT NVARCHAR(4000)
           ,@EMailHTMLBodyOUT NVARCHAR(MAX);

    EXEC [dbo].[spMFResultMessageForUI] @Processbatch_ID = 191
              ,@Detaillevel = 1     
              ,@MessageOUT = @MessageOUT OUTPUT
              ,@MessageForMFilesOUT = @MessageForMFilesOUT OUTPUT
              ,@GetEmailContent = 1
              ,@EMailHTMLBodyOUT = @EMailHTMLBodyOUT OUTPUT

              Select @MessageOUT standardOutput, @MessageForMFilesOUT MFilesFormat, @EmailHTMLBodyOut EmailOutput

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-08-25  LC         Resolve bug with null count
2021-02-26  LC         Fix issue with duration
2019-08-30  JC         Added documentation
2018-12-02  LC         Fix bug for returning more than one result in query
2018-11-18  LC         Fix count of records
2018-11-15  LC         Fix bug for MF message out
2018-05-20  LC         Modify result message for MFUserMessages
2017-12-29  LC         Allow for message from processbatchdetail level
2017-07-15  LC         Allow for default message when no table is involved in the process (e.g metadata synchronisation)
2017-06-26  AC         Add HTML Email Body Output
2017-06-26  AC         Remove @RowCount, RowCount calculated from ProcessBatch_ID as part of
2017-06-26  AC         Remove @ClassTable, Class Table derived from ProcessBatch_ID
2017-06-21  AC         Change @MessageOUT as optional (default = NULL)
2017-06-21  AC         Add MessageForMFilesOUT as optional (default=null) to allow for usage in multi-line text property
==========  =========  ========================================================

