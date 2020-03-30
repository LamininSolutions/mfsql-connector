
=======================
spMFTableAuditinBatches
=======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @FromObjid
    - Ususally from 1 but the update can start at any objid
  @ToObjid
    - The default is 10000, set to the highest objid of the Object Type
  @WithStats
    - Set to 1 to show update statistics in the SSMS results window
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

Procedure to update class table in batches

Additional Info
===============

Updating a large number of records from a specific class in MF to SQL in batches 

it is advisable to process updates of large datasets in batches.  
Processing batches will ensure that a logical restart point can be determined in case of failure
It will also keep the size of the dataset for transfer within the limits of 8000 bites.

Examples
========

.. code:: sql

    EXEC [dbo].[spMFTableAuditinBatches] @MFTableName = 'YourTable' -- nvarchar(100)
                                    ,@FromObjid = 1             -- int
                                    ,@ToObjid = 555000          -- int
                                    ,@WithStats = 1             -- bit
                                    ,@Debug = 0;                -- int

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-03-27  LC         add documentation
2019-08-05  LC         add process logging
2019-08-17  LC         Add routine to remove destroyed objects from class table
2018-12-10  LC         Create procedure
==========  =========  ========================================================

