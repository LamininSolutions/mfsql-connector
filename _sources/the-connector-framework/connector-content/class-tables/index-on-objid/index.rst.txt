
Indexes on class tables
=======================

The use of indexes on class tables could materially improve the efficiency and processing of objects, especially in larger tables.

Indexes is applied specific to the use of columns in the tables.  The Connector provides flexibility regarding the use of indexes.

We recommend to at least set indexes on the objid and external_id columns.  In some cases you may choose to set indexes on these columns in combination with other columns to improve additional efficiency.

MFSettings include a default setting for the creation of indexes. This setting is introduced in version 4.6.16.57.  By default the automatic creation of indexes is set to 0 (do not created indexes).

When this setting is set to 1 then spMFCreateTable will automatically create indexes on objid and external_id.

.. code:: sql

    SELECT * FROM dbo.MFSettings AS ms WHERE name = 'CreateUniqueClassIndexes'

    UPDATE ms
    SET value = '1'
    FROM dbo.MFSettings AS ms
    WHERE name = 'CreateUniqueClassIndexes'

Execute the procedure spMFSetUniqueIndexes to set indexes on all existing class tables, rather than recreating the tables from scratch.

.. code:: sql

    EXEC spmfsetuniqueindexes


