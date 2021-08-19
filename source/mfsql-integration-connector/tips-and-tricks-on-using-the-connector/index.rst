Tips and tricks on using the Connector
======================================

The Connector is designed to be applied in many different ways for a
range of different applications.  The following list highlights some of
these applications.



Multi-Class
-----------

Sometimes one need to have the ability to lookup or work with a object
across multiple classes. There is various ways to achieve this.  

#. a) create a view with a union statement for all the class tables that
   need to be included in the multi-class table.
#. b) use the procedure spMFObjectTypeUpdateClassIndex to update the
   table MFObjectTypeToClassObject.  This will create a index for all
   the records included in the application.

Reset SQL Class Table
---------------------

In various scenarios it may be necessary to re-align the class table
with M-Files.  For instance, you may have update the incorrect columns
or incorrect records in SQL and need to re-instate the records prior to
updating it in M-Files. If you are working in batch mode then simply
delete the error records in the SQL table and perform an update from
M-Files.

However, if you have changed the metadata structure of the object in
M-Files, it is good practice to drop the class table and recreate it.
This will ensure that the table design stays in tact.

Dynamically add additional property to class table when inserting/updating records
----------------------------------------------------------------------------------

An additional property that is not currently in the Class table can be
added to the record by adding the column to the class table and then
updating the record with updatemethod 0.  Note that if a lookup property
is added then two columns must be added, one for the property and
another for the property_id. The datatype of the column added must
comply with the definition of the SQL datatype as per MFDataType table

Alternatively the addition property can be added to any class object in
M-Files. When the data is syncronised the additional property column
will automatically be added to the Class Table.



View of Valuelistitems by Class 
--------------------------------

Using the following select statement and joins will show valuelistitems
 for valuelists per class with the related  Property

This view is useful when analysing the use of valuelists and
valuelistitems across multiple classes, especially documents.  

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         SELECT  mvli.ID ,
                 [mvli].[Name] ,
                 [mvli].[MFID] ,
                 [mvli].[AppRef] ,
                 mvli.[Owner_AppRef] AS OwnerAppRef ,
                 mvl.[Name] AS Valuelist ,
                 mvli2.ID AS OwnerID ,
                 [mvli2].[Name] OwnerValuelistitem ,
                 mvl2.[Name] AS OwnerValuelist ,
                 mp.[Name] AS PropertyName ,
                 mc.Name AS classname
         FROM    [dbo].[MFValueListItems] AS [mvli]
                 INNER JOIN [dbo].[MFValueList] AS [mvl] ON [mvl].[ID] = [mvli].[MFValueListID]
                 INNER JOIN [dbo].[MFValueListItems] AS [mvli2] ON [mvli2].[AppRef] = [mvli].[Owner_AppRef]
                 INNER JOIN [dbo].[MFValueList] AS [mvl2] ON [mvl2].[ID] = [mvli2].[MFValueListID]
                 INNER JOIN [dbo].[MFProperty] AS [mp] ON [mp].[MFValueList_ID] = [mvl].[ID]
                 INNER JOIN [dbo].[MFClassProperty] AS [mcp] ON [mp].ID = mcp.[MFProperty_ID]
                 INNER JOIN [dbo].[MFClass] AS [mc] ON mc.ID = mcp.[MFClass_ID]
         WHERE   [mvli].deleted = 0;



View of Valuelistitems by Owner ValuelistItem
---------------------------------------------

Using the following select statement will show valuelistitems by their
owner Valuelistitems

This view is useful when analysing the use of valuelistitems where the
items are owned by another.  For instance each Financial Year has their
own financial periods; or Each County/State has their own cities.

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

              SELECT  mvli.ID ,
                     [mvli].[Name] ,
                     [mvli].[MFID] ,
                     [mvli].[AppRef] ,
                     mvli.[Owner_AppRef] AS OwnerAppRef ,
                     mvl.[Name] AS Valuelist ,
                     mvli2.ID AS OwnerID ,
                     [mvli2].[Name] OwnerValuelistitem ,
                     mvl2.[Name] AS OwnerValuelist
             FROM    [dbo].[MFValueListItems] AS [mvli]
                     INNER JOIN [dbo].[MFValueList] AS [mvl] ON [mvl].[ID] = [mvli].[MFValueListID]
                     INNER JOIN [dbo].[MFValueListItems] AS [mvli2] ON [mvli2].[AppRef] = [mvli].[Owner_AppRef]
                     INNER JOIN [dbo].[MFValueList] AS [mvl2] ON [mvl2].[ID] = [mvli2].[MFValueListID]
             WHERE   [mvli].[OwnerID] <> 0;



Renaming of property related to a valuelist
-------------------------------------------

After renaming a property in M-Files Admin the metadata need to be
refreshed.  Use the MFSQL Manager Web App 'Opearations/Metadata refresh'
menu item. Select 'Properties' in the drop down ans select 'Refresh
meatata'

This will change the name of the property in MFProperty Table. It will
also change the ColumnName in MFProperty table and change the
ColumnsNames of  all existing class tables.  Note that the change of
name of the column in the class table will only come into effect on the
next table update with update method 1 or 2. 

If you area already using the property in any custom procedures,
reports, select statements etc, then you will have to manually adjust
your custom procedures to align with the new columnname.



Showing the objects that was updated using the history table
-------------------------------------------------------------

The :doc:`/tables/tbMFUpdateHistory` table has a record of the result of every update. Refer
to :doc:`/the-connector-framework/connector-content/utility-tables/index`
for more detail on the columns in the MFUpdateHistory table. The column
object version details include all the object versions from M-Files at
the time of the update transaction in XML format.  Use spMFHistoryShow
with @updatecolumn = 1 to return a list of the records that is included
in the update.

      .. code:: sql

              Declare @id int
          SELECT TOP 1 @id = [muh].id
          FROM [dbo].[MFUpdateHistory] AS [muh] ORDER by [muh].[Id] DESC

          EXEC [dbo].[sp_MFUpdateHistoryShow] @Debug = 0,
              @Update_ID = @id,
              @UpdateColumn = 1

Getting deleted objects
=======================

When spMFUpdateTable is executed with the MFLastmodified parameter then
this procedure does not check for records that is deleted in M-Files.
 The same applies when spMFUpdateTableWithLastModifiedDate is executed.

It those cases where it is important to ensure that deleted records in
M-Files are updated in SQL and it is important to use the MFLastModified
date as a parameter in the update routine then the following steps can
be followed to update the deleted records in the class table

This can be achieved by executing the :doc:`/procedures/spMFTableAudit`
procedure



Helper procedures when iterating through the configuration of the vault and the Connector
-----------------------------------------------------------------------------------------

To reset the metadata:  Use spmfDropandUpdateMetadata rather than
spmfSynchronizeMetadata

To delete all the class tables and start over again:
spMFdropAllClassTables

To recreate all class tables: set includeinApp = 1 in MFClass for the
desired tables to be created and then use spMFCreateAllMFTables
