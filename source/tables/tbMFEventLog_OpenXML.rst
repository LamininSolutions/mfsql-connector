
==================
MFEventLog_OpenXML
==================

Columns
=======

Id int (primarykey, not null)
  SQL primary key
XMLData xml
  Event log data
LoadedDateTime datetime
  Time of saving event log

Additional Info
===============

The event log is XML format in the MFEventLog_OpenXML table by executing the spMFGetMFilesLog procedure.

Used By
=======

- spMFGetMfilesLog


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

