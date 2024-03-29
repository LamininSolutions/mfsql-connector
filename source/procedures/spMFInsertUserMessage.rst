
=====================
spMFInsertUserMessage
=====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ProcessBatch\_ID int (optional)
    Referencing the ID of the ProcessBatch logging table
  @UserMessageEnabled int
    Set the user message enabled flag. 
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode


Purpose
=======

This procedure is used to insert an entry in the MFUserMessage table for the specified processbatch

Addition Info
=============

Enabling user messages are set in the MFSettings table. spMFProcessBatch trigger will use this setting to get the value for the @userMessageEnabled parameter.

Examples
========

exec spMFInsertUserMessage @processBatch_ID = 107, @userMessageEnabled = 1


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2019-01-03  LC         Fix bug related to column names
2018-11-15  LC         Add error logging; fix null value bug; check for duplicate messages per process batch
2018-07-25  LC         Resolve issue with workflow_state_id
2018-06-26  LC         Localise workflow and state
2018-05-18  LC         Add workflow and state
2018-04-28  LC         Add user message enabling
2018-04-20  LC         Update procedure for the new MFClass table for MFUserMessages
2018-04-18  LC         Set default for ProcessBatch_ID
2017-06-26  AC         Remove @ClassTable,  retrieve based on ProcessBatch_ID
2017-06-26  AC         Update call to spMFResultMessageForUI to read the message with carriage return instead of \n
2017-06-26  AC         Add ItemCount based on using new methods to generate RecordCount info message in MFProcessBatchDetail
==========  =========  ========================================================

