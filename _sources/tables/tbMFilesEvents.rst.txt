
============
MFilesEvents
============

Columns
=======

ID 
  Event ID - Primary key
Type 
  Event Type
Category
  Event Category
Timestamp
  Time of event in text format
CausesByUser
  Login Name of user
LoadDate
  Date when event was added to this table
Events
  Details of event in XML format
   
Indexes
=======

idx\_MfilesEvents\_Type
  - Type

  idx\_MfilesEvents\_Category
  - Category

Additional Info
===============

The xml schema of the events will differ for each type and category of events 

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-05-06  LC         Add indexes
2019-09-07  JC         Added documentation
2017-05-01  DEV2       Create Table 
==========  =========  ========================================================

