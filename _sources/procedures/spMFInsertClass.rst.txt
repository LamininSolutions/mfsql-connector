
===============
spMFInsertClass
===============

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Doc nvarchar(max)
    fixme description
  @isFullUpdate bit
    fixme description
  @Output int (output)
    fixme description
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======

The purpose of this procedure is to insert Class details into MFClass table.

Additional Info
===============

Prerequisites
=============

Warnings
========

Examples
========

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2018-11-10  LC         Add includedinApp update for User Messager table
2018-03-26  DEV2       Workflow required check
2016-03-19  LC         No error for duplicate Report Class
2015-07-20  DEV2       TableName Duplicate Issue Resolved
2015-07-14  DEV2       MFValuelist_ID column removed from MFClass
2015-05-27  DEV2       INSERT/UPDATE logic changed
==========  =========  ========================================================

