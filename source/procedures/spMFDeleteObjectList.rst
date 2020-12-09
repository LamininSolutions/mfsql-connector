
====================
spMFDeleteObjectList
====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @Process_id
    - Set process_id to 5 in the class table for the objects to be included in the delete operation
  @DeleteWithDestroy
    - Default = 0 (no)
	- Set to 1 to destroy the object in M-Files
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

Procedure to delete a series of objects

Prerequisites
=============

Set process_id of objects to be deleted in the class table prior to running the delete procedure.

Examples
========

.. code:: sql

    --check items before commencing
    SELECT id, objid, deleted, [Process_ID], *
    FROM   [MFCustomer]
    --set process_id object to be deleted 
    UPDATE [MFCustomer]
    SET	   [Process_ID] = 5
    WHERE  [ID] = 13

    --CHECK MFILES BEFORE DELETING TO SHOW DIFF

    --to delete
    EXEC [spMFDeleteObjectList] 'MFCustomer'
						  , 5
						  , 0

    --or

    EXEC [spMFDeleteObjectList] @tableName = 'MFCustomer'
						  , @Process_ID = 5
						  , @DeleteWithDestroy = 0

    -- to destroy

    EXEC [spMFDeleteObjectList] 'MFCustomer'
						  , 5
						  , 1

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-12-08  LC         Reset mfversion to -1 when deleting and destroying
2020-12-03  LC         Fix bug when object is destroyed
2020-10-06  LC         Modified to process delete operation in batch
2020-08-22  LC         deleted records in class table will be removed 
2018-04-9   lc         Delete object from class table after deletion.
2018-6-26   LC         Improve return value
2018-8-2    LC         Suppress SQL error when nothing deleted
==========  =========  ========================================================

