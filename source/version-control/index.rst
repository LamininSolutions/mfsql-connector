

Version Control
===============

Published
---------

Published version: 4.10.32.76 2023-06-30

================= ========== ==========
Component         Version    Date
================= ========== ==========
SQL scripts       4.10.32.76  2023-06-30 
Assemblies        4.10.32.0   2023-06-30
Vault application 4.10.1.27   2023-06-06
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

4.10.32.76
~~~~~~~~~~

#. This release includes changes to the VAF, Assemblies and Procedures and requires installation on both SQL server and M-Files server
#. The task processing delay in the VAF is reset from the default of 30 seconds to 1 second.
#. Add new functionality in Assembly and procedures to get users in usergroups. New CLR procedure spMFGetUserAccounts and new procedure spMFUsersbyUserGroup is added.
#. The search by date filter in the following procedures is explicitly set to use UTC date to bring it in line with the date format of the created, last modified and deleted dates in class table. This is an assembly change.  spMFAuditTable is also updated to respond to the change.
#. spMFGetContextMenu is updated to correctly pick up action 4 and 5 for processing in the new VAF.  The ParentID of these actions must always be null.
#. Bug fixing of divided by null in spMFGetProcedurePerformance
#. spMFUpdateExplorerFileToMFiles is updated to allow an option to set object to set object to single file and to improve logic for validation
#. spMFClassTableColumns is update to resolve bug with creating new columns with wrong datatype
#. spMFDeploymentDetails improve logging 
#. spMFGetMFilesAssemblyVersion fix return value to show correct version of M-Files
#. spMFCheckAndUpdateAssemblyVersion Fix bug with assembly version and add additional logging to track process results
#. fnMFGetCulture  Expand function to deal with USA anomolies
#. spMFInsertClassProperty Enforce adding name_or_title to class, even if not required
#. spMFInsertUserAccounts Add vault roles
#. spMFUpdateTableInternal Resolve bug for converting datetime incorrectly when new record is added
#. spMFCreateTable Resolve bug for excluding some columns on create ; Improve handling of lookup columns to handle duplicate property names
#. spMFDropAndUpdateMetadata Improve with column reset functionality
#. spMFUpdateTable Allow to change or select the last modified user ; Fix bug when updating table for missing object in class table; Replacing get user id to using user account instead of login account ; Rework filter processing to improve throughput and reduce locks; Change create and modified date when new to UTC instead of local time
#. spMFTableAudit Allowing for specifying UTC date in filters

4.10.31.75
~~~~~~~~~~

#. fnMFReplaceSpecialCharacter - add pipe sign to the character exclusions
#. spMFInsertProperty - prevent the loss of custom settings when duplicate property names are detected. Properties will not synchronize without fixing duplicate names in properties in M-Files.
#. spMFUpdateTableInternal - Resolve bug for converting datetime incorrectly when new record is added
#. spMFUpdateTable Rework filter processing to improve throughput and reduce locks
#. spMFUpdateTable Change create and modified date when new to UTC instead of local time
#. MFFileExportControl - new table for File Export Control
#. spMFExportFilesMultiClasses - new functionality to Export files for multiple classes
#. spMFDeleteObjectList - Set default value for Update_ID parameter
#. spMFObjectTypeUpdateClassIndex - resolve bug for not updating some classes
#. spMFExportFiles - bug to handle pipe sign in multifile document name; reset filesize to bigint
#. spMFUpdateExplorerFileToMFiles - Fix bug setting single file to 1 when count > 1 ; Improve logging messages
#. spMFInsertClassProperty - prevent loosing custom settings when duplicate property is found
#. spMFUpdateObjectChangeHistory - remove unwanted debugging code
#. spMFConvertTableToHtml - change colour of column headings darker
#. spMFUpdateExplorerFileToMFiles - improvements to importing files
#. spMFClassTableColumns - resolve bug for showing errors with duplicate properties
#. spMFDropandUpdateTable - resolve bug with parameter to update class table columns
#. Wrapper Assembly changes to improve file import handling

4.10.30.74
~~~~~~~~~~

This is a major new release with significant changes related to the vault application in response to M-Files moving to New Cloud.
It has material implications for users of the Context Menu functionality. Consult :doc:`/blogs/update-to-VAF-4-10/index`

