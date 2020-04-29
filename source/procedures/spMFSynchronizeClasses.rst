
======================
spMFSynchronizeClasses
======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @VaultSettings nvarchar(4000)
    - use fnMFVaultSettings()
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode
  @Out nvarchar(max) (output)
    - XML result
  @IsUpdate smallint (optional)
    - Default = 0
    - 1 = Push updates from SQL to M-Files

Purpose
=======

Internal procedure to synchronize classes
Used by spMFSynchronizeMetadata and spMFSynchronizeSpecificMetadata

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2018-04-04  DEV2       Added Module validation code
2017-12-3   LC         Prevent MFID -100 assignements to be included in update
2017-09-11  LC         Resolve issue with constraints
2016-09-26  DevTeam2   Removed vault settings and pass them as comma separate string in @VaultSettings parameter.
2015-10-01  DevTeam2   Create proc
==========  =========  ========================================================

