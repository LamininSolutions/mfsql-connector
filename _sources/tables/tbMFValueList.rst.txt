
===========
MFValueList
===========

Columns
=======

ID int (primarykey, not null)
  SQL Primary Key
Name varchar(100)
  Name of the valuelist from M-Files
Alias nvarchar(100)
  Alias from M-Files
MFID int
  M-Files ID
OwnerID int
  Owner MFID
ModifiedOn datetime (not null)
  When was the record last modified
CreatedOn datetime (not null)
  When was the record created
Deleted bit (not null)
  Is deleted
RealObjectType bit
  set to 1 if valuelist is an full object type with classes and properties

Additional Info
===============

The column **OwnerID** references the Owner Valuelist MFID or ObjectType MFID in the case of real ObjectTypes. For
example: 'State' is owned by 'Workflow'.

-1 indicates no owner

Indexes
=======

idx\_MFValueList\_1
  - ID
  - Name
udx\_MFValueList\_MFID
  - Name
  - MFID

USAGE
=====

.. code:: sql

   Select * from MFValueList  

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

