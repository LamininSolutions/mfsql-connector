
=======================
spMFInsertClassProperty
=======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Doc nvarchar(max)
    XML data
  @isFullUpdate bit
    flag from calling procedure
  @Output int (output)
    output status
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

To insert Class property details into MFClassProperty table.  This is procedure is used internally only

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-12-23  LC         Add class as a property 100
2019-08-30  JC         Added documentation
2017-09-11  LC         Resolve issue with constraints
2015-04-07  DEV2       Resolved synchronization issue (Bug 55)
==========  =========  ========================================================

