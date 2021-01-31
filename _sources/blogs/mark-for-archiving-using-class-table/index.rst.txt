Mark for Archiving using Class Table
====================================

The M-Files Property ‘Mark for Archiving’ is often used as part of processing document retention policies.  This property can be set with a workflow. Sometimes the retention policies include advanced conditions that may include evaluating the status of multiple objects and properties. This is an ideal use case to use the power of SQL to evaluate the retention and set the 'Mark for Archiving' flag on multiple related objects.

The property is not is not added by default onto a class table. However, it is possible to add the column to the class table

The following steps illustrate adding the column, and then changing the
flag and updating the objects with the flag.

Step 1 : add the column to the class table

.. code:: sql

    ALTER TABLE [YourTable]
    ADD Marked_For_Archiving bit

Step 2: Update the flag

.. code:: sql

    UPDATE mwl
    SET process_id = 1, Marked_For_archiving = 1
    FROM [Your Table] AS [mwl]
    WHERE [State_ID] = 214

Step 3: update the table

.. code:: sql

    EXEC [dbo].[spMFUpdateTable] @MFTableName = 'Your Table'    -- nvarchar(200)
                                ,@UpdateMethod = 0

The selected objects should now all be marked for arching and ready to
be using in replication and archiving procedures.

The use case may also involve multiple class tables and the evaluation of complex conditions to determine if a object should be set to archiving. These conditions can be built into a custom procedure that is automatically scheduled to run, say every month.

The final step is to dispose of the archived records.  Several alternative methods can be used:  All records, marked for archiving, can be removed using M-Files Replication and archiving services.  You may want to use SQL to retain an extract of the metadata of the files before removing the objects.  You could also use the connector capability to export the files to the folder system for long term storage.
