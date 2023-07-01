Working with files
==================

The connector provides a number of different ways to work with the file
documents in M-Files. 

#. **Import files into M-Files** from another database where the files are stored as blob or from a file location in explorer.
#. The primary focus of the connector is to work with the **metadata related to the files**.  The class table has the following columns specifically related to files.

   - SingleFile:  this column show if the object is a single or multi-file object.
   - FileCount: This column show the number of files in the multi-file object

#. **Export of files from M-Files**:  Export files from any class table to a designated folder on the SQL server.  :doc:`/tables/tbMFExportFileHistory` table references the exported files to allow for further processing such as using the files as an attachment to an email.  This functionality can be used to export files to explorer to create an extract of all the files in the vault.
#. **Use FolderExport v3 for bulk file imports** to generate a CSV file that can be used with M-Files Importing tool to import files and map them to the metadata with the Connector.
#. **Use the properties related to files** Export files as above and set the IsDownload parameter to 0 to only download file information without downloading the files. The data about the file (extention, file size, name) in the  :doc:`/tables/tbMFExportFileHistory` table can then be used in reporting or analysis 

Importing files from explorer
-----------------------------

The main use of this feature is create or update a record in the class
table and associate a file or files from explorer at the same time.

The procedure :doc:`/procedures/spMFUpdateExplorerFileToMFiles` allows for importing a file or files from explorer into M-Files. In simple terms an explorer file is matched with the record in the class table and imported into M-Files. The results are logged in the :doc:`/tables/tbMFFileImport` table

-  The object can be created in M-Files using MFSQL Connector at the same time as importing the file.
-  If another file is added to a single file object, it would automatically be converted to a multifile document
-  If a file is added to a empty multifile document, it would automatically change it to a single file object.
-  The file in M-Files will be overwritten If the file already exists for the specific object

Prerequisites for the spMFUpdateExplorerFiletoMFiles routine are:

- New or existing record in Class table - @SQLID parameter refers to the id of the record. The record must pre-exist in the class table.   There is no need to pre-update M-Files with a new record. This routine will automatically create the object in M-Files if it does not exist.
- Filename of the file to be imported - @fileName
- folder path of the file - @Filelocation. This location must be on the SQL server, preferably use the location c:/MFSQL/FileImport with sub folders.
- Class table name - @TableName

The routine will use the SQL Server security context to access files on the network. It is therefore important to ensure that the SQL Server login has access to the network folders.  Setup the SQL server to login as a service account that has access to the folders.  If the procedure is call by an agent, then the SQL Server agent login account must also have access to the folders. Alternatively certificates and proxies can be used to setup the agent security context.

SpMFUpdateExplorerFiletoMFiles processes one file for one record at a time.  To process a series of files and records one would create a loop to run through all the records and related file references. This can be accomplished in different ways, the choice of which will depend on the source of the files and data to be imported.

-  A Powershell utility for :doc:`/getting-started/configuration-and-setup/setup-powershell-utilities/index`  is available in the addons of MFSQL Connector as FolderExport_v3 to import file and folder data from explorer to CSV or staging tables. This utility exposes the contents of the file system to SQL to get the location of the file and file name for the import routine.

-  Sometimes the third party system have a reference to the file and location of the file. this data, combined with the record in the
   class table will setup the loop for calling the importing routine.

The following importing scenarios apply:

-  If the file already exist for the object then the existing file in M-Files will be overwritten. M-Files version control will record the prior version of the record.
-  If the object is new in the class table (does not yet have a objid and guid) then the object will first be created in M-Files and then the file will be added.
-  If the object in M-Files is a multifile document with no files, then the object will be converted to a single file object.
-  if the object in M-files already have a file or files, then it would convert to a multifile object and the additional file will be added 
-  If the filename or location of the file cannot be found, then a error will be added in the filerror column in the MFFileImport Table.
-  If the parameter option @IsFileDelete is set to 1, then the originating file will be deleted. The default is to not delete.
-  The Importing of files using spMFUpdateExplorerFileToMFiles will list all the files imported, or rejected in the MFMfileImport table. The results of each file import is shown in the column ImportError.

   |image0|

The following example illustrates importing a single file to an object.

