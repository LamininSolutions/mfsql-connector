
==============================
spMFSynchronizeWorkflowsStates
==============================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @VaultSettings nvarchar(4000)
    fixme description
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode
  @Out nvarchar(max) (output)
    fixme description
  @IsUpdate smallint
    fixme description


Purpose
=======

Called by other procedures to sync workflow states


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2023-07-29  LC         Improve logging and productivity
2019-08-30  JC         Added documentation
2018-04-04  DevTeam2   Added License module validation code 
2016-09-26  DevTeam2   Update @VaultSettings parmeter.
2018-11-15	LC         remove logging
2015-03-15  DEV        Create Procedure
==========  =========  ========================================================

