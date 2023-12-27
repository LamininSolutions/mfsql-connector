PRINT SPACE(5) + QUOTENAME(@@SERVERNAME) + '.' + QUOTENAME(DB_NAME()) + '.[custom].[DoCMObjectAction]';
GO
SET NOCOUNT ON;

IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'DoCMObjectAction' --name of procedure
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
CREATE PROCEDURE Custom.DoCMObjectAction
AS
SELECT 'created, but not implemented yet.';
--just anything will do

GO
-- the following section will be always executed
SET NOEXEC OFF;
GO
ALTER PROCEDURE Custom.DoCMObjectAction
@ID INT,
    @OutPut VARCHAR(1000) OUTPUT,
    @ProcessBatch_ID INT ,
    @ObjectID INT,
    @ObjectType INT,
    @ObjectVer INT,
    @ClassID INT
    
AS
BEGIN
    DECLARE @MFClassTable NVARCHAR(128);
    DECLARE @SQLQuery NVARCHAR(MAX);
    DECLARE @Params NVARCHAR(MAX);
    BEGIN TRY

        SET @OutPut = 'Process Start Time: ' + CAST(GETDATE() AS VARCHAR(50)); --- set custom process start message for user

        -- Setting Params

        BEGIN
            DECLARE @procedureName NVARCHAR(128) = N'custom.DoObjectAction',
                    @ProcedureStep NVARCHAR(128),
                    @StartTime DATETIME,
                    @Return_Value INT;
            --Updating MFContextMenu to show that process is still running
            --UPDATE dbo.MFContextMenu
            --SET IsProcessRunning = 1
            --WHERE ID = @ID;
            --Logging start of process batch
            EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID ,
                                             @ProcessType = @procedureName,
                                             @LogType = N'Message',
                                             @LogText = @OutPut,
                                             @LogStatus = N'Started',
                                             @debug = 0; 
            SET @ProcedureStep = N'Start custom.DoObjectAction';
            SET @StartTime = GETUTCDATE();
            EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID,
                                                   @LogType = N'Message',
                                                   @LogText = @OutPut,
                                                   @LogStatus = N'In Progress',
                                                   @StartTime = @StartTime,
                                                   @MFTableName = @MFClassTable,
                                                   @Validation_ID = NULL,
                                                   @ColumnName = NULL,
                                                   @ColumnValue = NULL,
                                                   @Update_ID = NULL,
                                                   @LogProcedureName = @procedureName,
                                                   @LogProcedureStep = @ProcedureStep,
                                                   @debug = 0; 
        END;
        --- start of custom process for the action, this example updates keywords property on the object
        BEGIN
            DECLARE @Name_or_Title NVARCHAR(100);
            DECLARE @Update_ID INT; 
            
            --get classtable name 
            SELECT @MFClassTable = TableName
            FROM dbo.MFClass
            WHERE MFID = @ClassID;

            -- create table if not existing
            IF NOT EXISTS
            (
                SELECT T.TABLE_NAME
                FROM INFORMATION_SCHEMA.TABLES AS T
                WHERE T.TABLE_NAME = @MFClassTable
            )
                EXEC dbo.spMFCreateTable @ClassName = N'@MFClassTable', 
                                         @Debug = 0;  
                                         
DECLARE @MFLastUpdateDate SMALLDATETIME,
        @Update_IDOut INT
