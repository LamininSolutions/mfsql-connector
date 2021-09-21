
=====================
spMFDeploymentDetails
=====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Int (optional)
    used as input variable to set the type of update message
     0 - default message
     -1 - Failed
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

Print deployment details

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-09-11  LC         Add parameter to set type of update
2019-08-30  JC         Added documentation
==========  =========  ========================================================

