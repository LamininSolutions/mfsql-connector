
=================
spMFDeleteHistory
=================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @DeleteBeforeDate
    - earliest date for retention of logs

Purpose
=======

The purpose of this procedure is to delete all records in MFlog,MFUpdateHistory,MFAuditHistory till the given date  
Additional Info
===============

This procedure is built into an agent to run it on a schedule

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-09-12  LC         Add documentation
2016-11-10  LC         Add ProcessBatch and ProcessBatchDetail to delete
==========  =========  ========================================================

