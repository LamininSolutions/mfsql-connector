
==============
MFAuditHistory
==============

Columns
=======

ID int (primarykey, not null)
  fixme description
RecID int
  fixme description
SessionID int
  fixme description
TranDate datetime
  fixme description
ObjectType int
  fixme description
Class int
  fixme description
ObjID int
  fixme description
MFVersion smallint
  fixme description
StatusFlag smallint
  fixme description
StatusName varchar(100)
  fixme description
UpdateFlag int
  fixme description

Indexes
=======

idx\_AuditHistory\_ObjType\_ObjID
  - ObjectType
  - ObjID
idx\_AuditHistory\_Class\_Flag
  - Class
  - ObjID

Used By
=======

- MFvwAuditSummary
- MFvwLogTableStats
- spMFClassTableStats
- spMFDeleteHistory
- spMFLogTableStats
- spMFTableAudit
- spMFUpdateItemByItem
- spMFUpdateMFilesToMFSQL
- spMFUpdateTable
- spMFUpdateTableinBatches


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

