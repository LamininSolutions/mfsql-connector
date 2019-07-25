spMFCreateTable
===============

Returns
   1 = success
Inputs
   @ClassName
      Pass the class name as stored in MFClass Table.
   @Debug
      1 = Debug Mode
      0 = No Debug Mode (default)

Execute “spMFCreateTable” to create table for a class with associate
properties and other custom columns (like ID, GUID, MX\_User\_ID, MFID,
ExternalID, MFVersion, FileCount, IsSingleFile, Update\_ID, and
LastModified).

Example
-------

.. code:: sql

     DECLARE    @return_value int
     
    EXEC        @return_value = [dbo].[spMFCreateTable]
                                  @ClassName =  N'Customer'
     
    SELECT    'Return Value'  = @return_value
     
    GO

Consider if the table will be used for batch update or transaction
update methods.

The trigger to perform the transaction update method will only be
created on the class table if the IncludeInApp column in the MFClass
Table is set to 2 BEFORE the table is created.
