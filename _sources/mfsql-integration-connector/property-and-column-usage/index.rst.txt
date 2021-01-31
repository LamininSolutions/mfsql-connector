
Property and column usage
=========================


The procedure :doc:`/procedures/spMFClassTableColumns`
works through all the properties and related columns for class tables and
provide a report on the usage of properties in the Connector. This
report is particularly powerful in complex and vaults with multiple
integration points.

The result of the procedures is saved a temporary table. This table can
be used in subsequent processes detect potential anomalies and trigger
corrective action.

.. code:: sql

    EXEC [dbo].[spMFClassTableColumns]
    SELECT * FROM ##spMFClassTableColumns

The rich set of data include:

-  ColumnType showing if the property is in use; defined on the metadata
   card; adhoc property; or a M-Files system property

-  Both SQL datatypes and M-Files datatypes is shown

-  Columns at the end of the table show error statuses for Datatype
   errors, Missing columns, Missing Tables, or if a table is not longer
   in use.

|image6|

:doc:`/procedures/spMFDropAndUpdateMetadata` detecta inconsistencies with column usage and
automatically update the metadata

:doc:`/procedures/spMFUpdateTable` validates columns and automatically execute updating of
the metadata if the metadata has changes since the last update. Note
that this check could increase the run time for spMFUpdateTable
significantly when executed just after a metadata change in the vault.


.. |image6| image:: img_7.jpg
