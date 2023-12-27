PRINT SPACE(5) + QUOTENAME(@@SERVERNAME) + '.' + QUOTENAME(DB_NAME()) + '.[custom].[DoCMAction]';
GO
SET NOCOUNT ON;

IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'DoCMAction' --name of procedure
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

-- if the routine exists this stub creation stem is parsed but not executed
CREATE PROCEDURE Custom.DoCMAction
AS
SELECT 'created, but not implemented yet.';
--just anything will do

GO
-- the following section will be always executed
SET NOEXEC OFF;
GO
ALTER PROCEDURE Custom.DoCMAction
    @ID INT,
    @OutPut VARCHAR(1000) OUTPUT,
    @ProcessBatch_ID INT = NULL OUTPUT,
    @Debug SMALLINT = 0
AS
BEGIN
    BEGIN TRY

        SET @OutPut = 'Process Start Time: ' + CAST(GETDATE() AS VARCHAR(50)); --- set custom process start message for user

        -- Setting Params

        DECLARE @procedureName NVARCHAR(128) = N'custom.DoCMAction',
                @ProcedureStep NVARCHAR(128),
                @StartTime DATETIME,
                @Return_Value INT;

        BEGIN
            --Updating MFContextMenu to show that process is still running
            UPDATE dbo.MFContextMenu
            SET IsProcessRunning = 1
            WHERE ID = @ID;

            --Logging start of process batch

            IF @Debug > 0
                SELECT @ProcessBatch_ID AS ProcessBatch_ID;

            EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                                             @ProcessType = @procedureName,
                                             @LogType = N'Message',
                                             @LogText = @OutPut,
                                             @LogStatus = N'Started',
                                             @debug = 0;

            SET @ProcedureStep = N'Metadata Syncronisation ';
            SET @StartTime = GETUTCDATE();
            EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID,
                                                   @LogType = N'Message',
                                                   @LogText = @OutPut,
                                                   @LogStatus = N'In Progress',
                                                   @StartTime = @StartTime,
                                                   @MFTableName = NULL,
                                                   @Validation_ID = NULL,
                                                   @ColumnName = NULL,
                                                   @ColumnValue = NULL,
                                                   @Update_ID = NULL,
                                                   @LogProcedureName = @procedureName,
                                                   @LogProcedureStep = @ProcedureStep,
                                                   @debug = 0;
        END;
        --- start of custom process for the action, this example updates perform metadata synchronization

        BEGIN
            SET @ProcedureStep = N'Synchronize metadata ';
            EXEC @Return_Value = dbo.spMFDropAndUpdateMetadata @IsResetAll = 0,
                                                               @WithClassTableReset = 0,
                                                               @WithColumnReset = 0,
                                                               @IsStructureOnly = 1,
                                                               @ProcessBatch_ID = @ProcessBatch_ID,
                                                               @Debug = 0;


        END;
        -- set custom message to user
        SET @OutPut = ISNULL(@OutPut, '') + ' Synchronised metadata End Time= ' + CAST(GETDATE() AS VARCHAR(100));

        IF @Debug > 0
            SELECT @OutPut AS FinalPutput;

        SET @StartTime = GETUTCDATE();
        BEGIN
            -- reset process running in Context Menu
            UPDATE dbo.MFContextMenu
            SET IsProcessRunning = 0
            WHERE ID = @ID;
            -- logging end of process batch
            SET @ProcedureStep = N'End Metadata synchrorization';

            EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID,
                                             @ProcessType = N'Syncronize metadata',
                                             @LogType = N'Message',
                                             @LogText = @OutPut,
                                             @LogStatus = N'Completed',
                                             @debug = 0;

            EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID,
                                                   @LogType = N'Message',
                                                   @LogText = @OutPut,
                                                   @LogStatus = N'Success',
                                                   @StartTime = @StartTime,
                                                   @MFTableName = NULL,
                                                   @Validation_ID = NULL,
                                                   @ColumnName = NULL,
                                                   @ColumnValue = NULL,
                                                   @Update_ID = NULL,
                                                   @LogProcedureName = @procedureName,
                                                   @LogProcedureStep = @ProcedureStep,
                                                   @debug = 0;
        END;
        -- format message for display in context menu     
        DECLARE @MessageOUT NVARCHAR(4000),
                @MessageForMFilesOUT NVARCHAR(4000),
                @EMailHTMLBodyOUT NVARCHAR(MAX),
                @RecordCount INT,
                @UserID INT,
                @ClassTableList NVARCHAR(100),
                @MessageTitle NVARCHAR(100);

        IF @Debug > 0
            SELECT @ProcessBatch_ID AS ProcessBatch_ID_For_Output;


        EXEC dbo.spMFResultMessageForUI @Processbatch_ID = @ProcessBatch_ID,
                                        @Detaillevel = 0,
                                        @MessageOUT = @MessageOUT OUTPUT,
                                        @MessageForMFilesOUT = @MessageForMFilesOUT OUTPUT,
                                        @GetEmailContent = 0,
                                        @EMailHTMLBodyOUT = @EMailHTMLBodyOUT OUTPUT,
                                        @RecordCount = @RecordCount OUTPUT,
                                        @UserID = @UserID OUTPUT,
                                        @ClassTableList = @ClassTableList OUTPUT,
                                        @MessageTitle = @MessageTitle OUTPUT,
                                        @Debug = 0;

        SELECT @OutPut = @MessageForMFilesOUT;
        RETURN @Return_Value;
    END TRY
    BEGIN CATCH
        SET @OutPut = 'Error:';
        SET @OutPut = @OutPut +
                      (
                          SELECT ERROR_MESSAGE()
                      );
        DECLARE @logstatus NVARCHAR(100);
        DECLARE @LogtextDetail NVARCHAR(100);
        SET @OutPut = 'Error:';
        SET @OutPut = @OutPut +
                      (
                          SELECT ERROR_MESSAGE()
                      );

        SET @StartTime = GETUTCDATE();
        SET @logstatus = N'Failed w/SQL Error';
        SET @LogtextDetail = ERROR_MESSAGE();

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
        (@procedureName, ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_PROCEDURE(), ERROR_STATE(), ERROR_SEVERITY(),
         ERROR_LINE(), @ProcedureStep);

        SET @ProcedureStep = N'Catch Error';
        -------------------------------------------------------------
        -- Log Error
        -------------------------------------------------------------   
        EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID,
                                         @ProcessType = 'DoCMAction',
                                         @LogType = N'Error',
                                         @LogText = @LogtextDetail,
                                         @LogStatus = @logstatus,
                                         @debug = 0;

        SET @StartTime = GETUTCDATE();

        EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID,
                                               @LogType = N'Error',
                                               @LogText = @LogtextDetail,
                                               @LogStatus = @logstatus,
                                               @StartTime = @StartTime,
                                               @MFTableName = NULL,
                                               @Validation_ID = NULL,
                                               @ColumnName = NULL,
                                               @ColumnValue = NULL,
                                               @Update_ID = NULL,
                                               @LogProcedureName = @procedureName,
                                               @LogProcedureStep = @ProcedureStep,
                                               @debug = 0;

        RETURN -1;
    END CATCH;
END;