
==============
spMFGetHistory
==============

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName nvarchar(128)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @Process\_id int
    - Set process_id in the class table for records to be selected
    - Use process_id not in (1-4) e.g. 5
  @ColumnNames nvarchar(4000)
    - Comma delimited list of the columns to be included in the export
  @IsFullHistory bit
    - Default = 1
    - 1 will include all the changes of the object for the specified column names
    - Set to 0 to specify any of the other filters
  @SearchString nvarchar(4000)
    - Search for objects included in the object select and property selection with a specific value
    - Search is a 'contain' search
  @NumberOFDays int
    - Set this to show the last x number of days of changes
  @StartDate datetime
    - set to a specific date to only show change history from a specific date (e.g. for the last month)
  @ProcessBatch\_id int (output)
    - Processbatch id for logging
  @Debug int (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

Allows to update MFObjectChangeHistory table with the change history of the specific property of the object based on certain filters

Additional Info
===============

When the history table is updated it will only report the versions that the property was changed. If the property included in the filter did not change, then to specific version will not be recorded in the table.

Process_id is reset to 0 after completion of the processing.

Use Cases(s)

- Show comments made on object
- Show a state was entered and exited
- Show when a property was changed
- Discovery reports for changes to certain properties

Using a search criteria is not yet active.

Prerequisites
=============

Set process_id in the class table to 5 for all the records to be included

Warnings
========

The columnname must match the property in the ColumnName column of MFProperty

Note that the same filter will apply to all the columns included in the run.  Split the get procedure into different runs if different filters must be applied to different columns.

Producing on the history for all objects in a large table could take a considerable time to complete. Use the filters to limit restrict the number of records to fetch from M-Files to optimise the search time.


Examples
========

This procedure can be used to show all the comments  or the last 5 comments made for a object.  It is also handly to assess when a workflow state was changed

.. code:: sql

    UPDATE mfcustomer
    SET Process_ID = 5
    FROM MFCustomer  WHERE id in (9,10)

    DECLARE @RC INT
    DECLARE @TableName NVARCHAR(128) = 'MFCustomer'
    DECLARE @Process_id INT = 5
    DECLARE @ColumnNames NVARCHAR(4000) = 'Address_Line_1,Country'
    DECLARE @IsFullHistory BIT = 1
    DECLARE @NumberOFDays INT
    DECLARE @StartDate DATETIME --= DATEADD(DAY,-1,GETDATE())
    DECLARE @ProcessBatch_id INT
    DECLARE @Debug INT = 0
    DECLARE @Update_ID int

    EXECUTE @RC = [dbo].[spMFGetHistory]
    @MFTableName = @TableName,
    @Process_id = @Process_id,
    @ColumnNames = @ColumnNames,
    @SearchString = null,
    @IsFullHistory = @IsFullHistory,
    @NumberOFDays = @NumberOFDays,
    @StartDate = @StartDate,
    @Update_ID = @Update_ID OUTPUT,
    @ProcessBatch_id = @ProcessBatch_id OUTPUT,
    @Debug = @Debug

    SELECT * FROM [dbo].[MFProcessBatch] AS [mpb] WHERE [mpb].[ProcessBatch_ID] = @ProcessBatch_id
    SELECT * FROM [dbo].[MFProcessBatchDetail] AS [mpbd] WHERE [mpbd].[ProcessBatch_ID] = @ProcessBatch_id

----

Show the results of the table including the name of the property

.. code:: sql

    SELECT toh.*,mp.name AS propertyname FROM mfobjectchangehistory toh
    INNER JOIN mfproperty mp
    ON mp.[MFID] = toh.[Property_ID]
    ORDER BY [toh].[Class_ID],[toh].[ObjID],[toh].[MFVersion],[toh].[Property_ID]

----

Show the results of the table for a state change

.. code:: sql

    SELECT toh.*,mws.name AS StateName, mp.name AS propertyname FROM mfobjectchangehistory toh
    INNER JOIN mfproperty mp
    ON mp.[MFID] = toh.[Property_ID]
    INNER JOIN [dbo].[MFWorkflowState] AS [mws]
    ON [toh].[Property_Value] = mws.mfid
    WHERE [toh].[Property_ID] = 39
    ORDER BY [toh].[Class_ID],[toh].[ObjID],[toh].[MFVersion],[toh].[Property_ID]

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-03-12  LC         resolve bug to update multiple columns
2020-06-25  LC         added exception if invalid column is used
2020-03-12  LC         Revise datetime formatting
2019-09-25  LC         Include fnMFTextToDate to set datetime - dealing with localisation
2019-09-19  LC         Resolve dropping of temp table
2019-09-05  LC         Reset defaults
2019-09-05  LC         Add searchstring option
2019-08-30  JC         Added documentation
2019-08-02  LC         Set lastmodifiedUTC datetime conversion to 105
2019-06-02  LC         Fix bug with lastmodifiedUTC date
2019-01-02  LC         Add ability to show updates in MFUpdateHistory
==========  =========  ========================================================

