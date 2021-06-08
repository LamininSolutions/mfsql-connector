
===============
MFUpdateHistory
===============

Columns
=======

Id int (primarykey, not null)
  SQL id
Username nvarchar(250) (not null)
  MFSQL User performing update
VaultName nvarchar(250) (not null)
  Name of vault being updated
UpdateMethod smallint (not null)
  1 = From MF to SQL
  0 = From SQL to MF
ObjectDetails xml
  Details of object being updated in xml form
ObjectVerDetails xml
  Object version detail of object(s)
NewOrUpdatedObjectVer xml
  Detail properties of object(s) being updated
NewOrUpdatedObjectDetails xml
  Results of update
SynchronizationError xml
  Object version of the record that has error
MFError xml
  Listing of the records with errors
DeletedObjectVer xml
  objects deleted
UpdateStatus varchar(25)
  Full or partial update
CreatedAt datetime
  Date of update

Additional Info
===============

Every update that is processed through spMFUpdateTable is logged in the MFUpdateHistory Table.

As soon as the update is initiated an ID is reserved from MFUpdateHistory and the items related to the update is recorded in the table as XML records. Note that this table potentially could include large XML records and it is not recommended to perform a select statement on this table without any filters. It is also important to ensure that this table is maintained and that old records are regularly deleted. See spMFDeleteHistory.

The significance and nature of the contents of the columns in the MFUpdateHistory table will depend and the parameters of the MFUpdateTable procedure and the outcome of the procedure.


Indexes
=======

idx\_MFUpdateHistory\_id
  - Id

Used By
=======

- MFvwLogTableStats
- spMFAddCommentForObjects
- spMFCheckAndUpdateAssemblyVersion
- spMFDeleteHistory
- spMFGetHistory
- spMFLogError\_EMail
- spMFSynchronizeFilesToMFiles
- spmfSynchronizeLookupColumnChange
- spMFSynchronizeUnManagedObject
- spmfSynchronizeWorkFlowSateColumnChange
- spMFUpdateExplorerFileToMFiles
- spMFUpdateHistoryShow
- spMFUpdateTable


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

