
ExternalID versus DisplayID versus Objid
========================================

M-Files maintains several IDs for an object.

#. Objid or internal ID: The Objid of the object
#. ID or External ID:  Unique ID of object within an Object Type. 
#. ExternalRepositoryID or Original ID: Represents the id of the object in a replication vault
#. DisplayID: This is the ID displayed in the metadata card and is searchable in the vault.

The displayID gets its value from one of the above IDs in the following order of priority
#. External ID
#. Original ID
#. Internal ID

MFSQL Connector show two IDs as columns for each object:
#. Objid
#. External_ID - this column represents the DisplayID of the object.

The external_ID is used to link the object id from an external system to M-Files. This column is updatable from SQL to M-Files and must be unique.  We recommend to maintain an unique index on the External_ID column in SQL.

When a class has replication objects from a different vault the uniqueness of the External_ID may be affected.  It these cases the External_ID is no longer used for linking to an external system and the unique index setting should not be used.




