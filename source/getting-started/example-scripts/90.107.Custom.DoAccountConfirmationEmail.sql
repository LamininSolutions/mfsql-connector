/*
This procedure is an example of a custom procedure to prepare a email using the bulk email capability of MFSQL Connector including
- MFEmailTemplate
- MFEmailLog
- spMFConvertTableToHtml
- spMFSendHTMLBodyEmail

If the placeholder of the body is defined as '{head}' then it would use the default CSS defined in MFSettings as the email head.

Two placeholders have been defined as examples : '{firstname}, {user}'. The use of the placeholders are optional.  Additional placeholders can be defined following the same pattern as these two placeholders.

Parameters
  @Template_ID 
     - id of the related template
  @testEmail 
    - recipient email for test
  @TestOnly 
    - set to 1 when testing to avoid sending emails to recipients
   @Objid
     - identity of related object such as objid
   @IncludeTable 
     - default = 0
     - if set to 1 then the email prepare will expect table to be added
   @ProcessBatch_ID (optional, output)
     - Referencing the ID of the ProcessBatch logging table
   @Debug (optional)
     - Default = 0
     - 1 = Standard Debug Mode

*/

ALTER PROC Custom.DoAccountConfirmationEmail -- each custom procedure will deal with a specific template
(
    @Template_ID INT,
    @TestEmail NVARCHAR(256) = N'support@lamininsolutions.com',
    @TestOnly BIT = 0,
    @Objid INT = NULL,
    @IncludeTable BIT = 0,
    @processbatch_ID INT = NULL OUTPUT,
    @debug SMALLINT = 0
)
AS
SET NOCOUNT ON;

BEGIN -- declarations
    -------------------------------------------------------------
    -- CONSTANTS: MFSQL Class Table Specific
    -------------------------------------------------------------
    DECLARE @MFTableName AS NVARCHAR(128) = NULL;
    DECLARE @ProcessType AS NVARCHAR(50);

    SET @ProcessType = ISNULL(@ProcessType, 'Prepare Email');

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
    DECLARE @ProcedureName AS NVARCHAR(128) = N'Custom.DoAccountConfirmationEmail';
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

    -------------------------------------------------------------
    -- VARIABLES: CUSTOM
    -------------------------------------------------------------
    DECLARE @Subject NVARCHAR(256);
    DECLARE @Body NVARCHAR(MAX);
    DECLARE @FromEmail NVARCHAR(128);
    DECLARE @CCmail NVARCHAR(128);
    DECLARE @TablePlaceholder NVARCHAR(128);
    DECLARE @TableBody NVARCHAR(MAX);
    DECLARE @Placeholder NVARCHAR(MAX);
    DECLARE @mailItem_ID INT;
    DECLARE @TableScript NVARCHAR(MAX);
    DECLARE @ChannelID INT;
    DECLARE @RecipientEmail NVARCHAR(256);
    DECLARE @Doc_objid INT;
    DECLARE @id INT;
    DECLARE @Message  NVARCHAR(4000),
        @ErrorMessage NVARCHAR(4000),
        @ec           INT,
        @Stage        NVARCHAR(256),
        @Step         NVARCHAR(256);
END;

--end declarations
-------------------------------------------------------------
-- INTIALIZE PROCESS BATCH
-------------------------------------------------------------
BEGIN --logging
    SET @ProcedureStep = N'Start Logging';
    SET @LogText = N'Processing ' + @ProcedureName;

    EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @processbatch_ID OUTPUT,
        @ProcessType = @ProcessType,
        @LogType = N'Status',
        @LogText = @LogText,
        @LogStatus = N'In Progress',
        @debug = @debug;

    EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @processbatch_ID,
        @LogType = N'Debug',
        @LogText = @ProcessType,
        @LogStatus = N'Started',
        @StartTime = @StartTime,
        @MFTableName = @MFTableName,
        @Validation_ID = @Validation_ID,
        @ColumnName = NULL,
        @ColumnValue = NULL,
        @Update_ID = @Update_ID,
        @LogProcedureName = @ProcedureName,
        @LogProcedureStep = @ProcedureStep,
        @ProcessBatchDetail_ID = @ProcessBatchDetail_IDOUT,
        @debug = 0;
END; -- end initial logging

