
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
  @WithAudit int
    - Default = 0
    - 1 = will include running spmftableaudit and updating info from MF
  @IncludeOutput int (optional)
    set to 1 to output result to a table ##spMFClassTableStats
  @SendReport int (optional)
    - Default = 0
    - When set to 1, and IncludeOutput is set to 1 then a email report will be sent if when any off the error columns are not null.
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

=====================  =====================================================================================================
Column                 Description
---------------------  -----------------------------------------------------------------------------------------------------
ClassID                MFID of the class
TableName              Name of Class table
IncludeInApp           IncludeInApp Flag
MissingTable           Will show a 1 when includedInApp = 1 and the table is not in the database
SQLRecordCount         Totals records in SQL (Note that this is not necessarily the same as the total per M-Files)
MFRecordCount          Total records in M-Files including deleted objects. 
                       This result is derived from the last time that spMFTableAudit procedure was run to produce a list
                       of the objectversions of all the objects for a specific class. 
MFNotInSQL             Total record in M-Files not yet updated in SQL. This excludes deleted objects in M-Files which are recorded in MFAuditTable with statusflag = 4.  It indicates that and update should be run.
SQLNotInMF             Count of records in class table not in MFAuditHistory. This may include new records in SQL, not yet pushed to M-Files.
Templates              Total records with IsTemplate Flag.  These records are excluded from the the class table
Collections            Total number of collections in class.  Note that MFSQL Connector does exclude all collections
Deleted                Total deleted in M-Files from MFAuditHistory.  
CheckedOut             Total number of records from MFAuditHistory that is checked out for the class 
RequiredWorkflowError  Total number of records with empty workflow where workflow is required in class definition
SyncError              Total Synchronization errors (process_id = 2)
Process_ID_not_0       Total of records with process_id <> 0 this includes the errors and show records that will be
                       excluded from an @updatemethod = 1 routine
MFError                Total of records with process_id = 3 as MFError
SQLError               Total of records with process_id =4 as SQL Error
LastModifed            Most recent date that SQL updated a record in the table. This is shown in local time
MFLastModified         Most recent that an update was made in M-Files on the record. This is shown in UTC
SessionID              ID  of the latest spMFTableAudit procedure execution.
=====================  =====================================================================================================

Warnings
========

The MFRecordCount results of spMFClassTableStats is only accurate based on the last execution of spMFTableAudit for a particular class table.

Corrective Action
=================

If MissingTable = 1 then run spMFCreateTable or set IncludeInApp column to null
If MFnotInSQL > 0 then rerun the update of class table
If SQLNotInMF > 0 then run spMFClasstableStats @WithAudit = 1
If CheckedOut > 0 then check in records and rerun the update of class table
If RequiredWorkflowError > 0 then update objects with the required workflow, or remove required workflow from the class table definition.
If SyncError > 0 then investigate the objects in the class table. Manually reset the process_id to 0, rerun update from M-Files or setup Sync presidence
If Process_ID_not_0 or MFError or SQLError > 0 then investigate the objects process_id and why the updating failed.  There could be many different reasons depending on the underlying process.

Use the following view to explore the MFAuditHistory

.. code:: sql

   SELECT * FROM dbo.MFvwAuditSummary

Usage
=====

This procedure can be built into other routines to trigger a report when the update has failed. Add the following as an additional step in the agent for spMFUpdateAllIncludedInApp to trigger a report to monitor the completion of the update procedure.

.. code:: sql

   EXEC dbo.spMFClassTableStats 
    @IncludeOutput = 1,
    @SendReport = 1,
    @Debug = 0

Additional Examples
===================

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

----

To include updating object information from M-files.

.. code:: sql

   EXEC [dbo].[spMFClassTableStats]
        @ClassTableName = N'YourTablename'
       ,@IncludeOutput = 1
       ,@WithAudit = 1

-----

To produce an error report

.. code:: sql

   EXEC dbo.spMFClassTableStats 
    @IncludeOutput = 1,
    @SendReport = 1,
    @Debug = 0

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-04-14  LC         Resolve issue with specifying a table name
2021-04-08  LC         Add check that table exists
2021-04-01  LC         Add column to report on number of collections 
2021-04-01  LC         Add parameter and option to send error report
2021-03-11  LC         Add column to report on number of templates
2021-03-11  LC         fix calculation of deleted objects
2021-03-02  LC         Add column to report on records without required workflow
2021-03-02  LC         Add column to report on Checked out objects
2020-12-10  LC         add new parameter to allow for a quick run without table audit
2020-09-04  LC         rebase MFObjectTotal to include checkedout
2020-08-22  LC         Update code for new deleted column
2020-04-16  LC         Add with nolock option
2020-03-06  LC         Remove statusflag 6 from notinSQL
2020-03-06  LC         Change deleted to include deleted from audit table
2020-03-06  LC         Change Column to show process_id not 0
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

