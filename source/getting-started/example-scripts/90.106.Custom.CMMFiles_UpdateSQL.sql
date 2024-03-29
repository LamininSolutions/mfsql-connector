
GO


PRINT SPACE(5) + QUOTENAME(@@ServerName) + '.' + QUOTENAME(DB_NAME()) + '.[custom].[CMMFiles_UpdateSQL]';
GO

SET NOCOUNT ON;
GO


IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'CMMFiles_UpdateSQL' --name of procedure
          AND ROUTINE_TYPE = 'PROCEDURE' --for a function --'FUNCTION'
          AND ROUTINE_SCHEMA = 'custom'
)
BEGIN
    PRINT SPACE(10) + '...Stored Procedure: update';

    SET NOEXEC ON;
END;
ELSE
    PRINT SPACE(10) + '...Stored Procedure: create';
GO

CREATE PROCEDURE Custom.CMMFiles_UpdateSQL
AS
SELECT 'created, but not implemented yet.';
GO

SET NOEXEC OFF;
GO

ALTER PROCEDURE Custom.CMMFiles_UpdateSQL
    -- Add the parameters for the stored procedure here
    @ObjectID INT,
    @ObjectType INT,
    @ObjectVer INT,
    @ClassID INT,
    @ID INT,
    @OutPut VARCHAR(1000) OUTPUT,
    @processBatch_ID INT = NULL OUTPUT,
    @Debug INT = 0
AS


/*rST**************************************************************************
==========================
Custom_CMMFiles_UpdateSQL
==========================

Purpose
=======

This procedure illustrates how to include the required sections of script to process the Context Menu queue into your custom procedure for processing Context Menu events.

Additional Info
===============

Two sections of code must be added to your custom script.  These sections are highlighted in the below example with SECTION 1 and SECTION 2

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-01-07  LC         Refine example
2019-12-06  LC         Create procedure
==========  =========  ========================================================

**rST*************************************************************************/


-------------------------------------------------------------
-- CONSTANTS: MFSQL Class Table Specific
-------------------------------------------------------------
DECLARE @MFTableName AS NVARCHAR(128) ;
DECLARE @ProcessType AS NVARCHAR(50);

SET @ProcessType = ISNULL(@ProcessType, 'ProcessType');

-------------------------------------------------------------
-- CONSTATNS: MFSQL Global 
-------------------------------------------------------------
DECLARE @UpdateMethod_1_MFilesToMFSQL TINYINT = 1;
DECLARE @UpdateMethod_0_MFSQLToMFiles TINYINT = 0;
DECLARE @Process_ID_1_Update TINYINT = 1;
DECLARE @Process_ID_6_ObjIDs TINYINT = 6; --marks records for refresh from M-Files by objID vs. in bulk
DECLARE @Process_ID_9_BatchUpdate TINYINT = 9; --marks records previously set as 1 to 9 and update in batches of 250
DECLARE @Process_ID_Delete_ObjIDs INT = -1; --marks records for deletion
DECLARE @Process_ID_2_SyncError TINYINT = 2;
DECLARE @ProcessBatchSize INT = 250;

-------------------------------------------------------------
-- VARIABLES: MFSQL Processing
-------------------------------------------------------------
DECLARE @Update_ID INT;
DECLARE @MFLastModified DATETIME;
DECLARE @Validation_ID INT;

-------------------------------------------------------------
-- VARIABLES: T-SQL Processing
-------------------------------------------------------------
DECLARE @rowcount AS INT = 0;
DECLARE @return_value AS INT = 0;
DECLARE @error AS INT = 0;

-------------------------------------------------------------
-- VARIABLES: DEBUGGING
-------------------------------------------------------------
DECLARE @ProcedureName AS NVARCHAR(128) = N'Custom.MFILES_UpdateMFSQLRecord';
DECLARE @ProcedureStep AS NVARCHAR(128) = N'Start';
DECLARE @DefaultDebugText AS NVARCHAR(256) = N'Proc: %s Step: %s';
DECLARE @DebugText AS NVARCHAR(256) = N'';
DECLARE @Msg AS NVARCHAR(256) = N'';
DECLARE @MsgSeverityInfo AS TINYINT = 10;
DECLARE @MsgSeverityObjectDoesNotExist AS TINYINT = 11;
DECLARE @MsgSeverityGeneralError AS TINYINT = 16;