.. code:: sql

    DECLARE @ProcessBatch_id INT;
    DECLARE @FileLocation NVARCHAR(256) = 'C:\Share\Fileimport\2\'
    DECLARE @FileName NVARCHAR(100) = 'CV - Tommy Hart.docx'
    DECLARE @TableName NVARCHAR(256) = 'MFOtherDocument'
    DECLARE @SQLID INT = 1

     EXEC [dbo].[spMFUpdateExplorerFileToMFiles]
     @FileName = @FileName
     ,@FileLocation = @FileLocation
     ,@MFTableName = @TableName
     ,@SQLID = @SQLID
     ,@ProcessBatch_id = @ProcessBatch_id OUTPUT
     ,@Debug = 0
     ,@IsFileDelete = 0

.. code:: sql

    SELECT * from [dbo].[MFFileImport] AS [mfi]

Importing files from a database
---------------------------------

In this use case we will illustrate how files in Blobs in a database are imported into M-Files. This use case is applicable in instances where the third party application store files in the database in binary or Blobs formats. This method will allow for a file that is stored in a database that is accessible as a view or table in MFSQL Connector database to be extracted and imported into M-Files.  There is a number of key elements and pre-requisites to set this up.

      -  A new text property with the name  Mfsql_File_Unique_Ref is added to the metadata of the target class.  For instance, if image files will be imported into the Drawing Class in M-Files then  Mfsql_File_Unique_Ref must be added in M-Files as a property and added to the Drawing Class in M-Files.
      -  Note the setting in MFSettings for the location of the temporary folder on the SQL server to be used during the processing of the file transfer.  The procedure will temporarily save the file in this folder, and then use M-Files API's to import the file into M-Files and link it with the metadata.
      -  A table or view must exist with the following minimum columns
         -  The Image in a blob format. This is usually a data type of bit or nvarchar(max)
         -  The name of the file
         -  A unique reference for the image

      -  Add or update the record to be updated in the MFSQL Connector class table by updating the Mfsql_File_Unique_Ref column and any additional metadata to be added / updated for the record. This is usually done by having a select statement with a join between all the related data in the image file database to extract all the relevant data from the third party database. Set the process_id of the table to 6 or higher.
      -   Execute :doc:`/procedures/spMFSynchronizeFilesToMFiles`

         -  if the record in the class table is new, a new single file object will be created in M-Files with the relevant metadata
         -  if the record exist and the file is new, the record will be set as a multi file document and the new file will be added.  A new file is where name of the file is different from another file in the multi-files of the specific object
         -  If the record exist and there is already a file in the multi-file document with the same name, then to file in M-Files will be overwritten.

      -  The procedure will allow for specifying the size of the batches to be imported. This will allow for importing larger volumes of files in segments. 

Following illustrate the code for the process following after the basic installation of MFSQL Connector.

Step 1: Identify the table(s) with the files and related data in the third and create view to access the key columns: unique identifier (e.g. GUID), filename, and file data plus additional information to related to the data. In the example below the accounts and loan data is mapped to the filedata table where the blob is stored

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

Step 2: Identify the target class(es) for the files in M-Files and create class table(s). Then update the records from M-Files for all related data. (e.g. a customer account invoice would at least require the class for invoice documents, and for customers.) In this case we will import files to the Invoices class and update the customers class. Add the property ‘MFSQL\_File\_Unique\_Ref’ to the target document class (Invoice in this case). The property for the unique reference will be used to link the imported file to the object in M-Files

.. code:: sql

    EXEC dbo.spMFCreateTable 'Invoice';
    EXEC dbo.spMFUpdateTable 'MFInvoice', 1;

Step 3: Use the Connector to add new objects in the class table. Ensure to complete the ‘MFSQL\_File\_Unique\_Ref’ for each record which will contain a file from the external system.  Ensure that the unique reference in the external data and in the object matches. At the same time all the dependent class and valuelist records should also be created updated to complete the updating of the metadata for the file object and its related data from the external system.

To add the unique reference to the class table

.. code:: sql

    ALTER TABLE MFInvoice
    ADD  Mfsql_File_Unique_Ref NVARCHAR(100)

To update the metadata for the Invoice

.. code:: sql

    INSERT INTO dbo.MFInvoice
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

    EXEC spmfupdatetable 'MFInvoice',0

Step 4: Set the process\_id = 6 for records with files.  This is to identify the records in the class to get the file blobs from the external source

.. code:: sql

    UPDATE t
     SET Process_ID = 6
    FROM MFInvoice t
    INNER JOIN Scion32.scu.vw_Filedata AS vf
    ON t.id IS NOT null

Step 5: Finally,import the files using the procedure :doc:`/procedures/spMFSynchronizeFilesToMFiles`. The import will be performed in batches of 500

