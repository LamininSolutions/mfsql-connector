
=====================
Installation Overview
=====================

What is included
----------------

This section provide guidance on how to perform a first time installation and to upgrade the tool after the initial installation.

The preparation of the environment before first installation is also highlighted in this section.

Consult the `requirements <https://doc.lamininsolutions.com/mfsql-connector/introduction/requirements/index>`_ before commencing with the installation.

Release 4.3.9.48 introduces a new method of installation building on the
new licensing methods and Vault applications introduced with the advent
of the first release of Release 4. 

Release 4 requires a minimum of version M-Files 2018.   Release 3
can upgrade to release 4, however release 4 cannot be downgraded
to release 3.

Key features of the installation packages
-----------------------------------------

-  MFSQL Connector installation package has two packages for installation: the main application and a separate package for the deployment of the Web API.
-  The main installation package is used to install/transfer files on the
   developer desktop, the M-Files server or the SQL Server. These are
   often the same computer in testing/development scenarios.
   The installation of the Web API is only used for M-Files Cloud deployments of MFSQL Connector when the context menu functionality is required.
-  The different modules are licensed by installing the license file to
   the vault applications. `Contact us <mailto:MFSQL@lamininsolutions.com>`__ if your license has expired.

-  The application will only operate with a valid license. Licenses
   expire when the subscription period runs out.
-  Selecting options in the installation package will install the
   content package and vault applications in the M-Files server, and the
   assemblies and procedures in the database server.
-  The vault application packages and assemblies can also be manually
   installed. See directions below. 
-  All installation files are installed on the computer as part of the
   installation. 
-   It is necessary to rerun the installation package for each
   vault/database installation to install multiple versions on the same
   computer
-  The installation files are in different folders for easy access. 
   Some of the destination folders for installation can be changes
   during the installation process.

   -   Installation files (destination can be changed)

      -  C:\Program Files (x86)\Laminin Solutions\MFSQL Connector
         Release 4\[Database Name]\Content Package
      -  C:\Program Files (x86)\Laminin Solutions\\MFSQL Connector
         Release 4\\[Database Name]\Database Scripts
      -  C:\Program Files (x86)Laminin Solutions\\MFSQL Connector
         Release 4\\[Database Name]\Example Scripts
      -  C:\Program Files (x86)\Laminin Solutions\\MFSQL Connector
         Release 4\\[Database Name]\Vault Applications

   -  Assemblies  (destination can be changed)

      -  C:\MFSQL\Assemblies

   -  File exchange folders (destination can be changed)

      -  C:\MFSQL\FileExport
      -  C:\MFSQL\FileImport

   -  Setup Files (fixed)

      -  C:\Users\[user]AppData\Local\MFSQL Vault Install

   -  Installation Log (fixed)

      -  C:\Users\lerouxc\AppData\Local\Temp (MSIXXX.log)

   -  License Update script

      -  C:\Program Files (x86)\Common Files\MFSQLConnector

-  The license files (.lic) is provided separately.  The Trial
   license is valid for 30 days. Thereafter new license files must be
   obtained from `support <mailto:MFSQL@lamininsolutions.com>`__


Download software
-----------------

The latest published release is available from the `Laminin Solutions website <https://lamininsolutions.com/download-mfsql-connector/>`_

Deployment server model
-----------------------

Single Server Deployment Model
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Connector can be deployed in a single server where M-Files server
and SQL server is installed on the same server.

The Connect must be deployed in a separate Database on the SQL Server.
It is not required, but preferred for the Connector Database to be a
separate SQL instance from the M-Files vault SQL Database in cases where
the M-Files vault is also deployed as a SQL database.

Multi Server Deployment Model
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When the Connector is used for integration with other applications or
for special application development, then a multi database deployment
model is preferred.

The following Server deployment is preferred in cases of high data
volume usage.

-  M-Files Server: Installation of the M-Files Server and vaults
-  SQL Server(s) with (separate instance for M-Files SQL vault
   databases)

   -  M-Files SQL Database
   -  Connector Database

-  SQL Server for special application databases

M-Files Cloud Deployment Model
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When the Vault is on M-Files-Cloud and SQL Server is either on premise
or hosted

-  M-Files Cloud and SQL Server is connected with a VPN and in the same
   Domain
-  M-Files Cloud and SQL Server is not connected with a VPN

When the M-Files Cloud is connected with to the SQL Server with a VPN
the deployment model is the same as a Multi-Server Deployment

Special considerations apply when SQL Server is not connected with
M-Files Cloud. Follow the installation instructions specific to this
model.

