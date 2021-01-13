Advanced updating of Valuelists from external source
====================================================

When updating M-Files using data from external sources, it is often necessary to create new associated valuelist items before the data of the object can be added to M-Files.  Using the Connector, the missing valuelist items can be identified and then added to M-Files before triggering the object import, all as one process.

The following is an example of an advanced updating of multiple dependent valuelists from an external source before processing the
update of the record from the external source.

There is some preparation to be done and several steps in the ongoing process to take into account.

Step 1: Create easy to use lookups for the valuelists.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Valuelists in M-Files is in the :doc:`/tables/tbMFValuelist` table and the valuelist items are all in the :doc:`/tables/tbMFValuelistItems` table.  Selecting the valuelist items for a specific valuelist requires a join between these two table based on the valuelist_id.

However, we recommend to create a individual view for each valuelist that would be used in your application. The :doc:`/procedures/spMFCreateValuelistLookups` is a very handy tool to rapidly create these lookups.

Step 2: Add a routine to assess and update new valuelist items before adding the objects to the main class table.

.. code:: sql
