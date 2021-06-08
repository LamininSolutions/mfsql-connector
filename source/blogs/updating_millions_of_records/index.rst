
Updating millions of records
============================

First Choice Credit Union had a particular challenge to import in excess of 2 million files.   The importing task did not only involve importing files, but the data about the files had to be aligned with the source system and M-Files before the import could take place.

Large scale data alignment is always much more productive using the powerful features of SQL.  In this case the data from the source system could be access using SQL, however, it seemed that the source system tables did not provide sufficient data about the file names, it only referenced the file path in the network system.

This called for using a utility that is part of MFSQL Connector for folder management.  The utility is built for using Powershell to compile and extract the file and directory data in a folder system to SQL database tables.  More about :doc:`/mfsql-integration-connector/mfsql_connector_addons/index`

The first part of the project was therefore focused on identifying all the members and there related file data by joining the results of the folder utility and the data in the source system to provide extracts of all the members, the file data, and the location of the file.
