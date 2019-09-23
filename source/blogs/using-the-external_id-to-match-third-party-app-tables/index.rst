Using the External\_ID to match third party app tables
======================================================

This use case focus on using the unique id from a third party
application table as a key reference in SQL and M-Files.

M-Files provides the capability on importing objects via External
Connector to set the unique ID of a dataset to be imported as the
objectID. The objectID is then shown on the metadata card as the ID of
the object. The Connector provides the capability to use the same
functionality. In additional it also provides the ability to update or
change the objectID.

--------------

Every class table has two relevant columns. The Objid and the
External\_ID.

Objid

Integer

Unique within Object Type

Cannot be edited

internal unique ID assigned by M-Files. Sequential within object type.

This ID is not visible in metadata card.

External\_ID

Varchar

Unique within class table

Can be edited

Referred to as Display\_ID in the M-Files API. This is the visible ID in
the metadata card.

If not assigned by the user then it is the same as the Objid.

Scenario 1: Insert new records with unique id from external table.

To insert the external\_Id use a insert SQL statements and set the
external\_id = unique ID from the external table, set process\_id = 1
and run spMFUpdate table with updatemethod = 0.

.. code:: sql

    INSERT INTO [dbo].[MFCustomer]
    (
        [Customer_Name],
        [Process_ID],
        [ExternalID]
    )
    VALUES
    (N'Test Customer', 1, 'C54');

    EXEC [dbo].[spMFUpdateTable] @MFTableName = 'MFCustomer',    -- nvarchar(200)
                                 @UpdateMethod = 0

|image0|

The Connector will throw and error if the external\_ID is not unique.
This check is only performed when the object is updating in M-Files.

Scenario 2: Modify the current external\_id.

This may become necessary when the external source have changed from one
system to another, or when the use of the external\_id is introduced at
a later stage.

Use an update statement to modify the existing record in the class table
and reset the external\_id to the new unique reference of the external
table.

In the use case the ID of the 'DAT Sports & Entertainment will be reset
from the current 134 to C134

Before the change the class record is shown as:

|image1|

And the metadata card is:

|image2|

Perform the update:

.. code:: sql

    UPDATE [dbo].[MFCustomer]
    SET [ExternalID] = 'C' + CAST([ObjID] AS VARCHAR(10)),
        [Process_ID] = 1
    WHERE [ID] = 2;

    EXEC [dbo].[spMFUpdateTable] @MFTableName = 'MFCustomer', -- nvarchar(200)
                                 @UpdateMethod = 0;

And the results is:

|image3|

.. |image0| image:: img_1.jpg
.. |image1| image:: img_2.jpg
.. |image2| image:: img_3.jpg
.. |image3| image:: img_4.jpg
