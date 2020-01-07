
=============================
spMFSynchronizeValueListItems
=============================

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
  @MFvaluelistID int
    fixme description


Purpose
=======

The purpose of this procedure is to synchronize M-File VALUE LIST ITEM details  

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
2018-05-26  LC         Delete valuelist items that is deleted in MF
2018-04-04  DEV2       Added License module validation code.
2016-26-09  DEV2       Change vault settings
2015-03-02  DEV1       Create proc
==========  =========  ========================================================

