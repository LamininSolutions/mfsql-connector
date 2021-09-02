====================================
Upgrading version 4.8.22.62 or later
====================================

Upgrading from a version prior to 4.8.22.62 to this version or a later version requires a few special steps to align the class tables with the new design of deleted objects

In brief, after installation and before processing any updates, it it necessary to run the 05_Updates_V4.8.22.62.sql.  This script is available at
C:\Program Files (x86)\\Laminin Solutions\MFSQL Connector Release 4\\[DatabaseName]\\Database Scripts\\V4.8.22.62\\05_Updates_V4.8.22.62.sql

This routine has only to be run once for each MFSQL Connector database.

There may be occasions where your application has custom constraints, statistics that will interfere with this update.  When the update show an error then manually delete the custom dependencies.  The update can be run multiple times until no further errors are reported.

To switch from not showing deletions to deletions, it would be necessary to re-run a full update of the class table using the spmfUpdateMfilesToMFSQL procedure with @RetainDeletions = 1

In cases where custom views or procedures includes conditions to include or exclude records based on the deletion status, you will have to make manual changes to the code.
The best method is to search on the term 'Deleted'.  Replace the condition deleted = 0 with deleted is null; also replace any reference to deleted = 1 with deleted is not null.

An error with 'Invalid column name 'Deleted' is a good indication to run the above update to reset the 'Deleted' columns.
