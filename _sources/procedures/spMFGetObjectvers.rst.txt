
=================
spMFGetObjectvers
=================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @TableName nvarchar(100)
    Class table name
  @dtModifiedDate datetime
    Date from for object versions and deletions
  @MFIDs nvarchar(4000)
    comma delimited string of objids 
  @outPutXML nvarchar(max) (output)
    object versions of filtered objects
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode


Purpose
=======

To get all the object versions of the class table as XML.

Deleted objects and current objects are combined in the @OutputXML if MFIDs are used as a parameter
When Last modified date are used then the @outputXML will include the objects changed later than the date specified 
and the @DeletedOutputXML will include the objects that was deleted since the date lastmodified date.

Warning
=======

Either objids or lastmodified date must be specified. The procedure cannot be used with both filters as null.

Examples
========

.. code:: sql

    DECLARE @outPutXML    NVARCHAR(MAX),
    @DeletedoutPutXML    NVARCHAR(MAX),
    @ProcessBatch_ID3 INT;

    EXEC dbo.spMFGetObjectvers @TableName = MFLarge_volume,
    @dtModifiedDate = '2020-08-01',
    @MFIDs = null,
    @outPutXML = @outPutXML OUTPUT,
    @ProcessBatch_ID = @ProcessBatch_ID3 OUTPUT,
    @Debug = 101

    SELECT CAST(@outPutXML AS XML)
    
Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-08-25  LC         Add return XML for deleted records
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

