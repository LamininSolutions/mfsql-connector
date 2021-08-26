Class tables
============

.. toctree::
   :maxdepth: 4

Class Table Columns
--------------------

Class tables are not added by the Connector on deployment. The class
tables are added by the developer using the Connector for those M-Files
classes that will be used in the application. See Functional
Description for the creation and use of the class tables.

Table Name: The name of the class table is defined in column TableName
in the MFClass Table. The Connector will create a default name for all
the tables. These names can be edited.

Column Name: The columns in the Class Tables is automatically assigned
on creation. The name of the column is defined in the MFProperty Table
in the column 'ColumnName'. These names can be edited.

Column Definitions: Several special columns are automatically created.
The column order also has a very specific arrangement. See Table Columns
for further detail.

Class Tables and there columns
------------------------------

All of the columns defined in the MFClassProperty Table for the
specified class will be included in the Class Table with the data types
defined above.

Where a property has an ID column and a name column (For example
Customer and Customer_ID) the name column is incidental and does not
have to be updated when changes are made. Only the ID have to be
updated. The name column will be automatically refreshed from the
metadata.

MF Ad-hoc Columns
-----------------

M-Files allow the addition of ad-hoc properties. Also, when a property
is dropped from the metadata definition in M-Files and already have
values on an object, then the property will retain its value.

When the Connector finds an additional property on an object, and it is
not part of the metadata card, then a column will be added to the end of
the Class Table with the columnname and datatype definitions as
previously described.

Non Connector Columns
---------------------

It is possible to add columns to the class table that will be ignored by
the Connector but is available for processing in the application. These
columns must have a prefix of MX\_ (for example MX_SAGE_Code)

Notwithstanding the ability to add additional columns to the Connector
tables following the convension above, it is recommended to create
additional tables for custom applications that is cross referenced to
the Connector tables rather than adding columns to Connector tables.

Special columns
---------------

    Required (NOT NULL)

      If the metadata is a required property as defined in the MFClassProperty
      table then the column will be created with a NOT NULL constraint.

    Column

        The columns that will be created for the table is derived from the
        following:

        -  Default column
        -  Derived from the MFClassProperty Table.
        -  Add - Hoc columns
        -  Non Connector columns

Default columns
---------------

The default columns are created on every class table irrespective of the
mapping of metadata for the specific class. These columns must not be
dropped or renamed. They are located in different sections of the table.

====================== =============================== ================================================================================================================================================================================================================================ ===========================
Default columns        Description                     Special Application                                                                                                                                                                                                              Updatable
====================== =============================== ================================================================================================================================================================================================================================ ===========================
ID                     Identity column for Table       Unique ID                                                                                                                                                                                                                        Identity=Yes, SQL Only
GUID                   MF Guid for object              Creating ULR links to record; SQL cannot update this item                                                                                                                                                                        From M-Files, SQL read only
MX_User_ID             SQL User ID                     External applications can use this column to show SQL user ID for the record                                                                                                                                                     SQL only
Created                MF Created date                 Automated by Connector, no need to specify when creating new record in SQL                                                                                                                                                       From M-Files, SQL Read Only
                       in UTC datetime format
MF_Last_Modified       MF last modified date           Automated by Connector, no need to specify when creating new record in SQL                                                                                                                                                       From M-Files, SQL Read Only
                       in UTC datetime format
MF_Last_Modified_By    MF user name                    From MF to SQL; Automated; do not specify when updating or creating record in SQL                                                                                                                                                From M-Files, SQL Read Only
MF_Last_Modified_By_ID MF user id                      From MF to SQL; Automated; do not specify when updating or creating record in SQL                                                                                                                                                From M-Files, SQL Read Only
Class                  MF Class                        For information only, not required to be updated                                                                                                                                                                                 From M-Files
Class_ID               MF ClassID                      Use Class_ID when combining several class tables into one view in application; Can also be used to move a record from one class to another                                                                                       Updatable
Workflow               MF Workflow                     For information only, not required to be updated                                                                                                                                                                                 From M-Files
Workflow_ID            MF Workflow_ID                  Always include workflow ID when inserting or updating the state                                                                                                                                                                  Updatable
State                  MF State                        For information only, not required to be updated                                                                                                                                                                                 From M-Files
State_ID               MF State_ID                     Used to update or insert a state                                                                                                                                                                                                 Updatable
LastModified           SQL last modified               This column is automated                                                                                                                                                                          SQL Only
                       Local time format
