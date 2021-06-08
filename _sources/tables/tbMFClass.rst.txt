
=======
MFClass
=======

Columns
=======

ID int (primarykey, not null)
  SQL Primary key
MFID int (not null)
  Assigned and maintained by M-Files
Name varchar(100) (not null)
  Class name
Alias nvarchar(100)
  - Alias from MF
  - Can be created in bulk by connector
IncludeInApp smallint
  - 1 = class table created
  - 2 = transactional processing
  - Automatically set on table creation
TableName varchar(100)
  Targeted Table name of class
MFObjectType\_ID int
  ID of the object type in MFObjectType table
MFWorkflow\_ID int
  ID of the workflow in assigned to the class in MFWorkflow table
FileExportFolder nvarchar(500)
  - User assigned
  - Used in the exporting of files from M-Files process
SynchPrecedence int
  - Used to assign presedence
ModifiedOn datetime (not null)
  Date last updated
CreatedOn datetime (not null)
  Date initially created in SQL
Deleted bit (not null)
  - Show deleted classed
  - Deleted classes records is automatically removed at next synchronisation
IsWorkflowEnforced bit
  - Maintained by M-files
  - Controls the rules to force workflow on class table

Additional Info
===============

Custom settings for the following columns will be retained when
:doc:`/procedures/spMFDropAndUpdateMetadata/` is used with the correct
parameters

#. The MFClass table is defines the classes included in the connector. The class table names is defined in column **TableName** in the MFClass Table. The Connector will create a default name with prefix **MF** for all the tables. These names can be edited.
#. The MFClass table column **IncludedInApp** has several functions. If this value is set to 1 then it indicates that the Class Table is specifically used in the application. This indicator is used in procedures to refresh or update all Class tables in the App with a single instruction, and are used in many other procedures to sub select classes included in the app. 
#. The FileExportFolder column?defines the root folder to be used when exporting files for the class. Refer to the :doc:`/procedures/spMFExportFiles/` .
#. The SynchPrecedence column defined the precedence for auto fixing of synchronization errors for the class. Refer to the :doc:`/mfsql-integration-connector/using-and-managing-logs/error-tracing/correcting-synchronization-errors/index`

The MFObjectType_ID references the primary key on the MFObjectType table. It is not the same as the M-Files internal ObjectType ID 

The MFWorkflow_ID references the primary key from the MFWorkflow table for the default workflow of the class as set in the metadata definition.  This ID is not the same as the Workflow internal ID.

The IsWorkflowEnforced column is set to 1 when the metadata definition is set to workflow enforced.  Updating a class table where the Workflow column is empty for an class that has workflow enforced will throw an error.

Indexes
=======

udx\_MFClass\_MFID
  - MFID

Foreign Keys
============

The MFClass table references the MFClassProperty, MFObjectType and Workflow tables

Examples
========

.. code:: sql

    -- show all tables included in app
    Select * from MFClass where includeInApp = 1

    -- use metadata structure view to explore class relationships with other objects
    SELECT * FROM [dbo].[MFvwMetadataStructure] AS [mfms] WHERE class = 'Customer'

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
2017-07-06  LC         Add column for filepath
2017-08-22  LC         Add column for syncprecedence
==========  =========  ========================================================

