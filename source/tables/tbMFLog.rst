
=====
MFLog
=====

Columns
=======

LogID int (primarykey, not null)
  fixme description
SPName nvarchar(max)
  fixme description
Update\_ID int
  fixme description
ExternalID nvarchar(50)
  fixme description
ErrorNumber int
  fixme description
ErrorMessage nvarchar(max)
  fixme description
ErrorProcedure nvarchar(max)
  fixme description
ProcedureStep nvarchar(max)
  fixme description
ErrorState nvarchar(max)
  fixme description
ErrorSeverity int
  fixme description
ErrorLine int
  fixme description
CreateDate datetime
  fixme description

Indexes
=======

idx\_MFLog\_id
  - LogID

Used By
=======

- MFvwLogTableStats
- spMFAddCommentForObjects
- spMFAliasesUpsert
- spMFChangeClass
- spMFCheckAndUpdateAssemblyVersion
- spMFCreateAllLookups
- spMFCreatePublicSharedLink
- spMFCreateTable
- spMFCreateValueListLookupView
- spMFCreateWorkflowStateLookupView
- spMFDeleteAdhocProperty
- spMFDeleteHistory
- spMFDeleteObjectList
- spMFDeploymentDetails
- spMFDropAndUpdateMetadata
- spMFExportFiles
- spMFGetDeletedObjects
- spMFGetHistory
- spMFGetMetadataStructureVersionID
- spMFGetMfilesLog
- spMFGetObjectvers
- spMFInsertClass
- spMFInsertClassProperty
- spMFInsertLoginAccount
- spMFInsertObjectType
- spMFInsertProperty
- spMFInsertUserAccount
- spMFInsertUserMessage
- spMFInsertValueList
- spMFInsertValueListItems
- spMFInsertWorkflow
- spMFInsertWorkflowState
- spMFLogError\_EMail
- spMFLogProcessSummaryForClassTable
- spMFProcessBatch\_EMail
- spMFProcessBatchDetail\_Insert
- spMFSearchForObject
- spMFSearchForObjectbyPropertyValues
- spMFSynchronizeClasses
- spMFSynchronizeFilesToMFiles
- spmfSynchronizeLookupColumnChange
- spMFSynchronizeMetadata
- spMFSynchronizeProperties
- spMFSynchronizeSpecificMetadata
- spMFSynchronizeUnManagedObject
- spMFSynchronizeValueListItemsToMFiles
- spmfSynchronizeWorkFlowSateColumnChange
- spMFSynchronizeWorkflowsStates
- spMFTableAudit
- spMFUpdateAllncludedInAppTables
- spMFUpdateClassAndProperties
- spMFUpdateItemByItem
- spMFUpdateMFilesToMFSQL
- spMFUpdateTable
- spMFUpdateTableinBatches
- spMFUpdateTableInternal


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

