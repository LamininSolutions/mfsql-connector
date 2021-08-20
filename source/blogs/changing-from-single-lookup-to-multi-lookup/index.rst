Changing from single lookup to multi lookup
===========================================

It is quite likely a lookup property datatype will change from double to
single and visa versa. Understanding the impact and how it would affect
the Connector in the background is important.

The documentation has a number of posts and sections about lookups. A
search on ‘lookup’ in the Connector guide is a necessity. it will
highlight sections about lookup datatypes, updating multi lookups,
lookup views, understanding the usage of lookups with
:doc:`/procedures/spMFClassTableColumns`, using lookups in reporting and much more.

Some of the controls and self healing features highlighted in this blog
is only available in version 4.3.9.48 and later.
:doc:`/procedures/spMFDropAndUpdateMetadata`
has new features to validate and update columns.
:doc:`/procedures/spMFClassTableColumns`
is used to validate column usage.

This blog deals with the question: I made a change - so what now?

The likelyhood that it would cause an error if you do nothing is very big,
but may not be noticed immediately.

The error :

Conversion failed when converting the nvarchar value 'errordata' to
data type int.

What causes the error: The \_ID column of a single lookup is of datatype
INT. If the property is changed to a multilookup in the vault and more
than one value is added in M-Files to the property and the metadata
structure did not refresh in the Connector the error will show up. Just
because SQL cannot put a comma delimited string into a INT type column.

The error will not be apparent if a change was made to the property in
M-Files and no multiple selections have been used on the property.

--------------

From version 4.3.9.48 the occurrence of issue is self healing. When the
update takes place the spmfUpdateTable procedure should detect that a
property type change took place, and would change the data type of the
column automatically.

The update of the columns can also be achieved by executing
spmfDropAndUpdateMetadata with the appropriate switches. This should be
done BEFORE executing the next spMFUpdateTable procedure.

.. code:: sql

    DECLARE @ProcessBatch_ID INT;
    EXEC [dbo].[spMFDropAndUpdateMetadata]
    @IsResetAll = 0
    ,@WithClassTableReset = 0
    ,@WithColumnReset = 1
    ,@IsStructureOnly = 0
    ,@ProcessBatch_ID = @ProcessBatch_ID OUTPUT
     ,@Debug = 0

--------------

Prior to 4.3.9.48 action should be taken.

#. Refresh the metadata: Exec spMFDropAndUpdateMetadata

#. Check the class table to verify if the the column has the correct
   datatype. Multilookups \_ID column must be nvarchar(4000). This is
   likely to be the case in versions prior to 4.2.7.46

#. If the column datatype is incorrect then manually change the type.

#. If the datatype is correct, then proceed to update the class table.
