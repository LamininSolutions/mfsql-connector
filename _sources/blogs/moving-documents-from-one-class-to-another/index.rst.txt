Moving documents from one class to another
==========================================

Note that the following method should only be used where the source and
target classes have the same object type.

In this use case objects need to be move from one class to other.  The
additional functionality of metadata configuration has made it possible
to consolidate similar objects with slightly different processing
requirements, instead of having separarate classes for each variety of
object.  Having less classes reduces the complexity for the users and
improves the analysis of the data.

Moving records from one class to another involves the following steps:

#. Update all the class tables in the Connector using spMFUpdatetable
   with updatemethod 1

#. Do a select statement on the source class table to isolate the
   records to be moved to another class

#. Update the class\_id column with the MFID of the new class, and set
   process\_id = 1

#. Use spMFUpdatetable with updatemethod 0 to  update the source class
   table.

#. Perform spMFUpdateTable with update method 1 on the target table and
   source table.

#. Note that the records in the source table will all be set to deleted
   = 1 and properties that were included in the source table but not
   part of the metadata structure of the target table will automatically
   be added as additional columns to the target table


