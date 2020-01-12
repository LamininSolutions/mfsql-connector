
============================
spMFSynchronizeFilesToMFiles
============================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @SourceTableName nvarchar(100)
    fixme description
  @FileUniqueKeyColumn nvarchar(100)
    fixme description
  @FileNameColumn nvarchar(100)
    fixme description
  @FileDataColumn nvarchar(100)
    fixme description
  @MFTableName nvarchar(100)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @TargetFileUniqueKeycolumnName nvarchar(100)
    fixme description
  @BatchSize int
    fixme description
  @Process\_ID int
    fixme description
  @ProcessBatch\_id int (output)
    fixme description
  @Debug int (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======



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
==========  =========  ========================================================

