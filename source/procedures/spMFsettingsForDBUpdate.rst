
=======================
spMFsettingsForDBUpdate
=======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFInstallationPath nvarchar(128)
    - Path where M-Files is installed on SQL server
    - Default assigned by installer 'C:\Program Files\M-Files'
  @MFilesVersion nvarchar(128)
    - M-Files version deployed on SQL server
    - Format '11.2.4320.51'
  @AssemblyInstallationPath nvarchar(128)
    - Path where the Laminin Assemblies have been copied to.
    - Default assigned by installer 'C:\MFSQL\Assemblies'
  @SQLConnectorLogin nvarchar(128)
    - SQL login user for the Connector
    - Default assigned by installer 'MFSQLConnect'
  @UserRole nvarchar(128)
    - Role for SQL user
    - Default assigned by installer 'AppUserRole'
  @SupportEmailAccount nvarchar(128)
    - Email to receive system error emails
    - Default assigned by installer 'support@lamininsolutions.com', semi colon separated for multiple emails
    - Depended on installing Database Mail
  @EmailProfile nvarchar(128)
    - DBMail profile to be used for emails
    - Default assigned by installer 'LSEmailProfile'
    - Depended on Database Mail installation
  @DetailLogging nvarchar(128)
    - 1 = include detail logging
    - Default of 1 assigned by installer
  @UserMessageEnabled nvarchar(128)
    - 1 = messages enabled
	- Default is set to 0 - not enabled
  @DBName nvarchar(128)
    - Connector database name
    - Assigned by installer
  @RootFolder nvarchar(128)
    - Base folder for exporting of files
    - Default assigned by installer 'C:\MFSQL\FileExport'
  @FileTransferLocation nvarchar(128)
    - Base folder for importing files
    - Default assigned by installer 'C:\MFSQL\FileImport'
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======

Procedure to allow updating of specific settings in the MFSettings table

Additional Info
===============

Include only the the items that need to be changed.
Refer to MFSettings for more information on the use of the settings.

Prerequisites
=============

Email functions is dependent on Database Mail being installed.

Warnings
========

Settings have an impact throughout the Connector.

Examples
========

.. code:: sql

    EXEC [spMFSettingsForDBUpdate]  @SupportEmailAccount = 'YourEmailAccount'
    select * from mfsettings where name = 'SupportEmailRecipient'

.. code:: sql

    DECLARE @RC int
    DECLARE @MFInstallationPath nvarchar(128)
    DECLARE @MFilesVersion nvarchar(128) 
    DECLARE @AssemblyInstallationPath nvarchar(128)
    DECLARE @SQLConnectorLogin nvarchar(128)
    DECLARE @UserRole nvarchar(128)
    DECLARE @SupportEmailAccount nvarchar(128) = 'mfsql@lamininsolutions.com'
    DECLARE @EmailProfile nvarchar(128)
    DECLARE @DetailLogging nvarchar(128)
    DECLARE @DBName nvarchar(128)
    DECLARE @RootFolder nvarchar(128)
    DECLARE @FileTransferLocation nvarchar(128)
    DECLARE @Debug smallint

    EXECUTE @RC = [dbo].[spMFSettingsForDBUpdate] 
    @MFInstallationPath
    ,@MFilesVersion
    ,@AssemblyInstallationPath
    ,@SQLConnectorLogin
    ,@UserRole
    ,@SupportEmailAccount
    ,@EmailProfile
    ,@DetailLogging
    ,@DBName
    ,@RootFolder
    ,@FileTransferLocation
    ,@Debug

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-11-27  LC         Add parameter for setting User message enabled
2019-08-30  JC         Added documentation
2018-04-28  LC         Add user message setting; vault structure setting
2018-02-16  LC         Add file import and export change setting
2017-11-23  LC         Resolve bug for missing value
2017-09-02  LC         Add RootFolder setting
2016-08-22  LC         Change Settings index
==========  =========  ========================================================

