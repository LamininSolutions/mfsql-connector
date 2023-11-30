
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
  source folder name of the file
TargetClassID int
  class of the target object
MFCreated datetime
  datetime in UTC of the last modified of the object
MFLastModified datetime
  datetime in UTC of the last modified of the object
ObjID int
  objid of the imported object
Version int
  version of the object
FileObjectID int
  file id of the imported object
FileCheckSum nvarchar(max)
  Checksum of file
ImportError nvarchar(4000)
  Import related errors

Additional Info
===============
The MFFileImport table is the logging table to record the results of the import routines

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

