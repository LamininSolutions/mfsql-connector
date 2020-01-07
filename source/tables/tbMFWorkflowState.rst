
===============
MFWorkflowState
===============

Columns
=======

ID int (primarykey, not null)
  SQL Primay key
Name varchar(100) (not null)
  fixme description
Alias varchar(100)
  fixme description
MFID int (not null)
  fixme description
MFWorkflowID int
  fixme description
ModifiedOn datetime (not null)
  fixme description
CreatedOn datetime (not null)
  fixme description
Deleted bit (not null)
  fixme description
IsNameUpdate bit
  fixme description

Additional Info
===============

Workflow State MFiles Metadata

Indexes
=======

idx\_MFWorkflowState\_MFID
  - MFID
TUC\_MFWorkflowState\_MFID
  - MFID
  - MFWorkflowID

Foreign Keys
============

+-----------------------------------+---------------------------------------------------------------+
| Name                              | Columns                                                       |
+===================================+===============================================================+
| FK\_MFWorkflowState\_MFWorkflow   | MFWorkflowID->\ `[dbo].[MFWorkflow].[ID] <MFWorkflow.md>`__   |
+-----------------------------------+---------------------------------------------------------------+

Uses
====

- MFWorkflow

Used By
=======

- spMFAliasesUpsert
- spMFDropAndUpdateMetadata
- spMFInsertUserMessage
- spMFInsertWorkflowState
- spmfSynchronizeWorkFlowSateColumnChange
- spMFSynchronizeWorkflowsStates


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
2017-07-02  LC         Change datatype of alias to varchar(100)
==========  =========  ========================================================

