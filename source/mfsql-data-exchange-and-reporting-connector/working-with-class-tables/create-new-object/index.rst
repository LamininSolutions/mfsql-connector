Create new object
=================

A new class object (e.g. Customer) can be created using the Connector.

Insert a new record in a class table and ensure that the following
columns are included as a minimum.

.. container:: table-wrap

   =================== ==========================================================================================================================
   Column              default value
   =================== ==========================================================================================================================
   Class_id            MFID of the target class
   Name_or_title       The name of the object; if the name is automatically calculated then add any value except NULL in this column
   Process_ID          1
   Valuelistitem \_ ID It is only necessary to include the MFID of the valuelistitem. There is no need to include the label of the valuelistitem.
   Deleted             0
   =================== ==========================================================================================================================

Required properties must also have values.  Note that SQL with through
an error if required properties are not included. 

Note that the following select statement will show the required
properties of a specific class

| SELECT mp.Name
| FROM MFClassProperty cp
| INNER JOIN dbo.MFClass mc
| ON `mc.id <http://mc.id>`__ = cp.[MFClass_ID]
| INNER JOIN [dbo].[MFProperty] AS [mp]
| ON `mp.id <http://mp.id>`__ = cp.[MFProperty_ID]
| where cp.Required = 1 and mc.TableName = 'NameOfClassTable' AND
  mp.mfid > 1000

Update table using spmfupdatetable with updatemethod 0 to update one or
multiple new objects into M-Files.  If the class table column
'includedinapp' was set to 2 then inserting a record will automatically
trigger spmfupdatetable for each insert.
