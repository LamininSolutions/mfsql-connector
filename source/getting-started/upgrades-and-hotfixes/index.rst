Upgrades and hotfixes
=====================

.. toctree::
   :maxdepth: 4

   setup-database/index

M-Files and MFSQL Connector regularly publish upgrades and hot fixes.  Lately, M-Files updates are automated and can be scheduled. MFSQL Connector
updates are not automated and the latest available releases are published on the website.

M-Files upgrades on workstations and the M-Files Server (in cases where the MFSQL SQL instance is not on the M-Files Server) does not affect MFSQL Connector,
however, MFSQL Connector is directly affected by an upgrade of M-Files on the SQL Server.

Special routines, highlighted below aim at keeping the MFSQL Connector responsive to an M-Files upgrade.
We nevertheless recommend to set M-Files upgrades on the SQL server as manual and to only upgrade M-Files when a new version of MFSQL connector is deployed.

This chapter elaborates on

 - How to perform a MFSQL Connector upgrade
 - Exception handling when MFSQL Connector did not update when M-Files upgraded
 - Considerations when copying, moving, or restoring an MFSQL Connector database

MFSQL Connector change management
---------------------------------

Changes to the connector and new functionality released in specific releases are highlighted in :doc:`/version-control/index`. The change control of each procedure is documented as a section in the procedure documentation.

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

  M-Files automatic upgrade
  =========================

  M-Files automatically upgrades to keep the M-Files software up to date.

  MFSQL Connector must response to the upgrade of M-Files on the SQL Server. MFSQL Connector requires M-Files Desktop on the SQL Server where MFSQL Connector is deployed. When M-Files upgrades on the SQL Server it moves the location of the MFilesAPI to the new installed version. MFSQL Connector must therefore be updated to repoint the MFileAPI in the CLR Assemblies to the new location.

  Methods to update MFSQL Connector
  ---------------------------------

  #. Automatic Update

  The Connector checks to validate if M-Files has upgraded by running the procedure `spMFCheckAndUpdateAssemblyVersion <https://doc.lamininsolutions.com/mfsql-connector/procedures/spMFCheckAndUpdateAssemblyVersion>`_.  This procedure can be run manually using `spMFUpdateAssemblies <https://doc.lamininsolutions.com/mfsql-connector/procedures/spMFUpdateAssemblies>`_, using a `SQL agent <https://doc.lamininsolutions.com/mfsql-connector/getting-started/first-time-installation/using-agent-for-automated-updates/index.html>`_ , or using a `powershell utility <https://doc.lamininsolutions.com/mfsql-connector/getting-started/first-time-installation/setup-powershell-utilities/>`_.  Use the powershell utility for SQL Express installations.

  #. Manual update

  Set the parameter to the current version of M-Files on the SQL Server then execute.

  .. code:: sql

      EXEC [dbo].[spMFUpdateAssemblies] @MfilesVersion = '19.9.8028.5'

  #. Rerun the installation package

  Another way to reset the assemblies is to re-run the installation package of the MFSQL Connector.

  #. Check the M-files version on the SQL Server

  .. code:: sql

      Declare @IsUpdateAssembly int, @MFilesVersion nvarchar(25)
      Exec spMFGetMFilesAssemblyVersion @IsUpdateAssembly = @IsUpdateAssembly output, @MFilesVersion = @MFilesVersion output
      Select @IsUpdateAssembly as IsUpdateRequired, @MFilesVersion as InstalledVersion

  Assembly related errors
  -----------------------

  An error reporting a missing procedure or that the assembly could not be found is usually an indication that the updating of the assemblies did not work.

  Check the following:

   - Check the agent or powershell utility to verify that the update is running as expected.
   - If the Connector is running updates regularly during the day, then it is advisable to ensure the agent runs say every half hour to catch any unexpected automatic M-Files updates.
   - Running the updates, especially with Connector versions prior to 4.8.24.65 may result in the dropping of the CLR assemblies, without reloading the assemblies.  Run exec spmfUpdateAssemblies @MfilesVersion = 'the current version on the SQL server' to fix.
