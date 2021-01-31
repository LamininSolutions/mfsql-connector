Explore Object History Versions
===============================

MFSQL Connector allows for extracting object history versions with different filters and selection criteria.

This capability is particularly useful when integration has gone off course and for what ever reason created a high number of redundant object history records. 

The unwanted history records can then be targeted to be deleted using the spMFDeleteObjectVersionList

The following illustrates the different options.

spMFGetHistory works in combination with the class table. The result is shown in MFObjectChangeHistory. 

The MFObjectChangeHistory table will include a row for every property changed in each version history for every objid included in the filter.  An object with 10 properties could have 26 records for the first version of the object. This is due to the internal property changes that also could be include in the change record.  For instance, the following is a list of properties changed when a new customer was added.

===========  ==========================================
Property ID  Name
===========  ========================================== 
0            Name or title
20           Created
21           Last modified
22           Single file
23           Last modified by
24           Status changed
25           Created by
27           Deleted
28           Deleted by
30	         Size on server (this version)
31           Size on server (all versions)
32           Marked for archiving
81           Accessed by me
89           Object changed
93           Deletion status changed
100          Class
101          Class groups
1073         Address (line 1)
1082         Address (line 2)
1085         Telephone number
1086         Web site
1087         ZIP/postal code
1088         City
1089         State/province
1090         Country
1110         Customer name
===========  ==========================================

Each time spMFGetHistory is run it will add additional rows for additional items.  It will not update existing items, or removed items that is not part of the filter.  To explore different selection scenarios the existing items must be deleted to avoid overlapping the new results of different scenarios.

Using spMFGetHistory procedure could run for a considerable time and potentially produce millions of records if the filters are not used appropriately.  If the class table contains 100 000 records and there are on average 100 versions and the class include 50 properties for each object then this could produce a result with 500 000 000 row. The SQL Server and M-Files is like to fall over unless the procedure is used within the context of multiple M-Files and large scale SQL servers. it is good practice to limit the exploration into smaller chucks to reduce the runtime for extracting the object versions.

The following parameters can be used to get all history versions for objects in a class. Use this with care as is.

.. code:: sql

    --get all history versions for all properties and objects in class
    EXEC dbo.spMFGetHistory @MFTableName = 'MFCustomer',
    @Process_id = 0,
    @ColumnNames = null,
    @SearchString = null,
    @IsFullHistory = 1,
    @NumberOFDays = null,
    @StartDate = null

When *@ColumnNames* is set to null, or the columnname is not valid then all the properties for the selected range will be returned.

The above procedure has produced 343 history records in MFObjectChangeHistory from 14 objects. This is a factor of 1 to 24.5.

We recommend to first explore the MFVersion column for the targeted class table and set the process_id for objects to get further history. 

.. code:: sql

    -- show number of objects to be included
    select sum(MFVersion), Count(*) from MFCustomer where mfversion > 100	
    --update process_id
    Update mc
    Set Process_id = 5 
    from MFCustomer mc
    Where mfversion > 10

Use spMFGetHistory to get the object history for each of these objects.  The result is in MFObjectchangeHistory.  The following illustrates getting the history for a subset of objects in the class table

.. code:: sql

    --Remove the previous result set from MFObjectChangeHistory
    DELETE FROM dbo.MFObjectChangeHistory 
    WHERE class_id = 78 AND ObjectType_ID = 136

.. code:: sql

    --set process_id to explore a single object
    Update mc
    Set Process_id = 5 
    from MFCustomer mc
    Where objid = 141	
    
.. code:: sql

   EXEC dbo.spMFGetHistory @MFTableName = 'MFCustomer',
    @Process_id = 5,
    @ColumnNames = null,
    @SearchString = null,
    @IsFullHistory = 1,
    @NumberOFDays = null,
    @StartDate = null
 
Note that the objid of the class is only unique in combination with the object type. The MFObjectChangeHistory table may contain results of other classes and object types also. Deleting the previous result set takes above takes account of this in the where clause.

The result for the above produces 29 rows.  The first version show all the properties that has been added when the object is created. The next versions show only rows for the properties that changed for the particular version.

Further filters can be used to restrict the result to only the changes required for your application.

 - using the *ColumnNames* filter as a comma delimited string will restrict the result to only the those columns
 - @IsFullHistory must be set to 0 for any of the other options to be operational. 
 - The Search is not operational. We recommend to use SQL to search for changes with a specific value by first getting all the changes for the desired property and then to filter the result in SQL.
 
.. code:: sql

    -- example toget all the changes where the name_or_title has changed
    EXEC dbo.spMFGetHistory @MFTableName = 'MFCustomer',
    @Process_id = 0,
    @ColumnNames = 'Name_or_Title',
    @SearchString = null,
    @IsFullHistory = 1,
    @NumberOFDays = null,
    @StartDate = null

.. code:: sql

    -- example to get only the workflow_state changes for specific objects
    EXEC dbo.spMFGetHistory @MFTableName = 'MFCustomer',
    @Process_id = 5,
    @ColumnNames = 'Workflow_State_id',
    @SearchString = null,
    @IsFullHistory = 1,
    @NumberOFDays = null,@StartDate = null

