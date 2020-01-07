
================
MFValueListItems
================

Columns
=======

ID int (primarykey, not null)
  SQL Primary Key
Name nvarchar(100)
  fixme description
MFID nvarchar(20)
  M-Files ID
MFValueListID int
  Associated MFValueList primary key
OwnerID int
  fixme description
ModifiedOn datetime (not null)
  When was the row last modified
CreatedOn datetime (not null)
  When was the row created
Deleted bit (not null)
  Is deleted
AppRef nvarchar(25)
  AppRef of the Valuelist item
Owner\_AppRef nvarchar(25)
  AppRef of the Valuelist item that owns the item
ItemGUID nvarchar(200)
  This is the M-Files internally assigned guid and can be used as an alternative unique reference to the item
DisplayID nvarchar(200)
  Usually this is the same as the MFID, This id can be used in M-Files external connector to set a different ID to the MFID
Process\_ID int
  - 0 = use M-Files value
  - 1 = use SQL value to update M-Files
  - 2 = delete item in M-Files
IsNameUpdate bit
  fixme description

Additional Info
===============

The MFValuelistItem table is a single table with all the valuelist items in the vault.

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

Uses
====

- MFValueList

Used By
=======

- MFvwUserGroup
- spMFDropAndUpdateMetadata
- spMFInsertValueListItems
- spmfSynchronizeLookupColumnChange
- spMFSynchronizeValueListItems
- spMFSynchronizeValueListItemsToMFiles

Examples
========

.. code:: sql

    SELECT mvli.*, mvl.name, mvli2.name FROM [dbo].[MFValueListItems] AS [mvli]
    left JOIN [dbo].[MFValueList] AS [mvl]
    ON mvl.id = mvli.[MFValueListID]

    INNER JOIN [dbo].[MFValueListItems] AS [mvli2]
    ON mvli2.[AppRef] = mvli.[Owner_AppRef]
    WHERE mvli.[OwnerID] <> 0

=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

