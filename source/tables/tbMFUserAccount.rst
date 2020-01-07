
=============
MFUserAccount
=============

Columns
=======

UserID int (primarykey, not null)
  M-Files internal ID for user
LoginName nvarchar(250)
  Name user sign in with
InternalUser bit
  - 1 = Internal user
  - 0 = External user
Enabled bit
  1 = enabled
Deleted bit
  1 = deleted in M-Files

Indexes
=======

idx\_MFUserAccount\_User\_id
  - UserID

Used By
=======

- spMFDropAndUpdateMetadata
- spMFInsertUserAccount
- spMFProcessBatch\_EMail
- spMFResultMessageForUI


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

