Considerations for deleted records
==================================

M-Files users can delete, destroy and undelete a record. MFSQL Connector
will remove deleted objects from the class table (or optionally retain
the record with a deleted flag) and reinstate the record in the class
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

Setting the @RetainDeletions controls if spMFUpdateTable remove the
deleted records from the class table. Setting this flag to 0 will retain
the deleted records in the table. This is particularly useful when the
deletions must be included in a report, or be updated in a third party
system.

When a record is undeleted in M-Files, spMFUpdateTable with no filters
will reinstate the record in the class table.

Using spMFUpdateTable on large class tables will have performance
issues. In these cases spMFUpdateMFilestoSQL must be used.

spMFUpdateMFilesToSQL
---------------------

spMFUpdateMFilestoSQL is used to update large class tables and should be
used as a default for building updates into custom procedures.

When a record is deleted or destroyed in M-Files, this procedure will
first get the object versions since the last class table update, and
then only update the changed records, including deletions.

spMFUpdateMFilesToSQL will identify an undeleted records also, however,
with large tables this could take considerably longer as it will have to
process through the entire dataset to determine if a object has been
undeleted and missing in the class table.

spMFGetDeletedObjects
---------------------

Use spMFGetDeletedObjects to mark deleted items in the class table
without removing them or processing a full update routine. A switch can
be used to remove the item from the class table at the same time. This
is particularly applicable where a deleted object need to be processed
into a third party system, or when there is need for reporting on
deleted objects.

This procedure will not return a result for destroyed objects. Use
spMFTableAudit to identify objects no longer in existence.

spMFGetDeletedObjectsInternal
-----------------------------

spMFGetDeletedObjects use the internal procedure
spMFGetDeletedObjectsInternal to fetch the deleted objects for a class
from M-Files. This procedure can be used independently from a class
table to identify records deleted in M-Files. It returns a list of
deleted objects which can be processed further for reporting, comparison
or any further analysis that may be required.

Destroyed objects is not returned with this procedure. A destroyed
object cease to exist.

Following is an example of getting the output in XML format.

.. code:: sql

    DECLARE @outputXML NVARCHAR(MAX);
    DECLARE @VaultSettings NVARCHAR(200) = [dbo].[FnMFVaultSettings]()

    EXEC [dbo].[spMFGetDeletedObjectsInternal] @VaultSettings = @VaultSettings    -- nvarchar(4000)
                                              ,@ClassID = 22       -- int
                                              ,@LastModifiedDate = null -- datetime
                                              ,@outputXML = @outputXML OUTPUT                            -- nvarchar(max)
    SELECT CAST(@OUTPUTxml AS xml)


