
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
  @RetainDeletions
    - Default = 0 (no)
	- Set to 1 to retain the objected objects in the class table
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

Additional info
===============

The return value from M-Files for the deletions include a status code and result message.  The return values are logged in the MFUpdateHistory table.

The following status codes are used:

 - 1 = Success object deleted
 - 2 = Success object version destroyed
 - 3 = Success object destroyed
 - 4 = Failed to destroy, object not found
 - 5 = Failed to delete, object not found
 - 6 = Failed to remove version, version not found

Use the parameter RetainDeletions = 1 to retain the deletions in the class table. The timestamp for the deletion will show in the deleted column.

The updated version and deleted state of the deleted record is also shown in the MFAuditHistory table.

Warning
=======

Deletions showing in the class table will be removed when the update procedure is run withoput retain deletions.  The next time this procedure is run showing deletions, all the deletions will be shown again in the class table. 

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

    -- to retain deleted records in class table for use in a third party update procedure
   
    EXEC [spMFDeleteObjectList] @tableName = 'MFCustomer'
						  , @Process_ID = 5
						  , @DeleteWithDestroy = 0
                          , @RetainDeletions = 1

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-06-08  LC         Remove object from class table if not found
2021-06-08  LC         Fix bug to remove item on deletion from class table
2021-06-08  LC         Fix entry in MFUpdateHistory on completion of deletion
2020-12-08  LC         Reset mfversion to -1 when deleting and destroying
2020-12-03  LC         Fix bug when object is destroyed
2020-10-06  LC         Modified to process delete operation in batch
2020-08-22  LC         deleted records in class table will be removed 
2018-04-9   lc         Delete object from class table after deletion.
2018-6-26   LC         Improve return value
2018-8-2    LC         Suppress SQL error when nothing deleted
==========  =========  ========================================================

