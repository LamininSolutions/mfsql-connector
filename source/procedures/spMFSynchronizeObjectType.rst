
=========================
spMFSynchronizeObjectType
=========================

Parameters
  @VaultSettings
    - use fnMFVaultSettings()
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode
  @Out (Output)
    - XML result
  @IsUpdate (Optional)
    - Default = 0
    - 1 = Push updates from SQL to M-Files

Purpose
=======

Internal procedure to synchronize ObjectTypes
Used by spMFSynchronizeMetadata and spMFSynchronizeSpecificMetadata

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2018-04-04  Dev2       Added License module validation code.
2016-09-26  Dev2       Removed Vault Settings parameters and pass them as comma separated string in single parameter
==========  =========  ========================================================

