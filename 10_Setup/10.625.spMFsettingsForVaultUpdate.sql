

GO


PRINT SPACE(5) + QUOTENAME(@@SERVERNAME) + '.' + QUOTENAME(DB_NAME()) + '.[dbo].[spMFSettingsForVaultUpdate]';
GO

SET NOCOUNT ON;
EXEC setup.[spMFSQLObjectsControl] @SchemaName = N'dbo',
    @ObjectName = N'spMFSettingsForVaultUpdate', -- nvarchar(100)
    @Object_Release = '3.1.1.34',                -- varchar(50)
    @UpdateFlag = 2;
-- smallint
GO

IF EXISTS
(
    SELECT 1
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'spMFSettingsForVaultUpdate' --name of procedure
          AND ROUTINE_TYPE = 'PROCEDURE' --for a function --'FUNCTION'
          AND ROUTINE_SCHEMA = 'dbo'
)
BEGIN
    PRINT SPACE(10) + '...Stored Procedure: updated';
    --		DROP PROCEDURE dbo.[spMFSettingsForVaultUpdate]
    SET NOEXEC ON;

END;
ELSE
    PRINT SPACE(10) + '...Stored Procedure: create';
GO


-- if the routine exists this stub creation stem is parsed but not executed
CREATE PROCEDURE [dbo].[spMFSettingsForVaultUpdate]
AS
    SELECT 'created, but not implemented yet.';
--just anything will do

GO
-- the following section will be always executed
SET NOEXEC OFF;
GO


ALTER PROCEDURE dbo.spMFsettingsForVaultUpdate
(
    @Username NVARCHAR(100) = NULL,
    @Password NVARCHAR(100) = NULL,
    @NetworkAddress NVARCHAR(100) = NULL,
    @Vaultname NVARCHAR(100) = NULL,
    @MFProtocolType_ID INT = NULL,
    @Endpoint INT = NULL,
    @MFAuthenticationType_ID INT = NULL,
    @Domain NVARCHAR(128) = NULL,
    @VaultGUID NVARCHAR(128) = NULL,
    @ServerURL NVARCHAR(128) = NULL,
	@Debug SMALLINT = 0
)
AS
/*rST**************************************************************************

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

**rST*************************************************************************/

