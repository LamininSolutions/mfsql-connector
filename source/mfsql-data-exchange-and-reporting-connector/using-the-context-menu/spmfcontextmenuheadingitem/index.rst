spMFContextMenuHeadingItem
==========================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      This procedure is designed to add a context menu heading item in
      MFContextMenu

      It is good practice to add the menu heading first, and then to add
      the actions using spMFContextMenuActionItem

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

         ============== =================================================================================
         Type           Description
         ============== =================================================================================
         Procedure Name spMFContextMenuHeadingItem
         Inputs         MenuName: this is the name visible to the user in the context menu
                       
                        PriorMenu: this can be used to re-organise the menu
                       
                        IsObjectContextMenu: set to 1 if the heading is used for object sensitive actions
                       
                        IsRemove: set to 1 to remove
                       
                        UserGroup: this will restrict the menu item for to the users in the usergroup
                       
                        Debug: 1 = Debug Mode; 0 = No Debug (default)
         Outputs        1 = success
         ============== =================================================================================

| 

.. container:: code panel pdl

   .. container:: codeContent panelContent pdl

      .. code:: sql

         EXEC [dbo].[spMFContextMenuHeadingItem] 
         @MenuName = 'Asynchronous Actions', 
         @PriorMenu = 'Synchronous Actions', 
         @IsObjectContextMenu = 0, 
         @IsRemove = 0, 
         @UserGroup = 'All internal users' 

| 
