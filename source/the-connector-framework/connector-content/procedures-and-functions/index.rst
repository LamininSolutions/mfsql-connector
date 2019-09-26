Procedures and Functions
========================

.. toctree::
   :maxdepth: 4

   spmfcreateobjectinternal/index
   clr-and-internal-procedures/index

The Connector include a number of procedures and functions that is used
and controlled by the Connector. These procedures and functions are part
of the deployment package and will be updated or changed with a new
deployment release. These procedures and functions can be called by
custom procedures and functions.  

The Connector procedures and functions are all prefixed for easy
identification.



Naming Convention prefixes
--------------------------

========= ======
Type      Prefix
========= ======
Procedure spMF
Function  fnMF
Trigger   tMF
========= ======

Custom changes
--------------

Custom changes to Connector procedures and functions will be
overwritten when a new release is published. Use the feedback box
in the Guide or email support for any suggested changes to the
procedures.

Procedures and functions available for custom applications
----------------------------------------------------------

The following is a list of Connector procedures and functions that can
be used in customer applications. These procedures and functions can
either be called in SQL Management Studio (SSMS), or be integrated into
the operational procedures of the custom application. Some of  these
procedures have also been used in the MFSQL Manager.

Functionality is dependent on the installation and licensing of specific
packages according to the product pricing and deployment modules.  Each
installation package will deploy the procedures that applies to the
specific package.  The module column show the related installation
package for the procedures and other objects.

The use of these procedures are covered in more detail in the section on
Using the Connector.

========================================================================================================================================================================================================= ============================================================================================================================== ==============
Procedure/Function                                                                                                                                                                                        General use                                                                                                                    Related module
========================================================================================================================================================================================================= ============================================================================================================================== ==============
spMFCreateTable                                                                                                                                                                                           Used to create MF Class table with associated Properties                                                                       Data exchange
spMFDecrypt                                                                                                                                                                                               CLR procedure used to decrypt the password                                                                                     Data exchange
spMFDeleteAdhocProperty                                                                                                                                                                                   Used to delete adhoc properties associated with an object                                                                      Integration
spMFDeleteObject                                                                                                                                                                                          Used to delete an object from M-Files                                                                                          Integration
spMFDeleteObjectList                                                                                                                                                                                      Used to delete a list of objects from M-Files                                                                                  Integration
spMFGetDataExport                                                                                                                                                                                         Used to export data (only works in collaboration with the M-Files Reporting add on)                                            Data exchange
spMFEncrypt                                                                                                                                                                                               CLR procedure used to encrypt the password                                                                                     Data exchange
`spMFDropAndUpdateMetadata <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/22478891/Synchronize+Methods>`__                                                                               Used to re-synchronize metadata table with a new vault by retaining the user defined columns in MFClass and MFProperty tables. Data exchange
spMFSearchForObject                                                                                                                                                                                       Used to search for an object using the name or title property                                                                  Data exchange
spMFSearchForObjectbyPropertyValues                                                                                                                                                                       Used to search for objects using property id and value                                                                         Integration
spMFTableAudit                                                                                                                                                                                            Use to update audit table history                                                                                              Integration
`spMFSynchronizeSpecificMetadata <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/22478891/Synchronize+Methods>`__                                                                         Used to synchronize a specific metadata table                                                                                  Data exchange
`spMFSynchronizeMetadata <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/22478891/Synchronize+Methods>`__                                                                                 Used to synchronize all metadata table with M-Files                                                                            Data exchange
`spMFUpdateTable <https://lamininsolutions.atlassian.net/wiki/pages/createpage.action?spaceKey=MFSQL&title=Update+Insert+ClassTable+objects&linkCreation=true&fromPageId=21200956>`__                     Used to insert/update objects into M-Files                                                                                     Data exchange
spMFObjectTypeUpdateClassIndex                                                                                                                                                                            User to update a table that index all classes of a specific Object Type                                                        Integration
spMFCreateAllMFTables                                                                                                                                                                                     Use to create all class tables marked with IncludedinApp in MFClass in a single statement                                      Integration
spMFDropAllClassTables                                                                                                                                                                                    Use to drop all the class tables with IncludeInApp a specified flag in MFClass                                                 Integration
`spMFUpdateAllncludedInAppTables <https://lamininsolutions.atlassian.net/wiki/pages/createpage.action?spaceKey=MFSQL&title=Update+Insert+ClassTable+objects&linkCreation=true&fromPageId=21200956>`__     Use to update all the class tables marked with IncludedInApp in MFClass in a single statement                                  Integration
`spMFUpdateTableWithLastModifiedDate <https://lamininsolutions.atlassian.net/wiki/pages/createpage.action?spaceKey=MFSQL&title=Update+Insert+ClassTable+objects&linkCreation=true&fromPageId=21200956>`__ Use to update class table by automatically setting the filter for last modified date                                           Data exchange
spMFUpdateMFilesToMFSQL                                                                                                                                                                                   Use to update records from M-Files to SQL with object audit                                                                    Integration
spMFTestMailProfile                                                                                                                                                                                       Use to send a test error email                                                                                                 Data exchange
spMFValidateEmailProfile                                                                                                                                                                                  Use to validate that the email profile is working                                                                              Data exchange
`spMFUpdateHistoryShow <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/25165829/Show+Update+History+for+Update+ID>`__                                                                     Use to show the detail of a specific column in the Update History Table                                                        Integration
spMFCreateValueListLookupView                                                                                                                                                                             Use to create a valuelist lookup view for a specific Valuelist                                                                 Integration
spMFCreateWorkflowStateLookupView                                                                                                                                                                         Use to create a workflow state lookup view for a specific Workflow                                                             Integration
`spMFClassTableStats <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/22478933/spMFClassTableStats>`__                                                                                     Used to show stats for the ClassTables in the MFSQL Manager                                                                    Integration
`spMFUpdateClassAndProperties <https://lamininsolutions.atlassian.net/wiki/pages/createpage.action?spaceKey=MFSQL&title=Change+of+Class&linkCreation=true&fromPageId=21200956>`__                         Used to update class and properties of an object into M-Files                                                                  Integration
`spMFUpdateItembyItem <https://lamininsolutions.atlassian.net/wiki/pages/createpage.action?spaceKey=MFSQL&title=Update+Insert+ClassTable+objects&linkCreation=true&fromPageId=21200956>`__                procedure that will use objver list of a class to perform a item by item update                                                Integration
spMFProcessBatch_Upsert                                                                                                                                                                                   Used to insert details of a new process or update the results of the process                                                   Data exchange
spMFProcessBatchDetail_Insert                                                                                                                                                                             Used to insert a record for the results of key process steps when a process is executed                                        Data exchange
spMFChangeClass                                                                                                                                                                                           Use to process updates where class changes takes place                                                                         Integration
spMFCheckAndUpdateAssemblyVersion                                                                                                                                                                         Use to check and update Assembly Version                                                                                       Data exchange
spMFCheckMFilesAssemblyVersion                                                                                                                                                                            Use to validate M-Files Assembly Version                                                                                       Data exchange
spMFDeleteHistory                                                                                                                                                                                         Use to delete history records                                                                                                  Integration
spMFGetMfilesLog                                                                                                                                                                                          Use to export M-Files Event log to table                                                                                       Integration
spMFCreatePublicLink                                                                                                                                                                                      Use to create public link for a document                                                                                       Integration
spMFGetDataExport                                                                                                                                                                                         Use to start a M-Files Reporting data export from SQL                                                                          Integration
`spMFResultMessageForUI <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/57774875/spMFResultMessageForUI>`__                                                                               Use to show a result message from the log table                                                                                Integration
spMFLogTableStats                                                                                                                                                                                         Use to produce a report for logging tables                                                                                     Integration
spMFSynchronizeValueListItemsToMfiles                                                                                                                                                                     Use to update valuelist items from SQL to M-Files                                                                              Integration
spMFObjectTypeUpdateClassIndex                                                                                                                                                                            Use to update object type indexes                                                                                              Integration
spMFProcessBatch_EMail                                                                                                                                                                                    Use to produce email message from log table                                                                                    Integration
spMFExportFiles                                                                                                                                                                                           Use to export files from M-Files to SQL                                                                                        Integration
.. rubric:: Views                                                                                                                                                                                                                                                                                                                       
   :name: Bookmark51                                                                                                                                                                                                                                                                                                                    
