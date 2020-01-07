
===============
MFClassProperty
===============

Columns
=======

MFClass\_ID int (primarykey, not null)
  ID column of MFClass
MFProperty\_ID int (primarykey, not null)
  ID column of MFProperty
Required bit (not null)
  If the property is required on the class

Additional Info
===============

Used to index the relationship of Properties with Classes.

Indexes
=======

idx\_MFClassProperty\_Property\_ID
  - MFProperty\_ID

Used By
=======

- MFvwClassTableColumns
- MFvwMetadataStructure
- spMFClassTableColumns
- spMFCreateAllLookups
- spMFCreateTable
- spMFDropAndUpdateMetadata
- spMFInsertClass
- spMFInsertClassProperty
- spMFInsertProperty
- spMFSynchronizeClasses
- spMFSynchronizeFilesToMFiles
- spMFUpdateExplorerFileToMFiles


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

