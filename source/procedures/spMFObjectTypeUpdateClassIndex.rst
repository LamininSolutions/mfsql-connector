
==============================
spMFObjectTypeUpdateClassIndex
==============================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @IsAllTables 
    - Default 0
    - When set to 1 it will get the object versions for all class tables
  @MFTableName
    - Class table name to perform the update for a single table
  @ProcessBatch_ID
    - Process batch id to manage to logging process
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

This procedure will update the table MFObjectTypeToClassObject with the latest version of all objects in the class.

The table is useful to get a total of objects by class and also to identify the class from the objid where multiple classes is related to an object type.

Prerequisites
=============

When parameter @IsAllTables is set to 0 then it will only perform the operation on the class tables with the column IncludeInApp not null.

Examples
========

to update all object types and tables

.. code:: sql

    EXEC [spMFObjectTypeUpdateClassIndex]  @IsAllTables = 1,  @Debug = 0  

    SELECT * FROM dbo.MFvwObjectTypeSummary AS mfots

to update only tables included in the application

.. code:: sql

    EXEC [spMFObjectTypeUpdateClassIndex]  @IsAllTables = 0,  @Debug = 0  

to update a single table

.. code:: sql

    EXEC [spMFObjectTypeUpdateClassIndex]  @IsAllTables = 0, @MFTableName = 'Customer',  @Debug = 0  

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2016-04-24  LC         Created
2017-11-23  lc         localization of MF-LastModified and MFLastModified by
2018-12-15  lc         bug with last modified date; add option to set objecttype
2018-13-21  LC         add feature to get reference of all objects in Vault
2020-08-13  LC         update assemblies to set date formats to local culture
2020-08-22  LC         update to take account of new deleted column
2021-03-17  LC         Set updatestatus = 1 when not matched
2022-04-12  LC         Add logging, remove updating MFclass, add error handling
2023-02-17  LC         Resolve bug on not updating class
==========  =========  ========================================================