BEGIN TRY
    -------------------------------------------------------------
    -- BEGIN PROCESS
    -------------------------------------------------------------
    BEGIN --prepare variables
        SET @ProcedureStep = N'Get channel id ';

        -------------------------------------------------------------
        -- Get channel id: the channel is used on the object to trigger the email template type
        -------------------------------------------------------------
        SELECT @ChannelID = MFID_ValuelistItems
        FROM Custom.vwEmailChannel         c
            INNER JOIN dbo.MFEmailTemplate t
                ON t.Channel = c.name_ValuelistItems
        WHERE t.ID = @Template_ID;

        -------------------------------------------------------------
        -- Prepare list of objects to include for the emails to be send out
        -------------------------------------------------------------
        SET @ProcedureStep = N'Get email recipients';

        IF
        (
            SELECT OBJECT_ID('tempdb..#Emaillist')
        ) IS NOT NULL
            DROP TABLE #Emaillist;

        CREATE TABLE #Emaillist
        (
            id INT IDENTITY PRIMARY KEY,
            doc_objid INT,
            RecipientEmail NVARCHAR(256)
        );

        INSERT INTO #Emaillist
        (
            doc_objid,
            RecipientEmail
        )
        /*
The select statement will depend on the case to get the objid and recipient email for all the emails to be send out in bulk. this will allow for each email to be prepared and sent as a loop
*/
        SELECT mo.ObjID,
            me.Email
        FROM dbo.MFOpportunity        AS mo
            INNER JOIN dbo.MFEmployee AS me
                ON me.ObjID = mo.Opportunity_Owner_ID
        WHERE mo.ObjID = @Objid;

        SELECT @id = MIN(id)
        FROM #Emaillist;

        SET @DebugText = N'';
        SET @DebugText = @DefaultDebugText + @DebugText;

        IF @debug > 0
        BEGIN
            SELECT *
            FROM #Emaillist;

            RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
        END;

        -------------------------------------------------------------
        -- Get Email variables from template
        -------------------------------------------------------------
        SET @ProcedureStep = N'Insert table';

        SELECT @FromEmail = et.FromEmail,
            @CCmail       = et.CCEmail,
            @TableScript  = et.TableScript,
            @Subject      = et.Subject,
            @Body
                          = N'<html>' + COALESCE(et.Head_HTML, '') + N'<body>' + COALESCE(et.Greeting_HTML, '')
                            + COALESCE(et.MainBody_HTML, '') + COALESCE(@TablePlaceholder, '') + COALESCE(et.Signature_HTML, '')
                            + COALESCE(et.Footer_HTML, '') + N'</body> </html>'
        FROM dbo.MFEmailTemplate AS et
        WHERE et.ID = @Template_ID;

        SET @DebugText = N'';
        SET @DebugText = @DefaultDebugText + @DebugText;

        IF @debug > 0
        BEGIN
            SELECT @FromEmail AS FromEmail,
                @CCmail       AS CCMail,
                @Subject      AS MailSubject,
                @TableScript  AS TableScript,
                @Body         AS Body;

            RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
        END;

        SET @ProcedureStep = N'Insert table';

        -------------------------------------------------------------
        -- prepare table data
        -------------------------------------------------------------
        IF @IncludeTable = 1
        BEGIN
            IF
            (
                SELECT OBJECT_ID('tempdb..##Report')
            ) IS NOT NULL
                DROP TABLE ##Report;

            -- table script comes from template
            EXEC sys.sp_executesql @TableScript, N'@ObjID int', @Objid;

            EXECUTE dbo.spMFConvertTableToHtml 'Select * from ##Report',
                @TableBody OUTPUT;

            SET @DebugText = N'';
            SET @DebugText = @DefaultDebugText + @DebugText;
            SET @ProcedureStep = 'Get table ';

            IF @debug > 0
            BEGIN
                SELECT *
                FROM ##Report;

                --  SELECT @TableBody
                RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
            END;
        END;

        -------------------------------------------------------------
        -- get list of place holders
        -------------------------------------------------------------
        DECLARE @Patstring NVARCHAR(MAX)
        DECLARE @ReturnString VARCHAR(1000) = '';
        DECLARE @FoundString VARCHAR(1000);
        DECLARE @PatStart INT;
        DECLARE @PatEnd INT;

        SET @Patstring = @Body
        --collate all place holders in body as comma delimited string
        WHILE PATINDEX('%{%', @Patstring) > 0
        BEGIN
            SELECT @PatStart = PATINDEX('%{%', @Patstring),
                @PatEnd      = PATINDEX('%}%', @Patstring);

            --  SELECT @PatStart, @PatEnd
            SET @FoundString = SUBSTRING(@Patstring, @PatStart, (@PatEnd - @PatStart) + 1);

            --     SELECT @FoundString
            IF (LEN(@ReturnString) > 0)
            BEGIN
                SET @ReturnString += ', ';
            END;

            SET @ReturnString += @FoundString;
            SET @Patstring = SUBSTRING(@Patstring, @PatEnd + 1, LEN(@Patstring));
        --        SELECT @Patstring
        END;

        SET @ProcedureStep = 'Placeholders in body: ';
        SET @DebugText = @ReturnString;
        SET @DebugText = @DefaultDebugText + @DebugText;

        IF @debug > 0
        BEGIN
            RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
        END;
    END; -- setup variables

    BEGIN -- head place holder
        -------------------------------------------------------------
        -- replace head CSS
        -------------------------------------------------------------
        SET @ProcedureStep = N'Replace head placeholder';
        SET @Placeholder = NULL;

        --head
            SELECT @Placeholder = CAST([Value] AS NVARCHAR(MAX))
            FROM dbo.MFSettings
            WHERE Name = 'DefaultEMailCSS';

            --SELECT CAST([Value] AS NVARCHAR(MAX))
            --FROM dbo.MFSettings
            --WHERE Name = 'DefaultEMailCSS';

            SELECT @Body = REPLACE(@Body, '{head}', @Placeholder);

        SET @DebugText = N': ' + COALESCE(@Body, ' Head invalid');
        SET @DebugText = @DefaultDebugText + @DebugText;

        IF @debug > 0
        BEGIN

            RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
        END;
    END;

    -- end head placeholder

    -------------------------------------------------------------
    -- Do while loop 
    -------------------------------------------------------------
    -- send email for each email address
    SET @ProcedureStep = N'Loop through emails ';

    WHILE @id IS NOT NULL
    BEGIN -- begin loop

        -------------------------------------------------------------
        -- get recipient email and doc id
        -------------------------------------------------------------
        BEGIN --prepare email
            SELECT @RecipientEmail = RecipientEmail,
                @Doc_objid         = doc_objid
            FROM #Emaillist
            WHERE id = @id;

            -------------------------------------------------------------
            -- set email for testing
            -------------------------------------------------------------
            IF @TestOnly = 1
                SELECT @RecipientEmail = @TestEmail;

            -------------------------------------------------------------
            -- for each place holder in body, get value of placeholder
            -------------------------------------------------------------
            DECLARE @FirstnamePlaceholder NVARCHAR(100);
            DECLARE @UserPlaceholder NVARCHAR(100);
            DECLARE @SubjectPlaceholder NVARCHAR(100);

            -- first name {FirstName} and {User}
            SELECT @FirstnamePlaceholder = c.First_Name,
                @UserPlaceholder         = mo.MF_Last_Modified_By,
                @SubjectPlaceholder      = mo.Account
            FROM dbo.MFContact               c
                INNER JOIN dbo.MFOpportunity AS mo
                    ON mo.Contact_ID = c.ObjID
            WHERE mo.ObjID = @Doc_objid;

            SELECT @Subject = REPLACE(@Subject, '{account}', COALESCE(@SubjectPlaceholder, ''));

            SET @DebugText = N'Subject : ' + COALESCE(@Subject, 'no subject set');
            SET @DebugText = @DefaultDebugText + @DebugText;

            IF @debug > 0
            BEGIN
                RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
            END;

            SELECT @Body = REPLACE(@Body, '{firstname}', COALESCE(@FirstnamePlaceholder, 'Sir/Madam'));

            SET @DebugText = N'firstname : ' + COALESCE(@Body, ' error with body');
            SET @DebugText = @DefaultDebugText + @DebugText;

            IF @debug > 0
            BEGIN
                RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
            END;

            SELECT @Body = REPLACE(@Body, '{user}', COALESCE(@UserPlaceholder, 'MFSQL Support'));

            SET @DebugText = N'user : ' + COALESCE(@Body, ' error with body');
            SET @DebugText = @DefaultDebugText + @DebugText;

            IF @debug > 0
            BEGIN
                RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
            END;

            SELECT @Body = REPLACE(@Body, '{table}', COALESCE(@TableBody, ''));

            SET @DebugText = N'table : ' + COALESCE(@Body, ' error with body');
            SET @DebugText = @DefaultDebugText + @DebugText;

            IF @debug > 0
            BEGIN
                RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
            END;

            SET @DebugText = N'';
            SET @DebugText = @DefaultDebugText + @DebugText;

            IF @debug > 0
            BEGIN
                SELECT @Body AS BodywithPlaceholders;

                RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
            END;
        END;

        --end prepare email
        -------------------------------------------------------------
        -- send and log email
        -------------------------------------------------------------
        BEGIN --send email

            -- Declare the return variable here
            SET @ec = 0;
            SET @rowcount = 0;
            SET @Stage = N'Email';
            SET @Step = N'Prepare';

            -------------------------------------------------------------
            -- start logging email
            -------------------------------------------------------------  
            SET @ProcedureStep = N'insert into maillog for mail preparation';

            MERGE INTO dbo.MFEmailLog t
            USING
            (
                SELECT Document_ID = @Objid,
                    Template_ID    = @Template_ID,
                    Email_Date     = GETDATE(),
                    Email_status   = 'Prepared',
                    Body           = @Body,
                    Recipient      = @RecipientEmail
            ) s
            ON t.document_ID = s.Document_ID
            WHEN NOT MATCHED THEN
                INSERT
                (
                    document_ID,
                    Template_ID,
                    Email_Date,
                    Email_Status,
                    Body,
                    Recipient
                )
                VALUES
                (s.Document_ID, s.Template_ID, s.Email_Date, s.Email_status, s.Body, s.Recipient)
            WHEN MATCHED THEN
                UPDATE SET t.Email_Date = s.Email_Date,
                    t.Email_Status = s.Email_status,
                    t.Body = s.Body,
                    t.Recipient = s.Recipient;

            SET @ProcedureStep = N'Send email';

            IF (@FromEmail IS NULL OR @Subject IS NULL OR @Body IS NULL)
            BEGIN
                SET @ProcedureStep = 'Validate email setup: ';
                SET @DebugText = N'Incomplete formatting ';
                SET @DebugText = @DefaultDebugText + @DebugText;

                RAISERROR(@DebugText, 16, 1, @ProcedureName, @ProcedureStep);
            END;
            ELSE
            BEGIN
                EXEC dbo.spMFSendHTMLBodyEmail @Body,
                    @Subject,
                    @FromEmail,
                    @RecipientEmail,
                    @CCmail,
                    @mailItem_ID OUTPUT;

                SET @DebugText = N'Mail sent id : %i';
                SET @DebugText = @DefaultDebugText + @DebugText;

                IF @debug > 0
                BEGIN
                    RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep, @mailItem_ID);
                END;

                SET @ProcedureStep = N'Update log table with outcome';

                UPDATE dbo.MFEmailLog
                SET msdb_mailitem_id = @mailItem_ID,
                    Email_Status = 'Sent'
                WHERE document_ID = @Objid
                      AND Template_ID = @Template_ID;
            END;

            SET @DebugText = N'Mail log entry for objid %i';
            SET @DebugText = @DefaultDebugText + @DebugText;

            IF @debug > 0
            BEGIN
                SELECT *
                FROM dbo.MFEmailLog
                WHERE document_ID = @Objid;

                RAISERROR(@DebugText, 10, 1, @ProcedureName, @ProcedureStep, @Objid);
            END;

            SELECT @id =
            (
                SELECT MIN(id) FROM #Emaillist WHERE id > @id
            );

            IF @TestOnly = 1
                SELECT @id = NULL;

            IF @debug > 0
                SELECT *
                FROM dbo.MFEmailLog
                WHERE document_ID = @mailItem_ID;
        END; -- end send email  
    END;

    -- end loop send email

    -------------------------------------------------------------
    --END PROCESS
    -------------------------------------------------------------
    END_RUN:
    SET @ProcedureStep = N'End';
    SET @LogStatus = N'Completed';

    -------------------------------------------------------------
    -- Log End of Process
    -------------------------------------------------------------   
    EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @processbatch_ID,
        @ProcessType = @ProcessType,
        @LogType = N'debug',
        @LogText = @LogText,
        @LogStatus = @LogStatus,
        @debug = @debug;

    SET @StartTime = GETUTCDATE();

    EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @processbatch_ID,
        @LogType = N'Debug',
        @LogText = @ProcessType,
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

    RETURN 1;
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
    EXEC dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @processbatch_ID OUTPUT,
        @ProcessType = @ProcessType,
        @LogType = N'Error',
        @LogText = @LogTextDetail,
        @LogStatus = @LogStatus,
        @debug = @debug;

    SET @StartTime = GETUTCDATE();

    EXEC dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @processbatch_ID,
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
GO