
===============
MFWorkflowState
===============

Columns
=======

ID int (primarykey, not null)
  SQL Primay key
Name varchar(100) (not null)
  M-Files workflow state name
Alias varchar(100)
  M-Files alias
MFID int (not null)
  MFID from M-Files
MFWorkflowID int
  Primary key of MFWorkflow 
ModifiedOn datetime (not null)
  Date last modified in SQL
CreatedOn datetime (not null)
  Date created in SQL
Deleted bit (not null)
  set to 1 if deleted in M-Files
IsNameUpdate bit
  set to 1 to allow update from SQL to M-Files of name

Additional Info
===============

The name and alias can be updated from SQL to M-Files.  New items cannot be created from SQL.

Indexes
=======

idx\_MFWorkflowState\_MFID
  - MFID
TUC\_MFWorkflowState\_MFID
  - MFID
  - MFWorkflowID

Foreign Keys
============

Table relates to MFWorkflow


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
2017-07-02  LC         Change datatype of alias to varchar(100)
==========  =========  ========================================================

