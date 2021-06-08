CLR and internal procedures
===========================



Procedures and functions used by Connector
------------------------------------------

The following list of procedures and functions are used by the Connector
to call the assemblies or called by another procedure. These procedures
are divided into those that is specifically related to the use of the
assemblies, and those that is called by other procedures.

The CLR procedures process the SQL procedure calls into M-Files.  These
procedures do not have any scope for user modifications. Issues with or
suggestions for improvement can be raised with MFSQL Connector Support.

.. container:: table-responsive

   .. container:: table-wrap

      =========================================== =========================================================================
      Procedure/Function                          General use
      =========================================== =========================================================================
      spMFGetClass                                CLR Procedure used to get class details from M-Files
      spMFGetLoginAccounts                        CLR Procedure used to get login accounts from M-Files
      spMFGetObjectType                           CLR Procedure used to get object types from M-Files
      spMFGetProperty                             CLR Procedure used to get properties from M-Files
      spMFGetUserAccounts                         CLR Procedure used to get user accounts from M-Files
      spMFGetValueList                            CLR Procedure used to get value list from M-Files
      spMFGetWorkFlow                             CLR Procedure used to get workflow from M-Files
      spMFGetWorkFlowState                        CLR Procedure used to get workflow states from M-Files
      spMFInsertClass                             Used to insert class details into MFClass table
      spMFInsertClassProperty                     Used to insert class property details into MFClassProperty table
      spMFInsertLoginAccount                      Used to insert login account details into MFLoginAccount table
      spMFInsertObjectType                        Used to insert object type details into MFObjectType
      spMFInsertProperty                          Used to insert property details into MFProperty table
      spMFInsertUserAccount                       Used to insert Used account details into MFUserAccount table
      spMFInsertValueList                         Used to insert value list details into MFValueList table
      spMFInsertValueListItems                    Used to insert value list items details into MFValueListItems
      spMFInsertWorkflow                          Used to insert work flow details into MFWorkflow table
      spMFInsertWorkflowState                     Used to insert workflow states details into MFWorkflowState table
      spMFSearchForObjectByPropertyValuesInternal CLR Procedure to search for object in M-Files using property id and value
      spMFSearchForObjectInternal                 CLR procedure used to search for objects in M-Files
      spMFSynchronizeClasses                      Used to synchronize MFClass table with M-Files
      spMFSynchronizeLoginAccount                 Used to synchronize MFLoginAccount table with M-Files
      spMFSynchronizeObjectType                   Used to synchronize MFObjectType table with M-Files
      spMFSynchronizeProperties                   Used to synchronize MFProperty table with M-Files
      spMFSynchronizeValueList                    Used to synchronize MFValueList table with M-Files
      spMFSynchronizeUserAccount                  Used to synchronize MFUserAccount table with M-Files
      spMFSynchronizeValueListItems               Used to synchronize MFValueListItems table with M-Files
      spMFSynchronizeWorkflow                     Used to synchronize MFWorkflow table with M-Files
      spMFSynchronizeWorkflowsStates              Used to synchronize MFWorkflowState table with M-Files
      spMFUpdateTableInternal                     Used to insert/update object details in MF Class table
      spMFUpdateClass                             Used to update class metadata table
      spMFLogError_EMail                          Used to send exception details as email
      fnMFParseDelimitedString                    Used to convert the comma separated key value pair into table data
      fnMFSplitString                             Used to convert comma separated value into table data
      fnMFCapitalizeFirstLetter                   Used to capitalize first letter of each work and concatenate
      fnMFReplaceSpecialCharacter                 Used to remove special characters from string
      tMFOnError_SendEmail                        Used to send email if any error inserted into MFLog table
      spMFCreateClassTableSynchronizeTrigger      Used to create the ClassTable syncronisation trigger
      spMFGetObjVers                              Used to call the CLR procedure smMFGetObjVersInternal
      spMFGetMissingObjectIds                     Get objids of missing objects
      spMFGetObjectVersInternal                   CLR Procedure to get Object Versions of a Class
      cardconf.InitializeRules                    create rules for card configuration routines
      cardconf.spMFCardPropertiesJson             Produce JSON for properties
      cardconf.spMFCardPropertiesUpsert           Update card configuration properties
      cardconf.spMFMetadatacardJson               Produce metadata card JSON
      spMFGetContextMenu                          Vault Application access to context menu
      spMFGetMFilesAssemblyVersion                Get M-Files Version for Assembly
      spMFGetMFilesLatestVersion                  Get Latest M-Files Version
      spMFGetMFilesLogInternal                    Get XML for event logs
      spMFInsertUserMessage                       Auto insert user message in user Message table
      spMFLogProcessSummaryForClassTable          Produce process summary for table
      script.CreateDeleteHistoryJob               Installation script to create agent for deleting log records
      spMFGetContextMenu                          Vault application get context menu
      spMFGetAction                               Vault application get context menu action
      spMFGetProcessStatus                        Vault application get process status
      spMFTableControlLog                         Update control log
      spMFGetFilesInternal                        Export files from M-Files
      spMFUpdateLastExcecutedB                     Update MFContextMenu table
       spMFUpdateCurrentUserIDForAction            Update MFContextMenu table
       spMfGetProcessStatus                        Get process status
       spMFGetContextMenuID                        Get Context Menu ID
      =========================================== =========================================================================
