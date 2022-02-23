
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

To show the details of a specific update history record for updates using spmfupdatetable.  

The parameter 'IsSummary' = 1 will show a summary of each column in addition to the result for the selected column.  With IsSummary = 0 only the detail for the selected column will be shown.

The result is a join between the column data and the class table.  The first couple of columns has additional info for identification.

Additional Info
===============

The significance of the update column depends on the update method
  - 0 : Objects in class updated from SQL to MF
  - 1 : Objects in class updated from MF to SQL
  - 10: Object versions updated in audit history
  - 11: Object Change versions update in objectChange History

Update column reference
 - UpdateColumn 0 = ObjectDetails: 
   - UpdateMethod 1,10 : represent the objecttype and class, will always show 1 record
   - UpdateMethod 0 : represents the objects in the class to be updated, will show the number of properties to be updated
   - UpdateMethod 11 : class id and property id for changes
 - UpdateColumn 1 = ObjectVerDetails:
   - UpdateMethod 1,11 : represents the object ver in SQL to be compared with MF, will show the number of records to be updated
   - UpdateMethod 0,10 : not used
 - UpdateColumn 2 = NewOrUpdatedObjectVer: 
   - UpdateMethod 1 : Not used
   - UpdateMethod 0,10 : represents the object ver in SQL to be updated in MF, will show the number of records to be updated
   - UpdateMethod 11 :represents the objectversions returned from MF
 - UpdateColumn 3 = NewOrUpdateObjectDetails: 
   - UpdateMethod 0,1 : Represents the object ver details from MF to be updated in SQL, will show the number of properties to be updated

 - UpdateColumn 4 = SyncronisationErrors  (not yet implemented)
 - UpdateColumn 5 = MFError  (not yet implemented)
 - UpdateColumn 6 = DeletedObjects (not yet implemented)

Warning
=======

MFUpdatehistory has records for different types of operations.  This procedure is targeted and showing updates to and from M-Files using the spMFupdateTable, spMFTableAudit and spMFUpdateObjectChange procedure. 

Examples
========

.. code:: sql
    
    EXEC dbo.spMFUpdateHistoryShow @Update_ID = 30,
    @IsSummary = 1,
    @UpdateColumn = 3,
    @Debug = 0

    select * from mfupdatehistory where id = 30

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-12-24  LC         Sset default for updatecolumn to null
2021-12-22  LC         Add Audit History and Object Change history show records
2021-12-13  LC         Remove redundant temp table from printing
2021-02-03  LC         Rewrite the procedure to streamline and fix errors
2020-08-22  LC         Update for impact of new deleted column
2018-05-09  LC         Fix bug with column 1
2018-08-01  LC         Fix bug with showing deletions
2017-06-09  LC         Change options to print either summary or detail
2017-06-09  Arnie      produce single result sets for easier usage
2016-01-10  LC         Create procedure
==========  =========  ========================================================

