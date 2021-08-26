Update settings
===============

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

See `utility tables <https://doc.lamininsolutions.com/mfsql-connector/the-connector-framework/connector-content/utility-tables/index.html>`_ section for details about the settings tables

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


If the settings need to be updated then use SSMS to execute the
following procedure

Note that only the parameters that requires changing have to be
specified. A parameter that is not specified will remain unchanged.

      **Execute Procedure**

      .. code:: sql

          DECLARE @RC int
         DECLARE @MFInstallationPath nvarchar(100)
         DECLARE @MFilesVersion nvarchar(100) = '11.3.4330.130'
         DECLARE @AssemblyInstallationPath nvarchar(100)
         DECLARE @SQLConnectorLogin nvarchar(100)
         DECLARE @UserRole sysname
         DECLARE @SupportEmailAccount nvarchar(100)
         DECLARE @EmailProfile nvarchar(100)
         DECLARE @Debug smallint

         -- TODO: Set parameter values here.

         EXECUTE @RC = [MFSQL_SampleVault].[dbo].[spMFSettingsForDBUpdate] 
            @MFInstallationPath
           ,@MFilesVersion
           ,@AssemblyInstallationPath
           ,@SQLConnectorLogin
           ,@UserRole
           ,@SupportEmailAccount
           ,@EmailProfile
           ,@Debug
         GO

Perform a select statement of the settings table to check that it is
correctly updated. Alternatively run the MFSQL Connector Package
installation again.

      **Execute Procedure**

      .. code:: sql

          DECLARE @RC int
         DECLARE @Username nvarchar(100) = 'YourUserName'
         DECLARE @Password nvarchar(100) = 'YourPassword'
         DECLARE @NetworkAddress nvarchar(100) = 'vault server network address'
         DECLARE @Vaultname nvarchar(100) = 'Name of vault'
         DECLARE @MFProtocolType_ID int 
         DECLARE @Endpoint int
         DECLARE @MFAuthenticationType_ID int 
         DECLARE @Domain nvarchar(128)
         DECLARE @VaultGUID nvarchar(1000) = 'xxxxxx'
         DECLARE @ServerURL nvarchar(500) = 'url for web access'
         DECLARE @Debug smallint

         -- TODO: Set parameter values here.

         EXECUTE @RC = [MFSQL_SampleVault].[dbo].[spMFSettingsForVaultUpdate] 
            @Username
           ,@Password
           ,@NetworkAddress
           ,@Vaultname
           ,@MFProtocolType_ID
           ,@Endpoint
           ,@MFAuthenticationType_ID
           ,@Domain
           ,@VaultGUID
           ,@ServerURL
           ,@Debug
         GO

View settings
-------------

Perform a select statement on MFVaultSettings to review the vault
settings 

Perform a select statement on MFSettings to review all other settings

