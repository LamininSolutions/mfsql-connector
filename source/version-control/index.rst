

Version Control
===============

Published
---------

Published version: 4.8.22.62 2020-08-25

================= ========== ==========
Component         Version    Date
================= ========== ==========
SQL scripts       4.8.22.62  2020-08-23
Assemblies        4.8.22.0   2020-08-23
Vault application 4.8.0.0    2020-07-17
================= ========== ==========

Installed releases
------------------

  - Get the latest release installed in your database : SELECT * FROM dbo.MFDeploymentDetail 
  - Get the latest release installed for a specific object:  SELECT * FROM setup.MFSQLObjectsControl WHERE Name = 'ObjectName'
  - View the Release of the package Installation File:  Right click on installation file / Select Properties / Select Details tab

Release numbering
-----------------

Starting with Rel 4, there is only one installation package and the release number of the main package show changes in different elements

  - The first digit is the main release.  e.g. Release 4 starts with 4.x.x.x
  - The second digit is for M-Files application changes (note that the Apps have their own release number series)
  - The third digit is for Assembly changes (note that the assemblies have their own release number series)
  - The fourth digit is for SQL changes.  This number will run in series for all packages.

Change control summary 
----------------------------------------------

Each procedure, table or function contains there own change control section. See each object for more detail

Version 4.8.21.61 and 4.8.22.62
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#. Significant changes in assemblies and multiple procedures to update MFSQL Connector to allign with Microsoft security advisory: If any of the updates related to the VCE-2020-1147 : .NET Framework, SharePoint Server, and Visual Studio Remote Code Execution Vulnerability advisory have been applied to the SQL Server, your M-Files to SQL updates will stop working until you have upgraded to the new version.
#. Replace Deleted bit column with Property 27 DataTime datatype.  Adjust multiple procedures where this change have an impact
#. Add RetainDeletions option on spMFUpdateMFilesToMFSQL, spmfUpdateAllIncludedInAppTables and spmfUpdateTableInBatches
#. Resolve bug with deleted objects in assembly
#. Remove procedure spMFGetDeletedObjects
#. Replace random default max objid default with getting count of object versions in spMFUpdateMFilesToMFSQL

Version 4.7.19.59 to 4.7.20.60
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#. Update naming of constraints on tables
#. spMFUpdateMFilesToMFSQL - set maximum objids default to 200000
#. spMFDeleteObject - update documentation for object version deletions
#. spMFCreateTable - add index to Update_ID to improve performance
#. spMFUpdateTable - fix bug for setting last modified user
#. spMFUpdateTable - Revome xml_document when transaction failed
#. spMFGetMFilesAssemblyVersion - fix logic and update MFVersion
#. spMFConnectionTest - add new procedure to perform simple vault connection test
#. spMFUpdateAllIncludeInAppTables - add exit if unable to connect to vault
#. spMFUpdateTableInternal - fix bug with localisation error on workflow
#. spMFCheckLicenseStatus - set module to 1 when null or 0
#. spMFImportBlobFilestoMFiles - rewrite import of blob functionality
#. spMFUpdateExplorerFileToMFiles - remove eroneous debugging
#. spMFExportFiles - fix bug with updating file_id into MFExportFileHistory
#. MFilesEvents - fix bug on updating indexes
#. MFvwMetadataStructure - improve view for not showing document objecttype in error
#. MFilesWrapper assembly - improve error messages
#. MFilesWrapper assembly - add new method for vault connection test
#. MFilesWrapper assembly - remove ability to modify last modified date
#. General update of procedure documentation


