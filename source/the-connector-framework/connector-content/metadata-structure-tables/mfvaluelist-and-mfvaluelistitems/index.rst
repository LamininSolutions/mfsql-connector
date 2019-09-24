MFValuelist and MFValueListItems
================================

The Connector use two tables in relation to Valuelists and ValueList
Items:  MFValuelist and MFValueListItems.

The ValueLists are cross referenced to the ValueListItem Table using the
SQL Valuelist.ID column.  Note that this is not the MFID of the
Valuelists but it uses the ID column assigned by SQL.

The ValueListItems table include all the Valuelist Items in the vault.
The MFID column contains the related ID's in M-Files.  Note that these
ID's are not unique nor are the names unique.  For this reason SQL
assigns a unique ID to each valuelistitem.  This ID may change if the
table is recreated or transferred from one database to another.

Using the AppRef column in the ValuelistItems table allows for a unique
reference for each valuelist item and can be ported from one system to
another.  The Appref can be used to syncronise the transfer of
valuelistitems accross multiple databases. The use of the AppRef column
also support referencing a valuelist item without having to build a join
statement with the ValueLists.



Valuelists
----------

The valuelist table include three types of records. These types are
distinguished in the OwnerID column

.. container:: table-wrap

   ========================================= =============================
   Type of item                              OwnerID
   ========================================= =============================
   Valuelists without a owner                0
   Valuelist with owned by another valuelist MFID of the owner valuelist
   Valuelist with owned by an objject Type   MFID of the owner object type
   Valuelist that is a workflow              7
   ========================================= =============================

Using the following select statement will show all the Valuelists with
their owner relationship.

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          SELECT * FROM [dbo].[MFValueList] AS [mvl]
          INNER JOIN ( SELECT MFID, Name FROM [dbo].[MFValueList] AS [mvl]
          UNION 
          SELECT  MFID, Name FROM [dbo].[MFObjectType] AS [mot]) AS mvl2
          ON [mvl2].mfid = [mvl].[OwnerID]
          WHERE [mvl].[OwnerID] <> 0

| 



Valuelist Items
---------------

The MFValuelistItem table is a single table with all the valuelist items
in the vault. The table has number of special columns

.. container:: table-wrap

   =========================================== ============= =========================================================================================================================
   Type of item                                Colmnname     Values
   =========================================== ============= =========================================================================================================================
   Valuelist of the valuelist item             MFValuelistID ID of Valuelist (not MFID)
   owner Valuelist item of the valuelist item  OwnerID       MFID of ValuelistItem
   Unique reference of Valuelist Item of owner Owner_AppRef  AppRef of the Valuelist item that owns the item
   Valuelist item unique reference             AppRef        AppRef of the Valuelist item
   Deleted valuelist items in M-Files          Deleted       0 = current; 1 = deleted
   external id of valuelist item               DisplayID     usually this is the same as the MFID, This id can be used in M-Files external connector to set a different ID to the MFID
   Guid of the valuelist item                  ItemGUID      This is the M-Files internally assigned quid and can be used as an alternative unique reference to the item.
   Process id indicator                        Process_ID    0 = use M-Files value; 1 = use SQL value to update M-Files; 2 = delete item in M-Files
   =========================================== ============= =========================================================================================================================

The following select statement will show all the valuelist items that
have a relationship with other valuelist items

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          SELECT mvli.*, mvl.name, mvli2.name FROM [dbo].[MFValueListItems] AS [mvli] 
          left JOIN [dbo].[MFValueList] AS [mvl]
          ON mvl.id = mvli.[MFValueListID] 

          INNER JOIN [dbo].[MFValueListItems] AS [mvli2]
          ON mvli2.[AppRef] = mvli.[Owner_AppRef]
          WHERE mvli.[OwnerID] <> 0

| 

| 
