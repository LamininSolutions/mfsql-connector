
=======================
spMFDeleteAdhocProperty
=======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName nvarchar(128)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @columnNames nvarchar(4000)
    Name of the column to be removed
  @process\_ID smallint
    Use any flag that is not 0 = 4 to indicate the records that should be included. Set the flag on all records if the adhoc property should be removed from all
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======

This procedure is specially useful when the metadata design in the vault has changed over time and properties that is not used any longer is still remaining on the metadata card.  Instead of manually deleted these properties from the metadata card, they can be deleted in bulk using the Connector.

Additional Info
===============

When a class table is refreshed in SQL and the properties are not defined on the metadata card, but are still on the object then it will be added as a separate column towards the end of the Class Table list of columns.

Using this procedure can delete these columns and delete it from the metadata.

Prerequisites
=============

There is a few requirements or steps to be taken to use this procedure:

- Identify the adhoc columns towards the end of the Class Table column list.
- Any column that is not a default column can be specified.
- The property will only be removed from the metadata card if there are no objects with values for that property any longer.
- If the property is set on the metadata card it, the value will be set to Null but it will not be removed.

Examples
========

.. code:: sql

    DECLARE @return_value int
    EXEC    @return_value = [dbo].[spMFDeleteAdhocProperty]
                                  @MFTableName =  N'MFCustomer',
                                  @columnNames =  N'Address',
                                  @process_ID = 5,
                                  @Debug =  NULL
    SELECT  'Return Value' = @return_value
    GO

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-08-22  LC         Update code for deleted column change
2019-08-30  JC         Added documentation
2018-04-25  LC         Fix bug to pick up both ID column and label column when deleting columns
2019-03-10  LC         Fix bug on not deleting the data in column
==========  =========  ========================================================

