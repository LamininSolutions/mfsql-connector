Integration with SAGE 50
========================

In this use case the sales invoices are prepared in M-Files.  These
invoices are the result of the quote to order to invoice management
process which are all performed in M-Files.  On completion of the
invoice in M-Files the resulting accounting transaction is posted into
SAGE 50 for financial accounting.

One of the key elements of this integration is that SAGE 50 does not
allow any direct update into their databases and only allow integration
by way of csv files.

The deployment of this integration have the following parts:

-  On completion and approval of the invoice in M-Files the invoice
   Class Table is syncronised with SQL.

-  SQL produces the CSV file in a designated location and format

-  SAGE 50 standard CSV importing utilities are used to import the CSV
   and complete the remainder of the financial accounting functions.


