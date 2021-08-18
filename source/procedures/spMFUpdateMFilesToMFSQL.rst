
=======================
spMFUpdateMFilesToMFSQL
=======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName nvarchar(128)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @MFLastUpdateDate smalldatetime (output)
    returns the most recent MF Last modified date
  @UpdateTypeID tinyint (optional)
    - 1 = incremental update (default)
    - 0 = Full update
  @MaxObjects INT
    - Default = 20000
    - This parameter has no longer any impact, 
  @WithObjectHistory BIT
    - Default = 0 (No)
    - set to 1 to include updating the object history
  @RetainDeletions BIT
    - Default = 0 (deletions will be removed from class table)
    - set to 1 to retain any deletions since the last update
  @WithStats BIT
    - default = 0
    - Set to 1 to show progress of processing
  @Update\_IDOut int (output)
    returns the id of the last updated batch
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug tinyint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======

The purpose of this procedure has migrated over time from processing records by objid to a routine that can be used by default for large and small tables to process records from M-Files to SQL.
The procedure is fundamentally based on updating M-Files to SQL using a rapid evaluation of the object version of each object and then to update based on the object id of the object.

Additional Info
===============

Setting UpdateTypeID = 0 (Full update) will perform a full audit of the class table by validating every object version in the class and run through an update of all the objects where the version in M-Files and SQL are not identical.

This will run spmfUpdateTableinBatches in silent mode. Note that the Max Objid to control the update is derived as the max(objid) in the class table + 500 of the class table.
Setting UpdateTypeID = 1 (incremental update) will perform an audit of the class table based on the date of the last modified object in the class table, and then update the records that is not identical

Deleted records in M-Files will be identified and removed.

The following importing scenarios apply:

- If the file already exist for the object then the existing file in M-Files will be overwritten. M-Files version control will record the prior version of the record.
- If the object is new in the class table (does not yet have a objid and guid) then the object will first be created in M-Files and then the file will be added.
- If the object in M-Files is a multifile document with no files, then the object will be converted to a single file object.
- if the object in M-files already have a file or files, then it would convert to a multifile object and the additional file will be added
- If the filename or location of the file cannot be found, then a error will be added in the filerror column in the MFFileImport Table.
- If the parameter option @IsFileDelete is set to 1, then the originating file will be deleted.  The default is to not delete.
- The MFFileImport table keeps track of all the file importing activity.

Warnings
========

Use spmfUpdateTableInBatches to initiate a class table instead of this procedure.

Examples
========

.. code:: sql

    --Full Update from MF to SQL

    DECLARE @MFLastUpdateDate SMALLDATETIME
       ,@Update_IDOut     INT
       ,@ProcessBatch_ID  INT;

    EXEC [dbo].[spMFUpdateMFilesToMFSQL] @MFTableName = 'YourTable' 
                                    ,@MFLastUpdateDate = @MFLastUpdateDate OUTPUT 
                                    ,@UpdateTypeID = 0 
                                    ,@Update_IDOut = @Update_IDOut OUTPUT 
                                    ,@ProcessBatch_ID = @ProcessBatch_ID OUTPUT
                                    ,@debug = 0;  

    SELECT @MFLastUpdateDate AS [LastModifiedDate];

    DECLARE @MFLastUpdateDate SMALLDATETIME
       ,@Update_IDOut     INT
       ,@ProcessBatch_ID  INT;

    EXEC [dbo].[spMFUpdateMFilesToMFSQL] @MFTableName = 'YourTable'
                                    ,@MFLastUpdateDate = @MFLastUpdateDate OUTPUT
                                    ,@UpdateTypeID = 1 
                                    ,@Update_IDOut = @Update_IDOut OUTPUT 
                                    ,@ProcessBatch_ID = @ProcessBatch_ID OUTPUT 
                                    ,@debug = 0;                   

    SELECT @MFLastUpdateDate;


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-07-03  LC         improve debugging and error reporting
2021-05-11  LC         redesign the grouping of objects to overcome persistent issues
2021-05-10  LC         add controls to validate group list creation
2021-04-26  LC         add removal of redundant class records
2021-03-17  LC         include audit statusflag =1 into incremental update
2021-03-17  LC         resolve issue where objid for exist for class in two objecttypes
2021-03-16  LC         Remove object where class has changed from audit table
2021-03-11  LC         fix objlist error when both class and audit objid is null
2021-03-10  LC         fix updatechangehistory when control table empty
2021-01-07  LC         Include override to recheck any class objects not in Audit
2020-09-04  LC         Resolve bug with full update 
2020-08-23  LC         replace get max objid with index update
2020-08-23  LC         Add parameter to retain deletions, default set to NO.
2020-08-22  LC         Elliminate use of get deleted records
2020-04-23  LC         Set maxobjects
2020-03-06  LC         Add updating of object history
2020-02-14  LC         Resolve skipped audit items where class missing items
2019-12-10  LC         Add a parameter to set the maximum number of objects in class
2019-09-27  LC         Set withstats for audit batches = 0 
2019-09-27  LC         Fix UpdateID in MFProcessBatchDetail
2019-09-03  LC         Set audittableinbatches to withstats = 0
2019-09-03  LC         Set default date for deleted record check to 2000-01-01
2019-08-30  JC         Added documentation
2019-08-05  LC         Fix bug in updating single record
2019-04-12  LC         Allow for large tables
2018-10-22  LC         Align logtext description for reporting, refine ProcessBatch messages
2018-10-20  LC         Fix processing time calculation
2018-05-10  LC         Add error if invalid table name is specified
2017-12-28  LC         Add routine to reset process_id 3,4 to 0
2017-12-25  LC         Change BatchProcessDetail log text for lastupdatedate
2017-06-29  AC         Change LogStatusDetail to 'Completed' from 'Complete'
2017-06-08  AC         Incorrect LogTypeDetail value
2017-06-08  AC         ProcessBatch_ID not passed into spMFTableAudit
2016-08-11  AC         Create Procedure
==========  =========  ========================================================

