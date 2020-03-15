
Get Incremental Updates for Object History
===========================================

Version 4.6.16.57 introduces several changes to the core procedures to enhance get object history, especially combining history updates with the class table updates.

The following procedures are related:
 -  spMFUpdateObjectChangeHistory
 -  spMFupdateAllncludedInAppTables
 -  spMFUpdateMfilesToSQL
 -  spMFGetHistory
 
The following tables are related:
 -  MFObjectChangeHistory
 -  MFObjectChangeHistoryUpdateControl 

MFObjectChangeHistory
---------------------

This table contains the result of the get history operation.  Examples of using the result in queries and views are detailed below.

MFObjectChangeHistoryUpdateControl
----------------------------------

This control table must have an entry for each class table to be included in the change history pull.  Each property to be included for the class table must be included in a separate row.

The underlying class table must be created and kept up to date for the change history to work.

spMFUpdateMfilesToSQL
---------------------

A new paramater is added to this procedure for including updating of the change history for the class specified class table.  By default change history is not included. When the class table is included in the MFObjectChangeHistoryUpdateControl table then it would automatically update the change history for the objects that a) is updated using the main procedure and b) check for any objects where the history is older than the class table and update the history.  Note that this works on incremental updates.  It will only look for changes history from the date of the previous update.
 
To update Change history when updating the class table: Set the @WithObjectHistory = 1
This setting will check the MFObjectChangeHistoryUpdateControl table, if the class table has entries in this control table then it would use these entries to call spMFUpdateObjectChangeHistory

Use spMFGetHistory as described below to force a full update of the change history for a table

.. code:: sql

    DECLARE @MFLastUpdateDate SMALLDATETIME,
    @Update_IDOut         INT,
    @ProcessBatch_ID      INT;
    
    EXEC dbo.spMFUpdateMFilesToMFSQL @MFTableName = 'MFCustomer',
    @MFLastUpdateDate = @MFLastUpdateDate OUTPUT,
    @UpdateTypeID = 1,
    @MaxObjects = null,
    @WithObjectHistory = 1,
    @Update_IDOut = @Update_IDOut OUTPUT,
    @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
    @debug = 0

spMFUpdateAllncludedinAppTables
-------------------------------

This procedure no longer calls spmfUpdateObjectChangeHistory directly.  It only calls spMFUpdateMfilesToSQL which in turns call spmfUpdateObjectChangeHistory
 
spmfUpdateObjectChangeHistory
-----------------------------

Use spMFUpdateobjectChangeHistory for automating the manual process of using spmfGetHistory.  This is an alternative method to spMFUpdateMFilestoMFSQL and may be used on its own.  spMFUpdateMfilestoSQL actually calls this procedures as part of its routine.

If @withClasstableupdate is set to 1 then the class table will be updated before the history is pulled.

If only a subset of objects must be updated then the @Objids can be set as a comma delimited string to update only the specific objects' change history.

.. code:: sql

    DECLARE   @ProcessBatch_ID      INT;

    EXEC dbo.spMFUpdateObjectChangeHistory @MFTableName = 'MFcustomer',
    @WithClassTableUpdate = 0,
    @Objids = null,
    @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
    @Debug = 0

spMFGetHistory
--------------

spMFGetHistory is the core procedure to fetch the history from M-Files
spMF

Using spMFGetHistory has two steps:
 -  set the process_id on the class table for the records to be included in the pull.
 -  pull the change history for these rows 
 
Set the records to be updated
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    UPDATE [MFPurchaseInvoice]
    SET Process_ID = 5

