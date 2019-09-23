Updating incorrect properties across multiple related classes 
==============================================================

In this case the vault has a valuelist that is used accross multiple
classes and object types. The objective is to consolidate and split the
use of the valuelist items across all the tables.

#. To determine in which classes the valuelist is being used, it is best
   to use a temporary view in M-Files and list all objects where the
   property in question is not null. Sub group this list by Class

#. ensure that all the classes in the list created in the Connector as a
   class table.

#. if the list of classes included is more than a few, then create a
   temporary table to set the list of class table that is included in
   this operation

   #. Create a temp tablewith columns Class\_ID, Tablename

      -  insert records into TempTable from MFClass where IncludeinApp =
         1.  if needed items can be added, or removed from this temp
         table.

#. Refresh all class tables with spmfupdatetable or
   spmfupdateallincludedinAppTables. Note that if this is the first time
   that the class tables are being updated then it could take a
   considerable time.

#. Create a special view to join all the related classes in a single
   view using union all. Select columns that is common to all the
   related classes.

#. Use MFSQL Manager to explore the metadata structure from different
   angles to assess the required alignments

#. When an issue is spot in a class then perform a bulk update

   #. When using SQL update, always include process\_id = 1

   #. Use spmfupdatetable updatemethod = 0 to process updates.


