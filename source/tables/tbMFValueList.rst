
===========
MFValueList
===========

Columns
=======

ID int (primarykey, not null)
  SQL Primary Key
Name varchar(100)
  fixme description
Alias nvarchar(100)
  fixme description
MFID int
  M-Files ID
OwnerID int
  Owner MFID
ModifiedOn datetime (not null)
  When was the record last modified
CreatedOn datetime (not null)
  When was the record created
Deleted bit (not null)
  Is deleted
RealObjectType bit
  fixme description

Indexes
=======

idx\_MFValueList\_1
  - ID
  - Name
udx\_MFValueList\_MFID
  - Name
  - MFID

Used By
=======

- MFProperty
- MFValueListItems
- MFvwMetadataStructure
- MFvwUserGroup
- spMFClassTableColumns
- spMFCreateAllLookups
- spMFCreateValueListLookupView
- spMFDropAndUpdateMetadata
- spMFInsertProperty
- spMFInsertValueList
- spMFInsertValueListItems
- spmfSynchronizeLookupColumnChange
- spMFSynchronizeProperties
- spMFSynchronizeSpecificMetadata
- spMFSynchronizeValueList
- spMFSynchronizeValueListItems
- spMFSynchronizeValueListItemsToMFiles


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

