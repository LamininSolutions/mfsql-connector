
===================
MFExportFileHistory
===================

Columns
=======

ID int (primarykey, not null)
  SQL primary key
FileExportRoot nvarchar(100)
  - Rootfolder is automatically set to C:\MFSQL\FileExport and can be changed in MFSettings
  - Rootfolder + FileExportFolder
  - The FileExportFolder is class specific and is set in the MFClass table by class. It defaults to NULL.
  - The FileExportFolder will separate the files for different classes in the folder system.
SubFolder\_1 nvarchar(100)
  This parameter is set in the spMFExportFiles procedure
SubFolder\_2 nvarchar(100)
  This parameter is set in the spMFExportFiles procedure
SubFolder\_3 nvarchar(100)
  This parameter is set in the spMFExportFiles procedure
MultiDocFolder nvarchar(100)
  fixme description
FileName nvarchar(256)
  M-Files filename of the file
ClassID int
  M-Files class ID of the related class table
ObjID int
  M-Files ObjID for the metadata object
ObjType int
  M-Files ObjectType for the class
Version int
  Version number of the object that contained the exported file
FileCheckSum nvarchar(100)
  Calculated checksum for the exported file
FileCount int
  The count of the files in the object
Created datetime
  The date and time of the export of the file
FileObjectID int
  fixme description

Used By
=======

- spMFExportFiles


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

