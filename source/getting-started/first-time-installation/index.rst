=======================
First time installation
=======================

.. toctree::
   :maxdepth: 4

   standard-new-installation/index
   content-package-installation/index
   installing-the-context-menu/index
   using-agent-for-automated-updates/index
   installing-database-mail/index
   common-installation-errors-and-resolutions/index
   setup-powershell-utilities/index
   install-package-with-logging/index


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