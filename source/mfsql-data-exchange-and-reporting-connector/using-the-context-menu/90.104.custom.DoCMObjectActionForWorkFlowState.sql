
PRINT SPACE(5) + QUOTENAME(@@SERVERNAME) + '.' + QUOTENAME(DB_NAME()) + '.[custom].[DoCMObjectActionForWorkFlowState]';
GO
SET NOCOUNT ON

IF EXISTS (	  SELECT	1
			  FROM		[INFORMATION_SCHEMA].[ROUTINES]
			  WHERE		[ROUTINE_NAME] = 'DoCMObjectActionForWorkFlowState' --name of procedure
						AND [ROUTINE_TYPE] = 'PROCEDURE' --for a function --'FUNCTION'
						AND [ROUTINE_SCHEMA] = 'custom'
		  )
	BEGIN
		PRINT SPACE(10) + '...Stored Procedure: update';
		SET NOEXEC ON;
	END;
ELSE PRINT SPACE(10) + '...Stored Procedure: create';
GO

-- if the routine exists this stub creation stem is parsed but not executed
CREATE PROCEDURE [custom].[DoCMObjectActionForWorkFlowState]
AS
	SELECT	'created, but not implemented yet.';
--just anything will do

GO
-- the following section will be always executed
SET NOEXEC OFF;
GO
ALTER  PROCEDURE [Custom].[DoCMObjectActionForWorkFlowState]
  @ID INT
    , @OutPut VARCHAR(1000) OUTPUT
 ,@ProcessBatch_ID INT 
    ,  @ObjectID INT
    , @ObjectType INT
    , @ObjectVer INT
    , @ClassID int
   
AS
      BEGIN
            DECLARE @MFClassTable NVARCHAR(128) = 'MFOtherDocument'
            DECLARE @SQLQuery NVARCHAR(MAX)
            DECLARE @Params NVARCHAR(MAX)
            BEGIN TRY

                  SET @OutPut = 'Process Start Time: ' + CAST(GETDATE() AS VARCHAR(50)) --- set custom process start message for user
  -- Setting Params
         BEGIN
                        DECLARE @procedureName NVARCHAR(128) = 'custom.DoCMObjectActionForWorkFlowState'
                              , @ProcedureStep NVARCHAR(128)
                              , @StartTime DATETIME
                              , @Return_Value INT
  --Updating MFContextMenu to show that process is still running
                        UPDATE  [dbo].[MFContextMenu]
                        SET     [MFContextMenu].[IsProcessRunning] = 1
                        WHERE   [MFContextMenu].[ID] = @ID
--Logging start of process batch
                        EXEC [dbo].[spMFProcessBatch_Upsert]
                            @ProcessBatch_ID = @ProcessBatch_ID 
                          , -- int
                            @ProcessType = @procedureName
                          , -- nvarchar(50)
                            @LogType = N'Message'
                          , -- nvarchar(50)
                            @LogText = @OutPut
                          , -- nvarchar(4000)
                            @LogStatus = N'Started'
                          , -- nvarchar(50)
                            @debug = 0 -- tinyint
                        SET @ProcedureStep = 'Start custom.DoObjectAction'
                        SET @StartTime = GETUTCDATE()
                        EXEC [dbo].[spMFProcessBatchDetail_Insert]
                            @ProcessBatch_ID = @ProcessBatch_ID
                          , -- int
                            @LogType = N'Message'
                          , -- nvarchar(50)
                            @LogText = @OutPut
                          , -- nvarchar(4000)
                            @LogStatus = N'In Progress'
                          , -- nvarchar(50)
                            @StartTime = @StartTime
                          , -- datetime
                            @MFTableName = @MFClassTable
                          , -- nvarchar(128)
                            @Validation_ID = NULL
                          , -- int
                            @ColumnName = NULL
                          , -- nvarchar(128)
                            @ColumnValue = NULL
                          , -- nvarchar(256)
                            @Update_ID = NULL
                          , -- int
                            @LogProcedureName = @procedureName
                          , -- nvarchar(128)
                            @LogProcedureStep = @ProcedureStep
                          , -- nvarchar(128)
                            @debug = 0 -- tinyint
                  END
     --- start of custom process for the action, this example updates keywords property on the object
                  BEGIN
          
                        DECLARE @Name_or_Title NVARCHAR(100)
                        DECLARE @Update_ID INT

      Select @MFClassTable=TableName from MFClass where MFID=@ClassID

      --get object from M-Files
                         EXEC [dbo].[spMFUpdateTable]
                            @MFTableName = @MFClassTable
                          , -- nvarchar(128)
                            @UpdateMethod = 1
                          , -- int
                            @ObjIDs = @ObjectID
                          , -- nvarchar(4000)
                            @Update_IDOut = @Update_ID OUTPUT
                          , -- int
                            @ProcessBatch_ID = @ProcessBatch_ID
                          , -- int
                            @Debug = 0 -- smallint
--Perform action on/with object