-------------------------------------------------------------
-- VARIABLES: LOGGING
-------------------------------------------------------------
DECLARE @LogType AS NVARCHAR(50) = N'Status';
DECLARE @LogText AS NVARCHAR(4000) = N'';
DECLARE @LogStatus AS NVARCHAR(50) = N'Started';

DECLARE @LogTypeDetail AS NVARCHAR(50) = N'System';
DECLARE @LogTextDetail AS NVARCHAR(4000) = N'';
DECLARE @LogStatusDetail AS NVARCHAR(50) = N'In Progress';
DECLARE @ProcessBatchDetail_IDOUT AS INT = NULL;

DECLARE @LogColumnName AS NVARCHAR(128) = NULL;
DECLARE @LogColumnValue AS NVARCHAR(256) = NULL;

DECLARE @count INT = 0;
DECLARE @Now AS DATETIME = GETDATE();
DECLARE @StartTime AS DATETIME = GETUTCDATE();
DECLARE @StartTime_Total AS DATETIME = GETUTCDATE();
DECLARE @RunTime_Total AS DECIMAL(18, 4) = 0;

-------------------------------------------------------------
-- VARIABLES: DYNAMIC SQL
-------------------------------------------------------------
DECLARE @sql NVARCHAR(MAX) = N'';
DECLARE @sqlParam NVARCHAR(MAX) = N'';

DECLARE @SQLQuery NVARCHAR(MAX);
DECLARE @Params NVARCHAR(MAX);
DECLARE @RetainDeletions INT = 0;
DECLARE @ContextMenuLog_ID INT;
SET @ProcedureStep = N'Start Custom.MFILES_UpdateMFSQLRecord';
SET @StartTime = GETDATE();

SET @Msg = CAST(@ObjectID AS VARCHAR(10));

--Logging start of process batch
EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                                             -- int
                                 @ProcessType = @ProcedureName,
                                             -- nvarchar(50)
                                 @LogType = N'Context Menu',
                                             -- nvarchar(50)
                                 @LogText = @OutPut,
                                             -- nvarchar(4000)
                                 @LogStatus = N'Started',
                                             -- nvarchar(50)
                                 @debug = 0; -- tinyint

--SECTION 1 OF QUEUE Processing
SET @ProcedureStep = N'Update insert contextmenu queue';

-- start of custom process for the action, this example updates keywords property on the object

-- Get the class table name

SELECT @MFTableName = TableName
FROM dbo.MFClass
WHERE MFID = @ClassID
      AND IncludeInApp > 0;

--Insert rows in MFContextMenuQueue to capture action from MF

BEGIN TRY

DECLARE @updateCycle INT

    SET @SQLQuery = N'UPDATE ' + QUOTENAME(@MFTableName) + N'
				SET process_id = 0
				WHERE objid = @ObjectID';
    EXEC sys.sp_executesql @SQLQuery, N'@ObjectID int', @ObjectID;


    SELECT @ContextMenuLog_ID = MIN(mcmq.id)
    FROM dbo.MFContextMenuQueue AS mcmq
    WHERE mcmq.ObjectID = @ObjectID
          AND mcmq.ObjectType = @ObjectType;
    IF @ContextMenuLog_ID > 0
    BEGIN
SELECT @updateCycle = UpdateCycle FROM dbo.MFContextMenuQueue AS mcmq WHERE id = @ContextMenuLog_ID

        UPDATE mcmq
        SET mcmq.Status = 0, @updateCycle = @updateCycle + 1
        FROM dbo.MFContextMenuQueue AS mcmq
        WHERE mcmq.ObjectID = @ObjectID
              AND mcmq.ObjectType = @ObjectType
              AND @ObjectVer <= mcmq.ObjectVer;

        DELETE FROM dbo.MFContextMenuQueue
        WHERE ObjectID = @ObjectID
              AND ObjectType = @ObjectType
              AND ObjectVer <> ISNULL(@ObjectVer, 0)
              AND id <> @ContextMenuLog_ID;

    END;
    ELSE
    BEGIN
        INSERT INTO dbo.MFContextMenuQueue
        (
            ContextMenu_ID,
            ObjectID,
            ObjectType,
            ObjectVer,
            ClassID,
            Status,
            UpdateCycle,
            ProcessBatch_ID,
            UpdateID,
            CreatedOn
        )
        VALUES
        (@ID, @ObjectID, @ObjectType, @ObjectVer, @ClassID, 0, 1, @ProcessBatch_ID, NULL, @StartTime);
        SET @ContextMenuLog_ID = @@IDENTITY;


    END;

