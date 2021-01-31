
=================
spMFAliasesUpsert
=================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableNames nvarchar(400)
    Valid Metadata structure table
  @Prefix nvarchar(10)
    Prefix before name
  @IsRemove bit (optional)
    - Default = 0
    - If 1 then aliases with prefix will be removed.
  @WithUpdate bit
    Set to 1 push updates to M-Files
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

Adding or removing aliases based on prefix.

Additional Info
===============

The following metadata tables include aliases:

- MFClass
- MFProperty
- MFObjectType
- MFValuelist
- MFWorkflow
- MFWorkflowState

The aliases can be synchronized with M-Files.  A switch on the procedure will determine if the update takes place from M-Files or to M-Files.

The following procedures will only update from M-Files to SQL:

- spMFSyncronizeMetadata
- spMFDropAndUpdateMetadata

Use spMFSyncronizeSpecificMetadata to update aliases from SQL to M-Files
Use spMFAliasesUpsert to bulk update aliases in M-Files

Using spMFAliasesUpsert to bulk update aliases
----------------------------------------------
This procedure allows selecting a prefix that would be added for all aliases in the execution. Select one or more of the metadata types that could have aliases.

- If @isRemove is set to 1 then all the aliases in the @MFTablesNames parameter with the set prefix will be removed.
- If @WithUpdate is set to 0 then the aliases will not be pushed into M-Files. This is mainly used to inspect the aliases before updating M-Files.

Suggested naming convensions are: (note that all special characters are removed, spaces are replaced with _)

WorkflowStates
  prefix.Workflow.WorkflowState (The full alias will be restricted to 100 characters)
Classes
  prefix.cl.Class
ObjectType
  prefix.ot.ObjectType
Property, Valuelists
  prefix.p.Name

Prefixes are flexible. For instance, use YourCompany.c.classname for classes, or p.property if you don't want any namespace prefix.
This procedure take approx 2 minutes per metadata table to update

Setting aliases
---------------
When setting aliases in SQL it is handy to use a special function that will remove the spaces and special characters in the name of the object
SET alias = dbo.fnMFReplaceSpecialCharacter(name)

Using aliases in SQL
--------------------
Use aliases when referencing workflow states in SQL procedures.  It is a better practice than using the name of the state.
Note that valuelist items does not have aliases.  However, the connector includes an internally generated unique reference called AppRef.  Use this reference in SQL procedures in the place of aliases.

Examples
========

.. code:: sql

    DECLARE @ProcessBatch_ID INT;
    EXEC [dbo].[spMFAliasesUpsert]
        @MFTableNames = 'MFWorkflowstate',
        @Prefix = 'LS',
        @IsRemove = 0, -- set to 1 to remove all aliases
        @WithUpdate = 1,
        @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
        @Debug = 0

    SELECT * FROM [dbo].[MFProcessBatchDetail] AS [mpbd] WHERE [mpbd].[ProcessBatch_ID] = @ProcessBatch_ID
    SELECT * FROM dbo.MFWorkflowState AS mws

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2017-07-30  LC         Create Procedure
==========  =========  ========================================================

