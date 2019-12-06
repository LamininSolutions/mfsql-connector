

Version Control
===============

Published
---------

Published version: 4.4.14.55 2019-12-07

================= ========== ==========
Component         Version    Date
================= ========== ==========
SQL scripts       4.4.14.55  2019-12-07
Assemblies        4.4.14.0   2019-09-27
Vault application 4.4.0.0    2019-06-15
UIX application   4.4.0.0    2019-06-15
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

Change control summary (from version 4.3.8.48)
----------------------------------------------

Each procedure, table or function contains there own change control section. See each object for more detail

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





















