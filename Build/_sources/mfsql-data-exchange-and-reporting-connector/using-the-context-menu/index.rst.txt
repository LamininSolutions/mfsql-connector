Using the Context Menu
======================

Installing MFContextMenu
------------------------

Refer to :doc:`/getting-started/first-time-installation/installing-the-context-menu/index`
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

Workflow State Actions
~~~~~~~~~~~~~~~~~~~~~~

The context menu methods is also used to execute procedures for workflow
state actions

Action 4 and 5 items do not appear in the menu.  They are called
directly from and action script in the workflow state.

These procedures are triggered by adding a script in the workflow state.

Updating table MFContextMenu
----------------------------

The MFContextMenu table controls the
procedures that will be executed and the type of action that will be
performed.  Add a record to this table to setup a menu item.

Adding items the to table can be done using various methods

-  Use SQL Update statement to update existing items
-  Use SQL insert statement to insert new items

or

-  Use spMFContextMenuHeadingItem to add, update, remove headings
-  Use spMFContextMenuActionItem to add, update or remove action items

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

Note that each procedure can be set to be either synchronous or
asynchronous.  When the procedure is processed synchronous it will allow
for feedback to the user on the outcome of the procedure in the context
menu.  When the process is asynchronous, is will continue to process in
the background and allow the user to continue with M-Files operations. 
See the section on Messaging for further guidance on providing feedback
in different situations.

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

Procedure with no context parameters (action type 1,4)

**Execute Procedure**

.. code:: sql

    Create PROCEDURE [Custom].[DoCMAction]
          @ID INT
        , @OutPut VARCHAR(1000) OUTPUT
    AS
          BEGIN
                BEGIN TRY

                      SET @OutPut = 'Process Start Time: ' + CAST(GETDATE() AS VARCHAR(50)) --- set custom process start message for user

      -- Setting Params

                      DECLARE @ProcessBatch_ID INT
                            , @procedureName NVARCHAR(128) = 'custom.DoCMAction'
                            , @ProcedureStep NVARCHAR(128)
                            , @StartTime DATETIME
                            , @Return_Value INT

                      BEGIN
      --Updating MFContextMenu to show that process is still running
                            UPDATE  [dbo].[MFContextMenu]
                            SET     [MFContextMenu].[IsProcessRunning] = 1
                            WHERE   [MFContextMenu].[ID] = @ID

     --Logging start of process batch

                            EXEC [dbo].[spMFProcessBatch_Upsert]
                                @ProcessBatch_ID = @ProcessBatch_ID OUTPUT
                              , -- int
                                @ProcessType = @procedureName
                              , -- nvarchar(50)
                                @LogType = N'Message'
                              , -- nvarchar(50)
                                @LogText = @OutPut
                              , -- nvarchar(4000)
                                @LogStatus = N'Started'
                              , -- nvarchar(50)
                                @debug = 0 -- tinyint
                            SET @ProcedureStep = 'Metadata Syncronisation '
                            SET @StartTime = GETDATE()
                            EXEC [dbo].[spMFProcessBatchDetail_Insert]
                                @ProcessBatch_ID = @ProcessBatch_ID
                              , -- int
                                @LogType = N'Message'
                              , -- nvarchar(50)
                                @LogText = @OutPut
                              , -- nvarchar(4000)
                                @LogStatus = N'In Progress'
                              , -- nvarchar(50)
                                @StartTime = @StartTime
                              , -- datetime
                                @MFTableName = NULL
                              , -- nvarchar(128)
                                @Validation_ID = NULL
                              , -- int
                                @ColumnName = NULL
                              , -- nvarchar(128)
                                @ColumnValue = NULL
                              , -- nvarchar(256)
                                @Update_ID = NULL
                              , -- int
                                @LogProcedureName = @procedureName
                              , -- nvarchar(128)
                                @LogProcedureStep = @ProcedureStep
                              , -- nvarchar(128)
                                @debug = 0 -- tinyint
                      END
    --- start of custom process for the action, this example updates perform metadata synchronization

                      BEGIN
                            EXEC @Return_Value = [dbo].[spMFSynchronizeMetadata]
                                @Debug = 0
                              , -- smallint
                                @ProcessBatch_ID = @ProcessBatch_ID  -- int
                      END
    -- set custom message to user
                      SET @OutPut = @OutPut + ' Process End Time= ' + CAST(GETDATE() AS VARCHAR(50))

                      BEGIN
    -- reset process running in Context Menu
                            UPDATE  [dbo].[MFContextMenu]
                            SET     [MFContextMenu].[IsProcessRunning] = 0
                            WHERE   [MFContextMenu].[ID] = @ID
    -- logging end of process batch
                            EXEC [dbo].[spMFProcessBatch_Upsert]
                                @ProcessBatch_ID = @ProcessBatch_ID
                              , -- int
                                @ProcessType = N'Syncronize metadata'
                              , -- nvarchar(50)
                                @LogType = N'Message'
                              , -- nvarchar(50)
                                @LogText = @OutPut
                              , -- nvarchar(4000)
                                @LogStatus = N'Completed'
                              , -- nvarchar(50)
                                @debug = 0 -- tinyint
                            SET @ProcedureStep = 'End Metadata syncrhorization'
                            SET @StartTime = GETDATE()
                            EXEC [dbo].[spMFProcessBatchDetail_Insert]
                                @ProcessBatch_ID = @ProcessBatch_ID
                              , -- int
                                @LogType = N'Message'
                              , -- nvarchar(50)
                                @LogText = @OutPut
                              , -- nvarchar(4000)
                                @LogStatus = N'Success'
                              , -- nvarchar(50)
                                @StartTime = @StartTime
                              , -- datetime
                                @MFTableName = NULL
                              , -- nvarchar(128)
                                @Validation_ID = NULL
                              , -- int
                                @ColumnName = NULL
                              , -- nvarchar(128)
                                @ColumnValue = NULL
                              , -- nvarchar(256)
                                @Update_ID = NULL
                              , -- int
                                @LogProcedureName = @procedureName
                              , -- nvarchar(128)
                                @LogProcedureStep = @ProcedureStep
                              , -- nvarchar(128)
                                @debug = 0 -- tinyint
                      END
    -- format message for display in context menu
                      EXEC [dbo].[spMFResultMessageForUI]
                        @ClassTable = ''
                      , -- varchar(100)
                        @RowCount = 0
                      , -- int
                        @Processbatch_ID = @Processbatch_ID
                      , -- int
                        @MessageOUT = @OutPut OUTPUT -- nvarchar(4000)
                END TRY
                BEGIN CATCH
                      SET @OutPut = 'Error:'
                      SET @OutPut = @OutPut + ( SELECT  ERROR_MESSAGE()
                                              )
                END CATCH
          END

