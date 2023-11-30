
Example procedure for importing sales invoices on demand
========================================================

This procedure is designed to import vendor invoices on demand from explorer.  The users scan or file the vendor invoice with the filename as a unique reference that relates to the vendor invoice transaction (voucher) in M-Files.  This import routine cam be triggered by the user in M-Files (using the context menu funtionality) or through an agent job or workflow state trigger. 

This procedure is preceded by running the Powershell utility to get the contents of the folder and the availability of the invoice into SQL

Apart from demomstrating the core functionality of importing and updating file objects, this example also include logging, debugging, error trapping and the use of a temporarytable to stream this procedure inside the procedure that creates and synchronises the vendor payment transaction.

Download the script file :download:`sql scriptfile <Custom.DoUpsertVendorInvoice.sql>`

