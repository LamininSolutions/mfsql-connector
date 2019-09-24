Standard New Installation
=========================

This page relates to Release 4.3.9.48 and later.

M-Files, and SQL on separate servers in the same domain network

Watch the video

| 



M-Files Server
--------------

Before executing the installation package:

-  Confirm M-Files version 12.0.6400.0 or higher is installed
-  Confirm SQL Server is installed with mixed authentication mode
   enabled
-  Ensure M-Files Desktop Client is installed on the M-Files Server and
   SQL server
-  Copy Sample Vault to create a new test vault to prototype with the
   Connector ; or use an existing vault
-  Install the package with windows administrator credentials. 
-  Connect to the M-Files server with system administration credentials
-  Setup a dedicated M-Files User for the vault. It is recommended to
   use M-Files authentication. However specific windows user can also be
   used.  Set user with vault admin rights. We recommend a user name
   that is easily identifiable as a Connector User such as MFSQLConnect

Watch the video

| 

| 

| 

.. container:: content-wrapper

   Run Installation Package on the M-Files Server

   .. container:: content-wrapper

   | 
   |  Confirm the license agreement

   .. container:: content-wrapper

   | 

    Select installation folder.

   The installation folder will contain the installation files for the
   specific to the Vault and Database being implemented. Accept default,
   or browse to desired folder

   .. container:: content-wrapper

       

   | 

    Login into M-Files to connect the M-Files Vault and the MFSQL
   Database.   The credentials used as login will be used by MFSQL
   Connector to access the vault for all future operations. The
   credentials can be changed at any time using SSMS or by rerunning the
   installation package.

.. container:: content-wrapper

    

| 

 Select either both, or one of the options to install the vault
applications. These options must ONLY be selected when the installer is
executed while on the M-Files Server.

#. Selecting **MFSQL Connector vault applications** will install

   #. Content package to add objects related and required by the
      connector.
   #. Vault application: MFSQL Connector VaultApp
   #. MFSQL Connector Context Menu UIX

#. Selecting the **DB File Connector **\ will install

   #. SQL Database Connector application

All these applications can be installed manually. See section for manual
installation.

The DB File Connector is only required if the functionality is needed to
connect to Blobs (database files) in a third party database  without
transferring the files to M-Files.  Installing this connector will
require M-Files IML core to be licensed by your M-Files license.

.. container:: content-wrapper

| 
|  Verify that the installation is connected to the correct Vault

Login into the SQL server with sysadmin credentials. The server name
must include the SQL Server \\ Instance.  Add the server port if a non
standard port are used.

.. container:: content-wrapper

    

| 
|  The installation will proceed through a number of steps
|  On completion of the installation a message box is shown to remind
  you to take vault offline and bring back online before proceeding

 Finish the installation.

This has now completed the installation of the vault applications

Get the vault installation error log at 

C:\Users\[windowsuser]\AppData\Local\MFSQL Vault Install\ErrorLog.txt

.. container:: content-wrapper

|  Configure M-Files ServerAfter installing the M-Files Application
  packages for the MFSQL Connector, proceed with setting up the
  Connector in M-Files
|  Take vault off line and bring back online

 Access the Applications window using M-Files Admin

See section on installing the licenses for further detail on licensing
the applications.

.. container:: content-wrapper

    

| 

 Access the application configuration using M-Files Admin



SQL Server
----------

Run Installation Package

.. container:: content-wrapper

| 
|  Confirm the license agreement

.. container:: content-wrapper

| 

 Select installation folder.

The installation folder will contain the installation files for the
specific to the Vault and Database being implemented.

Accept default, or

Browse to desired folder

.. container:: content-wrapper

    

| 

 Login into M-Files to connect the M-Files Vault and the MFSQL Database.
  The credentials used during login will be used by MFSQL Connector to
access the vault for all future operations.

The credentials can be changed at any time using SSMS or rerunning the
installation package.

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      The user must have server and vault administrator rights.
      Temporarily elevate the rights for the user to server
      administrator rights, and reset to vault administrator rights
      after the installation.

| 

 Add on premise or remote M-Files server. Login to access the list of
vaults. Select the vault.

Selecting a different authentication type will popup another window to
allow for adding the additional credentials.

 Before proceeding, select the installation type:

Checkbox: Install CLR.  This selection will create the database, install
the Connector in SQL and install the CLR Assemblies. 

Only check this box if the installation routine is being run on the SQL
Server.

Use the SQL Database window to login into the SQL Server. Use
credentials with sysadmin rights.

Type in the name of the database if it is a new installation. The
database will automatically be created.

Use the ... dots to show the existing databases on the server.  Select
an existing database when the installation is re-run for the database.

Continue with the installation until finished.

Log into SSMS from a workstation and access the MFSQL Connector
database.

Use the example scripts to guide you through the first steps to get
going with the Connector. The sample scripts are available at

C:\Program Files (x86)Laminin Solutions\\MFSQL Connector Release
4\\[Database Name]\Example Scripts

| 

| 

| 

.. container:: table-wrap

   ===== ===== =======
   Stage Steps Example
   ===== ===== =======
   ===== ===== =======
