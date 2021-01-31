
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

This procedure returns the M-Files Version on the SQL Server
When the procedure to update the assemblies fail, the CLR will have been deleted with reinstatement. When this happens the MFiles version must be updated manually in MFSettings table.

Examples
========

Get installed version of M-Files in SQL Server

.. code:: sql

    Declare @IsUpdateAssembly int, @MFilesVersion nvarchar(25)
    Exec spMFGetMFilesAssemblyVersion @IsUpdateAssembly = @IsUpdateAssembly output, @MFilesVersion = @MFilesVersion output
    Select @IsUpdateAssembly as IsUpdateRequired, @MFilesVersion as InstalledVersion

------

Get M-files version installed in Connector

.. code:: sql

   Select *
   from MFsettings
   where name = 'MFVersion'

------

Manually update the version in the Connector. Set the parameter to current installed version on the SQL server.

.. code:: sql

    Exec spMFUpdateAssemblies @MFilesVersion = '20.9.9430.5'

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-10-27  LC         Show error when CLR is not found
2020-10-27  LC         Improve error messages
2020-06-29  LC         Review logic to check and update MFVersion
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

