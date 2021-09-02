
==============================
spMFUpdateExplorerFileToMFiles
==============================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @FileName nvarchar(256)
    Name of file
  @FileLocation nvarchar(256)
    UNC path or Fully qualified path to file
  @MFTableName nvarchar(100)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @SQLID int
    the ID column on the class table
  @IsFileDelete bit (optional)
    - Default = 0
    - 1 = the file should be deleted in folder
  @ProcessBatch\_id int (output)
    Output ID in MFProcessBatch for logging the process
  @Debug int (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

MFSQL Connector file import provides the capability of attaching a file to a object in a class table.

Additional Info
===============

This functionality will:

- Add the file to an object.  If the object exist as a multidocument object with no files attached, the file will be added to the multidocument object and converted to a single file object.  If the files already exist for the object, the file will be added to the collection.
- The object must pre-exist in the class table. The class table metadata will be applied to object when adding the file. This procedure will add a new object from the class table, or update an existing object in M-Files using the class table metadata.
- The source file will optionally be deleted from the source folder.

The procedure will not automatically change a multifile document to a single file document. To set an object to a single file object the column 'Single_File' can be set to 1 after the file has been added.

Warnings
========

The procedure use the ID in the class table and not the objid column to reference the object.  This allows for referencing an record which does not yet exist in M-Files.

Examples
========

.. code:: sql

    DECLARE @ProcessBatch_id INT;
    DECLARE @FileLocation NVARCHAR(256) = 'C:\Share\Fileimport\2\'
    DECLARE @FileName NVARCHAR(100) = 'CV - Tommy Hart.docx'
    DECLARE @TableName NVARCHAR(256) = 'MFOtherDocument'
    DECLARE @SQLID INT = 1

    EXEC [dbo].[spMFUpdateExplorerFileToMFiles]
        @FileName = @FileName
       ,@FileLocation = @FileLocation
       ,@SQLID = @SQLID
       ,@MFTableName = @TableName
       ,@ProcessBatch_id = @ProcessBatch_id OUTPUT
       ,@Debug = 0
       ,@IsFileDelete = 0

    SELECT * from [dbo].[MFFileImport] AS [mfi]

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-08-03  LC         Fix truncate string bug
2021-05-21  LC         improve handling of files on network drive
2020-12-31  LC         Improve error handling in procedure
2020-12-31  LC         Update datetime handling in mffileexport
2019-08-30  JC         Added documentation
==========  =========  ========================================================

