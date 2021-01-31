Working with files
==================

The connector provides a number of different ways to work with the file
documents in M-Files. 

#. The primary focus of the connector is to work with the **metadata
   related to the files**.  The class table has the following columns
   specifically related to files.

   #. SingleFile:  this column show if the object is a single or
      multi-file object.
   #. FileCount: This column show the number of files in the multi-file
      object

#. **Export of files from M-Files**:  Export files from any class table
   to a designated folder on the SQL server.  The MFExportFileHistory
   table references the exported files to allow for further processing
   such as using the files as an attachment to an email.  This
   functionality can be used to export files to explorer to create an
   extract of all the files in the vault.
#. I\ **mport files into M-Files** from another database where the files
   are stored as blob.
#. **Show and search for files in M-Files** where the files are located
   in another database using the IML connector capability. 

Importing files from explorer
-----------------------------

The new procedure :doc:`/procedures/spMFUpdateExplorerFileToMFiles`
allows for importing a file or files from explorer into M-Files. In
simple terms an explorer file is matched with the record in the class
table and imported into M-Files.

-  The object can be created in M-Files using MFSQL Connector at the
   same time as importing the file.

-  If another file is added to a single file object, it would
   automatically be converted to a multifile document

-  The file in M-Files will be overwritten If the file already exists
   for the specific object

The following is required to make it all fit together:

-  The location of the file

-  The name of the file

-  The destination class table

-  The SQL id of the record in the class table to attach the file to.

The table MFFileImport show a history of the importing of files.

Refresh M-Files view or the object F5 after running procedure to show
the updated object

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
     ,@ProcessBatch_id = @ProcessBatch_id OUTPUT
     ,@Debug = 0
     ,@IsFileDelete = 0

    SELECT * from [dbo].[MFFileImport] AS [mfi]

In some cases the name of the file and location of the file is derived
from another database.

Contact us if you would like to know more about using a powershell
utility to import the file names and folder locations of the files into
SQL as a preparatory step to match the files to the objects in the class
table.

Extend importing files capability
---------------------------------

The Importing of files using spMFUpdateExplorerFileToMFiles will list
all the files imported, or rejected in the MFMfileImport table. The
results of each file import is shown in the column ImportError.

Exporting of files
------------------

Exporting files with :doc:`/procedures/spMFExportFiles` from
M-Files allows for extracting files, and information about the files from M-Files into explorer and SQL.  An object in M-Files, including its properties, could have none or multiple files each with its own properties. This capability allows for access these files and properties.

The functionality is designed to address different types of use cases.

Some of these use cases include:

- Get a file from M-Files and attach it to a database email, and therefore send bulk emails with attachments.
- Move files from one object type to another.
- Move objects from a non document Object type class  to a document type class.  This is particularly useful because one cannot change the class of a non-document object type to a document type class in the user interface.
- Get all the files related to a specific project, customer or event in explorer.
- Compare the versions of files on a checksum level with the same files outside of M-Files. (this use case stems from the need to legally prove that the files in M-Files did not change when compared with the originating files in explorer)
- Export files from M-Files when M-Files are no longer used.

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
                             @IncludeDocID = 0,
                             @Process_id = 5,
                             @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                             @Debug = 0

Step 4 - Review the result. :doc:`/tables/tbMFExportFileHistory`  show the output of the process. If @IsDownload = 1 then the files should be in the explorer folders

.. code:: sql

     SELECT * FROM [dbo].[MFExportFileHistory] AS [mefh]
