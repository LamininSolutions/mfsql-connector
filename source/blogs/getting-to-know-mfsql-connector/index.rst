Getting to know MFSQL Connector
===============================

MFSQL Connector is installed, so now what?

Getting started could be overwhelming with the Connector’s wide range of
capabilities and uses. This blog will guide you through the resources
for specific use cases to get started. When you mastered the basics, you
will discover more of the many capabilities that is installed with the
product.

However, it is likely that you are using the Connector to solve a
specific use case or problem. This guide aims at helping you on the way
to know what you need to know.

Resources
---------

The Connector includes a range of resources to fully use the all the
capabilities and features.

**Prerequisites:** It presumes a basic understanding of SQL. MFSQL
Connector enables a developer to use SQL to interact with M-Files. To
improve your SQL skills you could resort to
`Udemy.com <http://Udemy.com>`__ or many other training resources for
basic and advanced SQL training. Google search for any SQL task is a
good way to learn.

**This guide**: The MFSQL Connector guide is a rich source with information about the Connector and is constantly updated. Use the search to lookup any procedure or table or keyword, or follow the pages which is organised in a logical structure to guide you through specific focus areas. The guide includes technical documentation; general guidelines and a series of blogs or practical guides on different topics.

Your feedback on the guide will be appreciated.

**The blogs:** The guide includes a series of blogs prepared over time to highlight different aspects of the use of MFSQL Connector
Contact us if you would like to have a blog about a specific topic.

**The examples:** Examples of usage of the procedures and capabilities
can be found in this guide and in a series of SQL scripts. These scripts
are located in the installation folder for the package in the examples
scripts folder: C:\\Program Files (x86)\\Laminin Solutions\\MFSQL
Connector Release 4\\yourDatabaseName\\Example Scripts. A good way to
navigate through these is to access them directly from SSMS (Open file
in SSMS) and to use the search on keywords or a procedure name to get
scripts that relates to the keyword or procedure.

To search on the title of the examples: type the keyword in the search
in explorer

|image0|

To search the content of the files: type the prefix 'contents: ' and
then the keyword in the search in explorer

|image1|

**Videos:** There is a growing number of training and overview videos in
our youtube channel

https://www.youtube.com/user/lamininsolutions/videos

Topics procedures and related examples to get started
-----------------------------------------------------

 - **check connection** : spMFVaultConnectionTest : *01.100.Getting Started*
 - **Update metadata structure** : spMFSynchronizeMetadata, spMFDropAndUpdateMetadata : *01.100.Getting Started, 01.102.QuickStartup for multiple class tables, 01.105.MetadataStructureChanges*
 - **check settings** : MFvwVaultSettings, MFSettings, MFVaultSettings : *01.100.Getting Started, 01.101.Updating settings*
 - **Get error** : MFLog : *01.100.Getting Started*
 - **Review metadata structure** : MFvwMetadataStructure, MFclass, MFLoginAccount, MFUserAccount : *01.100.Getting Started*

Topics procedures and related examples for reporting and data exchange
----------------------------------------------------------------------

 - **Setup reporting** : MFClass, spMFCreateTable, spMFUpdateTable, spMFCreateAllMFTables, spMFUpdateAllncludedInAppTables, spMFUpdateTableinBatches, spMFClassTableStats, DoUpdateReportingData : *20.102.Setup Reporting, 08.101.Getting ready for reporting*
 - **Create class table** : spMFCreateTable : *01.100.Getting Started, 01.102.QuickStartup for multiple class tables*
 - **Get data from M-Files** : spMFUpdateTable, spMFUpdateTableWithLastModifiedDate, spMFUpdateMFilesToMFSQL,spMFUpdateAllncludedInAppTables, spMFUpdateTableinBatches : *01.100.Getting Started, 01.102.QuickStartup for multiple class tables, 02.115.using updatetable filters - Objid, 02.120.using updatetable filter - last modified date, 03.153.Comparing procedures for large volume updating*
 - **Working with multi lookup columns** : fnMFParseDelimitedString, fnMFMultiLookupUpsert : *16.101.Using functions in custom procs*
 - **Get hyperlink to object** : fnMFObjectHyperlink : *16.102.using object hyperlink*
 - **Get event log** : spMFGetMfilesLog, MFEventLog\_OpenXML, MFilesEvents : *17.101.Export and use M-Files event log*
 - **Get Comments, Get object change history, Get State change history** : spMFGetHistory, MFObjectChangeHistory : *04.155.Get Object History records, 04.170.Get Comments using Change History, 04.171.Get Workflow state changes using Change History, 04.172.Get all changes for object with Change History*
 - **Get class table stats** : spMFClassTableStats : *01.103.InitialiseApp*
 - **Setup context menu** : MFContextMenu, spMFContextMenuHeadingItem, spMFContextMenuActionItem : *01.103.InitialiseApp, 07.101.Updating the ContextMenu*

