Metadata Table Columns
======================

Generic Extended Columns
------------------------

The following additional columns are created on every SQL Connector
table.

=========== ==============================================================
Column      Description
=========== ==============================================================
ID          SQL Identity column that represents the SQL - ID of the object
MFID        M-Files id if the object
Alias       The M-Files Alias
Modified on Date that the item was last modified in SQL
Created on  Date that the items was created in SQL
Deleted     Item is set to 1 by the Connector if it was deleted in M-Files
=========== ==============================================================


The columns of all the Connector tables are automatically created and
maintained. The type of columns that are included on the table vary
by type of table. Tables have fixed columns defined by the Connector,
and other tables have variable columns, depending on the metadata
configuration in M-Files and the use of additional properties in
M-Files.

Changing the column structure, or naming of the Connector tables
could affect the procedures and functions of the Connector and negate
maintenance of the application.

If the special application requires additional colums that is outside
the scope of the Connector then these columns should be maintained in
a separate table that references the Connector table.

The following special considerations regarding columns in the tables
applies

Also note the section on common columns and rules associated with
these columns. These columns apply to all Metadata Structure tables.

The following tables and table columns are created by the initial
deployment and maintained by the metadata syncronisation procedures

MFClass
~~~~~~~

The custom settings for the following columns will be retained when
:doc:`/procedures/spMFDropAndUpdateMetadata` is used with the correct
parameters:

-  The MFClass table is defines the classes included in the connector.
   The class table names is defined in column \ **TableName** in the
   MFClass Table. The Connector will create a default name for all the
   tables. These names can be edited.
-  The MFClass table column **IncludedInApp** has several functions.
   If this value is set to 1 then it indicates that the Class Table is
   specifically used in the application. This indicator is used in
   procedures to refresh or update all Class tables in the App with a
   single instruction, and are used in many other procedures to sub
   select classes included in the app. If this value is set to 2 then an
   update to the Class table will automatically trigger an update to
   M-Files.
-  The **FileExportFolder** column defines the root folder to be used
   when exporting files for the class. Refer to the `file
   exporting <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/57913733/spMFExportFiles>`__
   section for further detail.
-  The S\ **ynchPrecedence** column defined the precedence for auto
   fixing of synchronization errors for the class. Refer to the
   `SynchPrecedence <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/60948546/Correcting+Synchronization+errors>`__
   section for further detail.

The MFClass table column 'IncludedInApp' is a status indicated for
different settings:

-  1 = Class is used in the app
-  2 = Class is automatically syncronised with M-Files with process_id =

These indicators are used by several procedures for different functions
such as to update all Class tables in the App with a single procedure.

The FilePath column on MFClass is introduced in version 3.1.2.38.  This
column sets the default path for exporting of files using the
spMFExportFiles procedure.  The default is set to
c:/MFSQL_ConnectorFiles

The MFClass table is referenced to the MFClassProperty table,
MFObjectType and MFWorkflow.

MFproperty
~~~~~~~~~~

The columns of the Class Tables is automatically assigned on creation.
The datatype defined by the column **MFDataType** will be applied to
the column. The name of the column is defined in the MFProperty Table in
the column **ColumnName**. A default ColumnName will be created for
each property when the MFproperty Table is created. These names can be
edited.

The **PredefinedOrAutomatic** column indicates if the property is
automatically calculated. These columns will follow the rules set by
M-Files.

The MFProperty tables is referenced by the Valuelist table and the
MFClassProperty Table.

MFClassProperty
~~~~~~~~~~~~~~~

The column **Required** show if the property is required on the
metadata card in M-files. If the property is required then the column in
the class table will be created with a NOT NULL constraint.

All of the columns defined in the MFClassProperty Table for the
specified class will be included in the Class Table with the data types
defined above

MFClassProperty are used by spMFCreateTable when new MF Class Tables are
created. This table maps the properties to specific classes as defined
in the the metadata structure.

The ID's on this table refers to the SQL ID on the MFClass and
MFProperty tables. It does not refer to the MFID on these tables.

The Required column in this table exposes the required properties in
M-Files to SQL and can be used to validate data input in special
applications to avoid errors when the record is updated in M-Files.

MFValuelist
~~~~~~~~~~~

The column **OwnerType** references the Owner Valuelist MFID. For
example: 'State' is owned by 'Workflow'.

MFValuelistItems
~~~~~~~~~~~~~~~~

The valuelist item table has two special columns to provide a unique
reference for a valuelist item accross all valuelist items. The AppRef
is assigned on creation of the valuelist item table and will not be
changed during syncronisation if the valuelist item name or MFID is
changed. The Owner_AppRef references the

Column Definitions: Several special columns are automatically created.
The column order also has a very specific arrangement. See Table Columns
for further detail.

Class tables are not added by the Connector on deployment. The class
tables are added by the developer using the Connector for those M-Files
classes that will be used in the application. See Functional
Description for the creation and use of the class tables

Reference tables
================

The column definition of the following tables are not defined by M-Files
metadata. These tables are used in the Connector for referencing:

-  Utility tables
-  Logging Tables

DataType: The datatype is defined by the MFDataType table.

-  If the datatype is a single lookup then two columns will be created:
   one for the value of the valuelist item and another for the MF ID of
   the valuelist Item as INT type. This allows for the easy reference of
   the values without having to rebuilt all the relationships between
   different lookup tables.
-  If the datatype is a multi lookup then two columns will be created
   with the value column having all the valuelist items separated by ';'
   and the ID column for the property being a varchar list of valuelist
   item id's separated by ','.
