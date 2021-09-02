
Working with object change history
==================================

Object change history is often used in reporting to get the data about property changes.  This include changes such as Comments, workflow states, and other key properties where changes to the properties requires monitoring.

The following procedures are related:
 -  spMFUpdateObjectChangeHistory
 -  spMFupdateAllncludedInAppTables
 -  spMFUpdateMfilesToMFSQL
 -  spMFGetHistory
 
The following tables are related:
 -  MFObjectChangeHistory
 -  MFObjectChangeHistoryUpdateControl 
 
Updating of the object change history is included in spmfUpdateAllIncludedInAppTables and spmfUpdateMFilestoMFSQL

After taking the steps outlined below spmfUpdateMFilestoMFSQL will automatically include processing spMFUpdateObjectChangeHistory.  spMFUpdateobjectChangeHistory uses the MFObjectChangeHistoryUpdateControl table to get all the classes and properties and then use spMFGetHistory to perform the updates.

spMFUpdateobjectChangeHistory can be executed on its own using the parameters to set the scope. See below for more detail.

 -  spMFGetHistory will be processed for each row in the control table (consisting of a valid class table name and a valid property column name)
 -  All records in the class table with values for the specific property will be included
 -  The start date of the update will be set to the last change date in for the specific class and property in the MFObjectChangeHistory table.
 -  The procedure will therefor only update new changes for the property. 
 
MFObjectChangeHistory maintains a cummulative object change history for the designated properties.

Steps the enable object change history
--------------------------------------
Step 1: Update the control table for the properties to be monitored
Step 2: Use spMFUpdateMFilestoMFSQL to update the class table and history
Step 3: Schedule spMFUpdateAllncludedinAppTables in an agent to regularly update the history

MFObjectChangeHistory
---------------------

This table contains the result of the get history operation.  Examples of using the result in queries and views are detailed below.

The table columns are the following:
 - ID: Identity of row
 - ObjectType\_ID: MFID of the ObjectType
 - Class\_ID: MFID of the Class
 - Objid: Objid of the class object
 - MFVersion: Version of the object where the value changed for the property in column Property\_ID. Only versions matching the filters on the spMFGetHistory procedure is fetched. Widening the filters may restrict the MFVersions returned. Narrowing the filters will not remove the rows previously fetched for
the object.
 - LastModifiedUtc: The 'CheckInTimeStamp' of the specific version for the object. The timestamp is shown in Universal Time.
 - MFLastModifiedBy\_ID: MFID of the user. User information is on MFUserAccount or MFLoginAccount.
 - Property\_ID: MFID of the property specified in the MFObjectChangeHistoryControl table. 
 - Property\_Value: value as a string. Interpreting and relating to this value will depend on the type of property. Lookups require special consideration, see below.
 - CreatedOn: timestamp when the row was recreated in the table
 
Column relationships and conversions
------------------------------------

Relations for ObjectType\_ID
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    --object types in change history table
    SELECT DISTINCT mot.Name AS objectType FROM [dbo].[MFObjectType] AS [mot]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON mot.[MFID] = moch.[ObjectType_ID]

    --getting the object type id for the class

    SELECT MC2.MFID class_id, mot.MFID ObjectType_ID, mc2.name Class, mot.name ObjectType FROM [dbo].[MFClass] AS [mc2]
    INNER JOIN [dbo].[MFObjectType] AS [mot]
    ON mot.id = mc2.[MFObjectType_ID]

Relations for Class\_ID
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    SELECT mc2.name FROM [dbo].[MFClass] AS [mc2]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON mc2.mfid = moch.[Class_ID]
    GROUP BY mc2.name

Universal versus local datetime
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: sql

    --understanding dates and times
    SELECT SYSDATETIME() AS [SYSDATETIME()]  
        ,SYSDATETIMEOFFSET() AS [SYSDATETIMEOFFSET()]  
        ,SYSUTCDATETIME() AS [SYSUTCDATETIME()]  
        ,CURRENT_TIMESTAMP AS [CURRENT_TIMESTAMP]  
        ,GETDATE() AS [GETDATE()]  
        ,GETUTCDATE() AS [GETUTCDATE()];  
        
      --adjust for local time (where the time offset is known)
     SELECT TOP 5 [moch].[LastModifiedUtc], DATEADD(HOUR,-5,[moch].[LastModifiedUtc]) EasternTime FROM [dbo].[MFObjectChangeHistory] AS [moch]
       

