
===============================
spMFSynchronizeSpecificMetadata
===============================

Return
  - 1 = Success
  - -1 = Error
  
Parameters
  @Metadata varchar(100)
    type of metadata from list below
  @IsUpdate smallint
    default = 0
    if set to 1 the procedure will update from SQL to M-Files
  @ItemName varchar(100)
    default = null
    only applicable for valuelistitems.  Use name of valuelist to synchronise a specific valuelist
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

Procedure will synchronise the metadata for one of the following

- Properties
- Valuelist
- Valuelistitems
- Workflow
- States
- ObjectType
- LoginAccount
- UserAccount

Using the @ItemName parameter for the specifying a valuelist name, the valuelists items for a specific valuelist can be updated.

Setting the @IsUpdate parameter to 1 will allow for the updating of the name from SQL to M-Files.

Additional Info
===============

This procedure is particularly useful when a small change was made in the vault that need to be pulled through.??

When changes are made to classes it is very important to perform all the dependent specific synchronizations before doing the class synchronization.

WHEN using the @Metadata parameter, only partial names can be used. 
 - use 'Proper' for 'Properties'
 - use 'Valuelist' for'Valuelist'
 - use 'Item' for'Valuelistitems'
 - use 'Workflow' for'Workflow'
 - use 'Stat' for'States'
 - use 'Object' for'ObjectType'
 - use 'Login' for'LoginAccount'
 - use 'User' for'UserAccount'

The @Update parameter is used for making a change to the name for the following objects.  A separate routine is used to make a change to valuelist items.  This update only include changing an existing item and cannot add new rows for these objects.

- Properties
- Valuelist
- Workflow
- States
- ObjectType
- LoginAccount
- UserAccount

Refer to :doc:`/procedures/spMFSynchronizeValueListItemsToMfiles/` for updating valuelist items

Examples
========

.. code:: sql

   EXEC [spMFSynchronizeSpecificMetadata] 'Class'; 

.. code:: sql

    EXEC [dbo].[spMFSynchronizeSpecificMetadata]
    @Metadata = 'User', --  ObjectType; Class; Property; Valuelist; ValuelistItem; Workflow; State; User; Login
    @IsUpdate = 0,  -- set to 1 to push updates to M-Files
    @ItemName = NULL , --only application for valuelists
    @Debug = 0

------

Only update value list items for a specific valuelist

.. code:: sql

    EXEC [dbo].[spMFSynchronizeSpecificMetadata] 
    @Metadata = 'Valuelist'	-- to set this for Valuelists
    ,@ItemName = 'Country'	-- use any valuelist name to update only the valuelist items for the selected item

-----

Review the tables with the metadata

.. code:: sql

    SELECT TOP 100 * FROM [dbo].[MFProperty] as [mp]
    SELECT TOP 100 * FROM [dbo].[MFClass] as [mc]
    SELECT TOP 100 * FROM [dbo].[MFValueList] as [mvl]
    SELECT TOP 100 * FROM [dbo].[MFValueListItems] as [mvli]
    SELECT TOP 100 * FROM [dbo].[MFWorkflow] as [mw]
    SELECT TOP 100 * FROM [dbo].[MFWorkflowState] as [mws]
    SELECT TOP 100 * FROM [dbo].[MFObjectType] as [mot]
    SELECT TOP 100 * FROM [dbo].[MFUserAccount] as [mua]
    SELECT TOP 100 * FROM [dbo].[MFLoginAccount] as [mla]

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2016-08-22  LC         Update settings index
2016-09-09  LC         Add login accounts and user accounts
2016-09-09  LC         provide for slight differences in metadata parameter
2016-09-26  DevTeam2   Removed vault settings parameters 
2016-12-08  LC         Add update as parameter
2015-04-08  Dev1       Create procedure
==========  =========  ========================================================

