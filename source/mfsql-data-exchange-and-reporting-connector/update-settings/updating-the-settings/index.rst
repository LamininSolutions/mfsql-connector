Updating the settings
=====================

If the settings need to be updated then use SSMS to execute the
following procedure

Note that only the parameters that requires changing have to be
specified. A parameter that is not specified will remain unchanged.



spMFSettingsForDBUpdate for database related settings
-----------------------------------------------------

.. container:: table-wrap

   ============== ======================================================================================================================================
   Type           Description
   ============== ======================================================================================================================================
   Procedure Name ::
                 
                     spMFSettingsForDBUpdate
   Inputs         MFInstallationPath : The path where M-Files was installed on the SQL Server in the format : C:\Program files\M-Files
                 
                  MFilesVersion : The version of M-Files installed on the SQL Server in the format: 11.2.4320.51
                 
                  AssembliyInstallationPath: This is the path where the assembly files have been copied to on the SQL Server. The default path is C:\CLR
                 
                  SQLConnectorLogin: We recommend that you do not change this
                 
                  UserRole: We recommend that you do not change this
                 
                   SupportEmailAccount: this is the email account that should receive all the system error messages
                 
                  EmailProfile: This is the DB Mail Profile that are available for the Connector to process emails.
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== ======================================================================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

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



spMFSettingsForVaultUpdate for vault related settings
-----------------------------------------------------

| 

.. container:: table-wrap

   ============== ================================================================================================================
   Type           Description
   ============== ================================================================================================================
   Procedure Name ::
                 
                     spMFSettingsForVaultUpdate
   Inputs         VaultGUID: Obtain vault GUID from properties of the vault
                 
                  ServerURL: this is the server URL as a DNS reference
                 
                  UserName: The user name in M-Files with a named user license and admin rights to the vault
                 
                  PassWord: password in plain text. It will automatically be encrypted
                 
                  VaultName: The name of the vault
                 
                  NetworkAddress: The internal UNC to the M-Files Server
                 
                  MFprototcolType_ID: Default to TCP/IP. Use 4 for HTTPS.
                 
                  EndPoint: port number. Default to 2266.
                 
                  MFAutenticationType_ID: Default to M-Files User. Use 3 for specific windows user and 2 for current windows user.
                 
                  Domain: add domain if windows user are selected, else use default
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== ================================================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

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

| 
