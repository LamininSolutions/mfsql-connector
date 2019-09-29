Getting Started
===============

.. toctree::
   :maxdepth: 4

   installation-and-upgrade---from-release-4.3.9.48-(release-4)/index
   next-steps-after-installation/index
   upgrades-and-hotfixes/index

Overview
--------

This section provide guidance on how to perform a first time installation and to upgrade the tool after the initial installation.

The preparation of the environment before first installation is also highlighted in this section.

Consult the :ref:`/Introduction` before commencing with the installation.

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
