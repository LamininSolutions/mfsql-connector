
============================
spMFSynchronizeFilesToMFiles
============================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @SourceTableName nvarchar(100)
    Name of source table
  @FileUniqueKeyColumn nvarchar(100)
    column with unique key to reference file
  @FileNameColumn nvarchar(100)
    column name for file name
  @FileDataColumn nvarchar(100)
    column referencing the file content
  @MFTableName nvarchar(100)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @TargetFileUniqueKeycolumnName nvarchar(100)
    property name of unique key in MF
  @BatchSize int
    set manage import in batches
  @Process\_ID int
    process id for referencing the objects in the class table
  @RetainDeletions bit
    - Default = No
    - Set explicity to 1 if the class table should retain deletions
  @IsDocumentCollection
    - Default = No
    - Set explicitly to 1 if the class table refers to a document collection class table
  @ProcessBatch\_id int (output)
    Process batch for the logging
  @Debug int (optional)
    - Default = 0
    - 1 = Standard Debug Mode


Purpose
=======

Procedure to synchronize files from a table to M-Files

Examples
========

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-01-10  LC         Fix bug with file import using GUID as unique ref; improve logging messages
2019-08-30  JC         Added documentation
==========  =========  ========================================================

