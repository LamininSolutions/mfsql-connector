
===========================
tMFProcessBatch_UserMessage
===========================

Purpose
=======

The trigger is placed on the MFProcessBatch table.  It will fire when User Message Enabled = 1 in the MFSettings table AND LogType = 'Message' AND logstatus is on of Complete or Error Fail

when it is triggered, the procedure spMFInsertUserMessage is executed to insert an entry into the MFUserMessage table

Warnings
========

By default User Messages are enabled.  Set User Messages Enabled in MFSettings to 0 to suppress this functionality

Examples
========

To generate a user message process and entry to the MFProcessBatch table 

.. code:: sql

      EXEC [dbo].[spMFProcessBatch_Upsert]
               @ProcessBatch_ID = 1026
              ,@ProcessType = 'Main processType'
              ,@LogType = 'Message'
              ,@LogText = 'Procedure Name'
              ,@LogStatus = 'Completed'
              ,@debug = 0  

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-01-14  LC         Suppress capability as it does not work correctly
2017-03-10  LC         Create trigger and messages functionality
==========  =========  ========================================================