#. Change of name of the procedure spMfGetSettingsForCofigurator to spMfGetSettingsForConfigurator
#. The assemblies were updated to change the approach the license expiry date to avoid localisation issues.
#. The VAF was fundamentally redesigned to cater for multi server mode, process actions as tasks and allow for full logging. The core functionality remained the same.
#. The MFSQLConnectorWebAPI is changed to respond to the changes in the new VAF.
#. Fix bug in spMFsendHTMLBodyEmail
#. Add new procedure spMFUndeleteObject to allow for undeleting of objects from SQL. This involve assembly changes
#. Increase parameter text size to allow for more feedback from the VAF in the procedure spMFValidateModule. The additional feedback will only come into effect with the VAF changes in the next version
#. Table MFContextMenuQueue is expanded to include additional logging information. These changes will only come into effect after the logging methods have been deployed.
#. spMFSetContextMenuQueue is being revised to respond to new logging methods in VAF. This is work in progress.
#. spMFUpdateTableInternal is changed with isolation levels and no lock to avoid locking
#. spMFUpdatetable is changed by adding protection against locking when updating class table
#. spMFUpdatetable is changed to fix bug with not updating MFAuditHistory
#. spMFSetup_Reporting added additional automated functionality, including automatically updating the created table and showing the classtablestats
#. spMFDeleteObject, spMFUndeleteObject and spMFDeleteObjectList are improved to return more detailed error messages
#. spMFInserUserMessage documentation is updated
#. spMFObjectTypeUpdateClassIndex added logging, remove resetting the MFClass, add error handling
#. spMFUpdateMFilesToMFSQL resolve bug with NextBatch_ID
#. MFvwUserGroup is revised to align with localisation.
#. Excel based temples in the add-ons is retired and removed as the template is no longer valid for latest releases of excel.
#. Several example scripts are updated, or retired as example scripts are being moved into the doc.lamininsolutions documentation
#. spMFUpdateAllncludedInAppTables documentation is updated to respond to the new parameters added for the procedure
#. Resolve bug with updating MFAuditHistory in the procedure spMFTableAudit and improve logging
#. Advanced installer is updated to allow for gRPC to be selected as a protocol
#. MFProtocolType table is updated to include gRPC
#. spMFUpdateTableInternal is update to fix a conflict of a property with a name 'value' in the Pivot.
#. spMFUpdateTable is update to resolve a bug with data definition in large text properties
#. spMFsetup_Reporting is modified to change the approach to only update selected tables
#. spMFClassTableStats is updated to resolve an error with the count of objects when sending a report, and to prevent sending a blank page.
#. spMFResultMessageForUI fixing bug with duration being null
#. spMFUpdateAllncludedInAppTables is updated to resolve a loop bug with updating history
#. spMFUpdateMFilesToMFSQL resolve issue of removal of class table objects
#. Update all example scripts for using the context menu to include ProcessBatch_ID and other changes
#. Update the Web API to respond to the newly designed VAF.
#. New functionality was added to allow for parameterised processing of additional properties. This has affected a range of procedures.  Refer to the guide for more details
#. Add VaultRoles to MFUserAccount dataset
#. Add ServerRoles to MFLoginAccount dataset
#. Upgrade spMFCheckAndUpdateAssemblyVersion to include updating when assemblies failed to load.
#. Add debugging to spMFUpdateAssemblies
#. Improvements with XML handling in the wrapper
#. Fix bug with localisation of Spanish and German handling of decimals
#. Fix bug for getting M-Files version for M-Files releases after 22.9 in spMFCheckAndUpdateAssemblyVersion

4.9.29.73
~~~~~~~~~

#. Change of login method to use guid instead of name of vault. This change affected a) the VAF, the assemblies, and spMFVaultConnectionTest, fnMFVaultSettings and spMFGetMetadataStructureID
#. Change spmfConnectionTest to test connection to M-Files Server without logging into vault. This method is mainly used to detect early of M-Files server is no longer available for long running processes
#. Improve performance in spMFAuditTable, spMFUpdateTable, spMFUpdateMFilesToMFSQL, spMFUpdateAllncludedInAppTables
#. Improve logging and the use of MFProcessBatchDetail to review processing.
#. Add Guid to fnMFVaultSettings to allow for login with Guid
#. Update spMFUpdateTable to allow for updating of collections in a class.
#. Automatically add guid in MFSettings to allow for logging in with Guid
#. Set default of updating tables in spMFUpdateObjectChangeHistory to 0 to prevent updating tables unnecessary
#. Remove redundant checking of vault connection in spMFGetLicense
#. Elliminate use of spMFGetObjectVers in spMFAuditTable to improve performance
#. Fix bug in spMFCheckandUpdateAssemblyVersion
#. Pair connectiontest and CLR procedures to elliminate unecessary use of checking a connection.
#. Maintain same ProcessBatch_ID throughout in spMFUpdateAllIncludeInAppTables to allow for performance monitoring of the entire process
#. Fix bug where some records did not update in spMFUpdateMFilesToMFSQL
#. Entend the output of spMFUpdateHistoryShow to include change of object versions and audit History
#. Improve and extend spMFGetProcedurePerformance
#. Fix bug to no longer drop agents already created.
#. Add CLRModule column in MFSQLObjectsControl to improve visibility of CLR methods
#. Add additional processes in the MFProcess table
#. Add MFAssemblylog table to support Assembly logging (for future release deployment)
#. Add MFObjidlist table to improve performance of updates
#. Fix bug in spMFGetMissingObjids to support deletions
#. Add assembly logging to app detail logging in spMFInsertClass, spMFCreateTable, spMFProcessBatchUpsert and spMFProcessBatchDetail_insert
#. Updates to spMFUpdateTable include
   - Optimize preparing properties for update and replace UNPIVOT with new case method
   - Allow null to be passed in for properties
   - Remove table scan when updatemethod 0 is used
   - Resolve bug related to audit table deletions removal
