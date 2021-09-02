
===============
spMFExportFiles
===============

Return
   1 = Success
   -1 = Error

Parameters
  @TableName nvarchar(128)
    - Name of class table
  @PathProperty\_L1 nvarchar(128) (optional)
    - Default = NULL
    - Optional property column for 1st level path.  
  @PathProperty\_L2 nvarchar(128) (optional)
    - Default = NULL
    - Optional column for 2nd level path
  @PathProperty\_L3 nvarchar(128) (optional)
    - Default = NULL
    - Optional column for 3rd level path
  @IsDownload bit
    - Default = 1 (yes)
    - When set to 0 the file data will be updated in the table but the file is not downloaded.
  @IncludeDocID bit (optional)
    - Default = 1
    - File name include Document id.
  @Process\_id int (optional)
    - Default = 1
    - process Id for records to be included
  @ProcessBatch\_ID int (optional, output)
    - Default = NULL
    - Referencing the ID of the ProcessBatch logging table
  @Debug int (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

The procedure is used to export selected files for class records from M-Files to a designated explorer folder on the server.

Additional Info
===============

The main use case for this procedure is to allow access to the files as attachments to emails or other third party system applications. An example is to prepare for bulk emailing of customer invoices.

All Object Types with Files can be included in an export.  Each class export is performed separately.

The destination folder in explorer is defined as:
  - The Root folder or UNC path is defined in MFSettings with name "RootFolder".  The user executing the script must have permission the read and write to this folder.  On installation this folder is automatically set to c:\\MFSQL\\FileExport.  
  - The next layer defines the root folder for the class.  This folder is defined in MFClass by changing the value of the column "FileExportFolder" for the specific class in MFClass. This layer is to set the 'What is being exported' e.g. SalesInvoices.  If the value in "FileExportFolder" for the class is null then the files will be saved to the root folder.
  - Three layers of property related folders can be defined as parameters by setting the PathPropertyL1 to L3 to valid columns on the class table.  These parameters are all optional.  L1 must have a value for L2 to and L3 to be specified.
  - Multi document objects will show the name of the object as the name of the folder for the files in the multi file object.
  - Filename (with or without object id)

For example the folders will be
  -  D:\\MFSQLExport\\SalesInvoices\\ABC Engineering\\Service Invoices\\2009\\ABC Engineering Inv 2324\\INV2345.pdf
  -  D:\\MFSQLExport\\SalesInvoices\\ABC Engineering\\Service Invoices\\2009\\ABC Engineering Inv 2324\\Supplements.pdf

The folder Definition comes from
  -  Root = D:\MFSQLExport (defined in MFSettings)
  -  Class = SalesInvoices (Defined in MFclass)
  -  Property 1 = Customer
  -  Property 2 = Document_type (type of invoice)
  -  Property 3 = Financial_year (Property showing financial year)
  -  MultiFile Object = Name_or_title
  -  Filename with object id

Each Path Property is the column values for the object. Level 3 is nested in Level 2 is nested in Level 1. E.g. CustomerABC\ProjectABC\InvoiceMonth.

The security context of the export functionality is using the SQL Service Account. The SQL Service Account must have appropriate permissions to create folders and files on the Root Folder.  Special care should be taken If a UNC path is used to set the SQL Service Account with appropriate permissions to access the UNC path.

MFExportFileHistory show the export result. Join this table on the class and objid with the class table to relate the files with the metadata.  Additional file data in the MFExportFileHistory table include:
 -  checksum
 -  File size
 -  File Extension
 -  File ID
 -  Count of files in object
 -  Name or title of object for multiple files 
 -  Date lastupdated
 -  Export Result

If IsDownload is set to 0 then the details of the file will be updated in the MFExportFileHistory table will be updated but the file will not be downloaded.

Examples
========

Extract of all sales invoices by customer.

.. code:: sql

    UPDATE  [MFClass] SET   [FileExportFolder] = 'SalesInvoices' WHERE  [ID] = 36;
    EXEC [spMFCreateTable] 'Sales Invoice';
    EXEC [spMFUpdateTable] 'MFSalesInvoice', 1;
    SELECT * FROM  [mfsalesinvoice];
    UPDATE [mfsalesinvoice]
    SET    [process_id] = 1
    WHERE  [filecount] > 0
    EXEC [spMFExportFiles]
        'mfsalesinvoice', 'Customer', NULL, NULL, 0, 0, 1, 0;

----

Produce extract of all sales invoices by Customer by Month (assuming that the invoice Month is a property on the invoice)

.. code:: sql

    DECLARE @ProcessBatch_ID INT;
    EXEC [dbo].[spMFExportFiles] @TableName = 'MFSalesInvoice', 
                                 @PathProperty_L1 = 'Customer', 
                                 @PathProperty_L2 = 'Document_Date', 
                                 @PathProperty_L3 = null, 
                                 @isDownload = 1,
                                 @IncludeDocID = 0, 
                                 @Process_id = 1, 
                                 @ProcessBatch_ID = @ProcessBatch_ID OUTPUT, 
                                 @Debug = 0 

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-01-07  LC         Change CLR to improve downloading multiple files
2021-01-07  LC         Include parameter to restrict download of files
2021-01-05  LC         Improve productivity and processing logic
2021-01-04  LC         Add columns filesize and file extension
2021-01-04  LC         Add new param for GetFiles and set default to 0 
2020-11-01  LC         Fix bug with misplaced as in code
2020-08-22  LC         Update code for deleted column change
2020-05-26  LC         Update fileid into table
2019-08-30  JC         Added documentation
2018-12-03  LC         Bug 'String or binary data truncated' in file name
2018-06-28  LC         Set return success = 1
2018-02-20  LC         Set processbatch_id to output
==========  =========  ========================================================

