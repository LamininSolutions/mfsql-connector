
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

This procedure is used in the Agent to automatically update the assemblies

Prerequisites
=============

M-Files version on SQL Server is the same as M-Files Server

Warnings
========

This procedure will fail if the SQL Server and M-Files Server have different M-Files versions.

Examples
========
.. code:: sql

    EXEC spMFCheckAndUpdateAssemblyVersion

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2019-07-25  LC         Add more debug and error trapping, fix issue to prevent update
2019-05-19  LC         Fix bug - insert null value in MFsettings not allowed
2018-09-27  LC         Change procedure to work with Release 4 scripts
2016-12-28  DEV2       Create Procedure
==========  =========  ========================================================