Topics procedures and related examples for integration and data management
--------------------------------------------------------------------------

 - **Adding / updating records from SQL to M-Files** : spMFUpdateTable : *01.120.Inserting new objects using batch mode, 03.115.Inserting new objects using lookup views*
 - **Updating large volume from SQL to M-Files** : spMFUpdateMFilesToMFSQL, spMFUpdateTableinBatches : *03.150 Update large volume from SQL to MF, 03.151.using spmfupdatetableInbatches for batch updates, 03.153.Comparing procedures for large volume updating*
 - **Get object history for large volumes** : spMFGetHistory, MFObjectChangeHistory : *04.175.Getting History in high volume situations*
 - **Updating multi lookup columns** : fnMFMultiLookupUpsert : *03.155.Using multilookup upsert*
 - **Get Object Versions** : spMFTableAudit, MFAuditHistory, spMFGetObjectvers : *03.152. using spMFTableAuditInBatches to get objversions in batches, 03.153.Comparing procedures for large volume updating*
 - **Setup and using auto correction for sync errors** : MFclass, MFUpdateTable : *15.104.using auto correction of synchronization errors, 15.106.Example of SyncPrecedence 0 (SQL takes precedence), 15.107.Example of SyncPrecedence 1 (MF takes precedence)*
 - **Get Public shared link** : spMFCreatePublicSharedLink, MFPublicLink : *04.150.Create public shared link*
 - **Add comments** : spMFAddCommentForObjects : *04.160.Adding comments to object*
 - **Adding new valuelist item** : spMFSynchronizeSpecificMetadata, spMFSynchronizeValueListItemsToMFiles : *03.120.Insert Records with single lookup columns*
 - **Importing Files, Exporting Files, Importing Blob Files, Send bulk emails with attachments** : spMFExportFiles, MFExportFileHistory, spMFSynchronizeFilesToMFiles, MFFileImport : *06.102.Exporting files from M-Files, 06.104.updating file from explorer into M-Files, 06.103.Uploading Blob Files into M-Files, 15.102.sending bulk emails with attachments*
 - **Deleting objects** : spMFDeleteObjectList : *01.130.Delete object list, 01.131 Example of Deleting duplicate objects in MFiles*
 - **Updating valuelist items** : MFValueListItems, spMFSynchronizeSpecificMetadata, spMFSynchronizeValueListItemsToMFiles : *01.150.Updating ValuelistItems*
 - **Working with workflows** : MFWorkflowState, MFWorkflow, spMFCreateWorkflowStateLookupView, MFvwMetadataStructure, spmfSynchronizeWorkFlowSateColumnChange : *01.200.working with workflows, 01.201.Resetting workflow state names on all class tables*
 - **Using Search** : spMFSearchForObject, spMFSearchForObjectbyPropertyValues : *09.101.using Search object*
 - **Update records based on external users** : spMFUpdateTable : 10.110.using updatetable filters - UserID
 - **Creating lookups** : spMFCreateValueListLookupView, spMFCreateWorkflowStateLookupView : *01.103.InitialiseApp, 01.140.create lookup views*
 - **Updating aliases** : spMFAliasesUpsert : *01.103.InitialiseApp, 01.115.update aliases, 01.116.Bulk Updating of aliases*
 - **Send bulk emails with attachements** : advanced metadata synchronization, spMFSynchronizeSpecificMetadata, spMFDropAndUpdateMetadata, MFvwMetadataStructure : *01.105.MetadataStructureChanges, 01.110.Metadata Update Development - Practical example*
 - **Setup unique indexes** : spMFCreateTable : *01.110.Metadata Update Development - Practical example*
 - **Removing ad hoc columns** : spMFDeleteAdhocProperty : *02.250.Add hoc columns*
 - **Working with agents, Get agent process status, Daily update agent** : *30.101.SQL Agent Job Status view, 30.102.adding daily update agent job, 30.103.adding agent job for use with wait status, 30.104.adding agent job to run wait status*
 - **Working with Context Menu** : custom.DoCMObjectAction, custom.DoCMAction, custom.CMDoObjectActionForWorkflowState, DoCMAsyncAction : *90.101.script.CreateDemoMenuitems, 90.102.custom.DoCMObjectAction, 90.103.custom.DoCMAction, 90.104.custom.CMDoObjectActionForWorkFlowState, 90.105.custom.DoCMAsyncAction*
 - **Sample custom procedures** : *70.100.Example - Sync Procesure, 70.101 Example - Sync Process - Test wLogging, 70.102.Example - Sync Process - Test, 70.103.Example - Sync Process - Check Progress, 70.104.Example - Start Job Wait - Agent,80.100.Template - custom procedure*

