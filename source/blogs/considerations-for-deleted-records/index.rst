Considerations for deleted records
==================================

M-Files users can delete, destroy and undelete a record. MFSQL Connector
will remove deleted objects from the class table (or optionally retain
the record showing the date of the deletion in the deleted column) and reinstate the record in the class
table if it has been undeleted. It is also possible to delete or destroy
records in M-Files in bulk from MFSQL Connector. This is particularly
useful when a large number of records must be deleted in M-Files.
M-Files user interface only allows for manual deletions in batches of
500.

spMFUpdateTable and deletions
-----------------------------

When a record is deleted in M-Files and a table is updated from M-Files
to SQL using spMFupdateTable with no filters, the deleted or destroyed
record will automatically be removed from the class table.

Each class table will include property 27 (Deleted) as a column with datatype datetime. If this column is null the record is not deleted. The date in this column reflects the date of the deletion of the object.

Setting the @RetainDeletions parameter for spMFUpdateTable controls the removal of the
deleted records from the class table. Setting this flag to 0 will retain
the deleted records in the table. The default of the procedure is set to 0. This is particularly useful when the
deletions must be included in a report, or be updated in a third party
system.

When a record is undeleted in M-Files, spMFUpdateTable with no filters
will reinstate the record in the class table.

Setting @RetainDeletions flag to 1 will retain the deleted records in the class table and show the date of the deletion to indicate that the record was deleted.

It is important to note that deleted object is processed into the class table when an update takes place.  If the setting is to remove deleted objects then the object is subsequently deleted from the table as part of the update routine.  This has a direct impact on the use of custom unique indexes or keys on the class table where SQL is checking for duplicates and one of the objects was deleted. In this case an error will be thrown in SQL for duplicate check, even if the deleted object is removed from the table subsequent to the updating.  It is advisable to destroy the object in <-Files when removing duplicate objects from a class table where a duplicate check is done with SQL constraints.


Using spMFUpdateTable on large class tables will have performance
issues. In these cases spMFUpdateMFilestoMFSQL must be used. The option to retain deletions is available on this procedure also.

spMFUpdateMFilesToMFSQL
-----------------------

spMFUpdateMFilestoMFSQL is used to update large class tables and should be
used as a default for building updates into custom procedures.

When a record is deleted or destroyed in M-Files, this procedure will
first get the object versions since the last class table update, and
then only update the changed records, including deletions.

spMFUpdateMFilesToMFSQL will identify an undeleted records also, however,
with large tables this could take considerably longer as it will have to
process through the entire dataset to determine if a object has been
undeleted and missing in the class table.

MFAuditHistory
--------------

The MFAuditHistory table is autmatically maintained when the update routines (spMFUpdateMFilesToMFSSQL, spmfUpdateTable) are processed.

This table show deleted objects with a statusflag of 4.

spmfTableAudit updates MFAuditHistory.

spMFGetObjectVers
-----------------

This procedure returns the object version of an object, including if the object is deleted.

spMFObjectTypeUpdateClassIndex
------------------------------

This procedure gets all the object versions in the vault and include the deleted objects. The result is in table MFObjectTypeToClassObject.
