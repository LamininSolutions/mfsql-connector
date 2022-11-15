
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
  @RetainDeletions bit
    - Default = No
    - Set explicity to 1 if the class table should retain deletions
  @IsDocumentCollection
    - Default = No
    - Set explicitly to 1 if the class table refers to a document collection class table
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
2022-09-02  LC         Update to include RetainDeletions and DocumentCollections
2022-08-03  LC         fix bug on calling proc in sync precedence
2022-08-03  LC         Updating debug logging to aid error trapping
2019-08-30  JC         Added documentation
2018-08-29  LC         Include this process as a part of the logging of MFUpdateTable
2018-08-23  LC         Update procedure to only process the errors from the prior update run
==========  =========  ========================================================

