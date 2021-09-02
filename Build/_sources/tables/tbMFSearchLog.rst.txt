
===========
MFSearchLog
===========

Columns
=======

ID int (primarykey, not null)
  SQL Primary Key
TableName varchar(200)
  Temporary table name
SearchClassID int
  fixme description
SearchText varchar(500)
  Search text used to generate the row
SearchDate datetime
  Date of search
ProcessID int
  fixme description

Used By
=======

- spMFSearchForObject
- spMFSearchForObjectbyPropertyValues


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

