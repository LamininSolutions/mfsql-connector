
Updating object change history
==============================

Version 4.4.13.54 introduces functionality to include the updating of the object change history in the scheduled updating of spmfUpdateAllIncludedInAppTables. After taking the steps outlined below this procedure will automatically include processing spMFGetHistory

The procedure spMFUpdateObjectChangeHistory and the table MFObjectChangeHistoryControl have been added in version 4.4.13.54.  The procedure allows for updating all of the tables and settings in the MFObjectChangeHistoryControl table to updated automatically.
 -  spMFGetHistory will be processed for each row in the control table (consisting of a valid class table name and a valid property column name)
 -  All records in the class table with values for the specific property will be included
 -  The start date of the update will be set to the last change date in for the specific class and property in the MFObjectChangeHistory table.
 -  The procedure will therefor only update new changes for the property. Previous changes of the property are in MFObjectChangeHistory

Insert records in MFObjectChangeHistoryControl
----------------------------------------------

Records must be added for your specific requirements in this table.  The procedure will have no impact if no records are found in this table.

.. code:: sql

   INSERT INTO dbo.MFObjectChangeHistoryUpdateControl(
   MFTableName,
   ColumnNames)
   VALUES
   (N'MFCustomer', N'City'),
   N'MFCustomer', N'Country_ID'),
   N'MFCustomer', N'State_ID'),
   N'MFPurchaseInvoice', N'State_ID');

Update object history for all the tables
----------------------------------------

There are various scenarios for updating object history:

Automatically schedule and update object history for all related class tables.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The procedure spMFUpdateAllIncludedInAppTables includes the updating of history using the spMFUpdateObjectHistory procedure.
This procedure is often included in an agent for scheduled updates or called by an Context Menu action

Update object history on demand
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Execute the following procedure after the table as outlined above has been updated.

.. code:: sql

   EXEC spMFUpdateObjectChangeHistory @WithClassTableUpdate = 1
   
Updating history for a specific class table during testing or development.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following sample script demonstrates how to setup and run spMFGetHistory.

.. code:: SQL

   UPDATE [MFPurchaseInvoice]
   SET Process_ID = 5

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
   DECLARE @Update_ID        INT

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

Results of the update
---------------------

This routine gets the change history of each property and class and update the result in the MFObjectChangeHistory table.

Below is examples of extracts of the different types of data from this table.

SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]

show list of values including property value

SELECT toh.*,mp.name AS propertyname FROM mfobjectchangehistory toh
INNER JOIN mfproperty mp
ON mp.[MFID] = toh.[Property_ID]
ORDER BY [toh].[Class_ID],[toh].[ObjID],[toh].[MFVersion],[toh].[Property_ID]

show list of values where property is a state

SELECT toh.*,mp.name AS propertyname, [mws].[Name] AS State FROM mfobjectchangehistory toh
INNER JOIN mfproperty mp
ON mp.[MFID] = toh.[Property_ID]
LEFT JOIN [dbo].[MFWorkflowState] AS [mws]
ON mws.mfid = toh.[Property_Value]
WHERE toh.[Property_ID] = 39
ORDER BY [toh].[Class_ID],[toh].[ObjID],[toh].[MFVersion],[toh].[Property_ID]
GO

Deleting records

DELETE FROM [dbo].[MFObjectChangeHistory] 
WHERE [Class_ID] IN (SELECT MFID FROM MFClass WHERE [TableName] = 'MFPurchaseInvoice')


views for the change history table

object types in change history table
SELECT DISTINCT mot.Name AS objectType FROM [dbo].[MFObjectType] AS [mot]
INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
ON mot.[MFID] = moch.[ObjectType_ID]

getting the object type id for the class

SELECT MC2.MFID class_id, mot.MFID ObjectType_ID, mc2.name Class, mot.name ObjectType FROM [dbo].[MFClass] AS [mc2]
INNER JOIN [dbo].[MFObjectType] AS [mot]
ON mot.id = mc2.[MFObjectType_ID]

