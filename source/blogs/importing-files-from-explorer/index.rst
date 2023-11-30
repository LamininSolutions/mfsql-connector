Importing files into M-Files
============================


.. toctree::
   :maxdepth: 2

   import-file-example/index

Files from explorer
-------------------
This blog demonstrates how to use the procedure to import a file or files from explorer to the objid referenced in parameter.  It also includes a full example of real life procedure including this routine into its wider framework.

The object can be created in M-Files using MFSQL Connector at the same time as importing the file. If another file is added to a single file object, it would automatically be converted to a multifile object. It may help to refresh the M-Files view or the object with F5 after running procedure to update the object to the latest version when checking if the import was successful in M-Files.

 -  The file location should point to the folder of the file to be imported
 -  Set IsFileDelete param = 1 if the file must be deleted after import
 -  Check the table MFFileImport for the results of the import

The Folder export utility :doc:`/getting-started/configuration-and-setup/setup-powershell-utilities/index` can be used to extract the folder information from explorer into a staging table in the database 

.. code:: sql

  DECLARE @ProcessBatch_id INT;
  DECLARE @FileLocation NVARCHAR(256) = 'C:\Share\Fileimport\2\'
  DECLARE @FileName NVARCHAR(100) = 'CV - TommyS Hart.docx'
  DECLARE @TableName NVARCHAR(256) = 'MFOtherDocuments'
  DECLARE @SQLID INT = 1

  EXEC [dbo].[spMFUpdateExplorerFileToMFiles] 
    @FileName = @FileName
    ,@FileLocation = @FileLocation 
    ,@MFTableName = @TableName
    ,@SQLID = @SQLID  
    ,@ProcessBatch_id = @ProcessBatch_id OUTPUT      
    ,@Debug = 101      
    ,@IsFileDelete = 0

   SELECT * from [dbo].[MFFileImport] AS [mfi]

Files from Blobs in a database
------------------------------

Uploading blob files involves
 -  having a DB with all the files and source metadata. This could be a pre-existing third party application, or one can upload files from explorer into a temp db as part of the data refinement process and preparing the data for import, and then use MFSQL to import the data.

 -  using MFSQL to extract the blob files and associate the files with metadata

Updating M-Files from a Blob can be used to create a new file object, add a new file to an existing object, and update an existing file on an existing object.

These illustrations are using the drawings document object in MF Sample Vault and another database Scion with the blob data

Reviewing and updating the target objects

.. code:: sql

    EXEC dbo.spMFCreateTable 'Drawing';
    EXEC dbo.spMFUpdateTable 'MFDrawing', 1;

    SELECT * FROM dbo.MFClass;
    SELECT * FROM dbo.MFDrawing;

.. :note: 

   that this table does not have the required MFSQL properties. the properties can be added on the metadata card, or using SQL

.. code:: sql

   ALTER TABLE MFDrawing
   ADD  Mfsql_File_Unique_Ref NVARCHAR(100)

   SELECT * FROM mfproperty WHERE [ColumnName]   = 'Mfsql_File_Unique_Ref' 

Review the folder that will be use as the temporary file export folder.

.. code:: sql

   SELECT * FROM mfsettings WHERE name = 'FileTransferLocation'

The basic requirement to get the blobs from the external database is that each image must have a unique reference in the external table

view the image source file in external database

.. code:: sql

   SELECT * FROM Scion.scu.vw_Filedata AS vf
   WHERE id = 22
   ORDER BY vf.id; 

It is good practice to create a view to get the file data and blob from the external tables

.. code:: sql

   SELECT * FROM filedata.dbo.FileIndex_FileData AS fifd


Illustration 1:  Adding file to existing object in M-Files
-------------------------------------------------------------

The file id in the foreign table is used as the unique reference to the file. This id to the target drawing object in M-Files.

.. code:: sql

   UPDATE dbo.MFDrawing
   SET Process_ID = 6
   , Mfsql_File_Unique_Ref = '10742'  
   WHERE ID = 21;

Then import the file from the blob

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
   @Debug = 101 ,
   @TargetFileUniqueKeycolumnName = 'mfsql_File_Unique_ref'; 

View the import history table and the result in the drawings class table

.. code:: sql

    SELECT *
    FROM dbo.MFFileImport; 

    SELECT id, name_or_title, MFVersion, FileCount, Single_File, mfsql_File_Unique_ref, *
    FROM dbo.MFDrawing WHERE id = 21;

    SELECT * FROM [dbo].[MFProcessBatchDetail] AS [mpbd] WHERE [mpbd].[ProcessBatch_ID] = @ProcessBatch_ID

Illustrstion 2: Adding an image and metadata from source file 
-------------------------------------------------------------

step 1: add new records in the target class with the associated file reference and metadata

.. code:: sql

    INSERT INTO dbo.MFDrawing
    (
    Mfsql_File_Unique_Ref,
    Keywords,
    Name_Or_Title,
    Process_ID
    )
    SELECT vf.id,
       'InsertFiles',
       vf.FileName,
       1
    FROM Scion32.scu.vw_Filedata AS vf;

step 2: Insert new records into MF

.. code:: sql

   EXEC spmfupdatetable 'MFDrawing',1

Step 3 set process_id = 6 for the class items with files

.. code:: sql

   UPDATE t 
   SET Process_ID = 6
   FROM MFDrawing t 
   INNER JOIN Scion32.scu.vw_Filedata AS vf
   ON t.id IS NOT null

Step 4: Update Records into M-Files

.. code:: sql

   DECLARE @ProcessBatch_id INT;
   EXEC dbo.spMFImportBlobFilesToMFiles @SourceTableName = 'scion32.scu.vw_Filedata',                -- varchar(100)
                                      @FileUniqueKeyColumn = 'ID',                            -- varchar(100)
                                      @FileNameColumn = 'FileName',                           -- varchar(100)
                                      @FileDataColumn = 'FileData',                           -- varchar(100)
                                     @MFTableName = 'MFDrawing',                               -- varchar(100)
                                      @BatchSize = 500,  
									  @Process_ID = 6,                                     -- int
                                      @ProcessBatch_id = @ProcessBatch_id OUTPUT,             -- int
                                      @Debug = 1,                                             -- int
                                      @TargetFileUniqueKeycolumnName = 'mfsql_File_Unique_ref'; -- varchar(100)

   SELECT *
   FROM dbo.MFFileImport;
   SELECT id, name_or_title, MFVersion, FileCount, Single_File, Mfsql_File_Unique_Ref, Process_ID
   FROM dbo.MFDrawing;

   SELECT *
   FROM dbo.MFProcessBatchDetail AS mpbd
   WHERE mpbd.ProcessBatch_ID = @ProcessBatch_id;