Procedure with parameters (action type 3)

.. code:: sql

    CREATE PROCEDURE [Custom].[CMDoObjectAction]
          @ObjectID INT
        , @ObjectType INT
        , @ObjectVer INT
        , @ID INT
        , @OutPut VARCHAR(1000) OUTPUT
     , @ClassID int
    AS
          BEGIN
                DECLARE @MFClassTable NVARCHAR(128)
                DECLARE @SQLQuery NVARCHAR(MAX)
                DECLARE @Params NVARCHAR(MAX)
                BEGIN TRY

                      SET @OutPut = 'Process Start Time: ' + CAST(GETDATE() AS VARCHAR(50)) --- set custom process start message for user

      -- Setting Params

             BEGIN
                            DECLARE @ProcessBatch_ID INT
                                  , @procedureName NVARCHAR(128) = 'custom.CMDoObjectAction'
                                  , @ProcedureStep NVARCHAR(128)
                                  , @StartTime DATETIME
                                  , @Return_Value INT
      --Updating MFContextMenu to show that process is still running
                            UPDATE  [dbo].[MFContextMenu]
                            SET     [MFContextMenu].[IsProcessRunning] = 1
                            WHERE   [MFContextMenu].[ID] = @ID
    --Logging start of process batch
                            EXEC [dbo].[spMFProcessBatch_Upsert]
                                @ProcessBatch_ID = @ProcessBatch_ID OUTPUT
                              , -- int
                                @ProcessType = @procedureName
                              , -- nvarchar(50)
                                @LogType = N'Message'
                              , -- nvarchar(50)
                                @LogText = @OutPut
                              , -- nvarchar(4000)
                                @LogStatus = N'Started'
                              , -- nvarchar(50)
                                @debug = 0 -- tinyint
                            SET @ProcedureStep = 'Start custom.DoObjectAction'
                            SET @StartTime = GETDATE()
                            EXEC [dbo].[spMFProcessBatchDetail_Insert]
                                @ProcessBatch_ID = @ProcessBatch_ID
                              , -- int
                                @LogType = N'Message'
                              , -- nvarchar(50)
                                @LogText = @OutPut
                              , -- nvarchar(4000)
                                @LogStatus = N'In Progress'
                              , -- nvarchar(50)
                                @StartTime = @StartTime
                              , -- datetime
                                @MFTableName = @MFClassTable
                              , -- nvarchar(128)
                                @Validation_ID = NULL
                              , -- int
                                @ColumnName = NULL
                              , -- nvarchar(128)
                                @ColumnValue = NULL
                              , -- nvarchar(256)
                                @Update_ID = NULL
                              , -- int
                                @LogProcedureName = @procedureName
                              , -- nvarchar(128)
                                @LogProcedureStep = @ProcedureStep
                              , -- nvarchar(128)
                                @debug = 0 -- tinyint
                      END
    --- start of custom process for the action, this example updates keywords property on the object
                      BEGIN
                            DECLARE @Name_or_Title NVARCHAR(100)
                            DECLARE @Update_ID INT
    --get object from M-Files
    SELECT @MFClassTable = TableName FROM MFClass WHERE MFID = @ClassID
    IF not EXISTS(SELECT T.TABLE_NAME FROM INFORMATION_SCHEMA.TABLES AS T WHERE T.TABLE_NAME = @MFClassTable)
    EXEC dbo.spMFCreateTable @ClassName = N'@MFClassTable', -- nvarchar(128)
        @Debug = 0 ;-- smallint;
                            EXEC @Return_Value = [dbo].[spMFUpdateTableWithLastModifiedDate]
                                @UpdateMethod = 1
                              , -- int
                                @Return_LastModified = NULL
                              , -- datetime
                                @TableName = @MFClassTable
                              , -- sysname
                                @Update_IDOut = @Update_ID OUTPUT
                              , -- int
                                @debug = 0
                              , -- smallint
                                @ProcessBatch_ID = @ProcessBatch_ID -- int
    --Perform action on/with object

                            SET @Params = N'@Output nvarchar(100), @ObjectID int'
                            SET @SQLQuery = N'

         UPDATE mot
         SET process_ID = 1
         ,Keywords = ''Updated in '' + @OutPut
         FROM ' + @MFClassTable + ' mot WHERE [objid] = @ObjectID '

                            EXEC [sys].[sp_executesql]
                                @SQLQuery
                              , @Params
                              , @OutPut = @OutPut
                              , @ObjectID = @ObjectID
    --process update of object into M-Files

                            EXEC [dbo].[spMFUpdateTable]
                                @MFTableName = @MFClassTable
                              , -- nvarchar(128)
                                @UpdateMethod = 0
                              , -- int
                                @ObjIDs = @ObjectID
                              , -- nvarchar(4000)
                                @Update_IDOut = @Update_ID OUTPUT
                              , -- int
                                @ProcessBatch_ID = @ProcessBatch_ID
                              , -- int
                                @Debug = 0 -- smallint

                      END
    -- reset process running in Context Menu
                      UPDATE    [dbo].[MFContextMenu]
                      SET       [MFContextMenu].[IsProcessRunning] = 0
                      WHERE     [MFContextMenu].[ID] = @ID
    -- set custom message to user
                      SET @OutPut = @OutPut + ' Process End Time= ' + CAST(GETDATE() AS VARCHAR(50))
    -- logging end of process batch
                      EXEC [dbo].[spMFProcessBatch_Upsert]
                        @ProcessBatch_ID = @ProcessBatch_ID
                      , -- int
                        @ProcessType = @procedureName
                      , -- nvarchar(50)
                        @LogType = N'Message'
                      , -- nvarchar(50)
                        @LogText = @OutPut
                      , -- nvarchar(4000)
                        @LogStatus = N'Completed'
                      , -- nvarchar(50)
                        @debug = 0 -- tinyint
                      SET @ProcedureStep = 'End custom.DoObjectAction'
                      SET @StartTime = GETDATE()
                      EXEC [dbo].[spMFProcessBatchDetail_Insert]
                        @ProcessBatch_ID = @ProcessBatch_ID
                      , -- int
                        @LogType = N'Message'
                      , -- nvarchar(50)
                        @LogText = @OutPut
                      , -- nvarchar(4000)
                        @LogStatus = N'Success'
                      , -- nvarchar(50)
                        @StartTime = @StartTime
                      , -- datetime
                        @MFTableName = @MFClassTable
                      , -- nvarchar(128)
                        @Validation_ID = NULL
                      , -- int
                        @ColumnName = NULL
                      , -- nvarchar(128)
                        @ColumnValue = NULL
                      , -- nvarchar(256)
                        @Update_ID = NULL
                      , -- int
                        @LogProcedureName = @procedureName
                      , -- nvarchar(128)
                        @LogProcedureStep = @ProcedureStep
                      , -- nvarchar(128)
                        @debug = 0 -- tinyint

    -- format message for display in context menu

                      EXEC [dbo].[spMFResultMessageForUI]
                        @ClassTable = @MFClassTable
                      , -- varchar(100)
                        @RowCount = 0
                      , -- int
                        @Processbatch_ID = @Processbatch_ID
                      , -- int
                        @MessageOUT = @OutPut OUTPUT -- nvarchar(4000)

                END TRY
                BEGIN CATCH
                      SET @OutPut = 'Error:'
                      SET @OutPut = @OutPut + ( SELECT  ERROR_MESSAGE()
                                              )
                END CATCH
          END



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