Pull the change history
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    DECLARE @RC INT
    DECLARE @TableName NVARCHAR(128) = 'MFPurchaseInvoice'
    DECLARE @Process_id INT = 5
    DECLARE @ColumnNames NVARCHAR(4000) = 'State'
    DECLARE @IsFullHistory BIT = 1
    DECLARE @NumberOFDays INT  
    DECLARE @SearchString NVARCHAR(MAX) = null
    DECLARE @StartDate DATETIME --= DATEADD(DAY,-1,GETDATE())
    DECLARE @ProcessBatch_id INT
    DECLARE @Debug INT = 1
    DECLARE @Update_ID  INT
    
    EXEC [dbo].[spMFGetHistory] @MFTableName =  @TableName   -- nvarchar(128)
                           ,@Process_id = @Process_id    -- int
                           ,@ColumnNames = @ColumnNames   -- nvarchar(4000)
                           ,@SearchString = null  -- nvarchar(4000)
                           ,@IsFullHistory = @IsFullHistory -- bit
                           ,@NumberOFDays = @NumberOFDays  -- int
                           ,@StartDate = @StartDate     -- datetime
                           ,@Update_ID = @Update_ID OUTPUT                         -- int
                           ,@ProcessBatch_id = @ProcessBatch_id OUTPUT            -- int
                           ,@Debug = @debug         -- int
    
    SELECT * FROM [dbo].[MFProcessBatch] AS [mpb] WHERE [mpb].[ProcessBatch_ID] = @ProcessBatch_id
    SELECT * FROM [dbo].[MFProcessBatchDetail] AS [mpbd] WHERE [mpbd].[ProcessBatch_ID] = @ProcessBatch_id
    
    SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]

Using MFObjectChangeHistory in views and queries
------------------------------------------------

Show list of values including property value
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    SELECT toh.*,mp.name AS propertyname FROM mfobjectchangehistory toh
    INNER JOIN mfproperty mp
    ON mp.[MFID] = toh.[Property_ID]
    ORDER BY [toh].[Class_ID],[toh].[ObjID],[toh].[MFVersion],[toh].[Property_ID]

Show list of values where property is a state
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    SELECT toh.*,mp.name AS propertyname, [mws].[Name] AS State FROM mfobjectchangehistory toh
    INNER JOIN mfproperty mp
    ON mp.[MFID] = toh.[Property_ID]
    LEFT JOIN [dbo].[MFWorkflowState] AS [mws]
    ON mws.mfid = toh.[Property_Value]
    WHERE toh.[Property_ID] = 39
    ORDER BY [toh].[Class_ID],[toh].[ObjID],[toh].[MFVersion],[toh].[Property_ID]

Deleting records for a specific class
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    DELETE FROM [dbo].[MFObjectChangeHistory] 
    WHERE [Class_ID] IN (SELECT MFID FROM MFClass WHERE [TableName] = 'MFPurchaseInvoice')

Show object types in change history table
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    SELECT DISTINCT mot.Name AS objectType FROM [dbo].[MFObjectType] AS [mot]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON mot.[MFID] = moch.[ObjectType_ID]

Get the object type id for the class
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    SELECT MC2.MFID class_id, mot.MFID ObjectType_ID, mc2.name Class, mot.name ObjectType FROM [dbo].[MFClass] AS [mc2]
    INNER JOIN [dbo].[MFObjectType] AS [mot]
    ON mot.id = mc2.[MFObjectType_ID]

Show classes in table
~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    SELECT mc2.name FROM [dbo].[MFClass] AS [mc2]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON mc2.mfid = moch.[Class_ID]
    GROUP BY mc2.name

Adjust for local time (where the time offset is known)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    SELECT TOP 5 [moch].[LastModifiedUtc], DATEADD(HOUR,-5,[moch].[LastModifiedUtc]) EasternTime FROM [dbo].[MFObjectChangeHistory] AS [moch]

Get the user for the user id
~~~~~~~~~~~~~~~~~~~~~~~~~~~~


.. code:: sql

    SELECT mla.[UserName], [mla].[FullName] FROM [dbo].[MFObjectChangeHistory] AS [moch]
    INNER JOIN [dbo].[MFLoginAccount] AS [mla]
    ON moch.[MFLastModifiedBy_ID] = mla.[MFID]

