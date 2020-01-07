
==========
MFWorkflow
==========

Columns
=======

ID int (primarykey, not null)
  SQL primary key
Name varchar(100) (not null)
  fixme description
Alias nvarchar(100)
  fixme description
MFID int (not null)
  fixme description
ModifiedOn datetime (not null)
  fixme description
CreatedOn datetime (not null)
  fixme description
Deleted bit (not null)
  fixme description

Additional Info
===============

Workflow MFiles metadata.

Indexes
=======

idx\_MFWorkflow\_MFID
  - MFID
TUC\_MFWorkflow\_MFID
  - MFID

Used By
=======

- MFClass
- MFWorkflowState
- MFvwMetadataStructure
- spMFAliasesUpsert
- spMFCreateAllLookups
- spMFCreateWorkflowStateLookupView
- spMFDropAndUpdateMetadata
- spMFInsertClass
- spMFInsertUserMessage
- spMFInsertWorkflow
- spMFInsertWorkflowState
- spMFSynchronizeWorkflow
- spmfSynchronizeWorkFlowSateColumnChange
- spMFSynchronizeWorkflowsStates


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