Versions 4.4.14.56 to 4.7.18.58
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#. spMFUpdateObjectChangeHistory - improve Object change history processing
#. spMFupdateMFilesToMFSQL - bug fixes and improvements
#. spMFUpdateAllIncludeInAppTables - improvements for Object change updates
#. spMFClassTableStats - resolve bug
#. spMFUpdateMFilesToMFSQL - add optional running of spMFUpdateChangeHistory
#. MFSettings - add new setting for indexes
#. spMFCreateTable - add optional create of indexes
#. add indexes to tables, including class tables to improve performance
#. resolve finish localisation bugs
#. spMFSynchronizeFilestoMFiles - improve synchronization of files
#. fnMFExcelObjectHyperlink - add new function for excel based hyperlinks
#. spMFImportBlobFilesToMFiles - improve importing of Blobs, include assembly changes
#. spMFUpdateTable_ObjIDs_GetGroupList - resolve issue with #objidlist not exist
#. spMFSynchronizeProperties - resolve bug with synchronisation
#. spMFUpdateMfilesToMFSQL - Set max objects
#. Reset naming of constraints on standard tables
#. MFSQLConnectorVaultApp - improve high volume context menu action updates
#. MFSQLConnectorVaultApp - add Web Services to as alternative to ODBC connection 
#. MFSQLConnectorVaultApp - improve error reporting
#. Update documentation on various procedures, tables and functions
#. Assemblies - improve error and debug messaging
#. spMFTableAudit - improvements and bug fixes
#. spMFsettingsForDBUpdate - improve messaging

Versions 4.4.13.54, 4.4.14.55
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#. Allow for comments to be included as a column in class table - Assembly change
#. Localisation of date and time for Finish Language
#. Bug fixing for adding comments
#. Update example for working with comments
#. Bug fixing for localisation in spmfTableAudit
#. Bug fixing for spMFGetHistory
#. Improve spmfUpdateAssemblies to allow for different M-Files Versions
#. Bug fix in spmfClassTableColumns to fix multilookup column change errors
#. Bug fix when non standard mail profile is being used
#. Bug fix spMFTableAudit delete of redundant records
#. Add MFUserMessagesEnabled to spMFSettingsForDBUpdate
#. Add MFContextMenuQueue table
#. Add trigger MFContextMenuQueue_UpdateQueue to trigger spMFUpdateContectMenuQueue
#. Add procedure spMFUpdateContectMenuQueue to re-process outstanding context menu items
#. Add logtype *END* to trigger MFProcessBatch_UserMessage to insert messages from spMFUpdateTable
#. Update spMFUpdateTableInternal and spMFUpdateTable to allow for *_id* in as part of the name of a property

Versions 4.4.12.52, 4.4.13.53
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#. Allow *ID* or *space ID* at the end of a property name - previously not allowed
#. Allow specifying MFilesVersion as a parameter in spMFUpdateAssemblies
#. Extend functionality of licence check to include notification on expiry and limit checks to once a day
#. Explicity log out of M-Files on license check and connection test to reduce concurrent sessions
#. Set ContextMenu group as default for permissions in context menu functionality
#. Allow for custom class list when using spMFCreateAllMFTables
#. New function to control Text to Date conversions to allow for Mexico localisation
#. Suppress stats to show detail when using spMFUpdateMFilesToSQL
#. Improve error trapping and logging
#. Remove deleted objects from MFAuditHistory
#. Add functionality to destroy specific version of an object

Version 4.3.9.49 - 4.4.11.51
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#. Add functionality to get all deleted objects in and object type from M-Files
#. Upgrade to latest release of VAF framework
#. Improve large scale updates 
#. Improve automatic updating of MFVersion on upgrading of M-Files
#. Improve error trapping and logging

Version 4.3.8.48
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#. Added new CLR to get details of a specfic unmanaged object
#. Added new procedure to Syncronise unmanaged object
#. Add procedures to validate and update assemblies automatically when MFiles Version changed on the SQL Server
#. Check validity of MFVersion when connection test is performed and auto fix if not valid
#. Add column to table FileObjedID
#. Update procedure to update file object Id
#. update changes to workflow state names to all related class table records
#. Add capability to import files from explorer using SQL procedure
#. Check if valuelist name exists or is duplicate
#. Fix bug for spMFDropandUpdateTable parameter
#. New functionality to be able to update object versions in large tables in batches
#. Add error checking for text columns that have incorrect size in spMFClassTableColumns
#. add validation that tables exists in spMFTableAudit. Add controls for large tables
#. Fix updating of object type if object type is Document Collection in spMFTableAudit
#. Switch to spMFTableAuditInBatches when table size have more 100 000 records in spMFUpdateMFilesToMFSQL
#. Add Import Error column in MFFileImport table
#. Add RealObjectType as a column in MFvwMetadataStructure
#. Add ability to process result in subsequent procedure for spMFSearchObject
#. Include connection string for context menu functionality in named value storage





















