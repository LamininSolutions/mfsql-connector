spMFContextMenuActionItem
=========================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      This helper procedure is used to add, update or remove an action
      item from the MFContextMenu table.

      By setting each parameter, the correct values will be added to the
      columns in MFContextMenu for the different types of actions

      It is useful the add the menu heading first before adding the
      action (see spMFContextMenuHeadingItem)

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         =========== ========
         Module      Release#
         =========== ========
         Integration 4.1.5.41
         =========== ========

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== =============================================================================================================
         Type           Description
         ============== =============================================================================================================
         Procedure Name spMFContextMenuActionItem
         Inputs         ActionName: this is the name visible to the user in the contextmenu
                       
                        ProcedureName: name of the procedure to be executed
                       
                        Description: this description is visible to the user
                       
                        RelatedMenu: Menu name for the action
                       
                        IsRemove: set to 1 to remove the item from the table
                       
                        IsObjectContext: set to 1 if the action will be performed as a object context related action.
                       
                        IsWeblink: set to 1 if the action is a url link
                       
                        IsAsynchronous: set to 1 if the action should be performed asynchronously
                       
                        IsStateAction: set to 1 if the action will be executed in a workflow state
                       
                        PriorAction: set to null if not needed, or set to the name of the action that should be preceding in the menu
                       
                        UserGroup: set to the name of the user group which should be able to perform the action
                       
                        Debug: 1 = Debug Mode; 0 = No Debug (default)
         Outputs        1 = success
         ============== =============================================================================================================

.. container:: code panel pdl

   .. container:: codeContent panelContent pdl

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
         @Debug = 0            -- int                                       
