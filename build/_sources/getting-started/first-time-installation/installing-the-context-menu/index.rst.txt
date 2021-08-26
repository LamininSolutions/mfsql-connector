Installing the Context Menu
===========================

The Context Menu functionality enables actioning a SQL Procedure from
within M-Files:

-  User selected action from a menu
-  User selected context sensitive action from a menu
-  Triggered by a workflow change
-  Triggered by an event handler

The installation and configuration of the context menu changed
from version 4.3.9.48.  The configuration and setup prior to this
version is not compatible with the new setup. Special attention is
required for:

#. Configuration of the SQL Connection string
#. Access security to the context menu 

The Context Menu requires several additional steps to complete the
installation. Note that this installation must be done after MFSQL
Connector package has been deployed.

If an object type 'MFSQL Connector' is not present in your vault, then
the Context Menu have not yet been installed.

The following tables and procedures are installed when the MFSQL
Connector is deployed:

-  dbo.MFContextMenu:  This table contains the menu items displayed in
   the Context Menu. Note that this is an empty table. The menu items is
   added as part of your deployment.
-  dbo.spMFGetContextMenu: This system procedure is used to by the vault
   application to action the items defined in the Context Menu.

The Context Menu is dependent on the following Vault Application and UIX
Application

-  ContextMenuVaultApp - version 3.2.1.42 and later
-  MFSQLContextMenuUIX - MFSQL Connector Vault App

The installation and application of the Web API is optional. The Web API allows for the communication between M-Files and SQL server to be entirely secure web services based without the need for using ODBC. This is specifically targeted for installations where the M-Files server is not in the same network as the SQL server, such as M-Files in the cloud. 

The installation of the context menu provides the framework to operate
the context menu. The individual menu items and procedures to execute is
described in the deployment of the context as set out in :doc:`/mfsql-data-exchange-and-reporting-connector/using-the-context-menu/index`.

Installation
------------

The installation folder contains the content package and vault applications required by the Context Menu.

The installation package will automatically install these components,
however, these components can be installed manually.  Follow the M-Files
documentation for instructions on performing content package imports and
application installations.

Restart the vault after installation of the applications.

SQL Connection configuration
----------------------------

The operations for the context menu is dependent on access to SQL using either an ODBC connection or a Web API connection. Check the configuration of the :doc:`/getting-started/first-time-installation/configuration-of-connection-string/index`

Context Menu Access
-------------------

Showing the action button to select the context menu is dependent on the
users or usergroups specified in the ContextMenu Usergroup.

Individual actions are shown in the context menu for users / user groups
set in the MFContextMenu table MFUserGroupID column.

The default installation set 'ContextMenu' as the user group. 
The users or usergroups for this group must be set for the context menu to be accessible.

Update M-Files client settings
------------------------------

#. Log into M-Files to get access to the context menu.
#. Validate that the following action menu is available in the task
   bar:

Context Menu
------------

When testing the MFSQL Connector Context after initial installation the
following should be displayed:

Configuration
-------------

The next steps to prepare or use the context menu are explained in detail in :doc:`/mfsql-data-exchange-and-reporting-connector/using-the-context-menu/index`

#. Insert records in MFContextMenu table to control the menu 
#. Create procedures to control the actions: 
#. Update workflow state actions to call state action procedures.
#. Prepare user messages if required.

