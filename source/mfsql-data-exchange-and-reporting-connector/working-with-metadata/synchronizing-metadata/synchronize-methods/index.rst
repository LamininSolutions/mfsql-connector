Synchronize Methods
===================

Synchronize metadata for the first time
---------------------------------------

In order to synchronize the metadata tables with M-File server execute
the procedure
`spMFSynchronizeMetadata <page36536335.html#Bookmark26>`__.This
procedure will internally call all required procedures

i.e.

-  ·        \ **spMFSynchronizeLoginAccount**
-  ·        \ **spMFSynchronizeUserAccount**
-  ·        \ **spMFSynchronizeObjectType**
-  ·        \ **spMFSynchronizeProperties**
-  ·        \ **spMFSynchronizeValueList**
-  ·        \ **spMFSynchronizeValueListItems**
-  ·        \ **spMFSynchronizeWorkflow**
-  ·        \ **spMFSynchronizeWorkflowsStates**
-  ·        \ **spMFSynchronizeClasses**

Each spMFSynchronize\* procedure will internally call two
other procedures

spMFGet\*

spMFInsert\*

spMFGet\* procedure will connect to M-Files server and get the metadata
details in XML format and spMFInsert\* procedure will insert those
details into the respective metadata tables.



Synchronize specific metadata
-----------------------------

Use `spMFSynchronizeSpecificMetadata <page36536341.html#Bookmark27>`__
to update a specific type of metadata.  This is particularly useful when
a small change was made in the vault that need to be pulled through.  

When changes are made to classes it is very important to perform
all the dependent specific synchronizations before doing the class
synchronization.



Synchronize metadata Tables with new Vault
------------------------------------------

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
