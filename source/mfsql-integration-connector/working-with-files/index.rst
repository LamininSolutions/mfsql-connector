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
M-Files has been available for some time. The
primary use of this functionality is to get a file from M-Files and be
able to attach it to a database email, and therefore send bulk emails
with attachments.

The functionality has been enhanced to allow for multi-file document
objects and to include the file object id in MFExportFileHistory.

Related script to demonstrate function: 06.102.Exporting files from
M-Files