Mark for Archiving using Class Table
====================================

The M-Files Property ‘Mark for Archiving’ is not added to a class table
by default. However, it is possible to add the column to the class
table, and to set the flag on the property to aid bulk update of this
property from SQL.

This is particular handy when advanced logic is used to determine if a
record should be archived and to set the flag.

The following steps illustrate adding the column, and then changing the
flag and updating the objects with the flag

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
be using in replication and archiving procedures