END TRY
BEGIN CATCH

    SET @DebugText = N'FAILED ';
    SET @DefaultDebugText = @DefaultDebugText + @DebugText;

    IF @Debug > 0
    BEGIN
        RAISERROR(@DefaultDebugText, 16, 1, @ProcedureName, @ProcedureStep);
    END;

END CATCH;

-- END OF SECTION 1

BEGIN TRY

    --Main procedure start

    IF @MFTableName IS NOT NULL
    BEGIN
        SET @OutPut = 'Process Start Time: ' + CONVERT(VARCHAR, GETDATE(), 21);

        EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID,
                                                           -- int
                                               @LogType = N'ContextMenu',
                                                           -- nvarchar(50)
                                               @LogText = @OutPut,
                                                           -- nvarchar(4000)
                                               @LogStatus = N'Start',
                                                           -- nvarchar(50)
                                               @StartTime = @StartTime,
                                                           -- datetime
                                               @MFTableName = @MFTableName,
                                                           -- nvarchar(128)
                                               @Validation_ID = NULL,
                                                           -- int
                                               @ColumnName = 'ObjectID',
                                                           -- nvarchar(128)
                                               @ColumnValue = @Msg,
                                                           -- nvarchar(256)
                                               @Update_ID = NULL,
                                                           -- int
                                               @LogProcedureName = @ProcedureName,
                                                           -- nvarchar(128)
                                               @LogProcedureStep = @ProcedureStep,
                                                           -- nvarchar(128)
                                               @debug = 0; -- tinyint

    END;


    EXEC dbo.spMFUpdateTable @MFTableName = @MFTableName,
                                         -- nvarchar(128)
                             @UpdateMethod = 1,
                                         -- int
                             @ObjIDs = @ObjectID,
                                         -- nvarchar(4000)
                             @Update_IDOut = @Update_ID OUTPUT,
                                         -- int
                             @ProcessBatch_ID = @ProcessBatch_ID,
                                         -- int
                             @Debug = 0, -- smallint
                                         --bit
                                         --														 @SyncErrorFlag = 0,
                             @RetainDeletions = @RetainDeletions;

    --SECTION 2 FOR QUEUE PROCESSING

    --validate that update has taken place
    DECLARE @VersionUpdated INT;
    SELECT @VersionUpdated = muh.NewOrUpdatedObjectDetails.value('(/form/Object/@objVersion)[1]', 'int')
    FROM dbo.MFUpdateHistory AS muh
    WHERE muh.Id = @Update_ID;

    --update queue with result
    BEGIN TRAN;
    UPDATE mcl
    SET mcl.UpdateID = @Update_ID,
        mcl.ObjectVer = @VersionUpdated,
        mcl.ProcessBatch_ID = @ProcessBatch_ID,
  mcl.updateCycle = mcl.UpdateCycle + 1,
  mcl.Status = CASE
                         WHEN ISNULL(@ObjectVer, 0) <= @VersionUpdated THEN
                             1
                         ELSE
                             -1
                     END
    FROM dbo.MFContextMenuQueue mcl
    WHERE mcl.id = @ContextMenuLog_ID;
    COMMIT;

    --END OF SECION 2

    EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID,
                                                 -- int
                                     @ProcessType = @ProcedureName,
                                                 -- nvarchar(50)
                                     @LogType = N'debug',
                                                 -- nvarchar(50)
                                     @LogText = @OutPut,
                                                 -- nvarchar(4000)
                                     @LogStatus = N'Completed',
                                                 -- nvarchar(50)
                                     @debug = 0; -- tinyint
    SET @ProcedureStep = N'End Custom.MFILES_UpdateMFSQLRecord';
    SET @StartTime = GETDATE();
    SET @OutPut = 'Process end time: ' + CONVERT(VARCHAR, GETDATE(), 21);

    EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID,
                                                       -- int
                                           @LogType = N'debug',
                                                       -- nvarchar(50)
                                           @LogText = @OutPut,
                                                       -- nvarchar(4000)
                                           @LogStatus = N'Success',
                                                       -- nvarchar(50)
                                           @StartTime = @StartTime,
                                                       -- datetime
                                           @MFTableName = @MFTableName,
                                                       -- nvarchar(128)
                                           @Validation_ID = NULL,
                                                       -- int
                                           @ColumnName = NULL,
                                                       -- nvarchar(128)
                                           @ColumnValue = NULL,
                                                       -- nvarchar(256)
                                           @Update_ID = NULL,
                                                       -- int
                                           @LogProcedureName = @ProcedureName,
                                                       -- nvarchar(128)
                                           @LogProcedureStep = @ProcedureStep,
                                                       -- nvarchar(128)
                                           @debug = 0; -- tinyint


    -- format message for display in context menu
    DECLARE @MessageOUT NVARCHAR(4000),
            @MessageForMFilesOUT NVARCHAR(4000),
            @EMailHTMLBodyOUT NVARCHAR(MAX),
            @RecordCount INT,
            @UserID INT,
            @ClassTableList NVARCHAR(100),
            @MessageTitle NVARCHAR(100);

    EXEC dbo.spMFResultMessageForUI @Processbatch_ID = @ProcessBatch_ID,                -- int
                                    @Detaillevel = 0,                                   -- int
                                    @MessageOUT = @Output OUTPUT,                   -- nvarchar(4000)
                                    @MessageForMFilesOUT = @MessageForMFilesOUT OUTPUT, -- nvarchar(4000)
                                    @GetEmailContent = 0,                               -- bit
                                    @EMailHTMLBodyOUT = @EMailHTMLBodyOUT OUTPUT,       -- nvarchar(max)
                                    @RecordCount = @RecordCount OUTPUT,                 -- int
                                    @UserID = @UserID OUTPUT,                           -- int
                                    @ClassTableList = @ClassTableList OUTPUT,           -- nvarchar(100)
                                    @MessageTitle = @MessageTitle OUTPUT;               -- nvarchar(100)



