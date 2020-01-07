
==========================
spMFsettingsForVaultUpdate
==========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Username nvarchar(100)
    M-Files user with vault admin rights
  @Password nvarchar(100)
    The password will be encrypted
  @NetworkAddress nvarchar(100)
    - Vault server URL from SQL server
    - example: 'laminindev.lamininsolutions.com'
  @Vaultname nvarchar(100)
    vault name
  @MFProtocolType_ID int
    - Default set by installer
    - select ID from list in MFProtocolType
  @Endpoint int
    - The portnumber for accessing the vault
    - Default set by installer 2266
  @MFAuthenticationType_ID int
    select ID from list of MFAutenticationType
  @Domain nvarchar(128)
    fixme description
  @VaultGUID nvarchar(128)
    GUID from M-Files admin
  @ServerURL nvarchar(128)
    - Web Address of M-Files
    - example: 'laminindev.lamininsolutions.com'
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

Procedure to allow updating of specific settings in both MFVaultSettings and MFSettings related to the vault
Table MFVaultSettings show the settings to connect to M-Files.
MFSettings table show the other settings for the Connector.

Examples
========

.. code:: sql

    -- check out the settings tables
    SELECT * FROM mfVaultSettings
    SELECT * FROM  [MFSettings] AS [ms]

    --the Protocol type and authentication type are referenced in related tables
    SELECT * FROM [dbo].[MFVaultSettings] AS [mvs]
    LEFT JOIN [dbo].[MFProtocolType] AS [mpt]
    ON mvs.[MFProtocolType_ID] = mpt.[ID]
    LEFT JOIN [dbo].[MFAuthenticationType] AS [mat]
    ON mvs.[MFAuthenticationType_ID] = mat.[ID]

    --updating the M-Files user name
    EXEC [spMFSettingsForVaultUpdate] @Username = 'Admin'

    --change the password

    EXEC spmfsettingsForVaultUpdate @Password = 'MotSys123'

    -- It is only necessary to specify the settings that need to change

    DECLARE @RC INT
    DECLARE @Username NVARCHAR(100) = 'MFSQLConnect'
    DECLARE @Password NVARCHAR(100) = 'Connector01'
    DECLARE @NetworkAddress NVARCHAR(100)
    DECLARE @Vaultname NVARCHAR(100) 
    DECLARE @MFProtocolType_ID INT = 1
    DECLARE @Endpoint INT = 2266
    DECLARE @MFAuthenticationType_ID INT = 4
    DECLARE @Domain NVARCHAR(128) 
    DECLARE @VaultGUID NVARCHAR(128)
    DECLARE @ServerURL NVARCHAR(128)
    DECLARE @Debug SMALLINT

    EXECUTE @RC = [dbo].[spMFSettingsForVaultUpdate] @Username
    , @Password
    , @NetworkAddress
    , @Vaultname
    , @MFProtocolType_ID
    , @Endpoint
    , @MFAuthenticationType_ID
    , @Domain
    , @VaultGUID
    , @ServerURL
    , @Debug

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2016-10-12  LC         Update procedure to allow for updating of settings into the new MFVaultSettings Table
2016-08-22  LC         Change settings index
2016-04-20  LC         Created Procedure
==========  =========  ========================================================

