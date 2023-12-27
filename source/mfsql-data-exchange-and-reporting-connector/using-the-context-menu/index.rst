Using the Context Menu
======================

Installing MFContextMenu
------------------------

Refer to :doc:`/getting-started/configuration-and-setup/installing-the-context-menu/index`
to get ready.

The Context Menu provides the ability for an authorised M-Files Desktop
user to perform the following functions:

#. **Open Web Page**  This is particularly useful if the user is required
   to access a Web Application. Instead of opening another browser, the
   user has a single window to open to go to the solution's Web
   Applications.
#. **Execute a SQL procedure**.  This option allows the user the start an
   action that is built into the SQL application.  An example is to pull
   information from a third party system or perform a match between
   M-Files and the external application.
#. **Execute a SQL procedure for a specific object**.  This option allows
   for the user to perform and operation for the selected object. An
   example is to push an update of the specific item into the Connector.
   Another example is to make a copy of the object, especially where the
   object has a number of related objects that also should be copied and
   comply with specific requirements.
#. **On the change of workflow state or event handler**.  This option
   allows for executing either a procedure without a input parameter, or
   a procedure that takes the object id and class as of the object in
   scope as input parameters.  This method is particularly relevant
   where the procedure must be triggered automatically when the user
   performed a function in M-Files.

Visibility of the Context Menu is controlled by the 'ContextMenu' User
group. 

The availability of individual menu action items can be controller by
adding the user group MFID in the MFContextMenu Table.  By default all
menu items is set to the ContextMenu user group. 

Menu and Menu items
-------------------

The menu consists of:

#. The action button to open the menu
#. The menu items on display

The action for a menu item must be 0 and the parent_id for a menu must also be 0 or Null.

Action Buttons
~~~~~~~~~~~~~~

Using an action 1 or 2
^^^^^^^^^^^^^^^^^^^^^^

Select the MFSQL Connector action button  in the task bar of the M-Files
Desktop client. 

This will open a separate window with menu options. The menu options
depends on preparation of the Context Menu as outlined above. 

Action 3 menu items will not be displayed.

Using the context sensitive action 3
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Select the M-Files object to be actioned.  Right click and select MFSQL
Connector from the bottom of the pop-up menu.

The separate window with menu options will be shown. This menu will only
include the actions that is setup for option 3 (context sensitive
actions).

Only action 3 items will be displayed.

Workflow State or Event Handler Actions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The context menu methods is also used to execute procedures for workflow
state actions or from an event handler

Action 4 and 5 items do not appear in the menu.  They are called
directly from and action script in either the workflow state or event handler.

The parent_id in the context menu for action 4 or 5 must be set to null as it does not relate to a heading in the context menu.

Updating table MFContextMenu
----------------------------

The MFContextMenu table controls the procedures that will be executed and the type of action that will be performed.  Add a record to this table to setup a menu item.

Adding items the to table can be done using various methods

-  Use a SQL Update script to update existing items
-  Use SQL insert script to insert new items

or

-  Use spMFContextMenuHeadingItem to add, update, remove headings
-  Use spMFContextMenuActionItem to add, update or remove action items

Using these procedures ensures that that the related and dependent settings for each action type is correctly set.

Adding a group heading for the menu items
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Menu item can be grouped together by using a header.  Use the following

**Execute Procedure**

.. code:: sql

    INSERT INTO [dbo].[MFContextMenu]
              ([ActionName]
              ,[Action]
              ,[ActionType]
              ,[Message]
              ,[SortOrder]
              ,[ParentID]
    ,UserGroupID)
        VALUES
              ('Group heading 1'
              ,null -- fixed value for headings
              ,0 -- fixed value for headings
              ,null -- fixed value for headings
              ,1 -- this is the sort order for the menu groups
              ,0 -- fixed value for headings
    ,111 -- set this to the usergroup ID of that requires access to the menu item
   )

Adding a menu item
~~~~~~~~~~~~~~~~~~

There are several types of menu items. Any combination of these
menu types can be included. Multiple instances of the same type is
allowed.   Each type will have different considerations and the menu
items will behave differently for each type.

All procedures will be run asynchronously and does not provide interactive feedback to the user on the completion of the process.

**Execute Procedure**

