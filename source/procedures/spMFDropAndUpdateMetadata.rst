
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
    - 101 = Advanced Debug Mode


Purpose
=======

To drop and update metadata for usage when creating multiple iterations of metadata and table changes during development.

Additional Info
===============

This procedure will only run if metadata structure changes were made. It is therefore useful to add this procedure as a scheduled agent, or as part of key procedures to keep the structure aligned.

Use spMFClassTableColumns to review the application and status of properties and columns on class tables.

Prerequisites
=============

Warnings
========

Do no run other procedures (such as spmfupdatetable) while any syncrhonisation of metadata is in progress.

The runtime of this procedure has increased, especially for large complex vaults. This is due to the extended validation checks performed during the procedure.

Not all metadata changes increases the GetMetadataStructureVersionID in M-Files. Changes to valuelist items are not incluced.
The default options is not appropriate when valuelist items must be included in the update There are several other methods to achieve the update of valuelist items rapidly.

Examples
========

Running the procedure with default settings and no structure metadata change has taken place will exit very rapidly.

.. code:: sql

    DECLARE @ProcessBatch_ID INT;
    EXEC [dbo].[spMFDropAndUpdateMetadata] @IsResetAll = 0          -- smallint
                                          ,@WithClassTableReset = 0 -- smallint
                                          ,@WithColumnReset = 0     -- smallint
                                          ,@IsStructureOnly = 1     -- smallint
                                          ,@ProcessBatch_ID = @ProcessBatch_ID OUTPUT -- int
                                          ,@Debug = 0               -- smallint

----

To force an update of metadata when only valuelist items have changed, set the @IsStructureOnly = 0.
Running the procedure with default settings will automatically add any missing columns on the class tables.

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

    EXEC [dbo].[spMFDropAndUpdateMetadata]
    @IsResetAll = 1

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

