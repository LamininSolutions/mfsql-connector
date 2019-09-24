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

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

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



spMFSettingsForDBUpdate
-----------------------

Note that only the parameters that requires changing have to be
specified. A parameter that is not specified will remain unchanged.

.. container:: table-wrap

   ======================================= =======================================================================================================================================
   .. container:: tablesorter-header-inner .. container:: tablesorter-header-inner
                                          
      Type                                    Description
   ======================================= =======================================================================================================================================
   Procedure Name                          ::
                                          
                                              spMFSettingsForDBUpdate
   Inputs                                  MFInstallationPath : The path where M-Files was installed on the SQL Server in the format : C:\Program files\M-Files
                                          
                                           MFilesVersion : The version of M-Files installed on the SQL Server in the format: 11.2.4320.51
                                          
                                           AssembliyInstallationPath: This is the parth where the assembly files have been copied to on the SQL Server. The default path is C:\CLR
                                          
                                           SQLConnectorLogin: We recommend that you do not change this
                                          
                                           UserRole: We recommend that you do not change this
                                          
                                            SupportEmailAccount: this is the email account that should receive all the system error messages
                                          
                                           EmailProfile: This is the DB Mail Profile that are available for the Connector to process emails.
                                          
                                           DetailLogging: 0 = no logging; 1 = processes logging activated
                                          
                                           DBName = Name of Connector database
                                          
                                           RootFolder = path of the root for the exporting of files. this path must be accessible from SQL Server
                                          
                                           FileTransferLocation = path of the folder used to temporarily save the files that is being imported into M-Files
                                          
                                           Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs                                 1 = success
   ======================================= =======================================================================================================================================

**Execute Procedure**

.. container::

   .. container:: syntaxhighlighter sh-emacs nogutter sql

      | 

      .. container:: table-wrap

         ===============================================================================================================================================================================================================================================================================================================================================================================================================================================================================================
         .. container::
         
            .. container:: line number1 index0 alt2
         
               `` EXEC dbo.spMFSettingsForDBUpdate @MFInstallationPath = ?, -- nvarchar(128)@MFilesVersion = ?, -- nvarchar(128)@AssemblyInstallationPath = ?, -- nvarchar(128)@SQLConnectorLogin = ?, -- nvarchar(128)@UserRole = ?, -- nvarchar(128)@SupportEmailAccount = ?, -- nvarchar(128)@EmailProfile = ?, -- nvarchar(128)@DetailLogging = ?, -- nvarchar(128)@DBName = ?, -- nvarchar(128)@RootFolder = ?, -- nvarchar(128)@FileTransferLocation = ?, -- nvarchar(128)@Debug = ? -- smallint``
         ===============================================================================================================================================================================================================================================================================================================================================================================================================================================================================================



spMFSettingsForVaultUpdate
--------------------------

It is recommended to rerun the installation package to reset the vault
connection settings.  However, in rare cases the
spMFSettingsForVaultUpdate may be used to reset some of the settings.

.. container:: table-wrap

   ======================================= =================================================================================================
   .. container:: tablesorter-header-inner .. container:: tablesorter-header-inner
                                          
      Type                                    Description
   ======================================= =================================================================================================
   Procedure Name                          ::
                                          
                                              spMFSettingsForVaultUpdate
   Inputs                                  VaultGUID: Obtain vault guid from properties of the vault
                                          
                                           ServerURL: this is the server URL as a DNS reference
                                          
                                           UserName: The user name in M-Files with a named user license and admin rights to the vault
                                          
                                           PassWord: password in plain text. It will automatically be encrypted
                                          
                                           VaultName: The name of the vault
                                          
                                           NetworkAddress: The internal UNC to the M-Files Server
                                          
                                           MFProtocolType_ID : the id of the protocol type from table MFProtocol
                                          
                                           MFDomainAuthenticationType_ID = the id of the authentication type from the table MFAuthentication
                                          
                                           Endpoint: The portnumber for accessing the vault
                                          
                                           Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs                                 1 = success
   ======================================= =================================================================================================

**Execute Procedure**

.. container::

   .. container:: syntaxhighlighter sh-emacs nogutter sql

      Note that only the parameter that is being changes have to be
      included.  All parameters does not have to be specified.

      .. container:: table-wrap

         =============================================================================
         .. container::
         
            .. container:: line number1 index0 alt2
         
               EXEC [dbo].[spMFSettingsForVaultUpdate] @Username = ?, -- nvarchar(100)
               @Password = ?, -- nvarchar(100)
               @NetworkAddress = ?, -- nvarchar(100)
               @Vaultname = ?, -- nvarchar(100)
               @MFProtocolType_ID = ?, -- int
               @Endpoint = ?, -- int
               @MFAuthenticationType_ID = ?, -- int
               @Domain = ?, -- nvarchar(128)
               @VaultGUID = ?, -- nvarchar(128)
               @ServerURL = ?, -- nvarchar(128)
               @Debug = ? -- smallint
         =============================================================================

.. container:: table-wrap

   ==================
   **Related Topics**
   ==================
   -  Utility Tables
   -  Security
   ==================
