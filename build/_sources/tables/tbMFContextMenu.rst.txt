
=============
MFContextMenu
=============

Columns
=======

ID int (primarykey, not null)
  SQL record id
ActionName varchar(250)
  Name of action. Is used for the Menu item label.
Action varchar(1000)
  Procedure called when the menu item is selected, or the URL of the website to open. 
  Leave blank when record is a menu heading
ActionType int
  Defines the type of action that is allowed
  0 = Menu heading - no action is performed
  1 = Procedure with no input parameter. Note that this procedure must comply with the preset format
  2 = URL address - opens up new browser window for this url
  3 = Procedure with input parameter. Note that this procedure must comply with the preset format
  4 = Procedure are called using a script in the workflow state action
  5 = Procedure is called with input parameters of the objid and class of the object using a script in the workflow state action
Message varchar(500)
  This message will display to the user when the menu item is selected
SortOrder int
  Order in which the menu items will appear within the context of the parent
ParentID int
  ID of the heading of the menu item.
  0 = menu heading
IsProcessRunning bit
  Default is 0. This column is set to 1 by the calling procedure (to be built into custom procedures)
ISAsync bit
  Default is 0. 0 = Synchronous processing of procedure. 1 = Asynchronous processing of procedure.
UserGroupID int
  The User Group ID referenced in this column will give access to the action
Last\_Executed\_By int
  The user Id of the M-Files user that last executed the procedure call by this action. This column is automatically updated when the action originates from the menu in M-Files
Last\_Executed\_Date datetime
  The date of last execution. This column is automatically updated when the action originates from the menu in M-Files.
ActionUser\_ID int
  The user id of the M-Files user that called this action. This column is automatically updated when the action originates from the menu in M-Files.

Used By
=======

- spMFContextMenuActionItem
- spMFContextMenuHeadingItem
- spmfGetAction
- spMFGetContextMenu
- spMFGetContextMenuID
- spMfGetProcessStatus
- spMFProcessBatch\_EMail
- spMFUpdateCurrentUserIDForAction
- spMFUpdateLastExecutedBy


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

