
===============
MFClassProperty
===============

Columns
=======

MFClass\_ID int (primarykey, not null)
  ID column of MFClass
MFProperty\_ID int (primarykey, not null)
  ID column of MFProperty
Required bit (not null)
  If the property is required on the class

Additional Info
===============

This table is used to index the relationship of Properties with Classes as defined on the metadata card.

The column **Required** show if the property is required on the metadata card in M-files. If the property is required then the column in the class table will be created with a NOT NULL constraint.

All of the columns defined in the MFClassProperty Table for the specified class will be included in the Class Table with the data types defined above

MFClassProperty are used by spMFCreateTable when new MF Class Tables are created. This table maps the properties to specific classes as defined in the the metadata structure.

The ID's on this table refers to the SQL ID on the MFClass and MFProperty tables. It does not refer to the MFID on these tables.

The Required column in this table exposes the required properties in M-Files to SQL and can be used to validate data input in special applications to avoid errors when the record is updated in M-Files.

Indexes
=======

idx\_MFClassProperty\_Property\_ID
  - MFProperty\_ID


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-04-22  LC         create constraints when table is created
2019-09-07  JC         Added documentation
==========  =========  ========================================================

