
============================
spMFUpdateClassAndProperties
============================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName nvarchar(128)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @ObjectID int
    ObjID of the object
  @NewClassId int (optional)
    - Default = NULL
    - New class ID
  @ColumnNames nvarchar(1000) (optional)
    - Default = NULL
    - New property ID’s(separated by comma) both MFID or property or columnName can be used.
  @ColumnValues nvarchar(1000) (optional)
    Value of the properties(separated by comma) Use # the separate the ids in case of a multilookup
  @Update\_IDOUT int (output)
    Output id of the record in MFUpdateHistory logging the update ; Also added to the record in the Update_ID column on the class table
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

The purpose of this procedure is to Change the class and update any property of an object

Additional Info
===============

The parameters 'ColumnNames' and 'ColumnValues'  follow this pattern.  'columnName1, ColumnName2', 'ValueforFirstColumn, ValueForSecondcolumn'

Use # to separate the values of a multi lookup property.  e.g. 'propvalue1,23#4#234,propvalue3

To set a property to null: include the ColumnName, and a empty string in the ColumnValues. In the example the value of column2 will be set to null.  (e.g. 'ColumnValue1,,ColumnValue3')

Warnings
========

Use the Column with ID in the case of a lookup column.  e.g. for including the Country Column in the procedure, then use the 'Country_ID'  column in the ColumnNames parameter.   Similarly the ID values must be used in the case of  lookup.

For columnNames and ColumnValues the single quote is only used at the start and end of the entire string (do enclose individual items in quotes)

The number of items in columnNames must be exactly the same as ColumnValues.

Examples
========

.. code:: sql

    EXEC [dbo].[spMFUpdateClassAndProperties]
               @MFTableName = N'MFOtherHrdocument', -- nvarchar(128)
               @ObjectID = 71, -- int
               @NewClassId = 1, -- int
               @ColumnNames = N'Name_or_Title', -- nvarchar(100)
               @ColumnValues = N'Area map of chicago.jpg', -- nvarchar(1000)
               @Debug = 0 -- smallint

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2018-04-22  AC         Resolve issue with "Conversion failed when converting the nvarchar value 'DELETE FROM {} WHERE OBJId = {} AND ' to data type int
2018-04-04  DEV2       Added License module validation code.
2017-12-20  LC         Set a default value for propertids and propertyValues; add parameters for UpdateID, and ProcessBatchID, Change naming conversion of Column related parameters, use MFUpdateTAble to process object in new class.
2017-11-23  LC         Localization of properties
2017-07-25  LC         Replace Settings with MFVaultSettings for getting username and vaultname
2016-09-21  DEV2       Removed @Username, @Password, @NetworkAddress,@VaultName and fetch default vault setting as commo separated in @VaultSettings Parameter.
2016-08-22  LC         Update settings index
2015-07-18  DEV2       New parameter add in spMFCreateObjectInternal
2015-07-02  DEV2       @PropertyIDs can be property ID or ColumnName
2015-07-02  DEV2       Bug Fixed: Adding New Property
2015-07-01  DEV2       Skip the object failed to update in M-Files
2015-07-01  DEV2       Error tracing logic updated
==========  =========  ========================================================

