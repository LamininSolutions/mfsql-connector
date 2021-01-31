Advanced updating of Valuelists from external source
====================================================

When updating M-Files using data from external sources, it is often necessary to create new associated valuelist items before the data of the object can be added to M-Files.  Using the Connector, the missing valuelist items can be identified and then added to M-Files before triggering the object import, all as one process.

The following is an example of an advanced updating of multiple dependent valuelists from an external source before processing the
update of the record from the external source.

There is some preparation to be done and several steps in the ongoing process to take into account.

Step 1: Create easy to use lookups for the valuelists.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Valuelists in M-Files is in the :doc:`/tables/tbMFValueList` table and the valuelist items are all in the :doc:`/tables/tbMFValueListItems` table.  Selecting the valuelist items for a specific valuelist requires a join between these two table based on the valuelist_id.

However, we recommend to create a individual view for each valuelist that would be used in your application. The :doc:`/procedures/spMFCreateValueListLookupView` is a very handy tool to rapidly create these lookups.

.. code:: sql

   EXEC dbo.spMFCreateValueListLookupView @ValueListName = 'Country',
    @ViewName = 'vwCountry',
    @Schema = 'custom',
    @Debug = 0

Step 2: Create custom procedure to string process together
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Start with updating the valuelist items from M-Files to the database.  This is only necessary if changes to the valuelist is allowed. :doc:`/procedures/spMFSynchronizeSpecificMetadata` can be executed for the specific ValueListName

.. code:: sql

    EXEC dbo.spMFSynchronizeSpecificMetadata @Metadata = 'ValuelistItem',
    @IsUpdate = 0,
    @ItemName = 'Country', -- reference the name of the valuelist
    @Debug = 0

The next routine is to add new valuelistitems if they do not already exist. The following example filter for missing items and update :doc:`/tables/tbMFValueListItems`, setting the process_id to 1.
Note using the ID of the valuelist table by setting a parameter from the lookup table.  The only values that is required to be populated in the MFvaluelistItem table is the name, valuelist id and process_id.  repeat this routine for each valuelist used in the source table.

.. code:: sql

    DECLARE @Valuelist_ID INT
    SELECT TOP 1 @Valuelist_id = vc.ID_ValueList FROM Custom.vwCountry AS vc

    INSERT INTO dbo.MFValueListItems
    (Name,
    MFValueListID,
    Process_ID)

    SELECT mc.Country,@Valuelist_ID,1
    FROM SourceTable mc
    LEFT JOIN custom.vwCountry vc
    ON vc.Name_ValueListItems = mc.Country
    WHERE vc.mfid_ValuelistItems IS null and mc.Country is not null

The final part of the entire process is to update the valuelist item table to M-Files using :doc:`/procedures/spMFSynchronizeValueListItemsToMfiles`

This procedure will create the new items in M-Files for all the new valuelist items with a process_id = 1.

.. code:: sql

    EXEC dbo.spMFSynchronizeValueListItemsToMFiles

Step 3: use the new mfid of the valuelist items
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Join the lookup table with the source table to get the mfid of the new valuelist item to insert the new record in the class table.

.. code:: sql

    INSERT INTO dbo.MFCustomer
    (Country_ID,
    Customer_Name,
    Process_ID   )
    SELECT vc.MFID_ValueListItems,'Customer Name',1
    FROM SourceTable s
    LEFT JOIN MFcustomer mc
    s.CustomerNr = mc.CustomerNr
    LEFT JOIN custom.vwCountry vc
    ON vc.Name_ValueListItems = s.Country
    WHERE mc.guid IS null
