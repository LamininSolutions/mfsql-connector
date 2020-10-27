
============================
spMFGetMFilesAssemblyVersion
============================

Return
  - 1 = Success
  - 0 = Error
Parameters
  @IsUpdateAssembly bit (output)
    - Default = 0
    - Returns 1 if M-Files version on the M-Files Server is different from MFSettings
  @MFilesVersion varchar(100) (output)
    - Returns M-Files version on the M-Files Server


Purpose
=======

The purpose of this procedure is to validate the M-Files version and return 1 if different

Additional Info
===============

Used by other procedures.


Warnings
========

This procedure returns to M-Files Version on the SQL Server
When the procedure to update the assemblies fail, the CLR will have been deleted with reinstatement. When this happens the MFiles version must be updated manually in MFSettings table.

Examples
========

.. code:: sql

    Declare @rt int, @MFilesVersion nvarchar(25)
    Exec @rt = spMFGetMFilesAssemblyVersion @MFilesVersion = @MFilesVersion output
    Select @rt, @MFilesVersion

    Select * from MFsettings where name = 'MFVersion'

    UPDATE [dbo].[MFSettings]
    SET value = '19.8.8114.8' WHERE name = 'MFVersion'

    Exec spMFUpdateAssemblies

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-06-29  LC         Review logic the check and update MFVersion
2020-02-10  LC         New CLR procedure to get MFVersion from local machine
2019-09-17  LC         Update documentation
2019-09-17  LC         Improve error trapping, add MFlog msg
2019-09-17  LC         Add condition to deal with scenario where CLR has been deleted
2019-08-30  JC         Added documentation
2019-05-19  LC         Block print of result
2018-09-27  LC         Remove licensing check. this procedure is excecuted before license is active
2018-04-04  DEV2       Added Licensing module validation code.
2015-03-27  DEV2       Create procedure
==========  =========  ========================================================

