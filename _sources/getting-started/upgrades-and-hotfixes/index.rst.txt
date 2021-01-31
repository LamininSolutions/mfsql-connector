Upgrades and hotfixes
=====================

.. toctree::
   :maxdepth: 4

   mfiles-upgrade/index
   updating-to-version-4.8.22.62/index

M-Files and MFSQL Connector regularly publish upgrades and hot fixes.

Connector functionality released in specific releases are highlighted in :doc:`/version-control/index`. The change control of each procedure is documented as a section in the procedure documentation.

Types of Upgrades
-----------------

Connector upgrades will differ depending on what is driving the upgrade.

#. Connector update following a `Mfiles-upgrade\index` upgrade on the SQL server (automated)
#. Connector update following a manual M-Files upgrade on the SQL Server
#. Upgrade and hotfixes of SQL procedures only.
#. Major Release upgrade. 
#. Upgrades from Release 3 (version 3.1.4.40 and earlier) to Release 4
   (version 4.1.5.41 and higher). 

..note::
    There is no need to update the Connector if the M-Files version changes on the user desktop or M-Files server, where the M-Files server is not the same as the SQL server.

Preparation for upgrading
-------------------------

The upgrade method of a package is intended to be
replace the previous package taking into account any migration of the
standard functionality from a previous to the new version. Any customization of procedures, tables or other objects
of any of the standard content of the package will be lost.  We
recommend that changes are never made to the connector objects. Custom procedures and other objects should use the schema ''custom'' with a distinctive naming convention.
Application requirements for adjustments to the standard objects must be
made through Laminin Solutions.

Before commencing with an upgrade always ensure that backups are
available

-  MFSQL Connector Database
-  M-Files Vault

On occasion it is necessary to restart the SQL server after the upgrade to allow M-Files
to release the API's from the previous version from memory and
load the new version API's into memory

Automatic updates
-----------------

The Connector will detect if the M-Files Version has changed when the automatic update has been configured. Follow the steps in `mfiles-upgrade/index`

Manual update of the Connector
------------------------------

The installation package for the same version as the installed version of the Connector can be repeatedly executed on the SQL Server.  This may be necessary to refresh the installation or to recover from an issue.

As an alternative, and when only the assemblies require updating the procedure :doc:`/procedures/spMFUpdateAssemblies` may be applied.

Upgrade the Connector to a new version
--------------------------------------

The latest published version of the connector is available for `download <https://lamininsolutions.com/download-mfsql-connector/>`_

Note the installed version before updating with `Version Check`.  If only the third or last segment of the version have changed, then the upgrade must only be applied to the SQL Server.
(e.g. 4.8.24.55 to 4.8.24.56)

When the second segment has changed, the package must be applied to both SQL Server and M-Files Server.
(e.g. 4.7.22.48 to 4.8.23.50)

Take special care when the current version is prior to 4.8.22.62.  Additional steps may include:
- :doc:`/getting-started/upgrades-and-hotfixes/updating-to-version-4.8.22.62/index`
- contact us when upgrading from releases prior to 4.4.7.40

Version Check
-------------

The current version of MF-Files and MFSQL Connector that has been
deployed in the database can be reviewed using :doc:`/tables/tbMFDeploymentDetail`
table

.. code:: sql

    SELECT * FROM [dbo].[MFDeploymentDetail] AS [mdd] ORDER BY id desc

  ==== =================================== ====================== ========== ==========
  ID   LSWrapperVersion                    MFilesAPIVersion       DeployedBy DeployedOn
  1019 2.1.1.11 / MFSQL Connector 2.1.1.13 7.0.0.0 :11.3.4330.134 RemoteSQL  12/11/2016
  ==== =================================== ====================== ========== ==========
