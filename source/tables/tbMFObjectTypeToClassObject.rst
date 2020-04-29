
=========================
MFObjectTypeToClassObject
=========================

Description:Object Type to Class Object Table 
This is a special table for indexing all the class tables included in app accross all object types.
This table is updated using the spMFObjectTypeUpdateClassIndex procedure

Columns
=======

ID int (not null)
  ID
ObjectType\_ID int (primarykey, not null)
  Object_Type
Class\_ID int (primarykey, not null)
  Class
Object\_MFID int (primarykey, not null)
  Object
Object\_LastModifiedBy varchar(100)
  Table last modified by
Object\_LastModified datetime
  Table last modified
Object\_Deleted bit
  is Object deleted

Used By
=======

- MFvwObjectTypeSummary
- spMFObjectTypeUpdateClassIndex


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