SELECT mc2.name FROM [dbo].[MFClass] AS [mc2]
INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
ON mc2.mfid = moch.[Class_ID]
GROUP BY mc2.name

converting universal time

SELECT SYSDATETIME() AS [SYSDATETIME()]  
    ,SYSDATETIMEOFFSET() AS [SYSDATETIMEOFFSET()]  
    ,SYSUTCDATETIME() AS [SYSUTCDATETIME()]  
    ,CURRENT_TIMESTAMP AS [CURRENT_TIMESTAMP]  
    ,GETDATE() AS [GETDATE()]  
    ,GETUTCDATE() AS [GETUTCDATE()];  

adjust for local time (where the time offset is known)

SELECT TOP 5 [moch].[LastModifiedUtc], DATEADD(HOUR,-5,[moch].[LastModifiedUtc]) EasternTime FROM [dbo].[MFObjectChangeHistory] AS [moch]

user id

SELECT mla.[UserName], [mla].[FullName] FROM [dbo].[MFObjectChangeHistory] AS [moch]
INNER JOIN [dbo].[MFLoginAccount] AS [mla]
ON moch.[MFLastModifiedBy_ID] = mla.[MFID]

property name


SELECT mp.name AS propertyName FROM [dbo].[MFProperty] mp 
INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
ON mp.[MFID] = moch.[Property_ID]

property values

workflow
SELECT name, mfid FROM [dbo].[MFWorkflow] AS [mw]
INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
ON moch.[Property_Value] = mw.[MFID]
WHERE [moch].[Property_ID] = 38

State
SELECT name, mfid FROM [dbo].[MFWorkflowState] AS [mw]
INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
ON moch.[Property_Value] = mw.[MFID]
WHERE [moch].[Property_ID] = 39

Valuelist items

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

SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
INNER JOIN [dbo].[MFvwMetadataStructure] AS [mfms]
ON [mfms].[Property_MFID] = [moch].[Property_ID] AND moch.[Class_ID] = mfms.[class_MFID]
INNER JOIN [dbo].[MFValueListItems] AS [mvli]
ON mvli.[MFID] = moch.[Property_Value] AND mfms.[Valuelist_ID] = mvli.[MFValueListID]

creating a valuelist item view for currency

EXEC [dbo].[spMFCreateValueListLookupView] @ValueListName = 'Currency' -- nvarchar(128)
,@ViewName = 'vwCurrency'
,@Schema = 'Custom'
,@Debug = 0 

SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
INNER JOIN [dbo].[MFProperty] AS [mp]
ON moch.[Property_ID] = mp.mfid
INNER JOIN custom.[VLvwCurrency] AS [vlc]
ON vlc.[MFID_ValueListItems] = moch.[Property_Value] AND vlc.[ID_ValueList] = mp.[MFValueList_ID]
ON 
working with a multi lookup valuelist

SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
CROSS APPLY [dbo].[fnMFParseDelimitedString]([moch].[Property_Value],',') AS [fmpds]
INNER JOIN [dbo].[MFvwMetadataStructure] AS [mfms]
ON [mfms].[Property_MFID] = moch.[Property_ID] AND moch.[Class_ID] = mfms.[class_MFID]
INNER JOIN [dbo].[MFValueListItems] AS [mvli]
ON mvli.[MFID] = [fmpds].[ListItem] AND mfms.[Valuelist_ID] = mvli.[MFValueListID]

Real object type Property Values

SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
INNER JOIN [dbo].[MFvwMetadataStructure] AS [mfms]
ON [mfms].[Property_MFID] = moch.[Property_ID] AND moch.[Class_ID] = mfms.[class_MFID]
INNER JOIN [dbo].[MFPurchaseInvoice] AS [ma]
ON moch.[Property_Value] = ma.[ObjID]
WHERE [mfms].[IsObjectType] = 1

