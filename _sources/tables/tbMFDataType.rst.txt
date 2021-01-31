
==========
MFDataType
==========

Description
===========

Datatypes match M-Files datatypes with SQL datatypes.  This table must not be changed and is created on installation.

Columns
=======

ID int (primarykey, not null)
  SQL ID
MFTypeID int (not null)
  Data type ID used by M-Files
SQLDataType varchar(50)
  Equivalent SQL datatype for the M-Files datatype
Name varchar(100)
  M-Files name of datatype
ModifiedOn datetime (not null)
  date SQL last modified
CreatedOn datetime (not null)
  date created in SQL
Deleted bit (not null)
  default = 0

Indexes
=======

idx\_MFDataType\_MFTypeID
  - MFTypeID
TUC\_MFDataType\_MFTypeID
  - MFTypeID

Used By
=======

- MFvwClassTableColumns
- MFvwMetadataStructure
- spMFAddCommentForObjects
- spMFClassTableColumns
- spMFCreateTable
- spMFDropAndUpdateMetadata
- spMFInsertProperty
- spMFSynchronizeFilesToMFiles
- spMFSynchronizeUnManagedObject
- spMFUpdateExplorerFileToMFiles
- spMFUpdateTable
- spMFUpdateTableInternal


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-01-02  Dev2       Changed property value to max
2019-09-07  JC         Added documentation
2015-03-01  LC         Table designed
==========  =========  ========================================================

