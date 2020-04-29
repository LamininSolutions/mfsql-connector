
=====================
MFObjectChangeHistory
=====================

Columns
=======

ID int (primarykey, not null)
  SQL primary key
ObjectType\_ID int
  - MF ID of the object Type of the class
Class\_ID int
  MF ID of the class
ObjID int
  ObjID of the object
MFVersion int
  Version of the object where the value changed for the property in column Property_ID
LastModifiedUtc datetime
  The 'CheckInTimeStamp of the specific version for the object
MFLastModifiedBy\_ID int
  MF ID of the user
Property\_ID int
  MF ID of the property
Property\_Value nvarchar(300)
  - Value as a string
  - Interpreting and relating to this value will depend on the type of property.
CreatedOn datetime
  Timestamp when row was created

Additional Info
===============

Get values related the the ObjectType using MFclass table. The MFObjectTyoe_ID on MFClass table references the ID column in MFObjectType table.

Only versions matching the filters on the spMFGetHistory procedure is fetched.  Widening the filters may restrict the MFVersions returned. Narrowing the filters will not remove the rows previously fetched for the object.

The timestamp is shown in Universal Time.

Used By
=======

- spMFGetHistory


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
2017-02-10  DevTeam2   Create Table
==========  =========  ========================================================

