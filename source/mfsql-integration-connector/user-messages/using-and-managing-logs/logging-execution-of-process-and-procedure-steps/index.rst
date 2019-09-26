Logging execution of Process and Procedure Steps
================================================

.. toctree::
   :maxdepth: 4

   process-logging/index

Summary of logging function
===========================

The folllowing  tables are related to logging of the process.


=========================================================================================================================== =======================================================================================================================
Table                                                                                                                       Use
=========================================================================================================================== =======================================================================================================================
`MFProcessBatch <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/55921730/Process+Batch+log+tables>`__       The calling procedure and all of the other procedures that is called by this procedure is recorded as a single process.
`MFProcessBatchDetail <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/55921730/Process+Batch+log+tables>`__ Each ProcessBatch have multiple procedure steps recorded in this table with reference to the MFProcessBatch
`MFUpdateHistory <page21200982.html#Bookmark61>`__                                                                          The Update_ID of MFUpdateHistory is recorded on the MFProcessBatchDetail record
=========================================================================================================================== =======================================================================================================================

#. When procedure is called it will assess if the it was called directly
   or by another procedure.
#. The calling procedure will pass through the ProcessBatch_ID.  A new
   ProcessBatch_ID will be created in table MFProcessBatch if no
   ProcessBatch_ID is passed through.
#. The procedure will insert records into MFProcessBatchDetail at on the
   execution of set procedure steps to record the outcome of these
   steps.
#. On completion of the procedure the process result will be updated in
   MFProcessBatch to record the outcome of the process.



Setting switch to use process logging
=====================================

MFSettings table contains a switch 'App_DetailLogging' set by default to
0.  To enable logging to MFProcessBatch and MFProcessBatchDetail the
switch must be set to 1.



Calling procedure or executing instruction
==========================================

 All procedures that is subject to logging will have @ProcessBatch_ID as
an input parameter. Procedures can be stringed together into one main
process by passing the ProcessBatch_ID from one procedure to another.


Related procedures
==================

The following procedures will automatically update MFProcessBatch and
MFProcessBatchDetail when the procedure is executed or called by another
procedure

=============================================================================================================== ===========================================================================
Procedure                                                                                                       Use
=============================================================================================================== ===========================================================================
spMFUpdateTable                                                                                                 Logging key sub processes for synchronizing records between M-Files and SQL
`spMFSynchronizeMetadata <https://lamininsolutions.atlassian.net/wiki/display/MFSQL/spMFSynchronizeMetadata>`__ Logging of synchronisation of metadata
=============================================================================================================== ===========================================================================

Procedures to update the logging
================================

The following procedures are used to update or insert records in the
logging tables. These procedures can be imitated to build logging of
custom applications.

============================= =================================
Procedure                     Use
============================= =================================
spMFProcessBatch_upsert       Create new ProcessBatch_ID
                             
                              Update / insert of process record
spMFProcessBatchDetail_insert Insert procedure step result
============================= =================================
