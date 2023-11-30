
=======================
spMFInsertWorkflowState
=======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Doc nvarchar(max)
    fixme description
  @Output int (output)
    fixme description
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======

To insert Workflow State details into MFWorkflowState table.

This procedure is called by other procedures

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2023-07-29  LC         Improve logging and productivity
2019-08-30  JC         Added documentation
2019-03-08  DEV2       Add insert updatecolumn
2017-07-02  LC         Change aliase datatype to varchar(100); Edit TRANS loop
==========  =========  ========================================================

