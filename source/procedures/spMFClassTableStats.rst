
===================
spMFClassTableStats
===================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ClassTableName nvarchar(128) (optional)
    - Default = NULL (all tables will be listed)
    - ClassTableName to show table stats for
  @Flag int (optional)
    - Default = NULL
  @WithReset int (optional)
    - Default = 0
    - 1 = deleted object will be removed, sync error reset to 0, error 3 records deleted.
  @IncludeOutput int (optional)
    set to 1 to output result to a table ##spMFClassTableStats
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

To show an extract of all the Class Tables created in the Connector database, the IncludedInApp status of the tables in MFClass the number of records in the class table and the date and time of the last updated record in the table. The date of the most recent MF_Last_Modified is also shown.

Additional Info
===============

The procedure also show a summary of the key status records from the process_id column of the tables. The number of records in the following categories are shown:

==============  ===============================================================
Column          Description
--------------  ---------------------------------------------------------------
ClassID         MFID of the class
TableName       Name of Class table
IncludeInApp    IncludeInApp Flag
SQLRecordCount  Totals records in SQL (Note that this is not necessarily the same as the total per M-Files)
MFRecordCount   Total records in M-Files. This result is derived from the last time that spMFTableAudit procedure was run to produce a list of the objectversions of all the objects for a specific class
MFNotInSQL      Total record in M-Files not yet updated in SQL
Deleted         Total for Deleted flag set to 1
SyncError       Total Synchronization errors (process_id = 2)
Process_ID_1    Total of records with process_id = 1
MFError         Total of records with process_id = 3 as MFError
SQLError        Total of records with process_id =4 as SQL Error
LastModifed     Most recent date that SQL updated a record in the table
MFLastModified  Most recent that an update was made in M-Files on the record
SessionID       ID  of the latest spMFTableAudit procedure execution.
==============  ===============================================================

Warnings
========

The MFRecordCount results of spMFClassTableStats is only accurate based on the last execution of spMFAuditTable for a particular class table.

Examples
========

.. code:: sql

   EXEC [dbo].[spMFClassTableStats]

----

To show a specific table.

.. code:: sql

   EXEC [dbo].[spMFClassTableStats] @ClassTableName = N'YourTablename'

----

To insert the report into a temporary table that can be used in messaging.

.. code:: sql

   EXEC [dbo].[spMFClassTableStats]
        @ClassTableName = N'YourTablename'
       ,@IncludeOutput = 1

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-26  LC         Update documentation
2019-08-30  JC         Added documentation
2017-12-27  LC         run tableaudit for each table to update status from MF
2017-11-23  LC         MF_lastModified set to deal with localization
2017-07-22  LC         add parameter to allow the temp table to persist
2017-06-29  LC         change mflastmodified date to localtime
2017-06-16  LC         remove flag = 1 from listing
2016-09-09  LC         add input parameter to only show table requested
2016-08-22  LC         mflastmodified date show in local time
2016-02-30  DEV2       Created procedure
==========  =========  ========================================================

