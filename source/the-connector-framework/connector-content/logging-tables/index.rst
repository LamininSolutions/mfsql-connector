Logging Tables
==============

The Connector includes several logging tables for different
purposes. Error management and functional use of these tables are
further described in the documentation of each table

:doc:`/tables/tbMFLog`: Used to store the Error details
:doc:`/tables/tbMFUpdateHistory`: Used to store the results of each record update
:doc:`/tables/tbMFProcessBatch`: Records start and finish of key processes
:doc:`/tables/tbMFProcessBatchDetail`:Records details of key sub processes with each batch process
:doc:`/tables/tbMFAuditHistory`: Records a listing of ObjectVersions when spMFTableAudit is processed.
:doc:`/tables/tbMFContextMenuQueue`: Records the calls for MFContextMenu actions
:doc:`/tables/tbMFEmaillog`: log emails sent via the bulk email routines
:doc:`/tables/tbMFExportFileHistory`: log file exports using spMFExportFiles
:doc:`/tables/tbMFFileImport`: log file imports using spMFSynchronizeFilesToMFiles

Class Record Updates
--------------------

The Connector logs updates to the ClassTables and errors. These logs are
created when spMFUpdateTable is executed.

The Table MFUpdateHistory have details of every ClassTable update that
the Connector do against SQL and M-Files.

Procedure Processing logs
-------------------------

Two tables are used to log key events for key procedures. 
MFProcessBatch has a unique reference for each process.  A single record
is created when the process starts and updated with progress of the
process until completion.  The MFProcessBatchDetail records individual
records for key events of each MFProcessBatch.

Error logs
----------

System error is logged when it is triggered in any procedure. The Table
MFLog have details of the system errors reported by the Connector.

Errors entries in MFLog Table triggers an email to the email address in the MFSettings table SupportEmailRecipient

An example of such an email is below
|Image0|

.. |image0| image:: img_3.png
