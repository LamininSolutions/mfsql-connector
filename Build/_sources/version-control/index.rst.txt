

Version Control
===============

Published
---------

Published version: 4.9.27.70 2021-08-15

================= ========== ==========
Component         Version    Date
================= ========== ==========
SQL scripts       4.9.27.70  2021-08-15
Assemblies        4.9.27.0   2021-04-14
Vault application 4.9.0.0    2021-01-31
Database File VAF 4.2.1.2    2021-07-15
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

4.9.27.71 not yet published
~~~~~~~~~~~~~~~~~~~~~~~~~~~

test

#. Add parameter to spMFUpdateItembyItem to deleted objects

4.9.27.70
~~~~~~~~~

#. Fix logging and updating of class table in spMFDeleteObjectList
#. Remove redundant debugging item from spMFUpdateExplorerFileToMFiles
#. Allow updating of Document Collection object type for class in spMFUpdateTable and spMFUpdateMFilesToMFSQL
#. Fix truncate string bug in
#. Add parameter to suppress the control report in spMFUpdateAllncludedInAppTables
#. Improve debugging and error logging in spMFUpdateMFilesToMFSQL
#. Improve debugging and resolve bug in spMFGetHistory
#. Resolve unwanted output in spMFExportFiles
#. Improve documentation for spMFDropandUpdateTable
#. Change datatype of varchar to nvarchar in table  MFFileImport
#. Improve control when version could not be found in spMFCheckandUpdateAssemblyVersions

Database File MFSQLConnector 4.2.1.2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Add funtionality to promote object and add metadata to a data base file object

4.9.27.69
~~~~~~~~~

#. Fix timestamp updating issue of not showing correct time in spMFUpdateTableInternal, and spMFUpdateTable
#. Redesign batching and grouping in spMFUpdateMFilesToMFSQL. spMFUpdateTable_ObjIds_GetGroupedList become redundant.
#. Fix bug to include first record in each batch in spMFUpdateTableInBatches
#. Fix spMFDeleteObject to delete a single object to include changed Wrapper module
#. Resolve issue with specifying a tablename in spMFClassTableStats
#. Add removal of redundant class records in spMFUpdateMFilesToMFSQL
#. Exclude running full spMFClassTableStats for each batch
#. update MFSQL Database File Connector

4.9.27.68
~~~~~~~~~

#. Remove required workflow check from spMFUpdateTableInternal and deploy the check in spMFClassTableStats
#. Add columns checkedOut, templates, MFNotInSQL, collections, Missingtables, and RequiredWorkflowError in spMFClassTableStats
#. Add error report to email in spMFClassTableStats
#. Fix calculation of deleted records in spMFClassTableStats
#. Remove deletion of audit table from spMFClassTableStats
#. Update MFvwAuditSummary to include collections
#. Update spMFAuditTable to set statusflag for collections
#. Update spMFUpdateAllIncludeInAppTables to include error report with spMFClassTableStats
#. Add detail in table in email messaging in spMFProcessBatch_Email and spMFResultMessageForUI
#. Fix bug in assemblies to return local server MFVersion, ensuring that spMFGetMFilesAssemblyVersion returns to correct value for spMFCheckandUpdateAssemblyVersions
#. Fix bug with spMFCreatePublicSharedLink
#. Fix bug with updating multiple columns with spMFGetHistory
#. Remove object from class table when class is changed to another object in the same object type with spMFUpdateTable
#. Set default schema for MFModule in spMFCheckLicenseStatus
#. Fix objlist error when both class and audit objid is null in spMFUpdateMfilesToMFSQL
#. Include statusflag = 1 into spMFUpdateMFilesToMFSQL with incremental update
#. Resolve issue with duplicate objids for same class in spMFUpdateMFilesToMFSQL - related to collections
#. Fix  spMFUpdateChangeHistory when control table MFObjectChangeHistoryControl is empty when running spMFUpdateMfilesToMFSQL
#. The number of objects in a batch is set to 500 in spMFUpdateTable_ObjIDs_GetGroupList
#. Improve debugging in spMFUpdateObjectChangeHistory
#. Set updateflag to 1 in spMFObjectTypeUpdateClassIndex to support audit history control
#. Remove resetting of audit history in spMFUpdateAllncludedInAppTables
#. Prevent spMFUpdateObjectChangeHistory to run if for a class without entries in control table
#. Set spMFUpdateAssemblies to accept other than sa as the default master owner
#. Fix bug with spMFUpdateItembyItem and improve logic for batch processing
#. Fix bug with installation package resetting MFSettings
#. Add connection test to spMFGetLicense to validate a connection before license check
#. Fix timestamp datatype bug in assemblies,  and spMFUpdateTableInternal

