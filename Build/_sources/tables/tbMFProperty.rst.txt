
==========
MFProperty
==========

Columns
=======

ID int (primarykey, not null)
  SQL primary key
Name varchar(100)
  Name of the property from M-Files
Alias varchar(100) (not null)
  Alias of the property
MFID int (not null)
  M-Files ID of the property
ColumnName varchar(100)
  Name of the column
MFDataType\_ID int
  M-Files datatype ID
PredefinedOrAutomatic bit
  If the property is automatically calculated
ModifiedOn datetime (not null)
  date when the MFProperty table was last modified
CreatedOn datetime (not null)
  date when the MFProperty table was created
Deleted bit
  Has the property been deleted in M-Files
MFValueList\_ID int
  Primary key of the MFValueList table

Additional Info
===============

The MFProperty table contains a reference to all the properties in vault.

The columns of the Class Tables is automatically assigned on creation using the rules defined in the property table. The datatype defined by the column **MFDataType** will be applied to the column. The name of the column is defined in the MFProperty Table in the column **ColumnName**. A default ColumnName will be created for
each property when the MFproperty Table is created. These names can be edited.  The custom changes of the columnname is preserved when metadata is refreshed.

Refer to :doc:`/introduction/requirements/index` for a list of reserved words. These should not be used as property names.

The datatype_ID references the primary key on the MFDataType table.  It is not the same as the datatype ID in the MFilesAPI.

The **PredefinedOrAutomatic** column indicates if the property is automatically calculated. These columns will follow the rules set by M-Files.

The MFValuelist_ID references the primary key on the MFValuelist table.  It is not the same as the M-Files internal ID for the valuelist.

Indexes
=======

idx\_MFProperty\_MFID
  - MFID
TUC\_MFProperty\_MFID
  - MFID

Foreign Keys
============

The MFProperty tables is referenced by the Valuelist table and the MFClassProperty Table.

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