Last modified user
~~~~~~~~~~~~~~~~~~

.. code:: sql

    SELECT mla.[UserName], [mla].[FullName] FROM [dbo].[MFObjectChangeHistory] AS [moch]
    INNER JOIN [dbo].[MFLoginAccount] AS [mla]
    ON moch.[MFLastModifiedBy_ID] = mla.[MFID]

Property
~~~~~~~~

.. code:: sql

    SELECT mp.name AS propertyName FROM [dbo].[MFProperty] mp 
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON mp.[MFID] = moch.[Property_ID]

Property Value
~~~~~~~~~~~~~~

Lookup property values require special consideration as the column will
contain the id or comma delimited list of ids rather than the labels. It
is best practice to build datasets for reporting and other uses for the
change data around specific property types. Combining analysis of change
history for diffferent property types simultaneously is more complex.
There are 4 types of lookups, each with different considerations:

-  valuelist single and multi select

-  workflow

-  class table object single and multi select

-  workflow state

Workflow
^^^^^^^^

The property value is the MFID of the workflow in the MFWorkflow Table
if the property\_id = 38

.. code:: sql

    SELECT name, mfid FROM [dbo].[MFWorkflow] AS [mw]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON moch.[Property_Value] = mw.[MFID]
    WHERE [moch].[Property_ID] = 38

workflow state
^^^^^^^^^^^^^^

The property value is the MFID of the workflow state in the
MFWorkflowState Table if the property\_id = 39

.. code:: sql

    SELECT name, mfid FROM [dbo].[MFWorkflowState] AS [mw]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON moch.[Property_Value] = mw.[MFID]
    WHERE [moch].[Property_ID] = 39

Valuelist item - single lookup
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The property value is the MFID of the Valuelist item in the
MFValuelistItem Table. The MFValuelistItem must be joined with the
MFValuelist for the specific property to select the correct MFID
through the MFProperty Table. Both Valuelist related to the property\_ID
and the Valuelist Item ID for the Property Value must be matched. See
line 10 below.

The samples below have three different approaches to achieve the same
objective.

-  The first illustrate the joins based on the base tables.

-  The second use the MFvwMetadataStructure to simplify the relationship

-  The third use a valuelist view. This view is generated using the
   spMFCreateValuelistLookup

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

    --using the MFvwMetadatastructure 

    SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
    INNER JOIN [dbo].[MFvwMetadataStructure] AS [mfms]
    ON [mfms].[Property_MFID] = [moch].[Property_ID] AND moch.[Class_ID] = mfms.[class_MFID]
    INNER JOIN [dbo].[MFValueListItems] AS [mvli]
    ON mvli.[MFID] = moch.[Property_Value] AND mfms.[Valuelist_ID] = mvli.[MFValueListID]

    --creating a valuelist item view for currency

    EXEC [dbo].[spMFCreateValueListLookupView] @ValueListName = 'Currency' -- nvarchar(128)
                                              ,@ViewName = 'vwCurrency'      -- nvarchar(128)
                                              ,@Schema = 'Custom'        -- nvarchar(20)
                                              ,@Debug = 0         -- smallint

    SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
    INNER JOIN [dbo].[MFProperty] AS [mp]
    ON moch.[Property_ID] = mp.mfid
    INNER JOIN custom.[VLvwCurrency] AS [vlc]
    ON vlc.[MFID_ValueListItems] = moch.[Property_Value] AND vlc.[ID_ValueList] = mp.[MFValueList_ID]
    ON 

valuelist item - multi lookup
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When a multi lookup property are used and there are more than one value
selected on the property, the values will be displayed as a comma
delimited string.

Before the joins above can be applied, the values in the Property Value
column must be split to allow for it to be joined the the underlying
tables.

Using cross apply with fnMFParseDelimitedString will parse the string
and allow joining with its parts. This is illustrated with the second
example for valuelist items.