MFvwVaultSettings                                                                                                                                                                                         Use to view settings for vault                                                                                                 Integration
MFvwAuditSummary                                                                                                                                                                                          Use to view a summary of audit history                                                                                         Integration
MFvwLogTableStats                                                                                                                                                                                         Use to view stats for all the logging tables                                                                                   Integration
MFvwMetadataStructure                                                                                                                                                                                     Use to explore metadata relationships                                                                                          Integration
MFvwUserGroup                                                                                                                                                                                             Use to show ids of user groups                                                                                                 Integration
.. rubric:: Functions                                                                                                                                                                                                                                                                                                                   
   :name: Bookmark52                                                                                                                                                                                                                                                                                                                    
fnMFSplit                                                                                                                                                                                                                                                                                                                               
fnMFSplitString                                                                                                                                                                                           Split string into its elements                                                                                                 Data exchange
fnMFReplaceSpecialCharacter                                                                                                                                                                               Replace special characters                                                                                                     Data exchange
fnMFParseDelimitedString                                                                                                                                                                                  Parse a string with with a predefined delimited                                                                                Data exchange
fnMFObjectHyperlink                                                                                                                                                                                       Output a hyperlink for an object                                                                                               Integration
fnMFCapitalizeFirstLetter                                                                                                                                                                                 Fix capitalization of item                                                                                                     Data exchange
fnMFVaultSettings                                                                                                                                                                                         Returns vault settings                                                                                                         Data exchange
fnVariableTableName                                                                                                                                                                                       Returns unique name of temporary table                                                                                         Data exchange
========================================================================================================================================================================================================= ============================================================================================================================== ==============