END TRY
BEGIN CATCH
    SET @StartTime = GETUTCDATE();
    SET @LogStatus = N'Failed w/SQL Error';
    SET @LogTextDetail = ERROR_MESSAGE();

    --------------------------------------------------
    -- INSERTING ERROR DETAILS INTO LOG TABLE
    --------------------------------------------------
    INSERT INTO dbo.MFLog
    (
        SPName,
        ErrorNumber,
        ErrorMessage,
        ErrorProcedure,
        ErrorState,
        ErrorSeverity,
        ErrorLine,
        ProcedureStep
    )
    VALUES
    (@ProcedureName, ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_PROCEDURE(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(),
     @ProcedureStep);

    SET @ProcedureStep = N'Catch Error';
    -------------------------------------------------------------
    -- Log Error
    -------------------------------------------------------------   
    EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                                     @ProcessType = @ProcessType,
                                     @LogType = N'Error',
                                     @LogText = @LogTextDetail,
                                     @LogStatus = @LogStatus,
                                     @debug = @Debug;

    SET @StartTime = GETUTCDATE();

    EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID,
                                           @LogType = N'Error',
                                           @LogText = @LogTextDetail,
                                           @LogStatus = @LogStatus,
                                           @StartTime = @StartTime,
                                           @MFTableName = @MFTableName,
                                           @Validation_ID = @Validation_ID,
                                           @ColumnName = NULL,
                                           @ColumnValue = NULL,
                                           @Update_ID = @Update_ID,
                                           @LogProcedureName = @ProcedureName,
                                           @LogProcedureStep = @ProcedureStep,
                                           @debug = 0;

    RETURN -1;
END CATCH;

GO

