Getting started with a custom application
=========================================

The connector is geared toward making your life as developer easier when
you iterate through the process of configuring M-Files and preparing the
custom procedures for your application.

Best practice is to create a script and add all the execution statements
for the initialization of the application to it. Save the script in a
project folder on your desktop as ‘script.InitializeApp’. Setup the
individual statements in the script to be repeatable.

The following is a list of statements which we often have as part of the
script.InitializeApp.

Script object

Usage

related script example

spMFdropAndUpdateMetadata

Used every after a M-Files configuration change

01.100.Getting Started

01.105.MetadataStructure changes

01.110 Metadata update Development

spMFSynchronizeSpecificMetadata

quick update of specific metadata changes

01.105.MetadataStructure changes

MFvwMetadataStructure

review of MF metadata structure

01.100.Getting Started

spMFcreatetable

spMFCreateAllMFTables

create / recreate all class tables targeted for the application

01.100.GettingStarted

01.102.QuickStartup for multiple class tables

spMFUpdateTable

spMFUpdateAllncludedInAppTables

update class tables after creation

01.100.GettingStarted

01.102.QuickStartup for multiple class tables

01.110 Metadata update Development

spMFDropAllClassTables

Start over

01.110 Work with all metadata procs

spMFAliasesUpsert

setting up all the aliases

01.116 Bulk update of aliases

spMFCreateValueListLookupView

spMFCreateWorkflowStateLookupView

setting up all the lookups

01.140 Creating lookup views

spMFContextMenuHeadingItem

spMFContextMenuActionItem

adding entries to the context menu

07.101 Updating context menu

spMFSettingsForVaultUpdate

spMFSettingsForDBUpdate

Setup custom settings

01.101.Updating settings

spMFClassTableStats

show table stats

01.102.QuickStartup for multiple class tables

MFLog

checking for SQL errors

01.100.Getting Started

See below an example of script to initialize the app. Note that this
script does not include all the variants of selections and options. this
will depend on your specific app.

.. code:: sql



    /*
    Script to initialise MFSQL Connector
    */

    --test connection
    exec spMFVaultConnectionTest

    --first time metadata synchronizaiton
    --exec spMFSynchronizeMetadata

    --Update synchronization

    EXEC [dbo].[spMFDropAndUpdateMetadata] @IsReset = 0

    GO
                                           -- smallint

    EXEC dbo.spMFDropAllClassTables @IncludeInApp = 1, -- int
                                    @Debug = 0         -- smallint
      
    --View structure
    SELECT class,* FROM [dbo].[MFvwMetadataStructure] AS [mfms] WHERE class = 'Tenant'

    --create class tables

    select * from MFClass

    UPDATE MFClass
    SET IncludeInApp = 1
    WHERE Name IN ('Loan','Member Account','Tenant','Account Document', 'Employee','Document Type', 'Scion Template', 'Address')

    Select TableName from MFClass where IncludeInApp = 1

    EXEC spMFCreateAllMFTables 

    --pull from MF for all class tables

    exec spMFUpdateAllncludedInAppTables @UpdateMethod = 1

    --check table stats

    exec spMFClassTableStats

    --

    GO

    --show errors

    SELECT TOP 3 * FROM mflog ORDER BY logid DESC

    --Create lookups

    EXEC [dbo].[spMFCreateValueListLookupView] @ValueListName = 'Country', 
                                               @ViewName = 'MFvwCpountry',      
                                               @Debug = 0          

    EXEC [dbo].[spMFCreateWorkflowStateLookupView] @WorkflowName = 'Approval Flow', 
                                                   @ViewName = 'MFvwApproval_State',     
                                                   @Debug = 0        
     
     --Create aliases

     DECLARE @ProcessBatch_ID INT;
     EXEC [dbo].[spMFAliasesUpsert] @MFTableNames = 'MFClass', -- nvarchar(400)
                                    @Prefix = 'c',       -- nvarchar(10)
                                    @IsRemove = 0,     -- bit
                                    @WithUpdate = 1,   -- bit
                                    @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,            -- int
                                    @Debug = 0         -- smallint

    --Remove aliases 

     EXEC [dbo].[spMFAliasesUpsert] @MFTableNames = 'MFClass', -- nvarchar(400)
                                    @Prefix = 'c',       -- nvarchar(10)
                                    @IsRemove = 1,     -- bit
                                    @WithUpdate = 1,   -- bit
                                    @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,            -- int
                                    @Debug = 0         -- smallint

    --customise settings

    EXEC [dbo].[spMFSettingsForDBUpdate]               
                                         @SupportEmailAccount = 'support@yourdomain.com'      -- nvarchar(128)
                                        

    -- add context menu items

    EXEC [dbo].[spMFContextMenuHeadingItem] @MenuName = 'MyMenu',            -- nvarchar(100)
                                            @PriorMenu = null,           -- nvarchar(100)
                                            @IsObjectContextMenu = 0, -- bit
                                            @IsRemove = 0,            -- bit
                                            @UserGroup = 'All Internal Users',           -- nvarchar(100)
                                            @Debug = 0                -- int

    EXEC [dbo].[spMFContextMenuActionItem] @ActionName = 'MyAction',      -- nvarchar(100)
                                           @ProcedureName = 'custom.doUpdate',   -- nvarchar(100)
                                           @Description = '',     -- nvarchar(200)
                                           @RelatedMenu = 'MyMenu',     -- nvarchar(100)
                                           @IsRemove = 0,        -- bit
                                           @IsObjectContext = 0, -- bit
                                           @IsWeblink = 0,       -- bit
                                           @IsAsynchronous = 0,  -- bit
                                           @IsStateAction = 0,   -- bit
                                           @PriorAction = null,     -- nvarchar(100)
                                           @UserGroup = 'All Internal Users',       -- nvarchar(100)
                                           @Debug = 0            -- int