.. code:: sql

    INSERT INTO [dbo].[MFContextMenu]
      ([ActionName]
      ,[Action]
      ,[ActionType]
      ,[Message]
      ,[SortOrder]
      ,[ParentID]
      ,[ISAsync]
      ,UserGroupID)
        VALUES
           ('Name of menu item'
      ,'ProcedureName' -- name of the procedure to be executed, in the case of Action Type 2 the URL of the website is used.
      ,1 -- one of 1, 2 or 3
      ,'Message displayed to user on selecting the item'
      ,1 -- this is the sort order for the menu items in the group
      ,1 -- this is the record ID of the group heading for this item
      ,1 -- set to asynchronous
      ,111 -- set this to the usergroup ID of that requires access to the menu item  )

Set Context menu for sample procedures
--------------------------------------

Installation of all the menu items for the demonstration script

Execute the following statement to reset the menu to the items in this script:

.. code:: sql

     Truncate table MFContextMenu

View the result in table

.. code:: sql

    SELECT * FROM [dbo].[MFContextMenu] AS [mcm]

Use the MFSQL Connector action button in the task bar in M-Files to view the result

The following script will reset the Context Menu to access the sample procedures

.. code:: sql

    SET NOCOUNT ON;
    DECLARE @ItemCount INT;
    DECLARE @Debug INT = 0;
    DECLARE @UserGroup NVARCHAR(100);

    SELECT @ItemCount = COUNT(id) FROM dbo.MFContextMenu AS mcm
    WHERE mcm.ActionName NOT IN ( 'Synchronous Actions', 'Asynchronous Actions', 'Synchronous Object Actions',
                                    'Asynchronous Object Actions', 'Action Type Sync', 'Action Type Async',
                                    'Sync action for context Object', 'Async action for context Object', 'StateAction1',
                                    'StateAction2', 'Web Sites', 'Google website'
                                );

    IF @Debug > 0
        SELECT @ItemCount AS Itemcount;

    IF @ItemCount = 0 -- this procedure will only be executed if no custom menus have been created
    BEGIN

Insert menu items

.. code:: sql

    EXEC dbo.spMFContextMenuHeadingItem @MenuName = 'Synchronous Actions',
            @PriorMenu = '',
            @IsRemove = 0,
            @UserGroup = 'ContextMenu';

      EXEC dbo.spMFContextMenuHeadingItem @MenuName = 'Asynchronous Actions',
            @PriorMenu = 'Synchronous Actions',
            @IsRemove = 0,
            @UserGroup = 'ContextMenu';

     EXEC dbo.spMFContextMenuHeadingItem @MenuName = 'Web Sites',
            @PriorMenu = 'Asynchronous Actions',
            @IsRemove = 0,
            @UserGroup = 'ContextMenu';

     EXEC dbo.spMFContextMenuHeadingItem @MenuName = 'Synchronous Object Actions',
            @PriorMenu = 'Web Sites',
            @IsRemove = 0,
            @IsObjectContextMenu = 1,
            @UserGroup = 'ContextMenu';

     EXEC dbo.spMFContextMenuHeadingItem @MenuName = 'Asynchronous Object Actions',
            @PriorMenu = 'Synchronous Object Actions',
            @IsRemove = 0,
            @IsObjectContextMenu = 1,
            @UserGroup = 'ContextMenu';

Setup Web Site access

.. code:: sql


     EXEC dbo.spMFContextMenuActionItem @ActionName = 'Google website',
            @ProcedureName = 'http://google.com',
            @Description = 'Illustrate access to a website',
            @RelatedMenu = 'Web Sites',
            @IsRemove = 0,
            @IsObjectContext = 0,
            @IsWeblink = 1,
            @IsAsynchronous = 0,
            @IsStateAction = 0,
            @PriorAction = NULL,
            @UserGroup = 'ContextMenu'

Setup Actions

