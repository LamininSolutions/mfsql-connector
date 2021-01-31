Align metadata from an external source with data in M-Files
===========================================================

The use case is where there is some metadata in M-Files (or none) and
data from an external system need to be imported into M-Files.  If the
external data is poorly aligned with the metadata of M-Files then using
the power of SQL will greatly enhance to ability analyse and align the
data. Having the metadata in SQL using the MFSQL Connector will further
improve the efficiency of correlating the data.

Several special MFSQL procedures can be used in this process

#. spMFSyncronizeMetadata to update the metadata

#. spMFCreateTable to create the class table in question

#. spMFupdateTable with updatemethod 1 to update the class table with
   the existing data.

#. Create an additional table in SQL as a working table for the external
   data

#. use spMFCreateLookupView to created easy to use lookups for the
   valuelists in question

#. Clean the data in the working table to align with the valuelist items

#. Configure Valuelist in M-Files with an external connection to the
   working table. Use a select distinct statement to import only the
   items from the columns in the working table

#. use spMFSyncroniseSpecificmetadata with ValuelistItems to update the
   valuelistitems.

#. use a select statement with joins between the working table and the
   new valuelistlookup table

#. use insert statement to add new records the class table.  Add all
   required columns (per metadata configuration), MFID only for
   valuelist columns, process\_id = 1 and minimum columns as defined in
   the Class Table section.

#. use spMFupdateTable with update method 0 to update the data back into
   M-Files

Note that MFSQL Connector is does not handle the importing of files. It
only operate on the metadata of the objects.  Use the external file
connector or the M-Files Importing Tool to import files.  Reference the
use case about importing files.