Get the property name
~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    SELECT mp.name AS propertyName FROM [dbo].[MFProperty] mp 
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON mp.[MFID] = moch.[Property_ID]

Get the property values for lookups
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

workflow

.. code:: sql

    SELECT name, mfid FROM [dbo].[MFWorkflow] AS [mw]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON moch.[Property_Value] = mw.[MFID]
    WHERE [moch].[Property_ID] = 38

Workflow State

.. code:: sql

    SELECT name, mfid FROM [dbo].[MFWorkflowState] AS [mw]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON moch.[Property_Value] = mw.[MFID]
    WHERE [moch].[Property_ID] = 39

Valuelist items

.. code:: sql

    SELECT moch.id,[moch].[ObjID], moch.MFVersion,  moch.[Property_ID], moch.[Property_Value]
    , mp.name Property, mvl.name AS Valuelist, mvl.[RealObjectType]
    , mvli.name AS Valuelistitem
    FROM [dbo].[MFObjectChangeHistory] AS [moch]
    INNER JOIN [dbo].[MFProperty] AS [mp]
    ON moch.[Property_ID] = mp.[MFID]
    INNER JOIN [dbo].[MFValueList] AS [mvl]
    ON mp.[MFValueList_ID] = mvl.[ID]
    INNER JOIN [dbo].[MFValueListItems] AS [mvli]
    ON moch.[Property_Value] = mvli.[MFID] AND mvli.[MFValueListID] = mvl.[ID]
    ORDER BY [moch].[ObjID]

Using the Metadata structure view
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
    INNER JOIN [dbo].[MFvwMetadataStructure] AS [mfms]
    ON [mfms].[Property_MFID] = [moch].[Property_ID] AND moch.[Class_ID] = mfms.[class_MFID]
    INNER JOIN [dbo].[MFValueListItems] AS [mvli]
    ON mvli.[MFID] = moch.[Property_Value] AND mfms.[Valuelist_ID] = mvli.[MFValueListID]

Using a valuelist item view
~~~~~~~~~~~~~~~~~~~~~~~~~~~

creating a valuelist item view for currency

.. code:: sql

    EXEC [dbo].[spMFCreateValueListLookupView] @ValueListName = 'Currency' 
                                              ,@ViewName = 'vwCurrency'
                                              ,@Schema = 'Custom' 
                                             ,@Debug = 0 

Using the created valuelist view

.. code:: sql

    SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
    INNER JOIN [dbo].[MFProperty] AS [mp]
    ON moch.[Property_ID] = mp.mfid
    INNER JOIN custom.[VLvwCurrency] AS [vlc]
    ON vlc.[MFID_ValueListItems] = moch.[Property_Value] AND vlc.[ID_ValueList] = mp.[MFValueList_ID]
    
Working with a multi lookup valuelist
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
    CROSS APPLY [dbo].[fnMFParseDelimitedString]([moch].[Property_Value],',') AS [fmpds]
    INNER JOIN [dbo].[MFvwMetadataStructure] AS [mfms]
    ON [mfms].[Property_MFID] = moch.[Property_ID] AND moch.[Class_ID] = mfms.[class_MFID]
    INNER JOIN [dbo].[MFValueListItems] AS [mvli]
    ON mvli.[MFID] = [fmpds].[ListItem] AND mfms.[Valuelist_ID] = mvli.[MFValueListID]

Working with real object type Property Values (class table lookups)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


.. code:: sql

    SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
    INNER JOIN [dbo].[MFvwMetadataStructure] AS [mfms]
    ON [mfms].[Property_MFID] = moch.[Property_ID] AND moch.[Class_ID] = mfms.[class_MFID]
    INNER JOIN [dbo].[MFPurchaseInvoice] AS [ma]
    ON moch.[Property_Value] = ma.[ObjID]
    WHERE [mfms].[IsObjectType] = 1


