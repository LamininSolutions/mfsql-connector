
===========================
spMFImportBlobFilesToMFiles
===========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @SourceTableName
   -  Fully qualified name of the table or view for the blob data.
  @FileUniqueKeyColumn
   -  Unique reference in blob table to reference the file to be imported. Th value in this column must corresponde with the value in the column set in @TargetFileUniqueKeycolumnName on the class table
  @FileNameColumn
   -  Name of column in blob table referencing the file name
  @FileDataColumn
   -  Name of column in blob table referencing the blob file in bit format
  @MFTableName
   - Target class tablename
  @TargetFileUniqueKeycolumnName
   - Property in class table for unique file reference of blob file
   - mfsql_File_Unique_ref is added by the installation package and can be used for this purpose
  @BatchSize (optional)
   - set batchsize for importing of files
   - default = 500
  @Process_id (required)
   - recommended to set to 6
   - set process_id for the targeted records for import on the class table prior to running this procedure
  @ProcessBatch_id (optional) OUTPUT
   - Referencing the ID of the ProcessBatch logging table
  @Debug (optional)
   - Default = 0
   - 1 = Standard Debug Mode

Purpose
=======

This procedure will get a blob file from a designated table and import the file to a object in the class table

Additional Info
===============

Uploading blob files involve
 #. having a DB with all the files and source metadata. This could be a pre-existing third party application, or one can upload files from explorer into a temp db as part of the data refinement process and preparing the data for import, and then use MFSQL to import the data.

 #. using MFSQL to extract the blob files and associate the files with metadata

The import history is in the table MFFileImport

Prerequisites
=============

The file source table as columns for a unique reference for each row, the file name and the blob data in bit format.
The class table has a column (the default property is Mfsql_File_Unique_Ref ) 
This column includes a reference that is a unique one to one relation to the file source table for every row that must import a file
The process_id column for the rows in the class table to be included in the import is set to 6

The import will be performed in batches of 500

Examples
========

.. code:: sql

   DECLARE @Processbatch_id int
   EXEC dbo.spMFImportBlobFilesToMFiles @SourceTableName = 'filedata.dbo.[FileIndex_FileData]',               
                                     @FileUniqueKeyColumn = 'SerialNumber', 
                                     @FileNameColumn = 'NameFile', 
                                     @FileDataColumn = 'Chart', 
                                     @MFTableName = 'MFDrawing',
                                     @BatchSize = 500,   
									 @Process_id = 6,  
                                     @ProcessBatch_id = @ProcessBatch_id OUTPUT, 
                                     @Debug = 0 , 
                                     @TargetFileUniqueKeycolumnName = 'mfsql_File_Unique_ref'; 

----

View import result

.. code:: sql

    SELECT * FROM dbo.MFFileImport

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-08-22  LC         Update code to include handling of new deleted column
2020-05-13  LC         Reset the procedure and issue as new
==========  =========  ========================================================

