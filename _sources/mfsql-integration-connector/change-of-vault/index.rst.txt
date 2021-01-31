Change of Vault
===============

Special care should be taken when an application that is developed with
the Connector is changed from one vault to another. 

New Vault
---------

Best practice is to create a new database, install the connector
from the installer package and script any custom procedures from
the previous database into the new database if required.

Just moving the settings from one vault by repointing it to a new
vault is possible but will require careful planning and
consideration of all the metadata related tables, views and custom
procedures.

Several tables include custom data. The custom data is described in more
detail in table design section. However, when metadata is refreshed the
custom data will be maintained and not overwritten by the refresh.

Moving the application from a DEV vault to QA vault and then Production
vault is a good example where this section will apply.

When QA or Production is a created as a structure copy of Dev
-------------------------------------------------------------

It his case all the M-Files object references remains the same.

Update Settings
'''''''''''''''

Update the settings in the settings table to point to the new vault

Updating metadata
'''''''''''''''''

Use the special procedure **spMFDropAndUpdateMetadata** to synchronise
metadata after the vault was changed in the settings table.

This procedure will retain all the user defined columns in the
Connector tables.

Scripting tool
--------------

It is common practice to use scripting tools in large scale SQL
developments with lots of custom procedures and functions. Note
that the DBDeployTool is available on request to assist with this
task.
