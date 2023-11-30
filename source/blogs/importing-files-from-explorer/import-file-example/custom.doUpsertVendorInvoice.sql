create or alter procedure Custom.DoUpsertVendorInvoice
(
    @ID int = 0
  , @OutPut varchar(1000) output
  , @ProcessBatch_ID int = null output
  , @ObjectID int = null
  , @ObjectType int = null
  , @ObjectVer int = null
  , @ClassID int = null
  , @TemporaryTable nvarchar(100) = null
  , @WithUpdate smallint = 1
  , @Debug smallint = 0
)
as
/***************************************************************************

======================
DoUpsertVendorInvoice
======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ID
  @output
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @objectID
  @ObjectType
  @ObjectVer
  @ClassID
  @WithUpdate : set to 0 to prevent updating new records into MF
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

This custom procedure update the imported Vendor Invoice with additional data 


Additional Info
===============


Prerequisites
=============

The sequence of the parameters must not be changed


Examples
========


  declare @OutPut          varchar(1000)
        , @ProcessBatch_ID int;
  exec custom.DoUpsertVendorInvoice @ID = 0
                                  , @OutPut = @OutPut output
                                  , @ProcessBatch_ID = @ProcessBatch_ID output
                                  , @ObjectID = null
                                  , @ObjectType = null
                                  , @ObjectVer = null
                                  , @ClassID = null
                                  , @TemporaryTable = null
                                  , @WithUpdate = 1
                                  , @Debug = 1

   

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
==========  =========  ========================================================

***************************************************************************/
begin
    set nocount on;

    -------------------------------------------------------------
    -- CONSTANTS: MFSQL Class Table Specific
    -------------------------------------------------------------
    declare @MFTableName as nvarchar(128) = N'MFVendor';
    declare @ProcessType as nvarchar(50);

    set @ProcessType = isnull(@ProcessType, 'Update Vendor Invoice');

    -------------------------------------------------------------
    -- CONSTATNS: MFSQL Global 
    -------------------------------------------------------------
    declare @UpdateMethod_1_MFilesToMFSQL tinyint = 1;
    declare @UpdateMethod_0_MFSQLToMFiles tinyint = 0;
    declare @Process_ID_1_Update tinyint = 1;
    declare @Process_ID_6_ObjIDs tinyint = 6; --marks records for refresh from M-Files by objID vs. in bulk
    declare @Process_ID_9_BatchUpdate tinyint = 9; --marks records previously set as 1 to 9 and update in batches of 250
    declare @Process_ID_Delete_ObjIDs int = -1; --marks records for deletion
    declare @Process_ID_2_SyncError tinyint = 2;
    declare @ProcessBatchSize int = 250;
    declare @UpdateTypeID_1_Incremental tinyint = 1;
    declare @Update_IDOut int;

    -------------------------------------------------------------
    -- VARIABLES: MFSQL Processing
    -------------------------------------------------------------
    declare @Update_ID int;
    declare @MFLastModified datetime;
    declare @Validation_ID int;

    -------------------------------------------------------------
    -- VARIABLES: T-SQL Processing
    -------------------------------------------------------------
    declare @rowcount as int = 0;
    declare @return_value as int = 0;
    declare @error as int = 0;

    -------------------------------------------------------------
    -- VARIABLES: DEBUGGING
    -------------------------------------------------------------
    declare @ProcedureName as nvarchar(128) = N'custom.DoUpsertVendorInvoice';
    declare @ProcedureStep as nvarchar(128) = N'Start';
    declare @DefaultDebugText as nvarchar(256) = N'Proc: %s Step: %s';
    declare @DebugText as nvarchar(256) = N'';
    declare @Msg as nvarchar(256) = N'';
    declare @MsgSeverityInfo as tinyint = 10;
    declare @MsgSeverityObjectDoesNotExist as tinyint = 11;
    declare @MsgSeverityGeneralError as tinyint = 16;

    -------------------------------------------------------------
    -- VARIABLES: LOGGING
    -------------------------------------------------------------
    declare @LogType as nvarchar(50) = N'Status';
    declare @LogText as nvarchar(4000) = N'';
    declare @LogStatus as nvarchar(50) = N'Started';
    declare @LogTypeDetail as nvarchar(50) = N'System';
    declare @LogTextDetail as nvarchar(4000) = N'';
    declare @LogStatusDetail as nvarchar(50) = N'In Progress';
    declare @ProcessBatchDetail_IDOUT as int = null;
    declare @LogColumnName as nvarchar(128) = null;
    declare @LogColumnValue as nvarchar(256) = null;
    declare @count int = 0;
    declare @Now as datetime = getdate();
    declare @StartTime as datetime = getutcdate();
    declare @StartTime_Total as datetime = getutcdate();
    declare @RunTime_Total as decimal(18, 4) = 0;
    declare @MFLastUpdateDate smalldatetime;
    -------------------------------------------------------------
    -- VARIABLES: DYNAMIC SQL
    -------------------------------------------------------------
    declare @sql nvarchar(max) = N'';
    declare @sqlParam nvarchar(max) = N'';

    -------------------------------------------------------------
    -- VARIABLES: CUSTOM
    -------------------------------------------------------------
    declare @ErrorCode nvarchar(100);
    declare @objids nvarchar(max);
    declare @Workflow_PO_id int;
    declare @Workflow_POFile_id int;
    declare @State_PO_new_Id int;
    declare @State_POFile_new_Id int;
    declare @State_LineItem_Id int;
    declare @Gltmp_SL7_Table nvarchar(100);
    declare @APError int;
    declare @APControl_ID int;
    declare @QueryFilter nvarchar(max);
    declare @PONbr nvarchar(100);
    declare @APOutput nvarchar(100);
    declare @ErrorCheckOutput nvarchar(100);
    declare @integration_error_ids nvarchar(100);
    declare @ErrorIDs nvarchar(100);

    -------------------------------------------------------------
    -- INTIALIZE PROCESS BATCH
    -------------------------------------------------------------
    set @ProcedureStep = N'Start Logging';
    set @LogText = N'Processing ' + @ProcedureName;

    set @LogTextDetail
        = N'Temp:' + isnull(@TemporaryTable, 'null') + N' ObjectID: ' + cast(isnull(@ObjectID, 0) as varchar(10));
    set @LogStatusDetail = @ProcessType;
    set @StartTime = getutcdate();

    exec dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID output
                                   , @ProcessType = @ProcessType
                                   , @LogType = N'Status'
                                   , @LogText = @LogText
                                   , @LogStatus = N'In Progress'
                                   , @debug = @Debug;

    exec dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID
                                         , @LogType = N'Debug'
                                         , @LogText = @LogTextDetail
                                         , @LogStatus = @LogStatusDetail
                                         , @StartTime = @StartTime
                                         , @MFTableName = @MFTableName
                                         , @Validation_ID = @Validation_ID
                                         , @ColumnName = @LogColumnName
                                         , @ColumnValue = null
                                         , @Update_ID = @Update_ID
                                         , @LogProcedureName = @ProcedureName
                                         , @LogProcedureStep = @ProcedureStep
                                         , @ProcessBatchDetail_ID = @ProcessBatchDetail_IDOUT
                                         , @debug = 0;

    begin try

        set @count = 0;

        if (
               @ObjectID is not null
               and
               (
                   select TableName from dbo.MFClass where MFID = @ClassID
               ) <> 'MFVendorInvoice'
           )
        begin
            set @DebugText = N'Incorrect object selected, select a PO then perform action';
            set @DebugText = @DefaultDebugText + @DebugText;
            set @ProcedureStep = N'Validate object sensitive call';

            if @Debug > 0
            begin
                raiserror(@DebugText, 16, 1, @ProcedureName, @ProcedureStep);
            end;
        end;

   
        -------------------------------------------------------------
        -- object specific
        -------------------------------------------------------------
        if @ObjectID is null
        begin
            set @DebugText = N'';
            set @DebugText = @DefaultDebugText + @DebugText;
            set @ProcedureStep = N'Update from M-Files - all class updates';

            if @Debug > 0
            begin
                raiserror(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
            end;

            -------------------------------------------------------------
            -- Update From M-Files
            -------------------------------------------------------------
            if @TemporaryTable is null
            begin
                set @MFTableName = N'MFVoucher';

                --UPDATE mpo
                --SET mpo.Process_ID = 0
                --FROM dbo.MFPurchaseOrder AS mpo
                --WHERE mpo.Process_ID = 2;

                exec dbo.spMFUpdateMFilesToMFSQL @MFTableName = @MFTableName
                                               , @MFLastUpdateDate = @MFLastUpdateDate output
                                               , @UpdateTypeID = 1
                                               , @WithStats = 0
                                               , @Update_IDOut = @Update_IDOut output
                                               , @ProcessBatch_ID = @ProcessBatch_ID
                                               , @debug = 0;

                set @MFTableName = N'MFVendorInvoice';

                exec dbo.spMFUpdateMFilesToMFSQL @MFTableName = @MFTableName
                                               , @MFLastUpdateDate = @MFLastUpdateDate output
                                               , @UpdateTypeID = 1
                                               , @WithStats = 0
                                               , @Update_IDOut = @Update_IDOut output
                                               , @ProcessBatch_ID = @ProcessBatch_ID
                                               , @debug = 0;
            end;

            if @ObjectID is not null
            begin
                set @MFTableName = N'MFVoucher';
                set @objids = cast(@ObjectID as nvarchar);

                exec dbo.spMFUpdateTable @MFTableName = @MFTableName
                                       , @UpdateMethod = 1
                                       , @ObjIDs = @objids
                                       , @Update_IDOut = @Update_IDOut output
                                       , @ProcessBatch_ID = @ProcessBatch_ID
                                       , @Debug = 0;

                select @APControl_ID = ObjID
                from dbo.MFApControl
                    cross apply dbo.fnMFParseDelimitedString(Purchase_Orders_ID, ',') as fmpds
                where fmpds.ListItem = @ObjectID;

                set @objids = cast(@APControl_ID as nvarchar);
                set @MFTableName = N'MFVendorInvoice';

                exec dbo.spMFUpdateTable @MFTableName = @MFTableName
                                       , @UpdateMethod = 1
                                       , @ObjIDs = @objids
                                       , @Update_IDOut = @Update_IDOut output
                                       , @ProcessBatch_ID = @ProcessBatch_ID
                                       , @Debug = 0;
            end;
        end; -- temptable is null


        -------------------------------------------------------------
        -- Update Vendor Invoice files
        -------------------------------------------------------------
        set @ProcedureStep = N' Update Vendor Invoice files';
        set @count = 0;
        set @MFTableName = N'MFVendorInvoice';

        if
        (
            select object_id('tempdb..#Fileslist')
        ) is not null
            drop table #Fileslist;

        create table #Fileslist
        (
            id int
          , Invoice_Objid int
          , Voucher_no nvarchar(100)
          , filename nvarchar(100)
          , filelocation nvarchar(100)
          , staging_location nvarchar(100)
          , ImportHistory_status nvarchar(100)
        );

        if @Debug > 0
        begin
            exec (N' SELECT ''staging'',
                *
            FROM Expl.Staging_Files_ImportFiles AS sfeif
            where subPath = ''Voucher''');

            exec (N'SELECT ''MFFileimport'',
                *
            FROM dbo.MFFileImport AS mfi
           where sourcename = ''MFVendorInvoice''');
        end;

        insert into #Fileslist
        (
            Voucher_no
          , filename
          , staging_location
        )
        exec (N'SELECT substring(sfeif.FileName,1,9),
            sfeif.FileName,
            sfeif.RootPath + sfeif.SubPath
        FROM Expl.Staging_Files_EHImportFiles AS sfeif
         where subPath = ''Voucher''');

        set @count = @@rowcount;
        set @OutPut = isnull(@OutPut, '') + ' Files in staging: ' + cast(@count as nvarchar(10));
        set @Msg = N' Files in staging ' + cast(@count as nvarchar(10));
        set @DebugText = N'';
        set @DebugText = @DefaultDebugText + @DebugText;

        if @Debug > 0
        begin
            raiserror(@DebugText, 10, 1, @ProcedureName, @ProcedureStep, @OutPut);
        end;

        set @LogTypeDetail = N'Status';
        set @LogStatusDetail = N'Explorer';
        set @LogTextDetail = @Msg;
        set @LogColumnName = N'';
        set @LogColumnValue = N'';

        execute @return_value = dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID
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
                                                                , @debug = @Debug;

        if @count > 0
        begin

           -------------------------------------------------------------
            -- add new objects if missing
            -------------------------------------------------------------
            set @ProcedureStep = 'Insert new invoice in MF';

            insert into dbo.MFVendorInvoice
            (
                Company_ID
              , Document_Categories_ID
              , Invoice_Display_Name
              , Name_Or_Title
              , State_ID
              , Vendor_ID
              , Voucher_ID
              , Workflow_ID
              , Process_ID
            )
            select mv.Company_ID
                 , (
                       select mdc.ObjID
                       from dbo.MFDocumentCategory as mdc
                       where mdc.Name_Or_Title = 'AP Invoice'
                   )
                 , mv.Voucher_no
                 , mv.Voucher_no
                 , (
                       select mws.MFID
                       from dbo.MFWorkflowState as mws
                       where mws.Alias = 'WFS.VendorInvoiceFlow.Vi02ScannedApInvoice'
                   )
                 , mv.Vendors_ID
                 , mv.ObjID
                 , (
                       select mw.MFID
                       from dbo.MFWorkflow as mw
                       where mw.Alias = 'WF.VendorInvoiceFlow'
                   )
                 , 1
            from #Fileslist                   as f
                inner join dbo.MFVoucher      as mv
                    on mv.Voucher_no = f.Voucher_no
                left join dbo.MFVendorInvoice vi
                    on vi.Voucher_ID = mv.ObjID
            where mv.Voucher_no = f.Voucher_no
                  and mv.ObjID is not null
                  and vi.GUID is null;

                  set @count = @@rowcount

                  set @MFTableName = 'MFVendorInvoice'

                  if @count > 0
                  begin

                  exec dbo.spMFUpdateTable @MFTableName = @MFTableName
                                         , @UpdateMethod = @UpdateMethod_0_MFSQLToMFiles
                                         , @Update_IDOut = @Update_IDOut output
                                         , @ProcessBatch_ID = @ProcessBatch_ID 
                                         , @Debug = 0
                  

                  End
   
   set @ProcedureStep = 'update #filelist '

            update f
            set f.Invoice_Objid = vi.ObjID
              , f.id = vi.id
            from #Fileslist                   as f
                inner join dbo.MFVoucher      as mv
                    on mv.Voucher_no = f.Voucher_no
                left join dbo.MFVendorInvoice vi
                    on vi.Voucher_ID = mv.ObjID
            where mv.Voucher_no = f.Voucher_no;

            update f
            set f.filelocation = mfi.SourceName
              , f.ImportHistory_status = mfi.ImportError
            from #Fileslist                        as f
                inner join  dbo.MFVendorInvoice vi
                    on vi.objid = f.Invoice_objid
                left join dbo.MFFileImport         as mfi
                    on mfi.ObjID = vi.ObjID
                       and mfi.TargetClassID = vi.Class_ID
            where mfi.ImportError = 'success';

            if @Debug > 0
            begin
                select '#filelist'
                     , *
                from #Fileslist as f;
            end;

            select @count = count(*)
            from #Fileslist as f
            where f.Invoice_Objid is not null;

            set @Msg = N' Matched files in Staging ' + cast(@count as varchar(10));
            set @DebugText = @Msg;
            set @DebugText = @DefaultDebugText + @DebugText;

            if @Debug > 0
            begin
                raiserror(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
            end;

            end; -- add new objects

            set @count = 0;

            declare @SQLid int;
            declare @Invoice_Objid int;
            declare @FileName nvarchar(100);
            declare @FileLocation nvarchar(258);

            set @MFTableName = N'MFVendorInvoice';
            set @ProcedureStep = N' File for import';

            select @Invoice_Objid = min(f.Invoice_Objid)
            from #Fileslist as f
            where f.staging_location is not null
                  and f.filename is not null
                  and f.id is not null;

            -------------------------------------------------------------
            -- loop for adding files
            -------------------------------------------------------------

            while @Invoice_Objid is not null
            begin
                select @SQLid        = f.id
                     , @FileName     = f.filename
                     , @FileLocation = f.staging_location
                from #Fileslist as f
                where f.Invoice_Objid = @Invoice_Objid;

                set @Msg
                    = N' File: SQLid  ' + cast(@SQLid as varchar(10)) + N' filename ' + @FileName + N' file location '
                      + @FileLocation;
                set @DebugText = @Msg;
                set @DebugText = @DefaultDebugText + @DebugText;

                if @Debug > 0
                begin
                    raiserror(@DebugText, 10, 1, @ProcedureName, @ProcedureStep);
                end;


                set @ProcedureStep = N'Get file ';
                set @LogTypeDetail = N'Status';
                set @LogStatusDetail = N'Importing';
                set @LogTextDetail
                    = N' SQLid ' + cast(@SQLid as varchar(10)) + N' Filename ' + isnull(@FileName, 'No File') + N'; '
                      + isnull(@FileLocation, 'No location');
                set @LogColumnName = N'id ';
                set @LogColumnValue = cast(@SQLid as varchar(10));

                execute @return_value = dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID
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
                                                                        , @debug = @Debug;

                set @MFTableName = N'MFVendorInvoice';

                exec dbo.spMFUpdateExplorerFileToMFiles @FileName = @FileName
                                                      , @FileLocation = @FileLocation
                                                      , @MFTableName = @MFTableName
                                                      , @SQLID = @SQLid
                                                      , @ProcessBatch_id = @ProcessBatch_ID
                                                      , @Debug = @debug
                                                      , @IsFileDelete = 1
                                                      ,@ResetToSingleFile = 1;

                set @DebugText = N' Import file id %i name %s location %s ';
                set @DebugText = @DefaultDebugText + @DebugText;


                if @Debug > 0
                begin
                    raiserror(@DebugText, 10, 1, @ProcedureName, @ProcedureStep, @SQLid, @FileName, @FileLocation);
                end;

                select @Invoice_Objid =
                (
                    select min(f.Invoice_Objid)
                    from #Fileslist as f
                    where f.Invoice_Objid > @Invoice_Objid
                          and f.filename is not null
                          and f.id is not null
                );

            end; -- get file loop

            set @LogTypeDetail = N'Status';
            set @LogStatusDetail = N'Debug';
            set @LogTextDetail = @OutPut;
            set @LogColumnName = N'';
            set @LogColumnValue = N'';

            execute @return_value = dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID
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
                                                                    , @debug = @Debug;
       




        select @LogStatus = N'Completed';

        --		  End -- errors found
        select @LogText = @OutPut;

        -------------------------------------------------------------
        --END PROCESS
        -------------------------------------------------------------
        END_RUN:
        set @ProcedureStep = N'End';
        set @LogStatus = N'Completed';

        -------------------------------------------------------------
        -- Log End of Process
        -------------------------------------------------------------   
        exec dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID
                                       , @ProcessType = @ProcessType
                                       , @LogType = N'Info'
                                       , @LogText = @LogText
                                       , @LogStatus = @LogStatus
                                       , @debug = @Debug;

        set @StartTime = getutcdate();

        exec dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID
                                             , @LogType = N'Message'
                                             , @LogText = @ProcessType
                                             , @LogStatus = @LogStatus
                                             , @StartTime = @StartTime
                                             , @MFTableName = @MFTableName
                                             , @Validation_ID = @Validation_ID
                                             , @ColumnName = null
                                             , @ColumnValue = null
                                             , @Update_ID = @Update_ID
                                             , @LogProcedureName = @ProcedureName
                                             , @LogProcedureStep = @ProcedureStep
                                             , @debug = @Debug;

        return 1;
    end try
    begin catch
        set @StartTime = getutcdate();
        set @LogStatus = N'Failed w/SQL Error';
        set @LogTextDetail = error_message();

        --------------------------------------------------
        -- INSERTING ERROR DETAILS INTO LOG TABLE
        --------------------------------------------------
        insert into dbo.MFLog
        (
            SPName
          , ErrorNumber
          , ErrorMessage
          , ErrorProcedure
          , ErrorState
          , ErrorSeverity
          , ErrorLine
          , ProcedureStep
        )
        values
        (@ProcedureName, error_number(), error_message(), error_procedure(), error_state(), error_severity()
       , error_line(), @ProcedureStep);

        set @ProcedureStep = N'Catch Error';

        -------------------------------------------------------------
        -- Log Error
        -------------------------------------------------------------   
        exec dbo.spMFProcessBatch_Upsert @ProcessBatch_ID = @ProcessBatch_ID
                                       , @ProcessType = @ProcessType
                                       , @LogType = N'Error'
                                       , @LogText = @LogTextDetail
                                       , @LogStatus = @LogStatus
                                       , @debug = @Debug;

        set @StartTime = getutcdate();

        exec dbo.spMFProcessBatchDetail_Insert @ProcessBatch_ID = @ProcessBatch_ID
                                             , @LogType = N'Error'
                                             , @LogText = @LogTextDetail
                                             , @LogStatus = @LogStatus
                                             , @StartTime = @StartTime
                                             , @MFTableName = @MFTableName
                                             , @Validation_ID = @Validation_ID
                                             , @ColumnName = null
                                             , @ColumnValue = null
                                             , @Update_ID = @Update_ID
                                             , @LogProcedureName = @ProcedureName
                                             , @LogProcedureStep = @ProcedureStep
                                             , @debug = @Debug;

        return -1;
    end catch;
end;
go