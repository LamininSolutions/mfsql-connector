Getting Started
===============

.. toctree::
   :maxdepth: 2

   installation-overview/index
   first-time-installation/index
   manual-installation-using-scripts/index
   licensing-management/index
   next-steps-after-installation/index
   upgrades-and-hotfixes/index
   update-settings/index
   setup-database/index
   database-mail/index

Quick steps for a new installation.
-----------------------------------

-   Check out the prerequisites :doc:`/introduction/requirements/index`
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

   -  Microsoft SQL Server version 2012, 2014, 2016, 2017, 2019 Express , Standard, or Enterprise editions.  (Note that procedures dependent on SSIS or SQL agents will only operate in Standard or Enterprise)

-  Always start with installation on the M-Files Server, and then the
   SQL Server for standard installations or upgrades
-  Follow the manual installation instructions for performing the SQL
   server installation without running the installation package
-  Follow the Cloud installation instructions for performing an
   installation for M-Files Cloud
-  Follow the WEB API instructions for installing a web service between M-Files and SQL Server  
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