#. Resolve bug on valuelists in spMFSetup_Reporting
#. Resolve issues and add logging in spMFDeleteObject
#. Add logging in spMFDeleteObjectList
#. Add new procedure for undeleting objects as spMFUndeleteObject
#. Increase size of email parameters to align with mailer in spMFClassTableStats
#. Add parameter to extend the flexibility of spMFUpdateAllncludedInAppTables to include other options in IncludeInApp column
#. Improve logging for spMFUpdateAllncludedInAppTables
#. Updates to spMFAuditTable to set objids datatype to max and to deal with class changes

4.9.27.72
~~~~~~~~~

Take note:
After installation of the package, restart the vault.

#. Update spMFAuditTable and spMFUpdateMFilesToMFSQL to re-evaluate deleted objects when incremental update is performed.
#. Remove deletion of MFAuditHistory on full update.
#. Change default for objectVersion to -1 in spMFDeleteObject
#. Change script for adding Delete History Agent to only create agent if not exist
#. Fix bug with spMFCheckAndUpdateAssemblyVersion
#. Remove duplicate indexes on tables MFLog, MFUpdateHistory
#. Update additional elements of Advanced Installer Package to improve control, resolve issues in use of powershell, allow TLS1.2 and cloud installation.
#. Fix bugs in spMFClassTableColumns for missing table not identying if table deleted and bug on multilookup data type change error
#. Remove bug of showing query with debug = 0 in spMFClassTableStats
#. The procedures spMFUpdateObjectChangeHistory and smMFGetHistory are fundamentally recoded to change the approach to improve performance
#. Update documentation in spMFDropandUpdateTable, spMFLogError_Email, spMFUpdateMfilesToMFSQL
#. Set maximum rows in MFvwClassTableColumns to 10000
#. Update spMFDeploymentDetails and spMFUpdateAssemblies to improve entries in the MFDeploymentDetail table
#. Fix update references in MFProcess table to map to descriptions
#. Update logging in spMFTableAudit to track performance
#. Fix spMFUpdateHistoryShow to aid performance tracking
#. Add new special procedure to aid performance tracking of a procedurebatch spMFGetProcedurePerformance
#. Align on premise VAF with cloud VAF with updates to image references

4.9.27.71
~~~~~~~~~

#. The installation package is significantly upgraded to include validations, improved UI and some bug fixing
#. Add parameter to spMFUpdateItembyItem to deleted objects
#. Add new column for valuelist_Class_ID in vwMFMetadataStructure
#. Resolve incorrect value in column SQLnotinMF in spmfClassTableStats
#. Add in spMFUpdateMfilesToMFSQL with full update: remove objects in class table not in audit table
#. Add parameter for RetainDeletions in spMFUpdateAllncludedInAppTables
#. Add output to parameter ProcessBatch_ID in spMFUpdateTableInBatches
#. Resolve bug with null count in spMFResultMessageForUI
#. Remove deletion of MFAuditHistory from spMFDeleteHistory
#. Remove incorrect license check in spmfDeleteObject
#. Improve spMFDeploymentDetails to record failed deployment
#. Renew Advanced installer - the installation package. UI improvements, installation validations, https installation bug fix, powershell setup recovery added to the installer
#. Update Advanced Installer SQL connection to be TLS 1.2 compliant. Update components to .Net framework 4.6.1
#. Update .Net Framework for MFSQLConnectorVaultApp VAF to 4.6.1
#. Update .Net Framework for MFSQLDBFileConnector VAF to 4.6.1

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

4.2.1.2 Database File
~~~~~~~~~~~~~~~~~~~~~

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