For Action Type 5

**VB Script for State Action**

.. code:: sql

    CREATE PROCEDURE [Custom].[CMDoObjectActionForWorkFlowState]
          @ObjectID INT
        , @ObjectType INT
        , @ObjectVer INT
        , @ID INT
        , @OutPut VARCHAR(1000) OUTPUT
     , @ClassID int
    AS
          BEGIN
                DECLARE @MFClassTable NVARCHAR(128) = 'MFOtherDocument'
                DECLARE @SQLQuery NVARCHAR(MAX)
                DECLARE @Params NVARCHAR(MAX)
                BEGIN TRY

                      SET @OutPut = 'Process Start Time: ' + CAST(GETDATE() AS VARCHAR(50)) --- set custom process start message for user
      -- Setting Params
             BEGIN
                            DECLARE @ProcessBatch_ID INT
                                  , @procedureName NVARCHAR(128) = 'custom.CMDoObjectAction'
                                  , @ProcedureStep NVARCHAR(128)
                                  , @StartTime DATETIME
                                  , @Return_Value INT
      --Updating MFContextMenu to show that process is still running
                            UPDATE  [dbo].[MFContextMenu]
                            SET     [MFContextMenu].[IsProcessRunning] = 1
                            WHERE   [MFContextMenu].[ID] = @ID
    --Logging start of process batch
                            EXEC [dbo].[spMFProcessBatch_Upsert]
                                @ProcessBatch_ID = @ProcessBatch_ID OUTPUT
                              , -- int
                                @ProcessType = @procedureName
                              , -- nvarchar(50)
                                @LogType = N'Message'
                              , -- nvarchar(50)
                                @LogText = @OutPut
                              , -- nvarchar(4000)
                                @LogStatus = N'Started'
                              , -- nvarchar(50)
                                @debug = 0 -- tinyint
                            SET @ProcedureStep = 'Start custom.DoObjectAction'
                            SET @StartTime = GETDATE()
                            EXEC [dbo].[spMFProcessBatchDetail_Insert]
                                @ProcessBatch_ID = @ProcessBatch_ID
                              , -- int
                                @LogType = N'Message'
                              , -- nvarchar(50)
                                @LogText = @OutPut
                              , -- nvarchar(4000)
                                @LogStatus = N'In Progress'
                              , -- nvarchar(50)
                                @StartTime = @StartTime
                              , -- datetime
                                @MFTableName = @MFClassTable
                              , -- nvarchar(128)
                                @Validation_ID = NULL
                              , -- int
                                @ColumnName = NULL
                              , -- nvarchar(128)
                                @ColumnValue = NULL
                              , -- nvarchar(256)
                                @Update_ID = NULL
                              , -- int
                                @LogProcedureName = @procedureName
                              , -- nvarchar(128)
                                @LogProcedureStep = @ProcedureStep
                              , -- nvarchar(128)
                                @debug = 0 -- tinyint
                      END
         --- start of custom process for the action, this example updates keywords property on the object
                      BEGIN
                WAITFOR DELAY '00:01:00';
                            DECLARE @Name_or_Title NVARCHAR(100)
                            DECLARE @Update_ID INT

          Select @MFClassTable=TableName from MFClass where MFID=@ClassID

          --get object from M-Files
                             EXEC [dbo].[spMFUpdateTable]
                                @MFTableName = @MFClassTable
                              , -- nvarchar(128)
                                @UpdateMethod = 1
                              , -- int
                                @ObjIDs = @ObjectID
                              , -- nvarchar(4000)
                                @Update_IDOut = @Update_ID OUTPUT
                              , -- int
                                @ProcessBatch_ID = @ProcessBatch_ID
                              , -- int
                                @Debug = 0 -- smallint
    --Perform action on/with object

                            SET @Params = N'@Output nvarchar(100), @ObjectID int'
                            SET @SQLQuery = N'

         UPDATE mot
         SET process_ID = 1
         --,Keywords = ''Updated in '' + @OutPut
         FROM ' + @MFClassTable + ' mot WHERE [objid] = @ObjectID '

                            EXEC [sys].[sp_executesql]
                                @SQLQuery
                              , @Params
                              , @OutPut = @OutPut
                              , @ObjectID = @ObjectID
    --process update of object into M-Files

                            EXEC [dbo].[spMFUpdateTable]
                                @MFTableName = @MFClassTable
                              , -- nvarchar(128)
                                @UpdateMethod = 0
                              , -- int
                                @ObjIDs = @ObjectID
                              , -- nvarchar(4000)
                                @Update_IDOut = @Update_ID OUTPUT
                              , -- int
                                @ProcessBatch_ID = @ProcessBatch_ID
                              , -- int
                               @Debug = 0 -- smallint

                      END
    -- reset process running in Context Menu
                      UPDATE    [dbo].[MFContextMenu]
                      SET       [MFContextMenu].[IsProcessRunning] = 0
                      WHERE     [MFContextMenu].[ID] = @ID
    -- set custom message to user
                      SET @OutPut = @OutPut + ' Process End Time= ' + CAST(GETDATE() AS VARCHAR(50))
    -- logging end of process batch
                      EXEC [dbo].[spMFProcessBatch_Upsert]
                        @ProcessBatch_ID = @ProcessBatch_ID
                      , -- int
                        @ProcessType = @procedureName
                      , -- nvarchar(50)
                        @LogType = N'Message'
                      , -- nvarchar(50)
                        @LogText = @OutPut
                      , -- nvarchar(4000)
                        @LogStatus = N'Completed'
                      , -- nvarchar(50)
                        @debug = 0 -- tinyint
                      SET @ProcedureStep = 'End custom.DoObjectAction'
                      SET @StartTime = GETDATE()
                      EXEC [dbo].[spMFProcessBatchDetail_Insert]
                        @ProcessBatch_ID = @ProcessBatch_ID
                      , -- int
                        @LogType = N'Message'
                      , -- nvarchar(50)
                        @LogText = @OutPut
                      , -- nvarchar(4000)
                        @LogStatus = N'Success'
                      , -- nvarchar(50)
                        @StartTime = @StartTime
                      , -- datetime
                        @MFTableName = @MFClassTable
                      , -- nvarchar(128)
                        @Validation_ID = NULL
                      , -- int
                        @ColumnName = NULL
                      , -- nvarchar(128)
                        @ColumnValue = NULL
                      , -- nvarchar(256)
                        @Update_ID = NULL
                      , -- int
                        @LogProcedureName = @procedureName
                      , -- nvarchar(128)
                        @LogProcedureStep = @ProcedureStep
                      , -- nvarchar(128)
                        @debug = 0 -- tinyint

    -- format message for display in context menu

                      EXEC [dbo].[spMFResultMessageForUI]
                        @ClassTable = @MFClassTable
                      , -- varchar(100)
                        @RowCount = 0
                      , -- int
                        @Processbatch_ID = @Processbatch_ID
                      , -- int
                        @MessageOUT = @OutPut OUTPUT -- nvarchar(4000)

                END TRY
                BEGIN CATCH
                      SET @OutPut = 'Error:'
                      SET @OutPut = @OutPut + ( SELECT  ERROR_MESSAGE()
                                              )
                END CATCH
          END

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

An example of the result message is illustrated below:
