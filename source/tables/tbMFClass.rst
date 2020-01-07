
=======
MFClass
=======

Columns
=======

ID int (primarykey, not null)
  SQL Primary key
MFID int (not null)
  Assigned and maintained by M-Files
Name varchar(100) (not null)
  Class name
Alias nvarchar(100)
  - Alias from MF
  - Can be created in bulk by connector
IncludeInApp smallint
  - 1 = class table created
  - 2 = transactional processing
  - Automatically set on table creation
TableName varchar(100)
  Targeted Table name of class
MFObjectType\_ID int
  ID of the object type in MFObjectType table
MFWorkflow\_ID int
  ID of the workflow in assigned to the class in MFWorkflow table
FileExportFolder nvarchar(500)
  - User assigned
  - Used in the exporting of files from M-Files process
SynchPrecedence int
  - Used to assign presedence
ModifiedOn datetime (not null)
  Date last updated
CreatedOn datetime (not null)
  Date initially created in SQL
Deleted bit (not null)
  - Show deleted classed
  - Deleted classes records is automatically removed at next synchronisation
IsWorkflowEnforced bit
  - Maintained by M-files
  - Controls the rules to force workflow on class table

Additional Info
===============

Update the following columns in the class table for the desired classes:

- IncludedInApp:  Set to 1 for all classes that should be included. Set to 2 if transaction based updates should be triggered.
- TableName: The name in this column will be used as the Table Name for the class.
  The default is set to prefix the class name with 'MF' and remove all special characters.
  This name can be changed and the custom name will be maintained when a metadata synchronization takes place.
- FilePath: The filepath is used to export the files when spMFExportFiles is executed. The default is set to 'C:\MFSQLConnector_Files'.

Indexes
=======

udx\_MFClass\_MFID
  - MFID

Foreign Keys
============

+-------------------------------+-----------------------------------------------------------------------+
| Name                          | Columns                                                               |
+===============================+=======================================================================+
| FK\_MFClass\_MFWorkflow\_ID   | MFWorkflow\_ID->\ `[dbo].[MFWorkflow].[ID] <MFWorkflow.md>`__         |
+-------------------------------+-----------------------------------------------------------------------+
| FK\_MFClass\_ObjectType\_ID   | MFObjectType\_ID->\ `[dbo].[MFObjectType].[ID] <MFObjectType.md>`__   |
+-------------------------------+-----------------------------------------------------------------------+

Uses
====

- MFObjectType
- MFWorkflow

Used By
=======

- MFvwAuditSummary
- MFvwClassTableColumns
- MFvwMetadataStructure
- MFvwObjectTypeSummary
- spMFAddCommentForObjects
- spMFChangeClass
- spMFClassTableColumns
- spMFClassTableStats
- spMFCreateAllLookups
- spMFCreateAllMFTables
- spMFCreatePublicSharedLink
- spMFCreateTable
- spMFDeleteAdhocProperty
- spMFDeleteObjectList
- spMFDropAllClassTables
- spMFDropAndUpdateMetadata
- spMFExportFiles
- spMFGetDeletedObjects
- spMFGetHistory
- spMFGetObjectvers
- spMFInsertClass
- spMFInsertClassProperty
- spMFLogProcessSummaryForClassTable
- spMFObjectTypeUpdateClassIndex
- spMFResultMessageForUI
- spMFSetup\_Reporting
- spMFSynchronizeClasses
- spMFSynchronizeFilesToMFiles
- spmfSynchronizeLookupColumnChange
- spmfSynchronizeWorkFlowSateColumnChange
- spMFTableAudit
- spMFUpdateAllncludedInAppTables
- spMFUpdateClassAndProperties
- spMFUpdateExplorerFileToMFiles
- spMFUpdateHistoryShow
- spMFUpdateItemByItem
- spMFUpdateMFilesToMFSQL
- spMFUpdateSynchronizeError
- spMFUpdateTable
- spMFUpdateTableinBatches
- spMFUpdateTableInternal
- fnMFObjectHyperlink


Examples
========

.. code:: sql

    -- show all tables included in app
    Select * from MFClass where includeInApp = 1

    -- use metadata structure view to explore class relationships with other objects
    SELECT * FROM [dbo].[MFvwMetadataStructure] AS [mfms] WHERE class = 'Customer'

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
2017-07-06  LC         Add column for filepath
2017-08-22  LC         Add column for syncprecedence
==========  =========  ========================================================

