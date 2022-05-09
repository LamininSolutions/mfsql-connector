Upgrading to VAF 10.4
=====================

M-Files requires all Vault Applications operating on the M-Files cloud to be Multi-Server-Mode (MSM) compatible. The upgrade of the MFSQL Connector VAF to the latest release of the Vault Application Framework includes a number of improvements and changes to the VAF.

This section have important information for the upgrade in your environment.  Not following these steps will cause errors. These steps must be followed when M<FSQL Connector is upgraded to version 4.10.29.74. This upgrade include upgrades to the MFSQL Connector modules:
 . MFSQLConnectorVAFApp
 . MFSQL Connector Web Services plugin
 . MFSQL Connector Assemblies
 . MFSQL Connector procedures

 and requires changes to any custom procedures that is called via the ContextMenu functionality.

VAF 10.4 and later has the following changes:
 .  Upgrade to version 2.3 of the VAF
 .  Upgrade of the VAF to be multi server mode compatible
 .  Deployment of VAF Tasks to process the context menu actions
 .  New logging method to record the logging of ContextMenu operations in the SQL logging tables.
 .  New logging method to record other ContextMenu operations of the MFSQLConnectorVAFApp
 .  Changes to the VAF Dashboard and configuration options

Changes in task handling
------------------------
The operations of the MFSQL Connector Context Menu was overhauled to align with task management introduced in VAF 22.4.21.  This allows for the operations to run asynchronously in the background in a multiserver mode. It is no longer necessary to manage the processing queue in the connector to monitor the completion of high frequency processing of tasks from M-Files to SQL.

Changes in SQL procedures
---------------------------

 .  The changes requires the installation of the deployment package on the SQL server BEFORE running the installation on the M-Files Server if SQL and M-Files is not on the same server.

 . The store procedure spMfGetSettingsForConfigurator has a name change.  The previous name was spMfGetSettingsForCofigurator.  This name change is automatically included in the upgrade and there is no need for any user action.

 . Custom procedures called from the context menu need to comply with the requirements setout below. This may require the resequencing of the parameters of the procedure.

Changes to the MFSQL Connector menu
-----------------------------------

There are no changes to the visual layout of the MFSQL Connector menu

Logging
-------

VAF 10 and later includes additional logging functionality, based on VAF 22.4.21, for:
 . Logging ContextMenu operations
 . Logging VAF operations

Logging ContextMenu operations
-------------------------------

The standard MFSQL Connector logging functionality is accessed by the VAF to log entries in the MFProcessBatch and MFProcessBatchDetail tables.

  . On the start of the action in M-Files (before the call reaches SQL) the VAF will get a new ProcessBatch_ID and record the entry in MFProcessBatch
  . When the task is scheduled in M-Files an entry is processed in the MFProcessBatchDetail table.
  . When the task is ready to calls the SQL Procedure as specified in the MFContextMenu another entry is made in MFProcessBatchDetail. This logs the start time of executing the operation.
  . When the operation is called it passed through the ProcessBatch_ID to the custom SQL Procedure.
  . Further logging in the custom procedure can then be used to record any detail logs for the procedure.

Required changes to procedures called via MFContextMenu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The changes in the logging functionality requires the parameters for procedures that is called by the context menu functionality to have very specific parameters in the correct sequence.  This may impact your current custom procedures and requires to check and ensure that these custom procedures complies with the following.

For procedures that is called using an action type 1 or 4 (menu action and event action that is NOT object context sensitive)

The parameters for the custom procedure must have the following parameters as the first three parameters in sequence:

    - @ID int not null
    - @Output nvarchar(1000) output
    - @ProcessBatch_ID int = null output

For procedures that is called using and action type 3 or 5 (menu action and event action that IS object context sensitive)
The parameters for the custom procedure must have the following parameters as the first seven parameters in sequence:

    - @ID int not null
    - @Output nvarchar(1000) output
    - @ProcessBatch_ID int = null output
    - @ObjectID INT = null
    - @ObjectType INT = null
    - @ObjectVer INT = null
    - @ClassID int = null

Optional changes to procedures called via MFContextMenu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Logging in the MFProcessBatch and MFProcessBatchDetail tables is automatic for all major standard procedures of the Connector.  However, logging can also be used in custom procedures to record the different stages of processing in the procedure and improve debugging. See :doc:`/mfsql-integration-connector/using-and-managing-logs/index`
