
====================
spMFUpdateAssemblies
====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFilesVersion 
    - Default is null
    - if the @MFilesVersion is null, it will use the value in MFSettings, else it will reset MFSettings with the value
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

Update assemblies when M-Files version changes

Additional Info
===============

This procedure is compiled during installation. The procedure can only be used in the specific database.

Use the @MFilesVersion parameter to reset the MFVersion in MFSettings.  This allows for using this procedure to fix an erroneous version in the MFSettings table

It will use the MFversion in the MFsettings table to drop all CLR procedures, reload all the CLR assemblies, and reload all the CLR Procedures

Examples
========

To update the assemblies based on the MFVersion in MFSettings

.. code:: sql

    Exec spMFUpdateAssemblies

------

To update the assemblies with a different MFVersion or manually update the assemblies

.. code:: sql

    Exec spMFUpdateAssemblies @MFilesVersion = '19.8.8082.5'

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-10-27  LC         Refine error messages and logging
2019-09-27  LC         Add MFilesVersion parameter with default
2019-03-10  LC         Created
==========  =========  ========================================================

