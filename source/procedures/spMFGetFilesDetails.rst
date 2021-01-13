
===================
spMFGetFilesDetails
===================

Return
  - 1 = Success
  - -1 = Error
Parameters
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

The procedure is used to get details of files for objects as set in the MFAuditHistory table and update MFFileExportHistory

Additional Info
===============

The main use case for this procedure is the explore details of files in SQL.  Details captured include: filename, FileID, File Extention, File size, objid, class id and object type.

Version 1 will export all information for all files from a class.  The export is performed in batches of 1000 records

Use the procedure spMFExportFiles to work with specific or individual objects and files.

Examples
========

Extract of all sales invoices by customer.

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-01-04  LC         Create Procedure
==========  =========  ========================================================

