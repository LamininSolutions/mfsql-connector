
================
MFValueListItems
================

Columns
=======

ID int (primarykey, not null)
  SQL Primary Key
Name nvarchar(100)
  Name of the valuelist item
MFID nvarchar(20)
  M-Files internal ID
MFValueListID int
  ID column column in MFValuelist table
OwnerID int
  MFID of the owner valuelistitem
ModifiedOn datetime (not null)
  When was the row last modified in SQL. This column is automatically populated.
CreatedOn datetime (not null)
  When was the row created in SQL. This column is automatically populated.
Deleted bit (not null)
  Is deleted in M-Files
AppRef nvarchar(25)
  Unique reference of the Valuelist item accross all all Valuelists
Owner\_AppRef nvarchar(25)
  AppRef of the Valuelist item that owns the item
ItemGUID nvarchar(200)
  This is the M-Files internally assigned guid and can be used as an alternative unique reference to the item
DisplayID nvarchar(200)
    Display ID from M-Files
Process\_ID int
    default = 0
    values could be 1 or 2 
IsNameUpdate bit
    default = 0


Additional Info
===============

The MFValuelistItem table is a single table with all the valuelist items in the vault.

The valuelist item table has two special columns to provide a unique reference for a valuelist item accross all valuelist items. The AppRef is assigned on creation of the valuelist item table and will not be changed during syncronisation if the valuelist item name or MFID is changed. The Owner_AppRef references the AppRef of the owner.  This feature is of particular importants with vault replication or making a copy of the vault when the unique identifyer for the valuelist item must stay constant accross multiple systems.

The MFValueListID references the primary key of the MFValuelist table and is different from the MFID of the valuelist.  

The OwnerID is the MFID of the valuelist item that owns the particular item.   For example: the document type property value is owned by the class of the object. In this case the ownerID of the valuelist item on the valuelist 'document type' will be the MFID of the class.

The Display id is often the same as the M-Files valuelist item intenal id (MFID). However, it is possible to set this to another id that can be used to link with external systems.

The IsNameUpdate column is used internally to indicate a requirement to push updates of the name of the valuelist item to class tables where this item is being used.

When Process_id = 0 the value from M-Files will be used.  When 1 then SQL value will update M-Files. When set to 2 the item in M-Files will be deleted.

Indexes
=======

idx\_MFValueListItems\_AppRef
  - AppRef

Foreign Keys
============

+-------------------------------------+------------------------------------------------------------------+
| Name                                | Columns                                                          |
+=====================================+==================================================================+
| FK\_MFValueListItems\_MFValueList   | MFValueListID->\ `[dbo].[MFValueList].[ID] <MFValueList.md>`__   |
+-------------------------------------+------------------------------------------------------------------+


Examples
========

.. code:: sql

    SELECT mvli.*, mvl.name, mvli2.name FROM [dbo].[MFValueListItems] AS [mvli]
    left JOIN [dbo].[MFValueList] AS [mvl]
    ON mvl.id = mvli.[MFValueListID]

    INNER JOIN [dbo].[MFValueListItems] AS [mvli2]
    ON mvli2.[AppRef] = mvli.[Owner_AppRef]
    WHERE mvli.[OwnerID] <> 0

Change control
==============

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

