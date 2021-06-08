
====================
MFProcessBatchDetail
====================

Columns
=======

ProcessBatchDetail\_ID int (primarykey, not null)
  SQL Primary key
ProcessBatch\_ID int
  Foreign key for Process Batch
LogType nvarchar(50)
  - System
  - Admin
  - User
ProcedureRef nvarchar(258)
  Show procedure name
LogText nvarchar(4000)
  Default show procedure step
Status nvarchar(50)
  In Progress
DurationSeconds decimal(18,4)
  Auto calculated value for individual process duration in seconds
CreatedOn datetime
  Default to GetDate()
CreatedOnUTC datetime
  Default to GetUTCDate()
MFTableName nvarchar(128)
  Show name of table being process if relevant
Validation\_ID int
  Show id of validation code if relevant
ColumnName nvarchar(128)
  Show column name that value is related to
ColumnValue nvarchar(256)
  Calculated value depending on sub process
Update\_ID int
  MFUpdateHistory ID

Additional Info
===============

The MFProcessBatchDetail records individual records for key events of each MFProcessBatch.

Indexes
=======

idx\_dbo\_MFProcessBatchDetail
  - ProcessBatch\_ID

Used By
=======

- MFvwLogTableStats
- spMFDeleteHistory
- spMFProcessBatchDetail\_Insert
- spMFResultMessageForUI


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

