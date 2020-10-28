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

Synchronize metadata for the first time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to synchronize the metadata tables with M-File server execute
the procedure :doc:`/procedures/spMFSynchronizeMetadata`.This
procedure will internally call internal procedures such as

-  spMFSynchronizeLoginAccount
-  spMFSynchronizeUserAccount
-  spMFSynchronizeObjectType
-  spMFSynchronizeProperties
-  spMFSynchronizeValueList
-  spMFSynchronizeValueListItems
-  spMFSynchronizeWorkflow
-  spMFSynchronizeWorkflowsStates
-  spMFSynchronizeClasses

Each spMFSynchronize\* procedure will internally call two
other procedures

spMFGet\*

spMFInsert\*

spMFGet\* procedure will connect to M-Files server and get the metadata
details in XML format and spMFInsert\* procedure will insert those
details into the respective metadata tables.

Synchronize specific metadata
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use `:doc:`/procedures/spMFSynchronizeSpecificMetadata/`
to update a specific type of metadata. 

Synchronize metadata Tables with new Vault
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to synchronize the metadata tables with a new vault, execute
“spMFDropAndUpdateMetadata”. This procedure will retain the following
custom settings in the metadata tables. All other column values will
updated with new vault details.


================ ====================
Table            Customisable columns
================ ====================
MFClass          IncludedInApp
                
                 TableName
MFProperty       ColumnName
MFValuelistItems AppRef
                
                 Owner_AppRef
================ ====================

This procedure can also be used to reset all the metadata, but retain
the custom settings in the Tables.


Why synchronising the metadata
------------------------------

The vault structure is captured in metadata baseline tables such as
classes, object types etc.  Synchronizing the metadata updates the
metadata structure of the specific vault into these inter related
tables. Note the following special considerations.

-  Each table contains an ID and MFID of the object. The ID is a unique
   SQL reference that is independent of the M-Files object ID.
-  Each table contains a column for Deleted. When an object is deleted
   in M-Files it is not automatically deleted from the SQL tables, but
   the deleted column is set to 1. Deletion of redundant records can be
   controlled by additional procedures or triggers.
-  Each table has a column for created and last modified date.

Exclude the deleted records when using the Metadata structure and
Class Tables in views or selection lists. Example: .... where
deleted <> 0

The following columns will not be overwritten on synchronizing the
metadata:

-  MFClass: IncludedInApp
-  MFClass: TableName
-  MFProperties: ColumnName
-  MFValueListItems: AppRef

All ValueListItems are contained in a single table. The column AppRef
contains a unique reference that can be used in applications to access a
ValuelistItem without reference to the valuelist. The AppRef consists of
the Valuelist MFID and the Item MFID and is automatically created by the
Connector.

The spMFCreateLookupView procedure can be used to create a view for a
specific valuelist to be used in applications.

The Columns MFID and Name of the ValuelistItems in the
MFValuelistItems table is not unique as this table include all
valuelistitems accross all valuelists

After deployment of the Connector, the metadata of the vault are added to
the baseline metadata tables by synchronising the metadata using the
**spMFSynchronizeMetadata** procedure. When changes are made to the
metadata structure in M-Files using the administrator the same procedure
can be used to refresh the metadata. Note that metadata is not
automatically refreshed. It is refreshed on demand.Metadata maintenance

The **spMFSynchronizeSpecificMetadata** store procedure can be used to
refresh a specific type of metadata such as valueslist items or states.

Automated refresh of the metadata can be built into the deployment of
the specific application depending on the requirements for automation of
the refresh.

Refer to the 'Change of Vault' section in a case where the metadata in
the Connector are ported from one vault to another.


Refresh all metadata:
~~~~~~~~~~~~~~~~~~~~~

The standard method of updating metadata from M-Files to SQL is to use
this procedure.  Note that this procedure will also record the update in
MFProcessBatch and MFProcessBatchDetail logging tables.

:doc:`/procedures/spMFSynchronizeMetadata`
:doc:`/procedures/spMFDropAndUpdateMetadata`

Use this procedure when a specific type of metadata is required to be
updated, or before the metadata must be updated from SQL to M-Files and a metadata change has taken place.

Metadata errors
---------------

Following is some of the errors that may arise and be reported
through email when working with metadata and how to resolve them.  These
errors may arise from deploying an update package on an existing
installation.

#. Unable to update record in SQL because null values are not allowed. 
#. No connection to the vault.

Change of workflow state names
------------------------------

When the name of a state is modified in M-Files, it does not trigger a
change of version of the underlying object and the name change there
does not replicate through to SQL. This is particularly relevant where
the state column in the class table is used in reporting.

The procedure :doc:`/procedures/spMFSynchronizeWorkFlowStateColumnChange` will
run through the class tables and update all state name changes.

Related script to demonstrate function: 01.201.Resetting workflow state
names on all class tables