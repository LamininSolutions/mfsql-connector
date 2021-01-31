
=========================
spMFSynchronizeProperties
=========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @VaultSettings nvarchar(4000)
    Vault login credentials
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
  @Out nvarchar(max) (output)
    output of spmfInsertProperty
  @IsUpdate smallint
    when set to 1 the procedure will perform full update


Purpose
=======
This is an internal procedure and is part of the metadata synchronisation process

Examples
========

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-04-07  LC         Resolve issue with synchronise properties
2019-08-30  JC         Added documentation
2016-09-26  DevTeam2   Removed vaultsettings parameters and pass them as 
                       comma separated string in @VaultSettings parameter
2018-04-04  DevTeam2   Added License module validation code
==========  =========  ========================================================

