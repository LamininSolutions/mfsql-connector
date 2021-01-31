Building applications around M-Files
====================================

Several procedures, functions and special columns in the metadata tables
are specifically designed for using with building applications.

Procedures applied in building applications in the use cases include:

===================================  =====================================================
Procedure/Function                   Use
===================================  =====================================================
fnObjectHyperlink                    Create hyperlink to object for external application
spMFCreatePublicSharedLink           Create public link on demand
spMFContextMenuActionItem            Create and update records in Context Menu
spMFContextMenuHeadingItem           |_|
spMFDeleteObjectList                 Remove objects from M-Files
spMFCreateValuelistLookupView        Create valuelist and workflow state lookups
spMFCreateAllLookups                 Rapidly create all lookups
spMFCreateWorkflowStateLookupView    |_|
spMFCreateTable                      Create class tables
spMFCreateAllMFTables                Rapidly creation of class tables
spMFDropAllClassTables               Rapidly delete all class tables
spMFSearchForObject                  Rapid search for objects
spMFSearchForObjectsByPropertyValue  Searching for objects within specific properties
spMFSynchronizeMetadata              Synchronize all metadata
spMFSynchronizeSpecificMetadata      Synchronize only specific metadata
spMFDropAndUpdateMetadata            |_|
spMFAliasesUpsert                    Updating aliases
spMFExportFiles                      Export files from M-Files
spMFGetHistory                       Get Object history
spMFGetMFilesLog                     Get MfilesEventLog
spMFupdateTable                      Update M-Files and SQL (Note use of filters)
spMFUpdateAllIncludedInAppTables     Rapid update of all tables included in app
spMFUpdateMfilesToSQL                Batch updates based on objid
spMFUpdateTableWithLastModifiedDate  Update only records since last update
spMFClassTableStats                  Monitor status of class tables
spMFLogTableStats                    Logging and messaging of process flow
spMFLogError\_Email                  |_|
spMFProcessBatch\_Upsert             |_|
spMFProcessBatchDetail\_Insert       |_|
spMFResultMessageforUI               |_|
spMFUpdateHistoryShow                |_|
===================================  =====================================================

Special columns used in the above applications are:

================  ================  ======================================================
Table             Column            Use
================  ================  ======================================================
MFValuelistitems  AppRef            Unique reference to valuelistitem for rapid validation and cross referencing rule conditions
MFClass           IncludeInApp      Set transaction level update; bulk update of all tables
|_|               FileExportFolder  Set the root for export files for the class
|_|               SynchPrecendence  Set Synch precedence for the class
Class Tables      MXuser\_ID        Membership update identification
|_|               Update\_ID        Get updated items after process completed
|_|               FileCount         Determine number of files in object
|_|               Guid              Create hyperlink to object
================  ================  ======================================================

.. |_| unicode:: 0xA0
   :trim:

