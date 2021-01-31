Importing files from a database
===============================

In this use case we will illustrate how files in Blobs in a database are
imported into M-Files.

This use case is applicable in instances where where the third party
application store files in the database in binary or Blobs formats. The
source database can be SQL server, Oracle or any database accessible to
the MFSQL Connector database.

To perform the operation, one need to have the MFSQL Database File
Connector module, which includes the full Connector package.

In short, the process involves the following after the basic
installation of MFSQL Connector.

-  Identify the table(s) with the files in the third party Database

-  Identify the table(s) with the related metadata for the files in the
   third party Database

-  Prepare a view with all the metadata to be imported and ensure that
   the view at least contains

   -  A unique reference for each file

   -  The name of the file including the file extension

   -  The file data

-  Identify the target class(es) for the files in M-Files

-  Create the Class table for the all the target classes, including the
   depend classes. (e.g. a customer invoice would at least require the
   class for invoice documents, and for customers.)

-  Add the property ‘MFSQL\_File\_Unique\_Ref’ to the target document
   class.

-  Use standard MFSQL Connector methods (described elsewhere) to add
   records in the Document Class Table. Ensure to complete the
   ‘MFSQL\_File\_Unique\_Ref’ for each record which will contain a file.

-  At the same time all the dependent class and valuelist records should
   also be created in MFSQL Connector.

-  After updating the new records in M-Files, set the process\_id for
   all records to have imported file to 6

-  Use spMFSyncchronizeFilesToM-Files to import the files.

-  The history log of the import is saved in MFFileImport

--------------

Step 1: Identify third party file table and create view

.. code:: sql

    ALTER VIEW [scu].[vw_Filedata]
    AS

    SELECT fd.[id]
         , fd.[GUID]
         , fd.[FileName]
         , fd.[FileData]
         , fd.[Created]
         , fd.[Modified_on]
      ,xxx -- All the related columns to the file
        FROM scu.filedata fd
    INNER JOIN [scu].[accounts] AS [a]
    ON [a].[Account_no] = fd.ACCOUNT_ID
    INNER JOIN [scu].[Loans] AS [l]
    ON [l].[Loan_No] = fd.loan_ID

    GO

Step 2: Create class table an update existing records in M-Files. In
this case we will import files for the Drawings class.

.. code:: sql

    EXEC dbo.spMFCreateTable 'Drawing';
    EXEC dbo.spMFUpdateTable 'MFDrawing', 1;

Add the File unique reference column

Step 3:

.. code:: sql

    ALTER TABLE MFDrawing
    ADD  Mfsql_File_Unique_Ref NVARCHAR(100)

Step 4: Create all the new objects in M-Files

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

    EXEC spmfupdatetable 'MFDrawing',0

Step 5: Set the process\_id for records to add files to.

.. code:: sql

    UPDATE t 
     SET Process_ID = 6
    FROM MFDrawing t 
    INNER JOIN Scion32.scu.vw_Filedata AS vf
    ON t.id IS NOT null

Step 6: Import the files

.. code:: sql

    DECLARE @ProcessBatch_id INT;
    EXEC dbo.spMFSynchronizeFilesToMFiles @SourceTableName = 'scion32.scu.vw_Filedata',                -- varchar(100)
                                          @FileUniqueKeyColumn = 'ID',                            -- varchar(100)
                                          @FileNameColumn = 'FileName',                           -- varchar(100)
                                          @FileDataColumn = 'FileData',                           -- varchar(100)
                                         @MFTableName = 'MFDrawing',                               -- varchar(100)
                                          @BatchSize = 500,  
               @Process_ID = 6,                                     -- int
                                          @ProcessBatch_id = @ProcessBatch_id OUTPUT,             -- int
                                          @Debug = 1,                                             -- int
                                          @TargetFileUniqueKeycolumnName = 'mfsql_File_Unique_ref'; -- varchar(100)

Step 7: view the results in SQL

.. code:: sql

    SELECT *
    FROM dbo.MFFileImport;

    SELECT id, name_or_title, MFVersion, FileCount, Single_File, Mfsql_File_Unique_Ref, Process_ID
    FROM dbo.MFDrawing;
