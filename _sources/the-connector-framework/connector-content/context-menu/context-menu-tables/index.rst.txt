Context Menu Tables
===================

The context menu operation is dependent on the table MFContextMenu. This
table defines the menu items and their associated actions.

.. container:: table-wrap

   ==================== =================================================================================================================================
   Column               Use
   ==================== =================================================================================================================================
   ID                   Primary key
   ActionName           Menu item label
   Action               Procedure called when the menu item is selected
                       
                        Leave blank when record is a menu heading
   Action Type          Defines the type of action that is allowed
                       
                        0 = Menu heading - no action is performed
                       
                        1 = Procedure with no input parameter. Note that this procedure must comply with the preset format
                       
                        2 = URL address - opens up new browser window for this url
                       
                        3 = Procedure with input parameter. Note that this procedure must comply with the preset format
                       
                        4=Procedure are called using a script in the workflow state action
                       
                        5=Procedure is called with input parameters of the objid and class of the object using a script in the workflow state acton
   Message              This message will display to the user when the menu item is selected
   SortOrder            Order in which the menu items will appear within the context of the parent
   ParentID             ID of the heading of the menu item.
                       
                        0 = menu heading
   IsProcessRunning     Default is 0. This column is set to 1
   IsAsync              Default is 0. 0 = Synchronous processing of procedure. 1 = Asynchronous processing of procedure.
    UserGroupID         Default is 1. this is the ID for All Internal Users.  The User Group ID referenced in this column will give access to the action 
    Last_Excecuted_by   The user Id of the M-Files user that last executed the procedure call by this action 
    Last_Excecuted_date The date of last execution 
   ActionUser_ID         The user id of the M-Files user that called this action.
   ==================== =================================================================================================================================

| 

| 

| 
