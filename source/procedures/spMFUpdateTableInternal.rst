
=======================
spMFUpdateTableInternal
=======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @TableName nvarchar(128)
    passed through by internal operation
  @Xml nvarchar(max)
    passed through by internal operation
  @Update\_ID int
    passed through by internal operation
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode
  @SyncErrorFlag bit
    - optional
    - set by internal operations


Purpose
=======

The purpose of this procedure is to update SQL class table with the result from M-Files

Additional Info
===============

This procedure is used internally only

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-04-14  LC         Fix timestamp datatype bug
2021-03-02  LC         Remove check for required workflows, check is included in spMFClassTableStats
2020-11-07  LC         Resolve issue with duplicate columns and multilookup datatype
2020-10-22  LC         set datetime conversion to 102 (ansi)
2020-10-22  LC         Required workflow check is only performed on updated objects
2020-09-23  LC         Remove rows from other classes for table update
2020-09-04  LC         split merge into parts per advice
2020-09-04  LC         move updating of audit history to smpfupdatetable
2020-08-26  LC         revise error checking for required workflows
2020-08-18  LC         replace column deleted flag with property 27 (deleted) datetime
2020-07-27  LC         Update to handle new status for deleted and checked out     
2020-06-20  LC         Fix bug with localisation error on workflow
2020-02-20  LC         Change assembly to system.culture time
2019-11-18  LC         Update time format to address localisation
2019-08-30  JC         Added documentation
2019-04-01  LC         Add process_id = 0 as condition
2018-12-17  LC         formatting of boolean property
2018-12-16  LC         prevent record from wrong class in class table
2018-10-02  LC         Fix localization bug on  missing quotename
2018-08-23  LC         Resolve sync error bug
2018-08-01  LC         Resolve deletions for filter objid
2018-07-03  LC         locatlisation for finish datetime
2018-06-22  LC         Localisation of workflow_id, name_or_Title property name
2017-11-29  LC         Fix Is Templatelist temp file to allow for multiple threads
2017-08-22  LC         Add synch error auto correction
2017-07-06  LC         Add updating of Filecount
17-04-2015  DEV 2      DATETIME column value convertion is changed
16-05-2015  DEV 2      Record Update/Insert logic is modified 
16-05-2015  DEV 2      (new logic : one record insert/update at a time and 
16-05-2015  DEV 2      skip the records which fails to insert/update)
25-05-2015  DEV 2      New input parameter added (@Update_ID)
25-05-2015  DEV 2      Adding @Update_ID & ExtrenalID into MFLog table
30-06-2015  DEV 2      Changed the return value to 4 if any record failed insert/Update
08-07-2015  DEV 2      Template object issue resolved
08-07-2015  DEV 2      BIT Column value resolved
22-2-2016   LC         Update Error logging, remove Is_template
10-8-2016   LC         update objid filter to fix bug
17-8-2016   LC         conversion of float columns for comma as decimal character
19-8-2016   LC         update to take account of class table name in foreign languages 
26-8-2016   LC         change usage of temptables to global variables and convert to multi user
10-11-2016  LC         fix bug for records with Null values in required fields
==========  =========  ========================================================

