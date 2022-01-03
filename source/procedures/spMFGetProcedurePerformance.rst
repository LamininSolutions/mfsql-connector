
===========================
spMFGetProcedurePerformance
===========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @WithUpdateEvents (BIT)
    - default = 0
    - Set to 1 to update events from MF
  @MFSQL_User 
    - default MFSQLConnect
    - change to another user if the event log is using a different MFSQL user
  @ProcessBatch_ID (required)
    Referencing the ID of the ProcessBatch to be analysed
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode
  
Purpose
=======

To review performance for a specific process based on a processbatch_id 

Get processbatch id to focus on
select top 100 * from mfprocessbatch order by processbatch_id desc


Additional Info
===============

This procedure combines the data in the logs to get a complete picture of the entire transaction on a timeline

processbatch - get transactions (ref, type, begin, end, duration, outcome, overlapping processing)
processbatch detail - get steps (steps type, begin, end, duration
mfupdatehistory - get volume, class, outcome (class, objects, begin, end , property count, update type)
mfilesevents - get MF processing during the same time (event type, start, stop, duration, related to object)

This procedure will create a number of interim global temp files (for further analysis) and a final stats summary

##spMFBatchProcess
##spMFBatchProcessDetail
##spMFUpdateHistory
##spMFUpdateHistoryShow
##spMFObjlist
##spMFEventList
##spMFProcessStats

Examples
========

.. code:: sql

    EXEC spMFGetProcedurePerformance
    @ProcessBatch_ID = 1050
    ,@WithUpdateEvents = 0
    ,@MFSQL_User  = N'MFSQLConnect'
    ,@Debug = 0 
   

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-12-15  LC         Create new procedure
==========  =========  ========================================================

