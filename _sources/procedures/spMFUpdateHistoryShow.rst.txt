
=====================
spMFUpdateHistoryShow
=====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Update_ID
    - id of the MFUpdateHistory table to be investigated
  @IsSummary
    Set to 1 to show summary report.  The columns for further inspection is obtained from this summary
  @UpdateColumn
    Set to the column number in the summary to show the detail of the column. Note that @IsSummary must be set to 0 for @UpdateColumn to have an effect
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

To show the details of a specific update history record

Additional Info
===============

UpdateColumn 1 = ObjecVerDetails: Data from SQL to QML
UpdateColumn 2 = NewOrUpdateObjectDetails: Data From M-Files to SQL
UpdateColumn 3 = NewOrUpdatedObjectVer: Objects to be updated in M-Files
UpdateColumn 4 = SyncronisationErrors  (no object currently showing
UpdateColumn 5 = MFError  (no object currently showing
UpdateColumn 6 = DeletedObjects
UpdateColumn 7 = ObjectDetails = ObjectType & class & properities of new object  (updatemethod = 0)


Examples
========

.. code:: sql

    EXEC [spMFUpdateHistoryShow] @Debug = 1, @Update_ID = 9372, @UpdateColumn = 2

    EXEC spmfupdateHistoryShow 9366, 1, 0, 0
    Select * from MFupdatehistory where updatemethod = 0
    select * from mfupdatehistory where id = 9366

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2016-01-10  LC         Create procedure
2017-06-09  Arnie      produce single result sets for easier usage 
2017-06-09  LC         Change options to print either summary or detail
2018-08-01  LC         Fix bug with showing deletions
2018-05-09  LC         Fix bug with column 1
2020-08-22  LC         Update for impact of new deleted column  
==========  =========  ========================================================

