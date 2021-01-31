
=============
MFContextMenu
=============

Columns
=======

ID int (primarykey, not null)
  fixme description
ActionName varchar(250)
  fixme description
Action varchar(1000)
  fixme description
ActionType int
  fixme description
Message varchar(500)
  fixme description
SortOrder int
  fixme description
ParentID int
  fixme description
IsProcessRunning bit
  fixme description
ISAsync bit
  fixme description
UserGroupID int
  fixme description
Last\_Executed\_By int
  fixme description
Last\_Executed\_Date datetime
  fixme description
ActionUser\_ID int
  fixme description

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