4.8.26.67
~~~~~~~~~

#. Fix datetime bug in spMFUpdateExplorerFileToMFiles when importing files and updating error handling
#. Fix datetime error in the assemblies for importing files using spMFUpdateExplorerFileToMFiles
#. Enhance functionality of spMFClassTableColumns
#. Expand the columns returned in vwMFMetadataStructure
#. Improve error message when license expired using spMFCheckLicenseStatus
#. Enhance functionality of spMFExportFiles to export files in batches. This significantly improves performance.
#. Extent functionality of spMFExportFiles to allow for getting file related metadata without downloading the file.
#. Add additional columns to MFExportFileHistory for file size and file extension
#. Replace spMFGetFilesInternal with spMFGetFilesListInternal. Update assemblies with corresponding code
#. Deploy several new tables and procedures to handle sending bulk emails using email templates. This include MFEmailLog, MFEmailTemplate, spMFsendHTMLBodyEmail, and spMFConvertTabletoHtml .
#. Add 90.107.Custom.DoAccountConfirmationEmail as an example custom procedure for bulk email setup
#. spMFUpdateMFilesToMFSQL Include override to recheck any class objects not in Audit
#. spMFRemoveAdditionalProperties replaces the previous procedure to update ad hoc properties
#. By default add class property 100 in the MFClassProperty Table with spMFInsertClassProperty
#. Set default schema for class tables in spMFCreateTable to dbo
#. Fix bug with checking module 2 license in spMFGetLicense
#. Provide for using different profiles for different email templates, updating spMFValidateEmailProfile
#. Fix bug in spMFUpdateTable on insert new object into audithistory
#. Remove duplicate routine for creating MFUserMessages




4.8.25.66
~~~~~~~~~

#. spMFUpdateTable is extended to include support for changing of a class.  The record will be updated and the new class table will automatically be refreshed for the object.
#. spMFUpdateTableInternal Fix datetime formatting on updating class table
#. spMFCreateTable fix bug on setting of objid value. unique index on non null values only.
#. spMFUpdateTable improve messaging when partial failure of update
#. MFSettings and MFVaultSettings fix incorrect setting of password when installing a new database
#. asseblies was updated for improvements on the status reports when using object delete
#. spMFDeleteObject, spMFDeleteObjectList, spMFDeleteObjectVersionList update to improve status and bug with destroy
#. spMFGetLicense is a new helper procedure for spMFCheckLicenseStatus
#. spMFCheckLicenseStatus updated for efficiency and improved error trapping
#. spMFClassTableStats has new switches to improve usability and efficiency
#. spMFClassTableCoumns has new swithces to improve usability and efficiency
#. Vault application: MFSQLConnectorVaultApp is changed for the Web API connection

4.8.24.65
~~~~~~~~~

#. spMFDeleteObjectList is redesigned to move away from single object deletions to multiple object deletions to improve performance and the number of M-Files logins
#. spMFDeleteObjectVersionList is introduced to allow for bulk deletions of selected object versions
#. Assemblies is updated to include additional methods for deletions in bulk
#. spMFGetHistory and MFObjectChangeHistory is modified to support spmfDeleteObjectVersionList
#. spMFCheckandUpdateAssemblyVersions is improved with more robust error checking
#. spMFGetMFilesAssemblyVersion is improved with additional error management
#. spMFUpdateAssemblies is improved with additional comments when executed manually
#. Updates to the M-Files Web App to implement setting of encryption key for the cloud
#. spMFUpdatetableInternal to set datetime conversion to ANSII (method 102)
#. spMFDropandUpdateTable to fix updating of changes to lookup columns
#. spMFupdatetable to fix bug with localisation of class_id
#. spMFUpdateTable to change column name 'Value' to avoid conflict with a similar property name
#. spMFCheckLicenseStatus to change the datatype of license date to date
#. spMFUpdateTableInBatches to set updatetable objids to include unmatched versions; fix batch size calculation and fix null count for set operation
#. spMFTableAuditInBatches is removed. The functionality is incorporated in spmfTableAudit
#. remove setting objid as a unique index
#. spMFUpdateMfilestoMFSQL to fix bug with update full set
#. spMFclassTableColumns to set single lookup column to error when not int


Version 4.8.21.61 to 4.8.23.64
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
