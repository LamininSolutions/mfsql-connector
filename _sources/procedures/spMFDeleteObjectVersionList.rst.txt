
===========================
spMFDeleteObjectVersionList
===========================

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

Procedure to delete a series of object versions from a list

This procedure is mainly used to remove unwanted versions of objects, especially in scenarios where these versions where created by repetitive integrations.

Prerequisites
=============

Set process_id of objects to be deleted in the class table prior to running the delete procedure.

This procedure use the table MFObjectChangeHistory as source.  Explore and determine the versions to be deteled using the spmfGetHistory procedure and then to update the Process_id on MFObjectChangeHistory to 1 for the object versions to be included in the deletion.

Warning
=======

When the version to be deleted is set to the latest version the process will fail with error status 6.



Examples
========

.. code:: sql

    --check items before setting process_id
    SELECT mc.id, mch.id, mc.objid, mch.MFversion, mc.MFVersion, mch.[Process_ID], mch.property_id, mch.property_Value, mch.LastModifiedUTC
    FROM   [MFCustomer] mc
    inner join MFObjectChangeHistory mch
    on mc.objid = mch.objid and mc.class_id = mch.class_id
    order by lastModifiedUTC

    --set process_id object to be deleted 
    UPDATE MFObjectChangeHistory
    SET	   [Process_ID] = 5
    WHERE  [ID] = 13

    --CHECK MFILES BEFORE DELETING TO SHOW DIFF


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-10-06  LC         Add new procedure
==========  =========  ========================================================

