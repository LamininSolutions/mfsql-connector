Queries for the MFObjectChangeHistory data
==========================================

The procedure spMFGetHistory creates rows for every change of the
specific property or properties of the given class based on the filters
specified.

When the procedure is run for the same object and filters, it will
update the existing row. If it finds a new change version for the same
property on the same object then a new row will be created.

Working with this table requires a deeper understanding of the data in
this table and the relationships with other tables

Columns
-------

The table columns are the following:

**Column**

**Description**

**Notes**

ID

Identity of row, primary key and increments for each new row

ObjectType\_ID

MF ID of the object Type of the class.

Get values related the the ObjectType using MFclass table.

Note the MFObjectTyoe\_ID on MFClass table references the ID column in
MFObjectType table.

Class\_ID

MF ID of the class

MFID column on the MFClass Table

Value of the Class\_ID column on the specific class table

Objid

Objid or the object

Objid column on the specific class table

MFVersion

Version of the object where the value changed for the property in column
Property\_ID

Only versions matching the filters on the spMFGetHistory procedure is
fetched. Widening the filters may restrict the MFVersions returned.
Narrowing the filters will not remove the rows previously fetched for
the object.

LastModifiedUtc

The 'CheckInTimeStamp of the specific version for the object

The timestamp is shown in Universal Time.

MFLastModifiedBy\_ID

MF ID of the user

User information is on MFUserAccount and MFLoginAccount

Property\_ID

MF ID of the property

From MFProperty

Property\_Value

value as a string

Interpreting and relating to this value will depend on the type of
property.

Lookups require special consideration, see below.

CreatedOn

timestamp when the row was recreated in the table

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

The property value is the MF id of the workflow in the MFWorkflow Table
if the property\_id = 38

.. code:: sql

    SELECT name, mfid FROM [dbo].[MFWorkflow] AS [mw]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON moch.[Property_Value] = mw.[MFID]
    WHERE [moch].[Property_ID] = 38

workflow state
^^^^^^^^^^^^^^

The property value is the MF id of the workflow state in the
MFWorkflowState Table if the property\_id = 39

.. code:: sql

    SELECT name, mfid FROM [dbo].[MFWorkflowState] AS [mw]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
    ON moch.[Property_Value] = mw.[MFID]
    WHERE [moch].[Property_ID] = 39

Valuelist item - single lookup
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The property value is the MF id of the Valuelist item in the
MFValuelistItem Table. The MFValuelistItem must be joined with the
MFValuelist for the specific property to select the correct MF ID
through the MFProperty Table. Both Valuelist related to the property\_ID
and the Valuelist Item ID for the Property Value must be matched. See
line 10 below.

The samples below have three different approaches to achieve the same
objective.

-  The first illustrate the joins based on the base tables.

-  The second use the MFvwMetadataStructure to simply the relationship

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


