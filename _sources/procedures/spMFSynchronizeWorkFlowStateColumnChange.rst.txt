
=======================================
spMFSynchronizeWorkFlowSateColumnChange
=======================================

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

Purpose
=======

The purpose of this procedure is to synchronize workflow state name change in M-Files into the reference table

Examples
========

.. code:: sql

    exec spMFSynchronizeWorkFlowSateColumnChange 'MFCustomer'


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-03-27  LC         Add documentation
2019-06-10  LC         fix bug in name of procedure for error trapping 
2018-03-01  DEV2       Create procedure
==========  =========  ========================================================

