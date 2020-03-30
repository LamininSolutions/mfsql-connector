Working with Metadata
=====================

.. toctree::
   :maxdepth: 4

   synchronizing-metadata/index

Metadata synchronization procedures
-----------------------------------

There are a number of store procedures  used for metadata
synchronization. Only three of these procedures are designed to be used
by the developer. The other procedures are all called by  these
procedures

Change of workflow state names
------------------------------

When the name of a state is modified in M-Files, it does not trigger a
change of version of the underlying object and the name change there
does not replicate through to SQL. This is particularly relevant where
the state column in the class table is used in reporting.

The procedure :doc:`/procedures/spMFSynchronizeWorkFlowSateColumnChange` will
run through the class tables and update all state name changes.

Related script to demonstrate function: 01.201.Resetting workflow state
names on all class tables