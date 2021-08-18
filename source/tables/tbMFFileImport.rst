
============
MFFileImport
============

Columns
=======

ID int (primarykey, not null)
  SQL primary key
FileName nvarchar(100)
  File name
FileUniqueRef nvarchar(100)
  Full file path
CreatedOn datetime (not null)
  Date of import
SourceName nvarchar(100)
  fixme description
TargetClassID int
  fixme description
MFCreated datetime
  fixme description
MFLastModified datetime
  fixme description
ObjID int
  fixme description
Version int
  fixme description
FileObjectID int
  fixme description
FileCheckSum nvarchar(max)
  Checksum of file
ImportError nvarchar(4000)
  Import related errors


Additional Info
===============

Used By
=======

- spMFSynchronizeFilesToMFiles
- spMFUpdateExplorerFileToMFiles


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-08-03  LC         Change datatype of varchar to nvarchar
2019-09-07  JC         Added documentation
==========  =========  ========================================================

