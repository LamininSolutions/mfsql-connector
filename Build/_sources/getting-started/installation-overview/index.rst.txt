=====================
Installation Overview
=====================

This section provide guidance on how to perform a first time installation and to upgrade the tool after the initial installation.

The preparation of the environment before first installation is also highlighted in this section.

Consult the :doc:`/introduction/requirements/index` before commencing with the installation.

.. contents::


Key features of the installation packages
-----------------------------------------

-  MFSQL Connector installation package has two packages for installation: the main application and a separate package for the deployment of the Web API.
-  The main installation package is used to install/transfer files on the
   developer desktop, the M-Files server or the SQL Server. These are
   often the same computer in testing/development scenarios.
-  The Context Menu functionality is optional and only need to be configured when SQL processes need to be triggered from M-Files.
-  The installation of the Web API is used for Context Menu functionality in installations where the MFSQL Server and M-Files server are in separate domains, such as M-Files Cloud.
-  The different modules are licensed by installing the license file to
   the vault applications. `Contact us <mailto:MFSQL@lamininsolutions.com>`__ if your license has expired.
-  The application will only operate with a valid license. Licenses
   expire when the subscription or rental period runs out.
-  Selecting options in the installation package will install the
   content package and vault applications in the M-Files server, and the
   assemblies and procedures in the database server.
-  The vault application packages and assemblies can also be manually
   installed. See separate directions. 
-  All installation files are installed on the computer as part of the
   installation. The installation files are in different folders for easy access.  See below for detials.
-  It is necessary to rerun the installation package for each
   vault/database installation to install multiple versions on the same
   computer
-  Some of the destination folders for installation can be changes during the installation process. Changing the destination (e.g. to drive D:) could require manual intervention for each installation or upgrade. See details in the installation instructions.

Installation files
------------------

Some destinations is configurable

      -  C:\\Program Files (x86)\\Laminin Solutions\\MFSQL Connector
         Release 4\\[Database Name]\Content Package
      -  C:\\Program Files (x86)\\Laminin Solutions\\MFSQL Connector
         Release 4\\[Database Name]\\Database Scripts
      -  C:\\Program Files (x86)Laminin Solutions\\MFSQL Connector
         Release 4\\[Database Name]\\Example Scripts
      -  C:\\Program Files (x86)\\Laminin Solutions\\MFSQL Connector
         Release 4\\[Database Name]\\Vault Applications

   -  Assemblies  (destination can be changed)

      -  C:\\MFSQL\\Assemblies

   -  File exchange folders (destination can be changed)

      -  C:\\MFSQL\\FileExport
      -  C:\\MFSQL\\FileImport

   -  Setup Files (fixed)

      -  C:\\Users\\[user]AppData\\Local\\MFSQL Vault Install

   -  Installation Log (fixed)

      -  C:\\Users\\lerouxc\\AppData\\Local\\Temp (MSIXXX.log)

   -  Context Menu Log (destination can be changed)

      -  C:\\Program Files\\M-Files\\Server Vaults\\[Vaultname]\\Applogs\\[GUID]\\[GUID]\0\current.txt

-  The license files (.lic) is provided separately.  The Trial
   license is valid for 30 days. Thereafter new license files must be
   obtained from `support <mailto:support@lamininsolutions.com>`__

Download software
-----------------

The latest published release is available from the `Laminin Solutions website <https://lamininsolutions.com/what-we-do/mfsql-connector/>`_

Deployment server model
-----------------------

Single Server Deployment Model
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Connector can be deployed in a single server where M-Files server
and SQL server is installed on the same server.

The Connector must be deployed in a separate Database on the SQL Server.

Multi Server Deployment Model
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When the Connector is used for integration with other applications or
for special application development, then a multi database deployment
model is preferred.

MFSQL Connector is Multiserver mode enabled for the purposes of a distributed M-Files installation.

When MFSQL Connector database is installed in a SQL High availability cluster then the following must be installed on each member server of the cluster

 - M-Files desktop
 - A copy of the Assembly files in the same folder as the main installation

Most often MFSQL Connector is installed in the same SQL server as the M-Files database and other applications.  However, the following Server deployment is preferred in cases of high data
volume usage.

-  M-Files Server: Installation of the M-Files Server and vaults
-  SQL Server(s) with (separate instance for M-Files SQL vault
   databases)

   -  M-Files SQL Database
   -  Connector Database

-  SQL Server for special application databases

M-Files and SQL is on separate domains (Cloud Deployment Model)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When the Vault is in a separate domain than the SQL Server such as M-Files-Cloud or another hosted solution then the following additional steps would apply:

 - Install or enable a Web Server in the same domain as SQL server
 - Install IIS on the Web Server and enable a SSL certificate for https protocol
 - Install the MFSQL Connector Web API installation package
 - Update the configurations tab in M-Files Admin for using the Web API

See detail instructions for :doc:`/getting-started/cloud-and-hosted-installation/install-webapi/index`

Quick steps for a new installation.
-----------------------------------

Before installation:
~~~~~~~~~~~~~~~~~~~~

 For M-Files, check the following

    -  Minimum version 20.5
    -  Target Vault is pre-created
    -  Named User dedicated to MFSQL Connector with Vault admin rights is
       available in M-Files
    -  The user doing the installation must have M-Files System rights
    -  The M-Files Desktop is enabled on the M-Files server
    -  The M-Files IML (Intelligent Metadata Layer) Core license is
       required for the MFSQL Database File Connector to operate

 For SQL, check the following

    -  Microsoft SQL Server version 2016, 2017, 2019 Express , Standard, or Enterprise editions.  (Note that procedures dependent on SSIS or SQL agents will only operate in Standard or Enterprise)
    -  Confirm SQL Server is installed with mixed authentication mode enabled
    -  The user doing the installation must have sysadmin rights to the SQL Server or access to a user credentials with these rights.
    -  M-Files desktop is installed on the SQL server

During installation:
~~~~~~~~~~~~~~~~~~~~

 -  Always start with installation on the M-Files Server, and then the
    SQL Server for a :doc:`/getting-started/on-premise-installation/index` or upgrade
 -  Follow the standard installation instructions for all installations and upgrades except if one of the following applies:

      - high availability multi SQL server
      - M-Files Cloud or other type of hosted installation
      - High security limited SQL server access
      - Database file connector for access to Blob Files
      - Using powershell utilities for SQL express installation

 -  Follow the manual installation instructions for high security limited SQL server access to perform the SQL
    server installation without running the installation package
 -  Follow the Cloud installation instructions for performing an installation for M-Files Cloud. These instructions include the WEB API instructions for installing a web service between M-Files and SQL Server
 -  Follow the DB File Connector installation and configuration to get access the database file blobs
 -  Follow the workstation installation instruction for installing the
    installation files only. This method is used to get access to the
    installation files for manual installation of certain parts of the
    package.
 -  Always take vault off-line and bring back online after installing the
    vault applications on the M-Files Server or making configuration changes for the context menu functionality
 -  Use SSMS and the examples scripts to get started with MFSQL Connector
