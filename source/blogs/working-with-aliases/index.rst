Working with aliases
====================

It is good practice to use aliases instead of names or ids of objects
such as states, classes etc when building applications.

This use case apply workflows and workflow states and include to
following connector objects

-  MFWorkflow

-  MFWorkflowState

-  spMFAliasesUpsert

--------------

Step 1:

Create aliases for workflows and workflow states.

.. code:: sql

    DECLARE @ProcessBatch_ID INT;
    EXEC [dbo].[spMFAliasesUpsert] @MFTableNames = 'MFWorkflowState', -- nvarchar(400)
                                   @Prefix = 'ws',       -- nvarchar(10)
                                   @IsRemove = 0,     -- bit
                                   @WithUpdate = 1,   -- bit
                                   @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,            -- int
                                   @Debug = 0         -- smallint

.. code:: sql

    DECLARE @ProcessBatch_ID INT;
    EXEC [dbo].[spMFAliasesUpsert] @MFTableNames = 'MFWorkflow', -- nvarchar(400)
                                   @Prefix = 'w',       -- nvarchar(10)
                                   @IsRemove = 0,     -- bit
                                   @WithUpdate = 1,   -- bit
                                   @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,            -- int
                                   @Debug = 0         -- smallint

Step 2:

Define custom variables in the procedure

.. code:: sql

    -------------------------------------------------------------
    -- Define custom parameters
    -------------------------------------------------------------
    DECLARE @State_New_Inv_ID INT,
      @State_Incomplete_Inv_id INT,
      @State_Validated_Inv_ID INT,
      @State_History_Inv_ID INT,
      @State_Incompatible_Inv_ID INT,
      @workflow_Inv_ID int

Step 3:

Get values of variables

.. code:: sql

    SELECT @State_History_Inv_ID = [mws].[MFID]
    FROM [dbo].[MFWorkflowState] AS [mws]
    WHERE [mws].[Alias] = 'ws.Inventory_Flow.Historic_Inventory';
    SELECT @State_New_Inv_ID = [mws].[MFID]
    FROM [dbo].[MFWorkflowState] AS [mws]
    WHERE [mws].[Alias] = 'ws.Inventory_Flow.New_Inventory';
    SELECT @State_Incomplete_Inv_id = [mws].[MFID]
    FROM [dbo].[MFWorkflowState] AS [mws]
    WHERE [mws].[Alias] = 'ws.Inventory_Flow.Incomplete_Data_Inventory';
    SELECT @State_Validated_Inv_ID = [mws].[MFID]
    FROM [dbo].[MFWorkflowState] AS [mws]
    WHERE [mws].[Alias] = 'ws.Inventory_Flow.Validated_Inventory';
    SELECT @State_Incompatible_Inv_ID = [mws].[MFID]
    FROM [dbo].[MFWorkflowState] AS [mws]
    WHERE [mws].[Alias] = 'ws.Inventory_Flow.Historic_Inventory';

    SELECT @workflow_Inv_ID = [mws].[MFID]
    FROM [dbo].[MFWorkflow] AS [mws]
    WHERE [mws].[Alias] = 'w.Inventory_Flow';

Step 4:

Use the parameters in the operations

.. code:: sql

    mic.State_ID = CASE WHEN mic.[State_ID] <> @State_Validated_Inv_ID AND i.[IsCurrent] = 1 AND i.[IsUpdate] IS null THEN @State_Validated_Inv_ID
     WHEN mic.[State_ID] <> @State_Validated_Inv_ID AND i.[IsCurrent] = 0 THEN @State_History_Inv_ID
     WHEN mic.[State_ID] <> @State_Validated_Inv_ID AND i.[IsCurrent] = 1 AND i.[IsUpdate] = 2 THEN @State_Incompatible_Inv_ID
     end
     
    --and another example

    SELECT i.[MillCast],
    'New inventory added from NAV',
    @ProcessBatch_ID,
    i.[MillPlate],
    [i].[Parent_Serial_no],
    [i].[Parent_Serial_no],
    @State_New_Inv_ID,
    @workflow_Inv_ID,
    1
    FROM ......