BEGIN

    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT * FROM [dbo].[MFVaultSettings] AS [mvs])
    BEGIN

        INSERT INTO [dbo].[MFVaultSettings]
        (
            [Username],
            [Password],
            [NetworkAddress],
            [VaultName],
            [MFProtocolType_ID],
            [Endpoint],
            [MFAuthenticationType_ID],
            [Domain]
        )
        VALUES
        (   '',              -- Username - nvarchar(128)
            NULL,            -- Password - nvarchar(128)
            N'localhost',    -- NetworkAddress - nvarchar(128)
            N'Sample Vault', -- VaultName - nvarchar(128)
            1,               -- MFProtocolType_ID - int
            2266,            -- Endpoint - int
            4,               -- MFAuthenticationType_ID - int
            N''              -- Domain - nvarchar(128)
        );
    END;

    BEGIN

        DECLARE @Prev_Username NVARCHAR(100),
            @Prev_Password NVARCHAR(100),
            @Prev_NetworkAddress NVARCHAR(100),
            @Prev_Vaultname NVARCHAR(100),
            @Prev_MFProtocolType_ID INT,
            @Prev_Endpoint INT,
            @Prev_MFAuthenticationType_ID INT,
            @Prev_Domain NVARCHAR(128),
            @Prev_VaultGUID NVARCHAR(128),
            @Prev_ServerURL NVARCHAR(128);

        SELECT @Prev_Username = Username,
            @Prev_Password = [Password],
            @Prev_NetworkAddress = NetworkAddress,
            @Prev_Vaultname = VaultName,
            @Prev_MFProtocolType_ID = MFProtocolType_ID,
            @Prev_Endpoint = [Endpoint],
            @Prev_MFAuthenticationType_ID = MFAuthenticationType_ID,
            @Prev_Domain = Domain
        FROM dbo.MFVaultSettings AS MVS;

        SELECT @Prev_VaultGUID = CONVERT(NVARCHAR(128), Value)
        FROM MFSettings
        WHERE Name = 'VaultGUID'
              AND [source_key] = 'MF_Default';

        SELECT @Prev_ServerURL = CONVERT(NVARCHAR(128), Value)
        FROM MFSettings
        WHERE Name = 'ServerURL'
              AND [source_key] = 'MF_Default';

        IF @Debug > 0
            SELECT @Prev_Username AS Username,
                @Prev_Password AS [Password],
                @Prev_NetworkAddress AS NetworkAddress,
                @Prev_Vaultname AS Vaultname,
                @Prev_MFProtocolType_ID AS MFProtocolType_ID,
                @Prev_Endpoint AS [Endpoint],
                @Prev_MFAuthenticationType_ID AS MFAuthenticationType_ID,
                @Prev_Domain AS Domain,
                @Prev_VaultGUID AS VaultGuid,
                @Prev_ServerURL AS ServerURL;



        UPDATE mfs
        SET Username = CASE
                           WHEN @Username <> @Prev_Username
                                AND @Username IS NOT NULL THEN
                               @Username
                           ELSE
                               @Prev_Username
                       END,
            NetworkAddress = CASE
                                 WHEN @NetworkAddress <> @Prev_NetworkAddress
                                      AND @NetworkAddress IS NOT NULL THEN
                                     @NetworkAddress
                                 ELSE
                                     @Prev_NetworkAddress
                             END,
            VaultName = CASE
                            WHEN @Vaultname <> @Prev_Vaultname
                                 AND @Vaultname IS NOT NULL THEN
                                @Vaultname
                            ELSE
                                @Prev_Vaultname
                        END,
            MFProtocolType_ID = CASE
                                    WHEN @MFProtocolType_ID <> @Prev_MFProtocolType_ID
                                         AND @MFProtocolType_ID IS NOT NULL THEN
                                        @MFProtocolType_ID
                                    ELSE
                                        @Prev_MFProtocolType_ID
                                END,
            [Endpoint] = CASE
                             WHEN @Endpoint <> @Prev_Endpoint
                                  AND @Endpoint IS NOT NULL THEN
                                 @Endpoint
                             ELSE
                                 @Prev_Endpoint
                         END,
            MFAuthenticationType_ID = CASE
                                          WHEN @MFAuthenticationType_ID <> @Prev_MFAuthenticationType_ID
                                               AND @MFAuthenticationType_ID IS NOT NULL THEN
                                              @MFAuthenticationType_ID
                                          ELSE
                                              @Prev_MFAuthenticationType_ID
                                      END,
            Domain = CASE
                         WHEN @Domain <> @Prev_Domain
                              AND @Domain IS NOT NULL THEN
                             @Domain
                         ELSE
                             @Prev_Domain
                     END
        FROM MFVaultSettings mfs;

        IF @Debug > 0
            SELECT CASE
                       WHEN @VaultGUID IS NOT NULL
                            AND @VaultGUID <> @Prev_VaultGUID THEN
                           CONVERT(SQL_VARIANT, @VaultGUID)
                       ELSE
                           CONVERT(SQL_VARIANT, @Prev_VaultGUID)
                   END AS VaultGUID;

        UPDATE [dbo].[MFSettings]
        SET Value = CASE
                        WHEN @VaultGUID IS NOT NULL
                             AND @VaultGUID <> @Prev_VaultGUID THEN
                            CONVERT(SQL_VARIANT, @VaultGUID)
                        ELSE
                            CONVERT(SQL_VARIANT, @Prev_VaultGUID)
                    END
        WHERE Name = 'VaultGUID'
              AND [source_key] = 'MF_Default';

        IF @Debug > 0
            SELECT CASE
                       WHEN @ServerURL <> @Prev_ServerURL
                            AND @ServerURL IS NOT NULL THEN
                           CONVERT(SQL_VARIANT, @ServerURL)
                       ELSE
                           CONVERT(SQL_VARIANT, @Prev_ServerURL)
                   END;


        UPDATE [dbo].[MFSettings]
        SET Value = CASE
                        WHEN @ServerURL <> @Prev_ServerURL
                             AND @ServerURL IS NOT NULL THEN
                            CONVERT(SQL_VARIANT, @ServerURL)
                        ELSE
                            CONVERT(SQL_VARIANT, @Prev_ServerURL)
                    END
        WHERE Name = 'ServerURL'
              AND [source_key] = 'MF_Default';


        IF @Password IS NOT NULL
        BEGIN



            DECLARE @EncryptedPassword NVARCHAR(250);
            DECLARE @PreviousPassword NVARCHAR(100);


            SELECT TOP 1
                @PreviousPassword = [Password]
            FROM dbo.MFVaultSettings s;

            IF @Debug = 1
                SELECT @EncryptedPassword AS '@EncryptedPassword',
                    @PreviousPassword AS '@PreviousPassword';

            IF @PreviousPassword IS NULL
                EXEC [dbo].[spMFEncrypt] @Password = N'null', -- nvarchar(2000)
                    @EcryptedPassword = @PreviousPassword OUTPUT; -- nvarchar(2000);


            EXEC [dbo].[spMFDecrypt] @EncryptedPassword = @PreviousPassword, -- nvarchar(2000)
                @DecryptedPassword = @PreviousPassword OUTPUT; -- nvarchar(2000)
        END;

        IF @Password IS NOT NULL
           AND @Password <> @PreviousPassword
        BEGIN

            EXECUTE dbo.spMFEncrypt @Password, @EncryptedPassword OUT;

            UPDATE s
            SET [s].[Password] = @EncryptedPassword
            FROM dbo.MFVaultSettings s;


        END;
    END;


    RETURN 1;
END;


GO
