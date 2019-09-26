Update settings
===============

.. toctree::
   :maxdepth: 4

   updating-the-settings/index

Installation
------------

The updating of settings changed from Release 4.  The settings are all
initialised during the installation.  It is normally not necessary to
make changes to the default settings.  The vault authentication settings
are derived from the installation procedure using the vault login
details when performing the installation .  The database settings are
all set with default values.   Some settings could be modified after the
initial installation to customise the connector further.  

The following table contains the settings:

-  MFSettings: For general database and vault settings
-  MFVaultSettings: Authentication settings for accessing the vault.

See\ `utility
tables <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/21200964/Utility+Tables>`__\ section
for details about the settings tables

A deeper understanding of the usage of the settings in the
connector is required before changing of settings after
installation.

User definable settings
-----------------------

User definable settings can be updated using the procedures
spmfSettingsForDBUpdate or spmfSettingsForVaultUpdate.

The connection with M-Files is established using the settings in
MFVaultSettings and no data will be able to synchronise unless the
related settings are correct. The connection can be tested using the
spmfVaultConnectionTest procedure

Many other procedures are also dependent on the correct settings in the
settings tables.

The settings table controls the following:

-  Access to M-Files.
-  Hyperlinks
-  Email communication for error reporting
-  Settings for Assembly installation
-  Database user settings
-  File exchange (import and export)
-  Logging 

The settings table can be extended with custom settings for special
applications. These settings will not be affected when the installation
packages is rerun.  However, we recommend to keep a script for all
custom changes to the settings.

Note that the password need to be encrypted. Refer to the security
section to encrypt the password.  Updating the password using the
spmfSettingsforVaultUpdate will automatically encrypt the password.
