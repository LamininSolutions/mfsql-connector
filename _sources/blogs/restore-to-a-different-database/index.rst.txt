============================================
Restore MFSQL database to a different server
============================================

Migrating an existing MFSQL Connector database to a different server requires special considerations.

Planning the migration must include the following steps:

Old SQL server
--------------

 - Script all the custom procedures, views, and tables to a file.
 - Script the following tables to capture any custom settings
   - MFSettings (capture any settings that was added or manually modified in this table)
   - MFProperty (capture any custom changes to the *columnname* 
   - MFClass  (capture any modifications in IncludeInApp, FileExportFolder, SynchPrecedence
 - Backup the MFSQL Connector database

New SQL server - Option 1: New install
--------------------------------------

 - Reinstall MFSQL Connector installation package to a new database
 - Synchronise metadata
 - Update MFSettings, MFProperty and MFClass with custom changes
 - Use spMFCreateAllMFTables to create all the class tables 
 - Pull all class tables using spMFUpdateAllncludedInAppTables with @IsIncremental = 0
 - Script all custom procedures, views, and tables into the new database
 - Identify and change any impact of the changes on integration nodes to other systems or databases

Using this option will provide an opportunity to refresh the MFSQL Connector database and get rid of all redundant objects

New SQL server - Option 2: Restore database
-------------------------------------------

 - Restore old database into new SQL server
 - Rerun installation package to reset all the connection settings and update the Assemblies
 - Test connection

Using this option risk having custom procedures, views, tables etc referencing the old database and causing conflicts

M-Files Vault
-------------

 - Update the configurator with the new server and database name
 - Update the MFSQL Connector license if the M-Files license serial number changed
 - If the MFSQL Connector WEBAPI has been deployed, then update the new connection string in the website
 - Reinstall the MFSQL Connector package to ensure the installation files on the M-Files Server is in line with the new database

