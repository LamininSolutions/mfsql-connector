
=================
spMFGetDataExport
=================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ExportDatasetName nvarchar(2000)
    fixme description
  @Debug int (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

To export the dataset.

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2018-04-04  DEV2       Added License module validation code
2016-10-11  LC         Change of Settings Tablename
2016-09-26  DEV2       Removed vault settings parameters and pass them as comma separated string in @VaultSettings parameter
==========  =========  ========================================================

