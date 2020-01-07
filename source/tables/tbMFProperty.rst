
==========
MFProperty
==========

Columns
=======

ID int (primarykey, not null)
  SQL primary key
Name varchar(100)
  Name of the property
Alias varchar(100) (not null)
  fixme description
MFID int (not null)
  M-Files ID of the property
ColumnName varchar(100)
  Name of the column
MFDataType\_ID int
  M-Files datatype ID
PredefinedOrAutomatic bit
  If the property is automatically calculated
ModifiedOn datetime (not null)
  fixme description
CreatedOn datetime (not null)
  fixme description
Deleted bit
  Has the property been deleted
MFValueList\_ID int
  Primary key of the MFValueList table

Indexes
=======

idx\_MFProperty\_MFID
  - MFID
TUC\_MFProperty\_MFID
  - MFID

Foreign Keys
============

+-------------------------------+--------------------------------------------------------------------+
| Name                          | Columns                                                            |
+===============================+====================================================================+
| FK\_MFProperty\_MFValueList   | MFValueList\_ID->\ `[dbo].[MFValueList].[ID] <MFValueList.md>`__   |
+-------------------------------+--------------------------------------------------------------------+

Uses
====

- MFValueList

Used By
=======

- MFvwClassTableColumns
- MFvwMetadataStructure
- spMFAddCommentForObjects
- spMFClassTableColumns
- spMFClassTableStats
- spMFClassTableSynchronize
- spMFCreateAllLookups
- spMFCreateTable
- spMFDeleteAdhocProperty
- spMFDropAndUpdateMetadata
- spMFExportFiles
- spMFGetHistory
- spMFInsertClassProperty
- spMFInsertProperty
- spMFInsertUserMessage
- spMFObjectTypeUpdateClassIndex
- spMFSearchForObject
- spMFSearchForObjectbyPropertyValues
- spMFSynchronizeFilesToMFiles
- spmfSynchronizeLookupColumnChange
- spMFSynchronizeProperties
- spMFSynchronizeUnManagedObject
- spMFUpdateClassAndProperties
- spMFUpdateExplorerFileToMFiles
- spMFUpdateHistoryShow
- spMFUpdateMFilesToMFSQL
- spMFUpdateTable
- spMFUpdateTableinBatches
- spMFUpdateTableInternal
- spMFUpdateTableWithLastModifiedDate

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

