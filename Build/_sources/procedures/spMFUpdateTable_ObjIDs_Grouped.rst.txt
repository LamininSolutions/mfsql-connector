
==============================
spMFUpdateTable_ObjIDs_Grouped
==============================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName nvarchar(128)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @MFTableSchema nvarchar(128)
    - Default = 'dbo'
    - Schema to operate on
  @UpdateMethod int (optional)
    - 1 = M-Files to MFSQL (default)
    - 0 = MFSQL to M-Files
  @ProcessId int
    - Default = 6 (merged updates)
  @UserId nvarchar(200) (optional)
    - Default = NULL
    - Update specific user
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

The purpose of this procedure is to group source records into batches and compile a list of OBJIDs in CSV format to pass to spMFUpdateTable

Examples
========

.. code:: sql

    EXEC [spMFUpdateTable_ObjIDs_Grouped]
         @MFTableName = 'CLGLChart',
         @MFTableSchema = 'dbo',
         @UpdateMethod = 0
         @ProcessId = 6     , -- 6 Merged Updates
         @UserId = NULL, --null for all user update
         @Debug  = 1

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2017-06-29  AC         @ObjIds_toUpdate change sizes to NVARCHAR(4000)
2017-06-29  AC         @ObjIds_FieldLenth change default value to 2000
==========  =========  ========================================================

