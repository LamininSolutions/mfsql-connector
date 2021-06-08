
===============
spMFCreateTable
===============

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ClassName nvarchar(128)
    - Valid Class Name as a string
    - Pass the class name, e.g.: 'Customer'
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

To create table for a class with associate properties and other custom columns (like ID, GUID, MX\_User\_ID, MFID, ExternalID, MFVersion, FileCount, IsSingleFile, Update\_ID, and LastModified)
The column **IncludedInApp** in the MFCLass table is set to 1 for the created class table.

Additional Info
===============

Class tables are not added by the Connector on deployment. The class tables are added by the developer using the Connector for those M-Files classes that will be used in the application.

Table Name
----------

The name of the class table is defined in column TableName in the MFClass Table. The Connector will create a default name for all the tables. These names can be customised.

Column Name
-----------

The name of the column is defined in the MFProperty Table in **ColumnName**. These names can be customised.
Several special columns are automatically created:

- Metadata structure properties
- Standard or system properties
- Additional properties
- Columns for special purposes
- Non Connector columns

The column order also has a very specific order.

Property Column Definitions
---------------------------

The metadata structure property columns in the Class Table is defined in the MFClassProperty table.
Single and multi-lookup properties will have both a label column and a ID column, for example Customer and Customer_ID. The label column is incidental and does not have to be updated when changes are made. Only the ID have to be updated. The name column will be automatically refreshed from the metadata.
If the metadata is a required property as defined in the MFClassProperty table then the column will be created with a NOT NULL constraint.

MF Addidional Property
----------------------

M-Files allow the addition of ad-hoc properties. When a property is dropped from the metadata definition in M-Files and already have values on an object, then the property will retain its value.

When the Connector finds an additional property on an object, and it is not part of the metadata card, then a column will be added to the end of the Class Table with the columnname and datatype definitions as previously described.

Non Connector Columns
---------------------

It is possible to add columns to the class table that will be ignored by the Connector but is available for processing in the application. These columns must have a prefix of MX\_ (for example MX_SAGE_Code)

Notwithstanding the ability to add additional columns to the Connector tables following the convension above, it is recommended to create additional tables for custom applications that is cross referenced to the Connector tables rather than adding columns to Connector tables.

Special columns
---------------

=======================  ===============  ================================================================  ================
Column                   Description      Special application                                               Updateable
-----------------------  ---------------  ----------------------------------------------------------------  ----------------
Workflow_ID              MF Workflow_ID   Always include workflow ID when inserting or updating the state   Updatable
Workflow                 MF Workflow      For information only, not required to be updated                  From M-Files
Update_ID                SQL history log  ID of history log when record was last updated                    SQL only, Read only
State_ID                 MF State_ID      Used to update or insert a state                                  Updatable
State                    MF State         For information only, not required to be updated                  From M-Files
Process_ID               SQL process ID   Show status of process of record. Default value is 0              Flag
ObjID                    MF Internal ID   Leave blank when new records is created in SQL                    From M-Files
MX_User_ID               SQL User ID      External applications SQL user ID for the record                  SQL only
MFVersion                MF Version       Last MF Version                                                   From M-Files
MF_Last_Modified_By_ID   MF user id                                                                         From M-Files
MF_Last_Modified_By      MFuser name                                                                        From M-Files
MF_Last_Modified         last modified    M-Files last modified in UTC datetime format                      From M-Files
LastModified             last modified    When SQL last updated, SQL server Local time format               Default Getdate()
IsSingleFile             MF Single File   Show status of the Single File property in M-Files.               From M-Files, Updatable
ID                       Identity         Record id in SQL                                                  SQL Only
GUID                     MF object Guid   Used for creating ULR links to record                             From M-Files
FileCount                MF File Count    Count of files included in the object                             From M-Files
ExternalID               MF External ID   MF displayID, must be unique                                      Updatable
Deleted                  MF Deleted       Deletion Status of record in MF                                   From M-Files
Created                  MF Created date  In UTC datetime format                                            From M-Files
=======================  ===============  ================================================================  ================

Prerequisites
=============

Class name exist
MFClass table contains names of the valid classes

Warnings
========

Drop and recreate to reset a class table when the table name is customised in MFClass
When an additional property is added in M-Files to an object the column will automatically be added at the end of the table.

Examples
========

.. code:: sql

   EXEC spMFCreateTable 'Customer'

----

.. code:: sql

   DECLARE    @return_value int
   EXEC       @return_value = [dbo].[spMFCreateTable]
              @ClassName =  N'Customer'
   SELECT    'Return Value'  = @return_value
   GO


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2015-05-23  DEV2       Default column ExternalID added
2015-05-25  DEV2       Default column Update_ID added
2016-06-27  LC         Automatically add includeInApp if null
2016-08-18  LC         Add system columns with localized text names that is required for creating a new record
2016-09-10  LC         Set process_ID default to 1 and deleted default to 0 on creating new record
2016-10-02  LC         Update multi lookup columns to nvarchar(4000)
2016-10-13  DEV2       Added Single_File Column in Class table
2016-10-15  LC         Change Default of Single_file to 0
2017-07-06  LC         Add new default column for FileCount
2017-11-29  LC         Add error message of file does not exist or table already exist
2018-04-17  LC         Add condition to only create trigger on table if includedinApp is set to 2 (for transaction based tables.)
2018-10-30  LC         Add creating unique index on objid and externalid
2019-09-20  LC         allow for ID at end of name of a lookup property
2019-10-14  LC         Resolve multilookup table data type incorrectly set
2019-12-01  LC         Resolve where duplicate columns exist and removal of ID
2020-03-11  LC         Add check license
2020-03-18  LC         Add non clustered unique index for objid
2020-03-27  LC         Add MFSetting to allow optional create of indexes
2020-04-22  LC         Improve naming of constraints
2020-05-12  LC         Add index on Update_ID to improve performance
2020-08-18  LC         replace deleted column flag with property 27 (deleted)
2020-11-21  LC         Fix bug with unique index on objid
2021-01-22  LC         set default schema to dbo
==========  =========  ========================================================

