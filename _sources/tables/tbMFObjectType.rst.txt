
============
MFObjectType
============

Columns
=======

ID int (primarykey, not null)
  SQL id
Name varchar(100)
  Name of Object Type
Alias nvarchar(100)
  Aliase of object type
MFID int (not null)
  M-Files id
ModifiedOn datetime (not null)
  last modified in SQL
CreatedOn datetime (not null)
  created in SQL
Deleted bit (not null)
  set to 1 when object is deleted in MF

Indexes
=======

TUC\_MFObjectType\_MFID
  - MFID

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

