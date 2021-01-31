
==============
MFProcessBatch
==============

Columns
=======

ProcessBatch\_ID int (primarykey, not null)
  SQL primary key
ProcessType nvarchar(50)
  Update Table, Synchronize Metadata (overall process being performed)
LogType nvarchar(50)
  - Status = indicate status of process to be reported to user
  - System =  considered internal operations only
  - Debug = only used for debugging purposes
  - Message = need to be reported back to user
LogText nvarchar(4000)
  User message
Status nvarchar(50)
  - Started
  - Completed
  - Failed
DurationSeconds decimal(18,4)
  Auto calculated value for the end to end process duration in seconds
CreatedOn datetime
  Default to GetDate()
CreatedOnUTC datetime
  Default to GetUTCDate()

Additional Info
===============

MFProcessBatch has a unique reference for each process. A single record is created when the process starts and updated with progress of the process until completion.

Used By
=======

- MFvwLogTableStats
- spMFDeleteHistory
- spMFLogProcessSummaryForClassTable
- spMFProcessBatch\_EMail
- spMFProcessBatch\_Upsert
- spMFResultMessageForUI


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

