
=========================
spMFContextMenuActionItem
=========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ActionName nvarchar(100)
    Name visible to the user in the contextmenu
  @ProcedureName nvarchar(100)
    Name of the procedure to be executed
  @Description nvarchar(200)
    Description is visible to the user
  @RelatedMenu nvarchar(100)
    Menu name for the action
  @IsRemove bit (optional)
    - Default = 0
    - 1 = remove the item from the table
  @IsObjectContext bit (optional)
    - Default = 0
    - 1 = the action will be performed as a object context related action
  @IsWeblink bit (optional)
    - Default = 0
    - 1 = the action is a url link
  @IsAsynchronous bit (optional)
    - Default = 0
    - 1 = the action should be performed asynchronously
  @IsStateAction bit (optional)
    - Default = 0
    - 1 = the action will be executed in a workflow state
  @PriorAction nvarchar(100)
    - NULL if not needed
    - The name of the action that should be preceding in the menu
  @UserGroup nvarchar(100)
    The name of the user group which should be able to perform the action
  @Debug int (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======

This helper procedure is used to add, update or remove an action item from the MFContextMenu table.

Additional Info
===============

By setting each parameter, the correct values will be added to the columns in MFContextMenu for the different types of actions
It is useful the add the menu heading first before adding the action (see spMFContextMenuHeadingItem)

Examples
========

.. code:: sql

    EXEC [dbo].[spMFContextMenuActionItem]
         @ActionName = 'Perform the update' ,
         @ProcedureName = 'Custom.DoMe',
         @Description = 'Procedure to action the update',
         @RelatedMenu = 'Asynchronous Actions',
         @IsRemove = 0,
         @IsObjectContext = 0,
         @IsWeblink = 0,
         @IsAsynchronous = 0,
         @IsStateAction = 0,
         @PriorAction = 'Name if action',
         @UserGroup = 'Internal users',
         @Debug = 0

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2018-07-15  LC         Add state actions
==========  =========  ========================================================

