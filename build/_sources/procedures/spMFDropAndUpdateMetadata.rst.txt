
=========================
spMFDropAndUpdateMetadata
=========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @IsResetAll smallint (optional)
    - Default = 0
    - 1 = Reset to default values
  @WithClassTableReset smallint (optional)
    - Default = 0
    - 1 = reset all class tables included in App
  @WithColumnReset smallint (optional)
    - Default = 0
    - 1 = automatically reset column datatypes where datatypes changed
  @IsStructureOnly smallint (optional)
    - Default = 0
    - 1 = include updating of all valuelist items or only main structure elements
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

To drop and update metadata for usage when creating multiple iterations of metadata and table changes during development.

Additional Info
===============

This procedure will only run if metadata structure changes were made. It is therefore useful to add this procedure as a scheduled agent, or as part of key procedures to keep the structure aligned.

Using this procedure will not overwrite custom settings in the structure tables. The custom columns include: 

================  ====================
Table             Customisable columns
================  ====================
MFClass           IncludedInApp
MFClass           TableName
MFClass           FileExportFolder
MFClass           SynchPresendence
MFProperty        ColumnName
MFValuelistItems  AppRef
MFValuelistItems  Owner_AppRef
================  ====================

This procedure can also be used to reset all the metadata, but retain
the custom settings in the Tables when the default is used or @ISResetAll = 0.

Set @ISResetAll = 1 only when custom settings in SQL should be reset to the defaults.  The following custom settings in the metadata tables.?

Setting the parameter @WithClassTableReset = 1 will drop and recreate all class tables where IncludeInApp = 1.  This is particularly usefull during testing or development to reset the class tables. This parameter is set to 0 by default.

Setting the parameter @WithColumnReset = 1 will force the synchronisation to add missing properties to class tables.  This is particularly handy when a property is added to multiple classes on the metadata cards and requires pull through to the class tables in SQL.  This parameter is set to 0 by default.

Use :doc:`/procedures/spMFClassTableColumns/` to review the application and status of properties and columns on class tables.

By default this procedure will not be triggered if only valuelist items have been added in M-Files or no metadata changes have taken place.  To force this procedure to run, set the @IsStructureOnly = 0 to force an update in this scenario. 

Warnings
========

Do no run other procedures (such as spmfupdatetable) while any syncrhonisation of metadata is in progress.

The runtime of this procedure has increased, especially for large complex vaults. This is due to the extended validation checks performed during the procedure.

Not all metadata changes increases the GetMetadataStructureVersionID in M-Files. Changes to valuelist items does not set a version change for metadata changes.

The default options is not appropriate when valuelist items must be included in the update. There are several other methods to achieve the update of valuelist items rapidly, for instance :doc:`/procedures/spMFSynchronizeSpecificMetadata/`

Examples
========

Standard use without any parameters. This will retain all custom settings and only run if changes in M-Files have been detected.

.. code:: sql

     EXEC spMFDropAndUpdateMetadata

Running the procedure with default settings and no structure metadata change has taken place will exit very rapidly.

.. code:: sql

    DECLARE @ProcessBatch_ID INT;
    EXEC [dbo].[spMFDropAndUpdateMetadata] @IsResetAll = 0          
                                          ,@WithClassTableReset = 0 
                                          ,@WithColumnReset = 0     
                                          ,@IsStructureOnly = 1     
                                          ,@ProcessBatch_ID = @ProcessBatch_ID OUTPUT 
                                          ,@Debug = 0 

----

To force an update of metadata when only valuelist items have changed or no metadata change has taken place, set the @IsStructureOnly = 0.

.. code:: sql

    EXEC [dbo].[spMFDropAndUpdateMetadata]
               @IsStructureOnly = 0

----

The parameter @IsResetAll will remove all custom settings in SQL and reset the metadata structure to the vault.  This include removing all the class tables. This should only be used as a tool during prototyping and testing use cases.

.. code:: sql

    EXEC [dbo].[spMFDropAndUpdateMetadata]
               @IsResetAll = 1

---

To reset columns when data types have changed, set the @WithColumnReset = 1

.. code:: sql

    DECLARE @ProcessBatch_ID INT;
    EXEC [dbo].[spMFDropAndUpdateMetadata]
               @IsResetAll = 0
              ,@WithClassTableReset = 0
              ,@WithColumnReset = 1
              ,@IsStructureOnly = 0
              ,@ProcessBatch_ID = @ProcessBatch_ID OUTPUT
              ,@Debug = 0

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-09-08  LC         Add fixing column errors in datatype 9
2019-08-30  JC         Added documentation
2019-08-27  LC         If exist table then drop, avoid sql error when table not exist
2019-08-06  LC         Change of metadata return value, remove if statement
2019-06-07  LC         Fix bug of not setting lookup table label column with correct type
2019-03-25  LC         Fix bug to update when change has taken place and all defaults are specified
2019-01-20  LC         Add prevent deleting data if license invalid
2019-01-19  LC         Add new feature to fix class table columns for changed properties
2018-11-02  LC         Add new feature to auto create columns for new properties added to class tables
2018-09-01  LC         Add switch to destinguish between structure only on including valuelist items
2018-06-28  LC         Add additional columns to user specific columns fileexportfolder, syncpreference
2017-06-20  LC         Fix begin tran bug
==========  =========  ========================================================

