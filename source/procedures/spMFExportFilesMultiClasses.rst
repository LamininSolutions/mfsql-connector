===========================
spMFExportFilesMultiClasses
===========================

Return
  - 1 = Success
  - -1 = Error

Parameters  
  @MFTableName 
    Name of Table. If not specified then all the tables set as active in MFFileExportControl will be processed
  @IsDownload 
    Default = 1
    Select 0 to only download the data about the files, without the file.
  @IncludeDocID 
    Default = 0
    Select 1 to include the objid in the file name
  @isSetup 
    Default = 1.  This will produce several views to assist with setup of the control table, and will not execute the download
    Set to 0 to perform the export
  @WithTableUpdate 
    Default = 0
    Set to 1 to perform an update of the class tables before the file export
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

This procedure allows for exporting files accross multiple classes from a vault as defined in the MFFileExportControl table.  

Additional Info
===============

This procedure use class tables as input, the classtables must therefore exist and be up to date to download the files.

To export a single table, configure the columns in MFFileExportControl and specify the tablename in the parameters of spMFExportFilesMultiClasses

If parameter MFtableName is null then the export will be performed for all files for all the objects in the classes included in the MFFileExportControl table.  To exclude a table from the export, set the Active column in the control table to 0

The MFFileExportControl include additional statistics for the export update during the process:  Total Objects with files, Total Files and Total Size of all files. The LastModified also include the datetime stamp when to process for the table was completed.

Prerequisites
=============
The classes to be included and the folder columns to use is defined in the MFFileExportControl table.
The export will use the folder defined in MFSettings under Root Folder as the root of the export of the files. Ensure that the user executing the procudure have access permissions to the folder system.
The next level of folder is defined in MFClass by Class in the column FileExportFolder. If this is set then all files for the class will start from this folder.  If this is not set for the table then the export of the files will use the next level of folders from the column definition.  
The next three levels of folders that is selected from the columns of the class is set in the MFFileExportControl table.
Multifile documents will be filed with an additional folder set as the name of the multifile document object

Folder setting examples
=======================

RootFolder: d:\VaultFiles (Set in MFSettings); No folder is set for class in MFClass

Scenario 1 - Files by department, class, and document type  

d:\VaultFiles\HR\CV\CV_Received\Filename.xxx
d:\VaultFiles\Finance\Purchases\Order\Filename.xxx
d:\VaultFiles\Finance\Purchases\Sales_invoice\Filename.xxx

Scenario 2 - Customer, Document Type
d:\VaultFiles\Customer 1\sales_invoice\Filename.xxx
d:\VaultFiles\Customer 1\Purchase_invoice\Filename.xxx


Examples
========

Setup control

.. code:: sql
  
    declare @ProcessBatch_ID int;
    exec dbo.spMFExportFilesMultiClasses @MFTableName = null
                                   , @IsDownload = 0
                                   , @IncludeDocID = 0
                                   , @isSetup = 1
                                   , @WithTableUpdate = 0
                                   , @ProcessBatch_ID = @ProcessBatch_ID output
                                   , @Debug = 0

Get filesizes from vault

.. code:: sql
  
    declare @ProcessBatch_ID int;
    exec dbo.spMFExportFilesMultiClasses @MFTableName = null
                                   , @IsDownload = 0
                                   , @IncludeDocID = 0
                                   , @isSetup = 0
                                   , @WithTableUpdate = 0
                                   , @ProcessBatch_ID = @ProcessBatch_ID output
                                   , @Debug = 0

Perform file export

.. code:: sql
  
    declare @ProcessBatch_ID int;
    exec dbo.spMFExportFilesMultiClasses @MFTableName = null
                                   , @IsDownload = 1
                                   , @IncludeDocID = 0
                                   , @isSetup = 0
                                   , @WithTableUpdate = 0
                                   , @ProcessBatch_ID = @ProcessBatch_ID output
                                   , @Debug = 0


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2023-03-16  LC         Update documentation
2023-02-22  LC         Create procedure
==========  =========  ========================================================

