
==========================
spMFSynchronizeUserAccount
==========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @VaultSettings nvarchar(4000)
    pass in @fnmfvaultsettings
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
  @Out nvarchar(max) (output)
    listing of user accounts from MF for the vault


Purpose
=======

Procedure is used in other procedures

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2023-10-12  LC         Change to update insert of rows and consolidate procedures
2019-08-30  JC         Added documentation
2016-09-26  DevTean2   Removed vault settings parameters and pass them as comma separated string in @VaultSettings parameter.
2018-04-04  DevTeam    Addded License module validation code
==========  =========  ========================================================