.. code:: sql

    -- working with a multi lookup valuelist

    SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
    CROSS APPLY [dbo].[fnMFParseDelimitedString]([moch].[Property_Value],',') AS [fmpds]
    INNER JOIN [dbo].[MFvwMetadataStructure] AS [mfms]
    ON [mfms].[Property_MFID] = moch.[Property_ID] AND moch.[Class_ID] = mfms.[class_MFID]
    INNER JOIN [dbo].[MFValueListItems] AS [mvli]
    ON mvli.[MFID] = [fmpds].[ListItem] AND mfms.[Valuelist_ID] = mvli.[MFValueListID]

Class table objects or real Object Type objects
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Where the property references a real object, such as ‘Customer’, the
Property\_Value column will reference the objid of the class. In the
example below the list show the changes for the Account property which
references the MFAccount class table.

.. code:: sql

    SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]
    INNER JOIN [dbo].[MFvwMetadataStructure] AS [mfms]
    ON [mfms].[Property_MFID] = moch.[Property_ID] AND moch.[Class_ID] = mfms.[class_MFID]
    INNER JOIN [dbo].[MFAccount] AS [ma]
    ON moch.[Property_Value] = ma.[ObjID]
    WHERE [mfms].[IsObjectType] = 1

Clearing rows in table
----------------------

The MFObjectChangeHistory table contains the version history for all the
classed and objects and properties for every time the procedure
spMFGetHistory is processed. This table is likely to grow very fast if
not maintained.

There is no automated process for clearing the history table. It really
depends on the specific application and use case for the object history.

In most applications fetching the history for an object is incidental
and can be removed after the data was consumed. In other cases this
table is constantly consumed for reporting on previous history.

Devising a strategy for deleting records in this table is likely to be
different for each class, and could even be different for specific
properties on the class.

Adhoc use of the change history can be deleted from the table. Always
delete by class. Truncating the entire table may destroy history records
of other classes unintentionally.

.. code:: sql

    DELETE FROM [dbo].[MFObjectChangeHistory] 
    WHERE [Class_ID] IN (SELECT MFID FROM MFClass WHERE [TableName] = 'MFPurchaseInvoice')

MFObjectChangeHistoryUpdateControl
----------------------------------

This control table must have an entry for each class table to be included in the change history pull.  Each property to be included for the class table must be included in a separate row.

The underlying class table must be created and kept up to date for the change history to work.

Records must be added for your specific requirements in the control table.  The update procedure will have no impact if no records are found in this table.

.. code:: sql

   INSERT INTO dbo.MFObjectChangeHistoryUpdateControl(
   MFTableName,
   ColumnNames)
   VALUES
   (N'MFCustomer', N'City'),
   N'MFCustomer', N'Country_ID'),
   N'MFCustomer', N'State_ID'),
   N'MFPurchaseInvoice', N'State_ID');

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

The operation will get the change history for specific objects and for
specific properties. It is not designed to get the change history for
every property on the object in a single process. The operation is
intended to be used where the target property and the specific object is
predetermined.

For instance the change history can be extracted for address changes in
all the customers ; the workflow state changes for purchase orders
approved in the last month can be extracted.

Volume warning
--------------

It is recommended to carefully consider the population of the extract
before executing the procedure. It is very easy to request the history
for a number of object and return many thousands of results. For
instance, getting the history of 4000 customers using 5 properties with
an average of 10 versions per customer would produce approx 200 000
history records.

Using filters
~~~~~~~~~~~~~

Several types of filters are available:

-  Exclude the objects where the data is no longer required or relevant:
   for instance if the report is targeting the approvals of invoices in
   the past month then only include the invoices where the
   MFLastModified date is in the last month by updating the process\_id
   = 5 only on these records.

-  Only include the properties on the object that is relevant for the
   report. The use of multiple properties should be reduced to the
   minimum.

-  Only use getting the full history if it is relevant, or the fist time
   that history is being updated. It would be more productive to
   initialize the data by getting the full history, and then to update
   the history by setting the start date or number of days filter.

-  The search string filter can be used to return a result for a
   specific value of change. For instance to only return the state
   change where the approval took place, instead of all the state
   change, set the search string value to the approval state ID.

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

