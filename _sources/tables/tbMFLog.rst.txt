
=====
MFLog
=====

Columns
=======

LogID int (primarykey, not null)
  Log id
SPName nvarchar(max)
  Store procedure name
Update\_ID int
  Update_ID from MFUpdateHistory
ExternalID nvarchar(50)
  not used
ErrorNumber int
  SQL Error number
ErrorMessage nvarchar(max)
  SQL Error description
ErrorProcedure nvarchar(max)
  Name of procedure with error
ProcedureStep nvarchar(max)
  Procedure step
ErrorState nvarchar(max)
  SQL Error state
ErrorSeverity int
  SQL Error severity
ErrorLine int
  Procedure line reference
CreateDate datetime
  Date of error

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

