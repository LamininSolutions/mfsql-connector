Using delimiter functions
=========================

MFSQL Connector uses delimiter based operations, especially for multi
lookups. These functions are useful in your custom development. This use
case elaborate on the application of the functions.

Parse Delimited String
----------------------

The function fnMFParseDelimitedString is a table based function to parse
any string of multiple items split by any delimiter into a table with
two columns: ID and ListItem.

.. code:: sql

    DECLARE @String NVARCHAR(1000)
    SET @string = 'item1, item 2, item 3' 
    select * from [dbo].[fnMFParseDelimitedString](@String,',') as [fmpds]

The ID is the row number of the listing, and the ListItem is the value.

|image0|

This function is also used to in conjunction with multi lookup columns
in class tables to create a join with another table

.. code:: sql

    SELECT * FROM [dbo].[MFCustomerOrder] AS [mco]
    CROSS APPLY [dbo].[fnMFParseDelimitedString](OrderLine_ID,',') AS [fmpds]
    INNER JOIN MFOrderLines mol
    ON mol.objid = [fmpds].listitem

Split
-----

The fnMFSplit function is specifically designed to parse and pair two
delimited lists of property ids and properties. The construct is
fnMFSplit('first list of items delimited','second list of items
delimited','delimiter') The result is a table with ID, PropertyID,
PropertyValue

.. code:: sql

    select * from [dbo].[fnMFSplit]('0,1079','Name of object, Customer',',') as [fms]

|image1|

Split paired string
-------------------

The fnSplitPairedString function is similar to split, however it allows
for including lists with inner delimiters for the two paired strings.
The construct is fnSplitPairedString('first list of items with delimiter
a','Second list of items with delimited a - some items are delimited
with delimited b','Delimiter a','Delimiter b'). In the following example
Customer\_ID values is a list of items in its own right.

.. code:: sql

    select * 
    from [dbo].fnMFSplitPairedString('Customer_ID,Project_ID,Objid','12;36;78,7,10007',',',';')
     as [fmsps]

|image2|

| Split String
| This is similar to ParseDelimitedString

select \* from [dbo].fnMFSplitString as [fmss]

.. |image0| image:: img_1.png
.. |image1| image:: img_2.png
.. |image2| image:: img_3.png
