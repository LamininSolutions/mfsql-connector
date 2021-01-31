
==========================
spMFUpdateSynchronizeError
==========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @TableName varchar(100)
    - Valid Class TableName as a string
    - Pass the class table name, e.g. MFCustomer
  @Update\_ID int
    Related update id output
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug int (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======

Fix synchronization errors.

Examples
========

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2018-08-29  LC         Include this process as a part of the logging of MFUpdateTable
2018-08-23  LC         Update procedure to only process the errors from the prior update run
==========  =========  ========================================================