.. code:: sql

    DECLARE @ProcessBatch_id INT;
    EXEC dbo.spMFSynchronizeFilesToMFiles 
        @SourceTableName = 'scion32.scu.vw_Filedata',
        @FileUniqueKeyColumn = 'ID',
        @FileNameColumn = 'FileName',
        @FileDataColumn = 'FileData',
        @MFTableName = 'MFInvoice',
        @BatchSize = 500,
        @Process_ID = 6,   
        @ProcessBatch_id = @ProcessBatch_id OUTPUT, 
        @Debug = 0, 
        @TargetFileUniqueKeycolumnName = 'mfsql_File_Unique_ref';

Step 6: view the results in SQL in the table MFFileImport

.. code:: sql

    SELECT *
    FROM dbo.MFFileImport;

    SELECT id, name_or_title, MFVersion, FileCount, Single_File, Mfsql_File_Unique_Ref, Process_ID
    FROM dbo.MFInvoice;

Exporting of files
------------------

Exporting files with :doc:`/procedures/spMFExportFiles` from M-Files allows for extracting files, and information about the files from M-Files into explorer and SQL.  An object in M-Files, including its properties, could have none or multiple files each with its own properties. This capability allows for access these files and properties.

The functionality is designed to address different types of use cases.

Some of these use cases include:

- Get a file from M-Files and attach it to a database email, and therefore send bulk emails with attachments.
- Move files from one object type to another.
- Move objects from a non document Object type class  to a document type class.  This is particularly useful because one cannot change the class of a non-document object type to a document type class in the user interface.
- Get all the files related to a specific project, customer or event in explorer.
- Compare the versions of files on a checksum level with the same files outside of M-Files. (this use case stems from the need to legally prove that the files in M-Files did not change when compared with the originating files in explorer)
- Export files from M-Files when M-Files are no longer used.
- Use the file data to calculate total number of files, files storage, file of specific type (extention) or other statistics 

In principal this capability centers around matching metadata of objects in a class with the files in the object and making the information related to the objects, and the actual files available outside M-Files.  The related information in SQL is in the class table and :doc:`/tables/tbMFExportFileHistory`.  The files, if downloaded, is in explorer in the folders specified in the parameters.  Some of the use cases will require additional custom procedures or steps to complete the functional process of the use case. The output of this exporting procedure is however a fundamental building block in the process.

Example of preparing to export of Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example use the Sales Invoice class

Step 1 - create class table, review setup for export destinations.  The Root folder is set in the MFSettings table.  The base folder for the class is set in the MFClass table

.. code:: sql

    EXEC spmfcreatetable 'Sales Invoice' --create table
    EXEC spmfupdatetable 'MFSalesInvoice',1  --update table

    SELECT * FROM mfsalesinvoice ---review objects in table

    Update mc  -- update Class table to set a custom folder for sales invoices
    SET FileExportFolder = 'SalesInvoices'
    FROM MFclass mc WHERE tablename = 'MFSalesInvoice'

   SELECT * FROM mfsettings WHERE name = 'RootFolder'  -- review Root folder: all files will be exported to C:\MFSQL\FileExport\ on the SQL server

Step 2 - Select the objects to be included in the export.  this could be for a single row, or the whole table.  Note that the column FileCount show if the object have none, or multiple files.  The Column Single_File indicate if the object is a multi document object or not.

.. code:: sql

    UPDATE MFSalesInvoice --mark records for files to be exported by setting the process_id column
    SET process_Id = 5 WHERE filecount > 0  --use filters to select the appropriate records.

Step 3 - determine the settings for the parameters.  Refer to :doc:`/procedures/spMFExportFiles` for more detail about the parameters

.. code:: sql

     DECLARE @ProcessBatch_ID INT;
     EXEC [dbo].[spMFExportFiles] @TableName = 'MFSalesInvoice',
                             @PathProperty_L1 = null,
                             @PathProperty_L2 = null,
                             @PathProperty_L3 = null,
                             @IsDownload = 1,
                             @IncludeDocID = 0,
                             @Process_id = 5,
                             @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                             @Debug = 0

Step 4 - Review the result. :doc:`/tables/tbMFExportFileHistory`  show the output of the process. If @IsDownload = 1 then the files should be in the explorer folders. If @IsDownloaded = 0 then the data will be in the table, but the file will not be in explorer. This is particularly useful if the objective is to perform analysis on the data about the files, rather than accessing the files.

.. code:: sql

     SELECT * FROM [dbo].[MFExportFileHistory] AS [mefh]

.. |image0| image:: img_1.png
