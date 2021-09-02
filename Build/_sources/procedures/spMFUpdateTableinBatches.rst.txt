
========================
spMFUpdateTableinBatches
========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @UpdateMethod INT
    - Default to 1 (From MF to SQL)
    - Set to 0 for updates from SQL to MF
  @WithTableAudit Int
    - Default = 0 (table audit not included)
    - Set to 1 to trigger a table audit on the selected objids
  @FromObjid BIGINT
    Starting objid
  @ToObjid BIGINT
    - End objid inclusive
    - Default = 100 000
  @WithStats BIT
    - Default = 1 (true)
    - When true a log will be produced in the SSMS message window to show the progress
    - Set to 0 to suppress the messages.
  @RetainDeletions BIT
    - Default = 0 (no)
    - Set to 1 to retain the deleted records in the class table
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

When updating a large number of records from a specific class in MF to SQL it is advisable to process these updates of large datasets in batches.  
Processing batches will ensure that a logical restart point can be determined in case of failure or to control the updating in large chunks.
It will also keep the size of the dataset for transfer within the limits of the XML transfer file.

Prerequisites
=============

It is good practice to provide the maximum object id in the Object Type + 500 as the @ToObjid instead of just working with the default of 100 000.  One way to obtain the maximum is to use a view in M-Files on the Segment ID.

Examples
========

update SQL to MF

.. code:: sql

    EXEC [dbo].[spMFUpdateTableinBatches] @MFTableName = 'YourTable'
                                         ,@UpdateMethod = 0
                                         ,@WithStats = 1
                                         ,@Debug = 0;


-----

Update MF to SQL : class table initialisation (note the setting with @WithtableAudit)

.. code:: sql

    EXEC [dbo].[spMFUpdateTableinBatches] @MFTableName = 'YourTable'
                                         ,@UpdateMethod = 1
                                         ,@WithTableAudit = 1
                                         ,@FromObjid = 1
                                         ,@ToObjid = 1000
                                         ,@WithStats = 1
                                         ,@Debug = 0;

-----

Update MF to SQL : Retain the deleted objects in the class table

.. code:: sql

    EXEC [dbo].[spMFUpdateTableinBatches] @MFTableName = 'YourTable'
                                         ,@UpdateMethod = 1
                                         ,@WithTableAudit = 1
                                         ,@FromObjid = 1
                                         ,@ToObjid = 1000
                                         ,@WithStats = 1
                                         ,@RetainDeletions = 1
                                         ,@Debug = 0;

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-08-25  LC         add output to the processbatch_id parameter
2021-05-03  LC         Fix bug to include first record of each batch
2020-09-24  LC         Set updatetable objids to include unmatched versions
2020-09-23  LC         Fix batch size calculation
2020-09-04  LC         Fix null count or set operation
2020-08-23  LC         Add parameter to retain deletions, default set to NO
2019-12-18  LC         include status flag 6 from AuditTable
2019-06-22  LC         substantially rebuilt to improve efficiencies
2019-08-05  LC         resolve issue with catching last object if new and only one object exist
2018-12-15  LC         Create procedure
==========  =========  ========================================================