Process_ID             SQL process ID                  Indicator to show status of process of record as per process table. Default value is 0                                                                                                                                           Flag
ObjID                  MF Internal ID                  Leave blank when new records is created in SQL                                                                                                                                                                                   From M-Files, SQL Read Only
ExternalID             MF External ID                  MF allows objects to have external ID, when the external ID is used, it is not longer possible for a user to search for a record in Mfiles by the internal ID. The internal ID is also no longer displayed in the Metadata Card. Updatable
IsSingleFile           MF Single File                  Show status of the Single File property in M-Files. Default value is 0 (multifile)                                                                                                                                               From M-Files, Updatable
FileCount              MF File Count                   Show count of files included in the object                                                                                                                                                                                       From M-Files; SQL Read Only
MFVersion              MF Version                      Automated. Also used by the Connector to identify syncronisation conflicts                                                                                                                                                       From M-Files, SQL Read Only
Deleted                MF Deleted                      Deletion Status of record in MF                                                                                                                                                                                                  From M-Files
Update_ID              SQL history log ID              ID of history log when record was last updated                                                                                                                                                                                   SQL only, Read only
====================== =============================== ================================================================================================================================================================================================================================ ===========================


The following sample statement will list all properties in the vault and
the relationship to the classes.

.. code:: sql

   SELECT * FROM [dbo].[MFClassProperty]
   AS [mcp]INNER
   JOIN [dbo].[MFClass] AS [mc]ON [mc].[ID] = [mcp].[MFClass_ID]
   INNER JOIN [dbo].[MFProperty] AS [mp]ON [mp].[ID] = [mcp].[MFProperty_ID]
   ORDER BY mc.mfid, mp.mfid asc

The following standard properties are included by default on every class
table:

-  Name or title
-  Created
-  Last modified
-  Last modified by
-  Created by

Process_id values
-----------------

== ==================== =====================================================
ID Name                 Description
1  Update               Set by user to show record to be updated by Connector
2  Syncronisation Error Set by Connector to show Syncronisation errors
3  SQLError             Set by Connector to show record with SQL error
4  MFError              Set by Connector to show record with MF error
== ==================== =====================================================

By default the process_ID on the class table is 0.

Refer to error management for more information on handling errors 

Refer to Update ClassTable records for more information on the use of
these process id's.

Indexes on class tables
--------------------------

The use of indexes on class tables could materially improve the efficiency and processing of objects, especially in larger tables.

Indexes is applied specific to the use of columns in the tables.  The Connector provides flexibility regarding the use of indexes.

We recommend to at least set indexes on the objid and external_id columns.  In some cases you may choose to set indexes on these columns in combination with other columns to improve additional efficiency.

MFSettings include a default setting for the creation of indexes. This setting is introduced in version 4.6.16.57.  By default the automatic creation of indexes is set to 0 (do not created indexes).

When this setting is set to 1 then spMFCreateTable will automatically create indexes on objid and external_id.

.. code:: sql

     SELECT * FROM dbo.MFSettings AS ms WHERE name = 'CreateUniqueClassIndexes'

     UPDATE ms
     SET value = '1'
     FROM dbo.MFSettings AS ms
     WHERE name = 'CreateUniqueClassIndexes'

Execute the procedure spMFSetUniqueIndexes to set indexes on all existing class tables, rather than recreating the tables from scratch.

.. code:: sql

   EXEC spmfsetuniqueindexes

Object change history
---------------------

The :doc:`/tables/tbMFObjectChangeHistory/` table include the object change history across all classes

MFSQL allows for extracting the change history for specific objects and for specific properties of these objects.

The data is shown as a row for each version and property change.  The table includes data accross all classes but will only show the data that has previously been extracting using the related procedures.

The table :doc:`/tables/tbMFChangeHistoryUpdateControl/` is used for setting up the properties and tables to be included in the get history process.

Object Versions
---------------

The class tables contain the full object detail including properties of an object.  On the other hand, the Connector also provides for and use the capability of extracting the Object Version only from M-Files.  This significantly improves the effficiency of determining the latest object version and status of an object.

The :doc:`/tables/tbMFAuditHistory/` table contains the object version detail of all classes where the data has been extracted from M-Files.