.. code:: sql

      EXEC dbo.spMFContextMenuActionItem @ActionName = 'Action Type Sync',
            @ProcedureName = 'custom.DoCMAction',
            @Description = 'Action the custom.DoCMAction procedure syncronously with feedback message',
            @RelatedMenu = 'Synchronous Actions',
            @IsRemove = 0,
            @IsObjectContext = 0,
            @IsWeblink = 0,
            @IsAsynchronous = 0,
            @IsStateAction = 0,
            @PriorAction = NULL,
            @UserGroup = 'ContextMenu'

      EXEC dbo.spMFContextMenuActionItem @ActionName = 'Action Type Async',
            @ProcedureName = 'Custom.DoCMAsyncAction',
            @Description = 'Action the custom.DoCMAsyncAction procedure Asyncronously - Feedback in User Messages',
            @RelatedMenu = 'Asynchronous Actions',
            @IsRemove = 0,
            @IsObjectContext = 0,
            @IsWeblink = 0,
            @IsAsynchronous = 1,
            @IsStateAction = 0,
            @PriorAction = NULL,
            @UserGroup = 'ContextMenu'

      EXEC dbo.spMFContextMenuActionItem @ActionName = 'Sync action for context Object ',
            @ProcedureName = 'Custom.CMDoObjectAction',
            @Description = 'Action the Custom.DoObjectAction procedure Synchronously with related object including feedback message',
            @RelatedMenu = 'Synchronous Object Actions',
            @IsRemove = 0,
            @IsObjectContext = 1,
            @IsWeblink = 0,
            @IsAsynchronous = 0,
            @IsStateAction = 0,
            @PriorAction = NULL,
            @UserGroup = 'ContextMenu'

      EXEC dbo.spMFContextMenuActionItem @ActionName = 'ASync action for context Object ',
            @ProcedureName = 'Custom.CMDoObjectAction',
            @Description = 'Action the Custom.DoObjectAction procedure Asynchronously with related object including message in UserMessages',
            @RelatedMenu = 'Asynchronous Object Actions',
            @IsRemove = 0,
            @IsObjectContext = 1,
            @IsWeblink = 0,
            @IsAsynchronous = 1,
            @IsStateAction = 0,
            @PriorAction = NULL,
            @UserGroup = 'ContextMenu'

Insert procedures for workflow state actions

.. code:: sql

      EXEC dbo.spMFContextMenuActionItem @ActionName = 'StateAction1',
      @ProcedureName = 'custom.DoCMAction',
            @Description = NULL,
            @RelatedMenu = NULL,
            @IsRemove = 0,
            @IsObjectContext = 0,
            @IsWeblink = 0,
            @IsAsynchronous = 0,
            @IsStateAction = 1,
            @PriorAction = NULL,
            @UserGroup = 'ContextMenu'

      EXEC dbo.spMFContextMenuActionItem @ActionName = 'StateAction2',
            @ProcedureName = 'Custom.CMDoObjectActionForWorkFlowState',
            @Description = NULL,
            @RelatedMenu = NULL,
            @IsRemove = 0,
            @IsObjectContext = 0,
            @IsWeblink = 0,
            @IsAsynchronous = 1,
            @IsStateAction = 1,
            @PriorAction = NULL,
            @UserGroup = 'Context Menu',
            @Debug = 0;
      END;

Context Menu security
---------------------

Context menu security has two dimensions:

#. Only users in the M-Files user group 'ContextMenu' will be able the
   see the MFSQL Connector menu.   
#. Adding a usergroup id in the column UserGroupID in table
   MFContextMenu will restrict access to the individual menu item to the
   members of the group.

ContextMenu user group
~~~~~~~~~~~~~~~~~~~~~~

The ContextMenu user group is automatically installed in the vault
during the installation routine for the replication content package.  By
all internal users is added to this group by default. Individual users
and/or user groups can be added.  Remove the default group when
restricting access to a limited set of users.

Using MFvwUserGroup to get UserGroupID 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default the ContextMenu user group is set as the item level user
group in the UserGroupID column.

The view MFvwUserGroup is a helper to get the ID of existing user groups
that can be assigned to this column.  Use Select \* from MFvwUserGroup
to get the ID.

Create MFContextMenu table record for each  menu item

User either a synchronous or asynchronous operation by setting the
ISAsync column to 1 for Asynchronous.

.. container:: table-wrap

   =========== ========================================================================== ================================================================================================================================= ==== ==============================================================================================================================
   Action type Action Type description                                                    Behaviour                                                                                                                         Show Setup Required
   =========== ========================================================================== ================================================================================================================================= ==== ==============================================================================================================================
   1           execute procedure (no input parameters)                                    Calls the procedure in ActionType.  Procedure will run asynchronously.                                                                 Create procedure with name in ActionType for the menu

                                                                                                                                                                                                                                 Create secondary procedure that is called by the above procedure to perform the action and return appropriate messages to user
   2           show URL                                                                   Opens URL in the default browser in new window outside of the scope of M-Files security context                                        use URL as the ActionType in MFContextMenu
   3           execute procedure with input parameters                                    Calls the procedure with class and objid of the selected item as parameters. Procedure will run asynchronously.                        Create procedure with two parameters and with name in ActionType for the menu

                                                                                                                                                                                                                                 Create secondary procedure that is called by the above procedure to perform the action and return appropriate messages to user
   4           execute procedure from a workflow action with no input parameters required Calls the procedure from a workflow state action                                                                                       Create procedure with name in ActionType for the menu

                                                                                                                                                                                                                                 Add script (sample below) in the workflow state action

                                                                                                                                                                                                                                 Create secondary procedure that is called by the above procedure to perform the action and return appropriate messages to user
   5           execute procedure from a workflow action with input parameters required    Calls the procedure from a workflow state action and passing the object version details back to the procedure as input parameters      Create procedure with name in ActionType for the menu

                                                                                                                                                                                                                                 Add script (sample below) in the workflow state action

                                                                                                                                                                                                                                 Create secondary procedure that is called by the above procedure to perform the action and return appropriate messages to user
   =========== ========================================================================== ================================================================================================================================= ==== ==============================================================================================================================