SET @output = 'Update_ID ' + CAST(@Update_ID AS NVARCHAR(10))

                      SET @ProcedureStep = 'Refresh from M-Files'
                        SET @StartTime = GETUTCDATE()
                        EXEC [dbo].[spMFProcessBatchDetail_Insert]
                            @ProcessBatch_ID = @ProcessBatch_ID
                          , -- int
                            @LogType = N'Debug'
                          , -- nvarchar(50)
                            @LogText = @OutPut
                          , -- nvarchar(4000)
                            @LogStatus = N'In Progress'
                          , -- nvarchar(50)
                            @StartTime = @StartTime
                          , -- datetime
                            @MFTableName = @MFClassTable
                          , -- nvarchar(128)
                            @Validation_ID = NULL
                          , -- int
                            @ColumnName = NULL
                          , -- nvarchar(128)
                            @ColumnValue = NULL
                          , -- nvarchar(256)
                            @Update_ID = NULL
                          , -- int
                            @LogProcedureName = @procedureName
                          , -- nvarchar(128)
                            @LogProcedureStep = @ProcedureStep
                          , -- nvarchar(128)
                            @debug = 0 -- tinyint


                        SET @Params = N'@Output nvarchar(100), @ObjectID int'
                        SET @SQLQuery = N'

     UPDATE mot
     SET process_ID = 1
     ,Keywords = ''Updated in '' + isnull(@OutPut,'''')
     FROM ' + @MFClassTable + ' mot WHERE [objid] = @ObjectID '



                        EXEC [sys].[sp_executesql]
                            @SQLQuery
                          , @Params
                          , @OutPut = @OutPut
                          , @ObjectID = @ObjectID
--process update of object into M-Files

                        EXEC [dbo].[spMFUpdateTable]
                            @MFTableName = @MFClassTable
                          , -- nvarchar(128)
                            @UpdateMethod = 0
                          , -- int
                            @ObjIDs = @ObjectID
                          , -- nvarchar(4000)
                            @Update_IDOut = @Update_ID OUTPUT
                          , -- int
                            @ProcessBatch_ID = @ProcessBatch_ID
                          , -- int
                           @Debug = 0 -- smallint
SET @output = 'Updated object '+ CAST(@ObjectID AS NVARCHAR(10)) + ' With Update_ID ' + CAST(@Update_ID AS NVARCHAR(10))

                      SET @ProcedureStep = 'Refresh To M-Files'
                        SET @StartTime = GETUTCDATE()
                        EXEC [dbo].[spMFProcessBatchDetail_Insert]
                            @ProcessBatch_ID = @ProcessBatch_ID
                          , -- int
                            @LogType = N'Debug'
                          , -- nvarchar(50)
                            @LogText = @OutPut
                          , -- nvarchar(4000)
                            @LogStatus = N'In Progress'
                          , -- nvarchar(50)
                            @StartTime = @StartTime
                          , -- datetime
                            @MFTableName = @MFClassTable
                          , -- nvarchar(128)
                            @Validation_ID = NULL
                          , -- int
                            @ColumnName = NULL
                          , -- nvarchar(128)
                            @ColumnValue = NULL
                          , -- nvarchar(256)
                            @Update_ID = NULL
                          , -- int
                            @LogProcedureName = @procedureName
                          , -- nvarchar(128)
                            @LogProcedureStep = @ProcedureStep
                          , -- nvarchar(128)
                            @debug = 0 -- tinyint


                  END
-- reset process running in Context Menu
                  UPDATE    [dbo].[MFContextMenu]
                  SET       [MFContextMenu].[IsProcessRunning] = 0
                  WHERE     [MFContextMenu].[ID] = @ID
-- set custom message to user
                  SET @OutPut = @OutPut + ' Process End Time= ' + CAST(GETDATE() AS VARCHAR(50))
-- logging end of process batch
                  EXEC [dbo].[spMFProcessBatch_Upsert]
                    @ProcessBatch_ID = @ProcessBatch_ID
                  , -- int
                    @ProcessType = @procedureName
                  , -- nvarchar(50)
                    @LogType = N'Message'
                  , -- nvarchar(50)
                    @LogText = @OutPut
                  , -- nvarchar(4000)
                    @LogStatus = N'Completed'
                  , -- nvarchar(50)
                    @debug = 0 -- tinyint
                  SET @ProcedureStep = 'End custom.DoObjectAction'
                  SET @StartTime = GETUTCDATE()
                  EXEC [dbo].[spMFProcessBatchDetail_Insert]
                    @ProcessBatch_ID = @ProcessBatch_ID
                  , -- int
                    @LogType = N'Message'
                  , -- nvarchar(50)
                    @LogText = @OutPut
                  , -- nvarchar(4000)
                    @LogStatus = N'Success'
                  , -- nvarchar(50)
                    @StartTime = @StartTime
                  , -- datetime
                    @MFTableName = @MFClassTable
                  , -- nvarchar(128)
                    @Validation_ID = NULL
                  , -- int
                    @ColumnName = NULL
                  , -- nvarchar(128)
                    @ColumnValue = NULL
                  , -- nvarchar(256)
                    @Update_ID = NULL
                  , -- int
                    @LogProcedureName = @procedureName
                  , -- nvarchar(128)
                    @LogProcedureStep = @ProcedureStep
                  , -- nvarchar(128)
                    @debug = 0 -- tinyint

-- format message for display in context menu


            END TRY
            BEGIN CATCH
                  SET @OutPut = 'Error:'
                  SET @OutPut = @OutPut + ( SELECT  ERROR_MESSAGE()
                                          )

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
                                         @ProcessType = 'DoObjectActionForWorkFlowState',
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
            END CATCH
      END