Moving metadata from text properties to Valuelist items
=======================================================

Sometimes a configuration change is made to elevate a property that is
defined as text to become a valuelist.  In most cases the data in the
text property need to be corrected to be consistent with the chosed
valuelist items.  Using the power of SQL the text property can be
analysed and updated. A temporary table with the adjusted valuelist
items can be prepared.  When ready this data can be updated into the new
valuelist using the standard external connector with Valuelists that
point to the temporary table.  Once this is done the new valuelist items
can be updated on the Class Table and refreshed into M-Files.  The last
step is to remove the data from the class table.

Several special MFSQL procedures can be used in this process.

#. spMFSyncroniseMetadata to update the metadata after the addition of
   the new valuelist property.

#. spMFCreateTable to create the class table in question

#. spMFupdateTable with updatemethod 2 to update the class table with
   the existing data.

#. Create an additional table in SQL as a working table for aligning the
   textvalues with columns ClassTable\_ID, TextpropertyValue,
   AdjustedTextValue, TargetValuelistItem\_ID. 

#. Insert records from the class table to the working table.

#. Use SQL to select and align the TextPropertyValue to the
   AdjustedTextValue.

#. Configure Valuelist in M-Files with an external connection to the
   working table. Use a select distinct statement to import only the
   items from the AdjustedTextValue.

#. use spMFSyncroniseSpecificmetadata with ValuelistItems to update the
   valuelistitems.

#. use spMFCreateLookupView on the valuelist to create and easy to use
   lookup for the new valuelist

#. use a select statement on the Class Table with joins to the working
   table and the new valuelistlookup and use an update statement to add
   the MFID of each valuelistitem to the Class Table. (include
   process\_id = 1 in the update statement)

#. use spMFupdateTable with update method 0 to update the data back into
   M-Files