Procedures for Action Types 1,3,4 in MFContextMenu table
--------------------------------------------------------

The Procedures that is referenced in the 'Action' column in
MFContextMenu must comply with the following requirements. 

-  All procedures must have an output parameter @Output varchar(1000)
   and a @ID int input parameter. The@Output parameter is returned to
   M-Files as a user message on completion (or error) of the routine. 
   The @input parameter is used by the system.
-  Action Type 1 and 4 procedures cannot have input parameters
-  Action Type 3  and 5 procedures must have the following additional
   parameters:  @ObjectID int, @ObjectType int, @ObjectVer
   int, @@ClassID int

Below is samples of the types of procedures that is referenced in the
MFContextMenu table. Note that the messaging component of these sample
scripts utilizes logging and procedures which are only available in the
Developer Module of the Connector.  These procedures will be installed
when the 'Install Sample Menu' option is selected during the MFSQL
Context Menu installation.

Procedure with no context parameters (action type 1)

:download:`Non object related sample procedure <90.103.custom.DoCMAction.sql>`

Procedure with object related parameters (action type 3)

:download:`Object context sensitive sample procedure <90.102.custom.DoCMObjectAction.sql>`

Workflow state scripts
----------------------

When action type 4 and 5 are used the procedure will be triggered by a
script in the workflow state.  The workflow state script must comply
with the following examples.  Note that there are only a few changes to
be done to the script. None of the remainder of the script should be
changed.

Changes to make to allow these scripts to action the designated
procedure:  Change 'workflowState1' in the text below to the name of the
action to be performed in the MFContextMenu table.

For example if the objective is to update the external ERP system with
the details of the approved vendor then add this script to the approved
state for the vendor workflow:

-  Add a record in MFContextMenu with action type = 5, ActionName =
   'VendorApproved', Action = 'custom.StateAction_VendorApproved'. 
-  Add the script below in the Approved workflow state action. Change
   the item ""WorkflowState1"" to ""VendorApproved"" and ensure that the
   ActionTypeID = 5.
-  Create a procedure with the name  following the format requirements
   for a procedure with parameters as outlined above.
-  Create another procedure custom.VendorERPInsert  that is called by
   'custom.StateAction_VendorApproved'. This procedure will perform the
   ERP insert process and return the result of the process to
   'custom.StateAction_VendorApproved'

For Action Type 4 and 5

:download:`workflow or event handler sample procedure <90.104.custom.DoCMObjectActionForWorkFlowState.sql>`

Event Handler scripts
---------------------

Action type 5 can be used in an event handler to trigger a store
procedure based on an event handler.  This will require including the
action script in the event handler with a corresponding record in the
MFContextMenu table.

**Event Handler**

.. code:: vbscript

    Option Explicit

    Dim ClassID
    ClassID= Vault.ObjectPropertyoperations.GetProperty(ObjVer, 100).value.GetLookupID

    Dim strInput
    strInput = "{""ObjectID""  : "&ObjVer.ID &", ""ObjectType""  : "&ObjVer.Type &", ""Objectver""  : "&ObjVer.Version&",""ClassID""  : "&ClassID&", ""ActionName""  : ""StateAction2"", ""ActionTypeID"": ""5""}"

    Dim strOutput
    strOutput = Vault.ExtensionMethodOperations.ExecuteVaultExtensionMethod("PerformActionMethod", strInput)

    'Err.Raise MfScriptCancel, strOutput



User Messaging: spMFResultMessageForUI
--------------------------------------

A helper procedure is included in the Connector to assist with returning
a formatted user message when using the context Menu.

This procedure works hand in hand with the ProcessBatch table and
requires for the main procedure that executes the context menu action to
incorporate logging as outline in :doc:`/mfsql-integration-connector/using-and-managing-logs/index`

