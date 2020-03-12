
=============================
spMFProcessBatchDetail_Insert
=============================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ProcessBatch\_ID int (optional)
    Referencing the ID of the ProcessBatch logging table
  @LogType nvarchar(50)
    - Type of logging:
    - Status
    - Error
    - Message
  @LogText nvarchar(4000)
    Include inputs or outputs of logging step
  @LogStatus nvarchar(50)
    - Indicate status of log:
    - Start
    - In Progress
    - Done
  @StartTime datetime
    - Set to GETUTCDATE()
  @MFTableName nvarchar(128)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @Validation\_ID int
    - Use this for a custom table with validation errors
  @ColumnName nvarchar(128)
    - Show the name of the column for the value in ColumnValue
  @ColumnValue nvarchar(256)
    - Show value such as count of records / count of errors etc
  @Update\_ID int
    - Set to Update_ID output from from the calling procedure
  @LogProcedureName nvarchar(128)
    - Set to the name of the procedure that is currently running
  @LogProcedureStep nvarchar(128)
    - Set to a description of the procedure step that is currently being executed
  @ProcessBatchDetail\_ID int (output)
    Add ProcessBatchDetail_ID as parameter to allow for calculation of duration if provided based on input of a specific ID. Procedure will use input to override the passed int StartDate and get start date from the ID provided. This will allow calculation of DurationInSecords seconds on a detail procedure level
  @debug tinyint
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

Add a record to the MFProcessBatchDetail table. This procedure is executed for specific procedure steps.

Additional Info
===============

The columns to be populated will depend on the nature of the sub procedure that is monitored.

Examples
========

.. code:: sql

    SET @ProcedureStep = 'Prepare Table';
    SET @LogTypeDetail = 'Status';
    SET @LogStatusDetail = 'Start';
    SET @LogTextDetail = 'For UpdateMethod ' + CAST(@UpdateMethod AS VARCHAR(10));
    SET @LogColumnName = '';
    SET @LogColumnValue = '';

    EXECUTE @return_value = [dbo].[spMFProcessBatchDetail_Insert]
                                  @ProcessBatch_ID = @ProcessBatch_ID
                                , @LogType = @LogTypeDetail
                                , @LogText = @LogTextDetail
                                , @LogStatus = @LogStatusDetail
                                , @StartTime = @StartTime
                                , @MFTableName = @MFTableName
                                , @Validation_ID = @Validation_ID
                                , @ColumnName = @LogColumnName
                                , @ColumnValue = @LogColumnValue
                                , @Update_ID = @Update_ID
                                , @LogProcedureName = @ProcedureName
                                , @LogProcedureStep = @ProcedureStep
                                , @ProcessBatchDetail_ID =   @ProcessBatchDetail_ID output
                                , @debug = @debug

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-03-12  LC         Improve default wording of text
2019-08-30  JC         Added documentation
2019-01-27  LC         Exclude MFUserMessage table from any logging
2018-10-31  LC         Update logging text
2017-06-30  AC         This will allow calculation of @DureationInSecords seconds on a detail proc level
2017-06-30  AC         Procedure will use input to overide the passed int StartDate and get start date from the ID provided
2017-06-30  AC         Add @ProcessBatchDetail_ID as param to allow for calculation of duration if provided based on input of a specific ID
==========  =========  ========================================================

