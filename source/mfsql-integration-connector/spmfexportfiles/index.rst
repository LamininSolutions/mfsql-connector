spMFExportFiles
===============

.. toctree::
   :maxdepth: 4

   mfexportfilehistory/index

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      The procedure is used to export selected files for class records
      from M-Files to a designated explorer folder on the server.

      The main use case for this procedure is to allow access to the
      files as attachments to emails or other third party system
      applications. An example is bulk emailing of customer invoices.

      Objects with Files and Document Type objects can be exported.

      Use root folder parameter to set the UNC path, or location on the
      SQL Server e.g. D:\\MFSQLExport\\.  On installation this folder is
      automatically set to c:\MFSQL\FileExport

      Use FileExportFolder column in MFClass to set the 'What is being
      exported' e.g. SalesInvoices

      If no path properties are set, then the files will be exported to
      D:\MFSQLExport\SalesInvoices 

      Each Path Property is the column values for the object.  Level 3
      is nested in Level 2 is nested in Level 1.  E.g.
      CustomerABC\ProjectABC\InvoiceMonth.  

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ========= ========
         Module    Release#
         ========= ========
         Developer 3.1.2.38
         ========= ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      The security context of the export functionality is using the SQL
      Service Account.  The SQL Service Account must have appropriate
      permissions to create folders and files on the Root Folder. 
      Special care should be taken If a UNC path is used to set the SQL
      Service Account with appropriate permissions to access the UNC
      path.

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      | 

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== ======================================================================
         Type           Description
         ============== ======================================================================
         Procedure Name spMFExportFiles
         Inputs         |  TableName: name of class table
                        |   RootFolder = required for root folder
                        |   PathProperty_L1 = optional column for 1st level path
                        |   PathProperty_L2 = optional column for 2rd level path
                        |   PathProperty_L3 = optional column for 3rd level path
                        |   IncludeDocID: File name include Document id. Default = 1 (yes)
                        |   Process_id: set process Id for records to be included. Default = 1
                       
                        ProcessBatch_ID = for logging of the export procedure
                       
                        Debug: 1 = Debug Mode; 0 = No Debug (default)
         Outputs        1 = success
         ============== ======================================================================

      A column with a datetime datatype will be displayed in the format
      yyyy-mm-dd when specified as one of the folder parameters 

| 

Produce extract of all sales invoices by customer

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          
         UPDATE [MFClass] SET [FileExportFolder] = 'SalesInvoices' WHERE [ID] = 36;
         EXEC [spMFCreateTable] 'Sales Invoice';
         EXEC [spMFUpdateTable] 'MFSalesInvoice', 1;
         SELECT * FROM [mfsalesinvoice];
         UPDATE [mfsalesinvoice]
         SET  [process_id] = 1
         WHERE [filecount] > 0
           
         EXEC [spMFExportFiles]
          'mfsalesinvoice', 'Customer', NULL, NULL, 0, 0, 1, 0;

Produce extract of all sales invoices by Customer by Month (assuming
that the invoice Month is a property on the invoice)

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         DECLARE @ProcessBatch_ID INT;
         EXEC [dbo].[spMFExportFiles] @TableName = 'MFSalesInvoice',       -- nvarchar(128)                             @PathProperty_L1 = 'Customer', -- nvarchar(128)                             @PathProperty_L2 = 'Document_Date', -- nvarchar(128)                             @PathProperty_L3 = null, -- nvarchar(128)                             
         @IncludeDocID = 0,    -- bit                             
         @Process_id = 1,      -- int                            
          @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,               --int                             
         @Debug = 0           -- int

.. container:: confluence-information-macro confluence-information-macro-information

   Use Cases(s)

   .. container:: confluence-information-macro-body

      Export files to folder to allow SQL to add the file as an
      attachment to a bulk email

      Export files for integration into a third party system

      Export files to be published to a website

| 
