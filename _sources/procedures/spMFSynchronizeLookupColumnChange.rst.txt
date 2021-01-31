
=================================
spmfSynchronizeLookupColumnChange
=================================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

The purpose of this procedure is to synchronize ValueListItems name change in M-Files into the reference table  

Additional Info
===============

The valuelist items that has changed and have not yet been updated is indicated by the IsNameUpdate column in the MFValuelistItem table.

Set @TableName to null to include all Class tables with the changed names of valuelistitems

When a name change has taken place on a valuelist item in M-Files then it this procedure will automatically be triggered on the next spMFDropandUpdateMetadata to update all the related class tables.

When valuelist items are changed from SQL to M-Files then this procedure must be called separately to update the class tables

Examples
========

.. code:: sql

   DECLARE @ProcessBatch_id INT;
   EXEC dbo.spmfSynchronizeLookupColumnChange @TableName = null,
                                           @ProcessBatch_id = @ProcessBatch_id1 OUTPUT, 
                                           @Debug = 0                                   

    

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-06-10  LC         Fix bug with updating multi lookup values
2018-03-01  DEV2       Create procedure
==========  =========  ========================================================

