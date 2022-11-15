Logging Tables
==============

The Connector includes several logging tables for different
purposes. Error management and functional use of these tables are
further described in the documentation of each table

 - :doc:`/tables/tbMFLog`: Used to store the Error details
 - :doc:`/tables/tbMFUpdateHistory`: Used to store the results of each record update
 - :doc:`/tables/tbMFProcessBatch`: Records start and finish of key processes
 - :doc:`/tables/tbMFProcessBatchDetail`:Records details of key sub processes with each batch process
 - :doc:`/tables/tbMFAuditHistory`: Records a listing of ObjectVersions when spMFTableAudit is processed.
 - :doc:`/tables/tbMFContextMenuQueue`: Records the calls for MFContextMenu actions
 - :doc:`/tables/tbMFEmaillog`: log emails sent via the bulk email routines
 - :doc:`/tables/tbMFExportFileHistory`: log file exports using spMFExportFiles
 - :doc:`/tables/tbMFFileImport`: log file imports using spMFSynchronizeFilesToMFiles

Class Record Updates
--------------------

The Connector logs updates to the ClassTables and errors. These logs are
created when spMFUpdateTable is executed.

The Table MFUpdateHistory have details of every ClassTable update that
the Connector do against SQL and M-Files. The id of this table is recorded in the class table as the Update ID. Consequently the class table shows the id in the history of the last update to the object.

The following core operations record entries in this table:

 - :doc:`/procedures/spMFUpdateTable` - recording updates to objects in classes
 - :doc:`/procedures/spMFTableAudit` - recording updates of object versions
 - :doc:`/procedures/spMFDeleteObjectList` - recoding deletions of Objects
 - :doc:`/procedures/spMFUnDeleteObject` - recoding deletions of Objects

Use the procedure :doc:`/procedures/spMFUpdateHistoryShow` to explore summarized content and lists of a specific updateid.

The table MFAuditHistory have details of the object version (objid, version, class, object type) of every object in class tables and is used to cross check the object version status with the class table object detail.  Use the view :doc:`/views/MFvwAuditSummary` for a summarised result.  When the procedure :doc:`/procedures/spMFObjectTypeUpdateClassIndex` is run the audit table will include details of all the tables, rather than only those with class tables.  Use the view :doc:`/views/MFvwObjectChangeHistory` for details about the object count and highest objid of the class.

Procedure Processing logs
-------------------------

Two tables are used to log key events for key procedures. 
:doc:`/tables/tbMFProcessBatch` has a unique reference for each process.  A single record
is created when the process starts and updated with progress of the
process until completion.  The :doc:`/tables/tbMFProcessBatchDetail` records individual
records for key events of each process batch.

These tables also include procedures actioned through the context menu.  The activity through the vault application is also recorded in the logs defined in configurations section of the MFSQLConnector VAF Application.

These logs are set for all standard procedures.  Custom procedures can include entries to MFProcessBatch by using :doc:`/procedures/spMFProcessBatch_Upsert` and to MFProcessBatchDetail by using :doc:`/procedures/spMFProcessBatchDetail_Insert`

Error logs
----------

System error is logged when it is triggered in any procedure. The Table
:doc:`/tables/tbMFLog` have details of the system errors reported by the Connector.

Errors entries in MFLog Table triggers an email to the email address in the MFSettings table SupportEmailRecipient.  This email is dependent on setting up database mail for the server. The logs can also be inspected with

.. code:: sql

   Select * from mflog order by logid desc

An example of such an email is below
|Image0|

.. |image0| image:: img_3.png
