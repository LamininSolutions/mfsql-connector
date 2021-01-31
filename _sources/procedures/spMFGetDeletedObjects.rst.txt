
=====================
spMFGetDeletedObjects
=====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName nvarchar(200)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @LastModifiedDate datetime
    Default to 2000-01-01
	Allows limited search for deleted object
  @RemoveDeleted bit
    Default = 1.  Deleted records in M-Files are removed from the class table.
	If set to 0 then deleted items will be marked in the class table column 'Deleted' instead of removing the record.
  @ProcessBatch\_ID int (optional, output)
    - Referencing the ID of the ProcessBatch logging table
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

Identify and optionally remove deleted objects in M-Files in class table.

Note this procedure is now redundant and replace with the improvements to spmfUpdateTable and including the Deleted property 27 in the dataset from M-Files by default.


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-08-22  LC         Remove procedure
2019-07-04  LC         Create Procedure
2019-08-30  JC         Added documentation
2019-09-03  LC         Set LastModifiedDate default to 2000-01-01
2019-09-03  LC         Fix bug related to vaultsettings parameter
==========  =========  ========================================================