Advanced topics procedures and examples
---------------------------------------

 - **Get vault settings** : FnMFVaultSettings : *01.101.Updating settings*
 - **Change Settings** : spMFSettingsForVaultUpdate, spMFSettingsForDBUpdate : *01.101.Updating settings*
 - **Vault settings related tables** : MFVaultSettings, MFProtocolType, MFAuthenticationType : *01.101.Updating settings*
 - **Metadata structure related tables** MFValuelist , MFValuelistItems, MFProperty , MFClassProperty, MFClass, MFWorkflow , MFWorkflowState : *01.100.Getting Started, 01.105.MetadataStructureChanges*
 - **Changing the lookup type** : spMFClassTableColumns : *15.109.Explorer impact of multi lookup property changes*
 - **Split Paired string, Split string, Replace special characters, Capitalize first letter** : fnMFSplit, fnMFSplitPairedStrings, fnMFSplitString, fnMFCapitalizeFirstLetter : *16.101.Using functions in custom procs*
 - **Advanced class table stats** : spMFClassTableStats, ##spMFClassTableStats : *01.105.MetadataStructureChanges*
 - **Class Table column error** : spMFClassTableColumns, ##spMFClassTableColumns : *15.108.Analyse Class table columns*
 - **Update record by record** : spMFUpdateItemByItem : *03.200.using record by record update*
 - **Managing deletions in M-Files** : spMFUpdateTable : *01.131 Example of Deleting duplicate objects in MFiles*
 - **Create all class tables** : spMFCreateAllMFTables : *01.103.InitialiseApp, 01.110.working with ALL metadata update procs*
 - **Drop all class tables** : spMFCreateAllMFTables : *01.103.InitialiseApp, 01.105.MetadataStructureChanges, 01.110.working with ALL metadata update procs*
 - **Update all class tables** : spMFUpdateAllncludedInAppTables : *01.103.InitialiseApp, 01.110.working with ALL metadata update procs*
 - **using custom table and column names** : spMFCreateTable, spMFDropAndUpdateMetadata : *01.105.MetadataStructureChanges*
 - **Create multiple class tables & update tables** : spMFCreateTable, spMFUpdateTable, fnMFParseDelimitedString : *01.102.QuickStartup for multiple class tables*
 - **Tracking processing** : MFUpdateHistory, MFAuditHistory, MFProcessBatchDetail, MFProcessBatch : *02.115.using updatetable filters - Objid, 05.100.understanding updatehistory logging tables*
 - **Processing performance report** : MFProcessBatch, MFProcessBatchDetail : *20.101.Processing PerformanceAnalysis*
 - **Manage logging** : MFUpdateHistory, spMFUpdateHistoryShow, spMFClassTableStats, spMFLogTableStats : *01.132.Deleting objects in M-Files, 02.115.using updatetable filters Objid, 05.100.Delete history logging tables, 15.101.Using user messaging*
 - **Managing logging tables** : spMFDeleteHistory : *05.100.understanding uhistory tables*
 - **Using user messages** : MFUserMessages, MFProcessBatch, spMFInsertUserMessage, spMFProcessBatch\_EMail, spMFResultMessageForUI : *15.101.Using user messaging*

.. |image0| image:: img_1.jpg
.. |image1| image:: img_2.jpg
