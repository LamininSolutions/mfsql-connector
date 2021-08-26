
==================================
MFObjectChangeHistoryUpdateControl
==================================

Columns
=======

ID int (primarykey, not null)
MFTableName (String)
-  class table Name
ColumnNames (string)
-  columnName of property to be included
-  add multiple rows for multiple properties to be included for a class table

Additional info
===============

This table contains the class table name and the property columnname for each change record to be updated.  The class table name must correspond with MFClass and the columnname must correspond with MFProperty for the specific property.

The records in this table must be added and maintained manually. spMFUpdateObjectChangeHistory is dependent on valid records in this table to function.

Used By
=======

- spMFUpdateObjectChangeHistory
- spMFUpdateAllIncludedInAppTables


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-11-04  LC         Create Table
==========  =========  ========================================================

