Installation and upgrade - From Release 4.3.9.48 (Release 4)
============================================================

.. toctree::
   :maxdepth: 4

   content-package-installation/index
   installing-the-context-menu/index
   using-agent-for-automated-updates/index
   installing-database-mail/index
   common-installation-errors-and-resolutions/index
   standard-new-installation/index
   setup-powershell-utilities/index
   install-package-with-logging/index

.. _Installationandupgrade-FromRelease4.3.9.48(Release4)-/*<![CDATA[*/div.rbtoc1569241490273{padding:0px;}div.rbtoc1569241490273ul{list-style:disc;margin-left:0px;}div.rbtoc1569241490273li{margin-left:0px;padding-left:0px;}/*]]>*/#Installationandupgrade-FromR:

.. container:: toc-macro rbtoc1569241490273

   -  ` <#Bookmark57>`__
   -  `Overview <#Bookmark8>`__
   -  `Download software <#Bookmark9>`__
   -  `Quick steps for a new installation. <#Bookmark10>`__
   -  `Installation scenarios <#Bookmark11>`__
   -  `DB File Connector Configurator Settings <#Bookmark12>`__



Overview
--------

Release 4.3.9.48 introduces a new method of installation building on the
new licensing methods and Vault applications introduced with the advent
of the first release of Release 4. 

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      Release 4 requires a minimum of version M-Files 2018.   Release 3
      can upgrade to release 4, however release 4 cannot be downgraded
      to release 3.

Key features of the installation package

-  There is only one installation package for all modules. 
-  The same installation file is used to install/transfer files on the
   developer desktop, the M-Files server or the SQL Server. These are
   often the same computer in testing/development scenarios.
-  The different modules are licensed by installing the license file to
   the vault applications. Contact us if your license has expired
   at \ `MFSQL@lamininsolutions.com <https://lamininsolutions.atlassian.net/mailto:MFSQL@lamininsolutions.com>`__
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

-  The license files (.lic) is be provided separately.  The Trial
   license  is valid for 30 days. Thereafter new license files must be
   obtained from
   `MFSQL@lamininsolutions.com <https://lamininsolutions.atlassian.net/mailto:MFSQL@lamininsolutions.com>`__



Download software
-----------------

`Download from
here <https://lamininsolutions.com/what-we-do/products/mfsql-connector/download-mfsql-connector/>`__



Quick steps for a new installation.
-----------------------------------

-   `Prerequisites <http://prerequisits>`__
-   M-Files

   -  Minimum version 12.0 (M-Files 2018)
   -  Target Vault is pre-created
   -  Named User dedicated to MFSQL Connector with Vault admin rights is
      available
   -  The context menu connection string configuration will use the
      connection to the M-Files Server user credentials. This user must
      have system administrator rights configure or change the
      connection string.
   -  The M-Files IML (Intelligent Metadata Layer) Core license is
      required for the MFSQL Database File Connector to operate

-  SQL

   -  Microsoft SQL Server version 2012, 2014, 2016, 2017 Express,
      Standard, Enterprise editions.  (Note that procedures dependent on
      SSIS or Agents  will only operate in Standard or Enterprise)

-  The same version of M-Files Client is installed on both the SQL
   Server and M-Files Server
-  Always start with installation on the M-Files Server, and then the
   SQL Server for standard installations or upgrades
-  Follow the manual installation instructions for performing the SQL
   server installation without running the installation package
-  Follow the Cloud installation instructions for performing an
   installation for M-Files Cloud
-  Follow the workstation installation instruction for installing the
   installation files only. This method is used to get access to the
   installation files for manual installation of certain parts of the
   package.
-  The installation package will install the SQL Server and M-Files
   Server in one session if it is on the same computer.
-  Run installation as windows administrator with sysadmin access to the
   SQL Server.
-  Always log into M-Files in the prompt.
-  Always take vault off-line and bring back online after installing the
   vault applications on the M-Files Server
-  Update DB File Connector Configurator using M-Files Admin
-  Use SSMS and the examples scripts to get started with MFSQL Connector



Installation scenarios
----------------------

Different server configurations could give rise to different
installation methods.

.. container:: table-wrap

   ============================================================================================================================================================================================================================= ============================================================================================================================================================================================ ==========================================================================================================
   Server Scenario                                                                                                                                                                                                               Comments                                                                                                                                                                                     Installation Method
   ============================================================================================================================================================================================================================= ============================================================================================================================================================================================ ==========================================================================================================
    M-Files server and SQL Server is separate servers in the same domain network.                                                                                                                                                 This is the recommended and most common scenario for production environments                                                                                                                 Use the standard Installation method as outlined below
                                                                                                                                                                                                                                                                                                                                                                                                                             
   |                                                                                                                                                                                                                                                                                                                                                                                                                         
    M-Files Server and SQL Server is on the same box (server or workstation)                                                                                                                                                      This is the most common scenario for test and development environments                                                                                                                       Use the standard installation as outlined below and select all the installation options at the same time.
                                                                                                                                                                                                                                                                                                                                                                                                                             
   |                                                                                                                                                                                                                                                                                                                                                                                                                         
    M-Files server and SQL Server is separate servers. The servers are not connected with a common domain. Either or M-Files applications and configuration must be installed manually or SQL Server must be installed manually. This is the scenario for a M-Files Cloud deployment                                                                                                                                           Use the M-Files Cloud installation as outlined below
                                                                                                                                                                                                                                                                                                                                                                                                                             
   (e.g. M-Files vault is in the cloud, and SQL server is on premise or separately hosted)                                                                                                                                                                                                                                                                                                                                   
    M-Files server and SQL Server is separate servers in the same domain network. IT policy requires all SQL scripts to be installed by the DBA and auto installation of scripts are not permitted.                               In some scenarios the SQL scripts must be installed separately using SSMS.  This is often the case in larger organisations where the DBA function is separated from the developer function.  Install on a workstation as outlined below for a Manual Installation.
    Parts of installation need to be performed manually to update settings or fix errors                                                                                                                                         The following components can be installed manually:                                                                                                                                          Rerun the components using the scripts generated for the specific installation
                                                                                                                                                                                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                 Content Package, Vault Applications, SQL main installation scripts                                                                                                                          
   ============================================================================================================================================================================================================================= ============================================================================================================================================================================================ ==========================================================================================================



DB File Connector Configurator Settings
---------------------------------------

The Database File  Connector must be configured in the M-Files
Configurator before in becomes operational. Refer to `MFSQL Database
File
Connector <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/156401668/MFSQL+Database+File+Connector>`__
for detail.

| 

| 

| 

| 

| 
