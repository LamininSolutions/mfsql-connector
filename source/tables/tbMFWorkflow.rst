
==========
MFWorkflow
==========

Columns
=======

ID int (primarykey, not null)
  SQL primary key
Name varchar(100) (not null)
  Name of Workflow from M-Files
Alias nvarchar(100)
  Alias in M-Files
MFID int (not null)
  MFID of workflow 
ModifiedOn datetime (not null)
  Date last changed in SQL
CreatedOn datetime (not null)
  Date Created in SQL
Deleted bit (not null)
  set to 1 if deleted in M-Files

Indexes
=======

idx\_MFWorkflow\_MFID
  - MFID
TUC\_MFWorkflow\_MFID
  - MFID

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

