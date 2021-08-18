
==============
spMFTableAudit
==============

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName nvarchar(128)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @MFModifiedDate datetime
    Filter by MFiles Last Modified date as a datetime string. Set to null if all records must be selected
  @ObjIDs nvarchar(4000)
    Filter by comma delimited string of objid of the objects to process. Set as null if all records must be included
  @SessionIDOut int (output)
    Output of the session id used to update table MFAuditHistory
  @NewObjectXml nvarchar(max) (output)
    Output of the objver of the record set as a result in nvarchar datatype. This can be converted to an XML record for further processing
  @DeletedInSQL int (output)
    Output the number of items that will be marked as deleted when processing the next spmfUpdateTable
  @UpdateRequired bit (output)
    Set to 1 if any condition exist where M-Files and SQL is not the same.  This can be used to trigger a spmfUpdateTable only when it necessary
  @OutofSync int (output)
    If > 0 then the next updatetable procedure will have synchronisation errors
  @ProcessErrors int (output)
    If > 0 then there are unresolved errors in the table with process_id = 3 or 4
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

Update MFAuditHistory and return the sessionid and the M-Files objver of the selection class as a varchar that can be converted to XML if there is a need for further processing of the result.

Additional Info
===============

At the same time spMFTableAudit will set the deleted flag for all the records in the Class Table that is deleted in M-Files.  This is particularly relevant when this procedure is used in conjunction with the spMFUpdateTable procedure with the filter MFLastModified set.

Examples
========

.. code:: sql

    DECLARE @SessionIDOut INT
           ,@NewObjectXml NVARCHAR(MAX)
           ,@DeletedInSQL INT
           ,@UpdateRequired BIT
           ,@OutofSync INT
           ,@ProcessErrors INT
           ,@ProcessBatch_ID INT;

    EXEC [dbo].[spMFTableAudit]
               @MFTableName = N'MFCustomer' -- nvarchar(128)
              ,@MFModifiedDate = null -- datetime
              ,@ObjIDs = null -- nvarchar(4000)
              ,@SessionIDOut = @SessionIDOut OUTPUT -- int
              ,@NewObjectXml = @NewObjectXml OUTPUT -- nvarchar(max)
              ,@DeletedInSQL = @DeletedInSQL OUTPUT -- int
              ,@UpdateRequired = @UpdateRequired OUTPUT -- bit
              ,@OutofSync = @OutofSync OUTPUT -- int
              ,@ProcessErrors = @ProcessErrors OUTPUT -- int
              ,@ProcessBatch_ID = @ProcessBatch_ID OUTPUT -- int
              ,@Debug = 0 -- smallint

    SELECT @SessionIDOut AS 'session', @UpdateRequired AS UpdateREquired, @OutofSync AS OutofSync, @ProcessErrors AS processErrors
    SELECT * FROM [dbo].[MFProcessBatch] AS [mpb] WHERE [mpb].[ProcessBatch_ID] = @ProcessBatch_ID
    SELECT * FROM [dbo].[MFProcessBatchDetail] AS [mpbd] WHERE [mpbd].[ProcessBatch_ID] = @ProcessBatch_ID

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-04-01  LC         Add statusflag for Collections
2020-09-08  LC         Update to include status code 5 object does not exist
2020-09-04  LC         Add update locking and commit to improve performance
2020-08-22  LC         update to take into account new deleted column
2019-12-10  LC         Fix bug for the removal of records from class table
2019-10-31  LC         Fix bug - change Class_id to Class in delete object section 
2019-09-12  LC         Fix bug - remove deleted objects from table
2019-08-30  JC         Added documentation
2019-08-16  LC         Fix bug for removing destroyed objects
2019-06-22  LC         Objid parameter not yet functional
2019-05-18  LC         Add additional exception for deleted in SQL but not deleted in MF
2019-04-11  LC         Fix collection object type in table
2019-04-11  LC         Add large table protection
2019-04-11  LC         Add validation table exists
2018-12-15  LC         Add ability to get result for selected objids
2018-08-01  LC         Resolve issue with having try catch in transaction processing
2017-12-28  LC         Change insert to merge on audit table
2017-12-27  LC         Remove incorrect error message
2017-08-28  LC         Add param for update required
2017-08-28  LC         Add logging
2017-08-28  LC         Change sequence of params
2016-08-22  LC         Change objids to NVARCHAR(4000)
==========  =========  ========================================================

