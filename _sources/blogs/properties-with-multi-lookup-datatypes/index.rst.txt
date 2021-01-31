Properties with multi lookup datatypes
======================================

When a new class is created in M-Files it automatically creates a
property with a multi lookup datatype. New properties can also be
created on any class with a multi lookup datatype pointing to either a
class of an object type or a value list.

Working with multi lookup properties in the Connector requires special
treatment.

--------------

Display of multi lookups in class table: The values and IDs are shown as
a delimited string in the class table.

|image0|

In this example we need to select all the records assigned to Andy Nash.
This can easily be accomplished by using the special table function
fnMFParseDelimitedString.

Use cross apply with the table function. The column to be split is used
as the first parameter. The delimited is the second parameter.

The listitem column of the table function will contain the values of the
split string.

.. code:: sql

    SELECT [mpi].[ObjID],
           [mpi].[Name_Or_Title],
           [mpi].[Assigned_to]
    FROM [dbo].[MFPurchaseInvoice] AS [mpi]
        CROSS APPLY [dbo].[fnMFParseDelimitedString]([mpi].[Assigned_to], ';') AS [fmpds]
    WHERE [fmpds].[ListItem] = 'Andy Nash';

A separate row will be shown for each value in the delimited string.

|image1|

| 

.. |image0| image:: img_1.jpg
.. |image1| image:: img_2.jpg
