Installing the Context Menu
===========================

The Context Menu functionality enables actioning a SQL Procedure from
within M-Files:

-  User selected action from a menu
-  User selected context sensitive action from a menu
-  Triggered by a workflow change
-  Triggered by an event handler

This guide deals with the installation and configuration of the context menu
for versions between 4.3.9.48 and 4.9.29.73  and from 4.10.30.74 onwards.  The configuration and setup prior to 4.3.9.48
version is not compatible with the new setup of context menu. Version 4.10.30.74 introduced VAF Multi server mode, task scheduling and logging to the context menu with significant changes to the configuration and use of the context menu.

This chapter is concerned with the basic configuration and enablement of the context menu functionality. The use and deployment of different alternatives for this functionality is in :doc:`/mfsql-data-exchange-and-reporting-connector/using-the-context-menu/index`
The steps to enable the context menu include:

#. Setup of the SQL Connection
#. Access security to the context menu
#. Enabling Logging

This configuration must be done after MFSQL Connector package has been deployed.  The context menu functionality is dependent on the following elements installed when the package is run

Tables and procedures
~~~~~~~~~~~~~~~~~~~~~

The following tables and procedures are installed when the MFSQL
Connector is deployed:

-  MFContextMenu:  This table contains the menu items displayed in
   the Context Menu. Note that this is an empty table. The menu items is
   added as part of your deployment.
-  MFProcessBatch:
-  MFProcessBatchDetail:
-  spMFGetContextMenu: This system procedure is used to by the vault
   application to action the items defined in the Context Menu.

Example custom procedures
~~~~~~~~~~~~~~~~~~~~~~~~~

User group
~~~~~~~~~~


Vault Application (VAF)
~~~~~~~~~~~~~~~~~~~~~~~

The Context Menu is dependent on the following Vault Application and UIX
Application

-  ContextMenuVaultApp - Vault application of licensing and Context menu handling
-  MFSQLContextMenuUIX - MFSQL Connector Vault App

Web service
~~~~~~~~~~~

The installation and application of the Web API is optional. The Web API allows for the communication between M-Files and SQL server to be entirely secure web services based without the need for using ODBC. This is specifically targeted for installations where the M-Files server is not in the same network as the SQL server, such as M-Files in the cloud.

The installation of the context menu provides the framework to operate
the context menu. The individual menu items and procedures to execute is
described in the deployment of the context as set out in :doc:`/mfsql-data-exchange-and-reporting-connector/using-the-context-menu/index`.

Log files
~~~~~~~~~

Installation
------------

The installation folder contains the content package and vault applications required by the Context Menu.

The installation package will automatically install these components,
however, these components can be installed manually.  Follow the M-Files
documentation for instructions on performing content package imports and
application installations.

Restart the vault after installation of the applications.

SQL Connection configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The operations for the context menu is dependent on access to SQL using either an ODBC connection or a Web API connection. Check the configuration of
 the :doc:`/getting-started/cloud-and-hosted-installation/install-webapi/index`

Configuration of connection string
==================================

**Configuration method**

The configuration of the connection string to access SQL from
M-Files has changed from Release 4.3.9.48.

This instruction refers only to the new connection string
configuration.

Only a user with M-Files Server System Administrator credentials can
make changes to the configuration of the connection string.

Access the configuration using the **Configurations** option in the
vault administration window.

Select **Other Applications** and expand.

Select **MFSQL Connector Vault App**. This will show the
configuration on the right.

Select **Configuration** tab. Then select the **ConnectionString**

**Nothing is showing**

Nothing will show when the user is not system administrator

Update the Servername, Username Password and databasename. 

-  The servername must include the instance and port if applicable.  
-  The default user name is MFSQLConnect.  This is a SQL Authentication
   user and is created with all the required authentication during
   installation. Another user can be used. However, the user must be
   added to the MFSQLConnect_db role in the database to operate
   seamlessly.
-  The default password for MFSQLConnect is Connector01.  Change the
   password in SQL.  Remember to update the password in the
   Configurator.
-  The database is the MFSQL Connector database for the specific vault
   created during first installation of the Connector.
-  The APIURL (from version 4.6.15.56) is only applicable when the Web API is used.  Leave blank if WEB API is not used. Refer to WEBAPI instructions to compile the API Url

Take vault offline and back online to activate the connection string.

Select **Dashboard** tab to validate the connection.

Context Menu Access
~~~~~~~~~~~~~~~~~~~

Showing the action button to select the context menu is dependent on the
users or usergroups specified in the ContextMenu Usergroup.

Individual actions are shown in the context menu for users / user groups
set in the MFContextMenu table MFUserGroupID column.

The default installation set 'ContextMenu' as the user group. 
The users or usergroups for this group must be set for the context menu to be accessible.

Update M-Files client settings
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
