
==========================
spMFContextMenuHeadingItem
==========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MenuName nvarchar(100)
    The name visible to the user in the context menu
  @PriorMenu nvarchar(100) (optional)
    - Default = NULL
    - This can be used to re-organise the menu
  @IsObjectContextMenu bit (optional)
    - Default = 0
    - 1 = the heading is used for object sensitive actions
  @IsRemove bit (optional)
    - Default = 0
    - 1 = remove the item from the table
  @UserGroup nvarchar(100)
    Restrict the menu item for to the users in the usergroup
  @Debug int (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

This procedure is designed to add a context menu heading item in MFContextMenu

Prerequisites
=============

It is good practice to add the menu heading first, and then to add the actions using spMFContextMenuActionItem

Examples
========

.. code:: sql

    EXEC [dbo].[spMFContextMenuHeadingItem]
         @MenuName = 'Asynchronous Actions',
         @PriorMenu = 'Synchronous Actions',
         @IsObjectContextMenu = 0,
         @IsRemove = 0,
         @UserGroup = 'All internal users'

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2018-07-15  LC         Add ability to change Heading
==========  =========  ========================================================

