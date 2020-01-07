
=================
spMFGetObjectvers
=================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @TableName nvarchar(100)
    fixme description
  @dtModifiedDate datetime
    fixme description
  @MFIDs nvarchar(4000)
    fixme description
  @outPutXML nvarchar(max) (output)
    fixme description
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======

To get all the object versions of the class table as XML.

Additional Info
===============

Prerequisites
=============

Warnings
========

Examples
========

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-12-12  LC         Improve text in MFProcessBatchDetail
2019-09-04  LC         Add connection test
2019-08-30  JC         Added documentation
2019-08-05  LC         Improve logging
2019-07-10  LC         Add debugging and messaging
2018-04-04  DEV2       Added License module validation code
2016-08-22  LC         Update settings index
2016 08-22  LC         Change objids to NVARCHAR(4000)
2015 09-21  DEV2       Removed old style vaultsettings, replace with @VaultSettings
2015-06-16  Kishore    Create procedure
==========  =========  ========================================================

