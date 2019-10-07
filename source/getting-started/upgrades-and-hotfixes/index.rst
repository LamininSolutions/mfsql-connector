Upgrades and hotfixes
=====================

.. toctree::
   :maxdepth: 4

   upgrades-and-fixes-and-version-check/index
   upgrades-hotfixes/index
   configuration-of-connection-string/index

From time to time upgrades and hot fixes will be published.

Functionality released in specific releases are highlighted in the
`Release <version-control>`_ section
section.

The following procedure must be followed when a new update is made
available.  Note that the upgrade method of a package is intended to be
replace the previous package taking into account any migration of the
standard functionality from a previous to the new version.

It is important to note that :Any customization of procedures, tables or other objects
of any of the standard content of the package will be lost.  We
recommend that changes are never made to the connector objects.
Application requirements for adjustments to the standard objects must be
made through Laminin Solutions.

Before commencing with an upgrade always ensure that backups are
available

-  MFSQL Connector Database
-  M-Files Vault
-  Prior Release folders on both M-Files Server and SQL Server (we
   recommend that to zip these folders)

   -  Installation folder
   -  File and assembly folder

   Restart server

      Always restart the SQL server after the upgrade to allow M-Files
      to release the API's from the previous version from memory and
      load the new version API's into memory

| 



Types of Upgrades
-----------------

Upgrades and hotfixes have two scenarios

#. Upgrades from Release 3 (version 3.1.4.40 and earlier) to Release 4
   (version 4.1.5.41 and higher). 
#. Major Release upgrade.  This would happen when not only SQL scripts
   are changed, but Applications and CLR assemblies are modifed.  This
   is signalled by a change in the second digid (e.g. 4.1 changing to
   4.2)
#. Upgrade and hotfixes of SQL procedures only.

| 

| 

| 

| 
