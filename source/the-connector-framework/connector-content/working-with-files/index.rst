Working with files
==================

The connector provides a number of different ways to work with the file
documents in M-Files. 

#. The primary focus of the connector is to work with the **metadata
   related to the files**.  The class table has the following columns
   specifically related to files.

   #. SingleFile:  this column show if the object is a single or
      multi-file object.
   #. FileCount: This column show the number of files in the multi-file
      object

#. **Export of files from M-Files**:  Export files from any class table
   to a designated folder on the SQL server.  The MFExportFileHistory
   table references the exported files to allow for further processing
   such as using the files as an attachment to an email.  This
   functionality can be used to export files to explorer to create an
   extract of all the files in the vault.
#. I\ **mport files into M-Files** from another database where the files
   are stored as blob.
#. **Show and search for files in M-Files** where the files are located
   in another database using the IML connector capability. 

.. container:: table-wrap

   =====================================================================================================================================================
   **Related Topics**
   =====================================================================================================================================================
   -  `Class Table Columns <page21200940.html#Bookmark24>`__
   -  `spMFExportFiles <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/57913733/spMFExportFiles>`__
   -  `MFSQL Database File Connector <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/156401668/MFSQL+Database+File+Connector>`__
   -  `Database file import into M-Files <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/183631882/Database+file+import+into+M-Files>`__
   =====================================================================================================================================================
