
=======================
spMFProcessBatch_Upsert
=======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @ProcessType nvarchar(50)
    - Debug
    - Upsert
    - Create
    - Setup
    - Error
  @LogType nvarchar(50)
    - Start
    - End
  @LogText nvarchar(4000)
    - Text string for updating user
  @LogStatus nvarchar(50)
    - Initiate
    - In Progress
    - Partial
    - Completed
    - Error
  @debug smallint
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======

Batch multi-function processing with logging.

Examples
========

.. code:: sql

    DECLARE @ProcessBatch_ID INT = 0;

    EXEC [dbo].[spMFProcessBatch_Upsert]
               @ProcessBatch_ID = @ProcessBatch_ID OUTPUT
              ,@ProcessType = 'Test'
              ,@LogText = 'Testing'
              ,@LogStatus = 'Start'
              ,@debug = 1

    SELECT * FROM MFProcessBatch WHERE ProcessBatch_ID = @ProcessBatch_ID

    WAITFOR DELAY '00:00:02'

    EXEC [dbo].[spMFProcessBatch_Upsert]
               @ProcessBatch_ID = @ProcessBatch_ID
              ,@ProcessType = 'Test'
              ,@LogText = 'Testing Complete'
              ,@LogStatus = 'Complete'
              ,@debug = 1

    SELECT * FROM MFProcessBatch WHERE ProcessBatch_ID = @ProcessBatch_ID

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-03-12  LC         Remove debug text
2019-08-30  JC         Added documentation
2019-01-26  LC         Resolve issues with commits
2019-01-21  LC         Remove unnecessary log entry for dbcc
2018-10-31  LC         Improve debugging comments
2018-08-01  LC         Add debugging
==========  =========  ========================================================

