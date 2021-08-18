
=================================
spMFCheckAndUpdateAssemblyVersion
=================================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Debug int (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

The purpose of this procedure is to check  M-Files Version and update the assemblies.

Additional Info
===============

This procedure is normally used in a SQL Agent or powershell utility to schedule to check at least once day.  It can also be run manually at any time, especially after a M-Files upgrade on the SQL server.

This procedure calls spMFGetMFilesAssemblyVersion that will return the M-Files Desktop version on the SQL server.

An entry is made in the table MFupdateHistory when a version change is detected or an error is found.

Take into account the time diffence between M-Files automatically upgrading and the scheduled time for the job as any procedures using the assemblies in this time gap will is likely to fail.

Warnings
========

When the MFversion could not be found the procedure will not attempt to upgrade the assemblies. This will cause the connector to fail.

Examples
========
.. code:: sql

    EXEC spMFCheckAndUpdateAssemblyVersion @debug = 1

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-08-11  LC         Improve control when version could not be found
2020-10-27  LC         Improve error message
2019-08-30  JC         Added documentation
2019-07-25  LC         Add more debug and error trapping, fix issue to prevent update
2019-05-19  LC         Fix bug - insert null value in MFsettings not allowed
2018-09-27  LC         Change procedure to work with Release 4 scripts
2016-12-28  DEV2       Create Procedure
==========  =========  ========================================================

