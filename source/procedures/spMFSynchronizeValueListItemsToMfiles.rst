
=====================================
spMFSynchronizeValueListItemsToMfiles
=====================================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table    
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

The purpose of this procedure is to synchronize Sql  MFVALUELISTITEM table to M-files. All items with process_id <> 0 will be considered for updating

Additional Info
===============

Set process_id = 1 to update valuelist item or create new
Set process_id = 2 to delete valuelist item

Prerequisites
=============

All items where process_id is 1 or 2 will be included in the update.  Set the process_id for the items to be update before running this procedure

Examples
========

.. code:: sql

    Exec spMFSynchronizeValueListItemsToMfiles
    
Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-02-20  LC         Add set IsnameUpdate = 1 when update take place
2020-01-10  LC         Improve documentation, add debubbing
2019-08-30  JC         Added documentation
2018-04-04  DEV2       Added Licensing module validation code
==========  =========  ========================================================

