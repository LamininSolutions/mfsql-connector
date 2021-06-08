MFSQL Connector addons and utilities
=====================================

The MFSQL Connector installation folder includes the following addons and utilities.  These utilities are provided as is, and is not fully productised. Use these as examples or a starting point for your own development.

The files are located in the installation folder. For example C:\Program Files (x86)\Laminin Solutions\MFSQL Connector Release 4\YourDatabase\60_Addons

Excel Basic for SQL queries
---------------------------

This excel workbook includes VB script to allow for connecting to MFSQL Connector and populating the excel with the contents of the tables and views.

Excel SQL reports
-----------------

This excel is similar to the above, except that it has more advanced features.  This excel is based on the requirements for a specific customer.

Folder Export
-------------

This utility is built with powershell to extract directories and files from the explorer folders into CSVs.  The columns is specifically designed to support importing the CSV filed into a database and to use in in conjunction with MFSQL Connector file importing routines. Consult the readme.txt file for more information.

SQL Scheduler
-------------

This powershell utility is specifically designed to schedule MFSQL Connector procedures for an SQL Express installation. (Express does not allow SQL Agents). Consult the readme.txt file for setup and usage instructions.
