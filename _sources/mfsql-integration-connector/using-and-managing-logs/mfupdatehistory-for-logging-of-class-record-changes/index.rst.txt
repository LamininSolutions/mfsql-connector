MFUpdateHistory for logging of class record changes
===================================================

Logging
-------

Every update that is processed through spMFUpdateTable is logged in the
MFUpdateHistory Table.

As soon as the update is initiated an ID is reserved from
MFUpdateHistory and the items related to the update is recorded in the
table as XML records.  Note that this table potentially could include
large XML records and it is not recommended to perform a select
statement on this table without any filters.  It is also important to
ensure that this table is maintained and that old records are regularly
deleted.  See spMFDeleteHistory.

The significance and nature of the contents of the columns in the
MFUpdateHistory table will depend and the parameters of the
MFUpdateTable procedure and the outcome of the procedure.


========================= ====================================================================================================== ============================================================================================================
Column                    Description of XML columns                                                                             Sample
========================= ====================================================================================================== ============================================================================================================
ObjectDetails             ObjectType and Class of the table                                                                      | <form>
                                                                                                                                 | <Object id="0">
Update Method 1                                                                                                                  | <class id="17" />
                                                                                                                                 | </Object>
                                                                                                                                 | </form>
ObjectDetails             ObjectType, Class, Property id, datatype and value of each record included in the filter               | <form>
                                                                                                                                 | <Object id="243" sqlID="33328">
Update Method 0                                                                                                                  | <class id="163">
                                                                                                                                 | <property id="0" dataType="1">Update</property>
                                                                                                                                 | <property id="27" dataType="7">0</property>
                                                                                                                                 | <property id="37" dataType="8" />
                                                                                                                                 | <property id="38" dataType="9">122</property>
                                                                                                                                 | <property id="39" dataType="9">214</property>
                                                                                                                                 | <property id="1079" dataType="10" />
                                                                                                                                
                                                                                                                                
ObjVerDetails             Object Version of the objects including: Object Type, Object ID; Version: ObjectGuid                   | form>
                                                                                                                                 | <ObjectType id="186">
Update Method 1                                                                                                                  | <objVers objectID="67957" version="1" objectGUID="{8328F62A-6534-4286-B436-07B394711187}" />
                                                                                                                                 | <objVers objectID="68750" version="3" objectGUID="{F34392E4-D130-4ACB-A4D5-3B325399F6AB}" />
                                                                                                                                 | <objVers objectID="68940" version="1" objectGUID="{8B079EFF-6096-49C3-981F-006A58917ABC}" />
                                                                                                                                 | <objVers objectID="68941" version="1" objectGUID="{5BDAAB58-3DE2-4105-BFAE-B38827BA2042}" />
                                                                                                                                 | <objVers objectID="68997" version="1" objectGUID="{3EE44F72-37F5-4DFE-9AB0-60409AE4014F}" />
                                                                                                                                
                                                                                                                                 
ObjVerDetails             Not applicable                                                                                         Null
                                                                                                                                
Update Method 0                                                                                                                 
NewOrUpdatedObjectVer     Not Applicable                                                                                         Null
                                                                                                                                
Update Method 1                                                                                                                 
NewOrUpdatedObjectVer     Object Version of new objects from M-Files to be updated in SQL                                        | <form>
                                                                                                                                 | <ObjectType id="186">
Update Method 0           Object Type, Object ID; Version: ObjectGuid                                                            | <objVers objectID="67957" version="1" objectGUID="{8328F62A-6534-4286-B436-07B394711187}" />
                                                                                                                                 | <objVers objectID="68750" version="3" objectGUID="{F34392E4-D130-4ACB-A4D5-3B325399F6AB}" />
                                                                                                                                 | <objVers objectID="68940" version="1" objectGUID="{8B079EFF-6096-49C3-981F-006A58917ABC}" />
                                                                                                                                 | <objVers objectID="68941" version="1" objectGUID="{5BDAAB58-3DE2-4105-BFAE-B38827BA2042}" />
                                                                                                                                 | <objVers objectID="68997" version="1" objectGUID="{3EE44F72-37F5-4DFE-9AB0-60409AE4014F}" />
                                                                                                                                 | <objVers objectID="68998" version="1" objectGUID="{9264AB20-59B6-45C0-B2B5-605E2E56A54E}" />
                                                                                                                                 | <objVers objectID="68999" version="1" objectGUID="{5D7DC8ED-07BF-4D6B-8442-8123E23D6E66}" />
                                                                                                                                
NewOrUpdatedObjectDetails Property details of the objects that is new or has changed in M-Files and are due to be updated in SQL | <form>
                                                                                                                                 | <Object objectId="662" objVersion="6" objectGUID="{53C12CE1-600B-4FBF-BA50-6D524FB34E2E}" DisplayID="662">
Update Method 1 and 0     Note that when NewOrUpdatedObjectVer is included that these objects are new in SQL                     | <properties propertyId="0" dataType="MFDatatypeText" propertyValue="Brokered Purchase Order TEMPLATE" />
                                                                                                                                 | <properties propertyId="21" dataType="MFDatatypeTimestamp" propertyValue="10-05-2015 21:23" />
                                                                                                                                 | <properties propertyId="23" dataType="MFDatatypeLookup" propertyValue="leRoux Cilliers" />
                                                                                                                                 | <properties propertyId="23" propertyValue="34" />
SynchronizationError      Object version of the record that has error                                                           
DeletedObjects            Object version of the record that is marked as deleted                                                 | <form>
                                                                                                                                 | <objVers objectID="345208" version="6" />
                                                                                                                                 | <objVers objectID="346581" version="2" />
MFError                   Listing of the records with errors                                                                    
========================= ====================================================================================================== ============================================================================================================

This table could be a large table due to the XML content and it is
advisable to extract specific data from it, rather that attempting to
list the entire table.

To view the most recent updates use 

**Execute Procedure**

.. code:: sql

    SELECT top 5 * FROM [dbo].[MFUpdateHistory] AS [muh] order by id des

Use the procedure spMFUpdateHistoryShow to review the results of a
specific Update_ID

