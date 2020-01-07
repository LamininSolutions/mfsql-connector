
===============
spMFExportFiles
===============

Return
  - 1 = Success
  - -1 = Error
Parameters
  @TableName nvarchar(128)
    Name of class table
  @PathProperty\_L1 nvarchar(128) (optional)
    - Default = NULL
    - Optional column for 1st level path
  @PathProperty\_L2 nvarchar(128) (optional)
    - Default = NULL
    - Optional column for 2nd level path
  @PathProperty\_L3 nvarchar(128) (optional)
    - Default = NULL
    - Optional column for 3rd level path
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
    - 101 = Advanced Debug Mode

Purpose
=======

The procedure is used to export selected files for class records from M-Files to a designated explorer folder on the server.

Additional Info
===============

The main use case for this procedure is to allow access to the files as attachments to emails or other third party system applications. An example is bulk emailing of customer invoices.
Objects with Files and Document Type objects can be exported.

Use root folder parameter to set the UNC path, or location on the SQL Server e.g. D:\\MFSQLExport\\. On installation this folder is automatically set to c:\MFSQL\FileExport

Use FileExportFolder column in MFClass to set the 'What is being exported' e.g. SalesInvoices

If no path properties are set, then the files will be exported to D:\MFSQLExport\SalesInvoices

Each Path Property is the column values for the object. Level 3 is nested in Level 2 is nested in Level 1. E.g. CustomerABC\ProjectABC\InvoiceMonth.

The security context of the export functionality is using the SQL Service Account. The SQL Service Account must have appropriate permissions to create folders and files on the Root Folder.  Special care should be taken If a UNC path is used to set the SQL Service Account with appropriate permissions to access the UNC path.

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
    EXEC [dbo].[spMFExportFiles] @TableName = 'MFSalesInvoice', -- nvarchar(128)
                                 @PathProperty_L1 = 'Customer', -- nvarchar(128)
                                 @PathProperty_L2 = 'Document_Date', -- nvarchar(128)
                                 @PathProperty_L3 = null, -- nvarchar(128)
                                 @IncludeDocID = 0, -- bit
                                 @Process_id = 1, -- int
                                 @ProcessBatch_ID = @ProcessBatch_ID OUTPUT, --int
                                 @Debug = 0 -- int

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2018-12-03  LC         Bug 'String or binary data truncated' in file name
2018-06-28  LC         Set return success = 1
2018-02-20  LC         Set processbatch_id to output
==========  =========  ========================================================

