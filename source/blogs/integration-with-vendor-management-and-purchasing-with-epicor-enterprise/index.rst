
Integration with Vendor Management and Purchasing with Epicor Enterprise
========================================================================

This use case are using M-Files to Management Vendors and Vendor Invoice
approval in M-Files, capture the full invoice, including line items and
then automatically post the approved transactions into Epicor.

The deployment of this integration has two parts:

-  Synchronize the classes in M-Files that relates to these operations
   with SQL. These include classes such as Vendors, Invoice Headers,
   Invoice documents and Invoice Line items.

-  Trigger the update of the Epicor SQL database when conditions are met
   in the SQL Class tables.

The core application features and functions of this integration include:

-  Data takeon from Epicor into M-files of vendors, valuelists and other
   static data.

-  Updating SQL with M-Files when the controller is ready to push
   transactions into Epicor. This applies MFSQL Connector to synchronize
   the data

-  Alignment of the data between M-Files and Epicor. This involves
   valuelist synchronization for drop downs in M-Files and data mapping
   between fields.

-  Exception and error handling for the data mapping and compliance with
   the rules of both systems.

-  Procedures to trigger when Vendors can be pushed into Epicor as
   approved vendors.

-  Procedures to trigger when Invoices are approved and ready to be
   pushed into Epicor

-  Exception and error handling for rejections from Epicor

-  Updating M-files with the results of the integration

-  Updating M-Files with the payments documents matched with the invoice
   metadata

-  Updating Epicor explorer with a hot link to all invoice related
   documents allowing click through to the documents from Epicor to
   M-Files.