EXEC @Return_Value = dbo.spMFUpdateMFilesToMFSQL @MFTableName = @MFClassTable,
                                                 @MFLastUpdateDate = @MFLastUpdateDate OUTPUT,
                                                 @UpdateTypeID = 1,    
                                                 @Update_IDOut = @Update_IDOut OUTPUT,
                                                 @ProcessBatch_ID = @ProcessBatch_ID,
                                                 @debug = 0
 
            --Perform action on/with object

            SET @Params = N'@Output nvarchar(100), @ObjectID int';
            SET @SQLQuery
                = N'

     UPDATE mot
     SET process_ID = 1
     ,Name_or_Title = Name_or_Title + ''Updated '' 
     FROM ' + @MFClassTable + N' mot WHERE [objid] = @ObjectID ';

            EXEC sys.sp_executesql @SQLQuery,
                                   @Params,
                                   @OutPut = @OutPut,
                                   @ObjectID = @ObjectID;
            --process update of object into M-Files

            EXEC dbo.spMFUpdateTable @MFTableName = @MFClassTable,
                                     @UpdateMethod = 0,
                                     @ObjIDs = @ObjectID,
                                     @Update_IDOut = @Update_ID OUTPUT,
                                     @ProcessBatch_ID = @ProcessBatch_ID,
                                     @Debug = 0; 

        END;

        -- reset process running in Context Menu
        --UPDATE dbo.MFContextMenu
        --SET IsProcessRunning = 0
        --WHERE ID = @ID;

        -- set custom message to user
        SET @OutPut = @OutPut + ' Process End Time= ' + CAST(GETDATE() AS VARCHAR(50));
        -- logging end of process batch
        EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID,
                                         @ProcessType = @procedureName,
                                         @LogType = N'Message',
                                         @LogText = @OutPut,
                                         @LogStatus = N'Completed',
                                         @debug = 0; 

        SET @ProcedureStep = N'End custom.DoObjectAction';
        SET @StartTime = GETUTCDATE();
        EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID,
                                               @LogType = N'Message',
                                               @LogText = @OutPut,
                                               @LogStatus = N'Success',
                                               @StartTime = @StartTime,
                                               @MFTableName = @MFClassTable,
                                               @Validation_ID = NULL,
                                               @ColumnName = NULL,
                                               @ColumnValue = NULL,
                                               @Update_ID = NULL,
                                               @LogProcedureName = @procedureName,
                                               @LogProcedureStep = @ProcedureStep,
                                               @debug = 0; 

        -- format message for display in context menu

        DECLARE @MessageOUT NVARCHAR(4000),
                @MessageForMFilesOUT NVARCHAR(4000),
                @EMailHTMLBodyOUT NVARCHAR(MAX),
                @RecordCount INT,
                @UserID INT,
                @ClassTableList NVARCHAR(100),
                @MessageTitle NVARCHAR(100);
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

        SET @OutPut = @MessageOUT;

    END TRY
    BEGIN CATCH
        DECLARE @logstatus NVARCHAR(100);
        DECLARE @LogtextDetail NVARCHAR(100);
        SET @OutPut = 'Error:';
        SET @OutPut = @OutPut +
                      (
                          SELECT ERROR_MESSAGE()
                      );

        SET @StartTime = GETUTCDATE();
        SET @LogStatus = 'Failed w/SQL Error';
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
        (@procedureName, ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_PROCEDURE(), ERROR_STATE(), ERROR_SEVERITY(),
         ERROR_LINE(), @ProcedureStep);

        SET @ProcedureStep = N'Catch Error';
        -------------------------------------------------------------
        -- Log Error
        -------------------------------------------------------------   
        EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                                         @ProcessType = 'DoObjectAction',
                                         @LogType = N'Error',
                                         @LogText = @LogTextDetail,
                                         @LogStatus = @LogStatus,
                                         @debug = 0;

        SET @StartTime = GETUTCDATE();

        EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID,
                                               @LogType = N'Error',
                                               @LogText = @LogTextDetail,
                                               @LogStatus = @LogStatus,
                                               @StartTime = @StartTime,
                                               @MFTableName = null,
                                               @Validation_ID = null,
                                               @ColumnName = NULL,
                                               @ColumnValue = NULL,
                                               @Update_ID = @Update_ID,
                                               @LogProcedureName = @procedureName,
                                               @LogProcedureStep = @ProcedureStep,
                                               @debug = 0;

        RETURN -1;
    END CATCH;
END;