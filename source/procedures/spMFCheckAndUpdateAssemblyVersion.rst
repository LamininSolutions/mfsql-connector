
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

Take into account the time diffence between M-Files automatically upgrading and the scheduled time for the job as any procedures using the assemblies in this time gap will is likely to fail.

Warnings
========

This procedure will fail if the SQL Server and M-Files Server have different M-Files versions.

Examples
========
.. code:: sql

    EXEC spMFCheckAndUpdateAssemblyVersion @debug = 1

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-10-27  LC         Improve error message
2019-08-30  JC         Added documentation
2019-07-25  LC         Add more debug and error trapping, fix issue to prevent update
2019-05-19  LC         Fix bug - insert null value in MFsettings not allowed
2018-09-27  LC         Change procedure to work with Release 4 scripts
2016-12-28  DEV2       Create Procedure
==========  =========  ========================================================

