Logging Tables
==============

.. toctree::
   :maxdepth: 4

   process-batch-log-tables/index

The Connector includes several logging tables for different
purposes. Error management and functional use of these tables are
further described in the documentation of each table

Logging Tables
--------------

:doc:`/tables/tbMFLog`: Used to store the Error details
:doc:`/tables/MFUpdateHistory`: Used to store the results of each record update
:doc:`/tables/MFProcessBatch`: Records start and finish of key processes
:doc:`/tables/MFProcessBatchDetail`:Records details of key sub processes with each batch process
:doc:`/tables/MFAuditHistory`: Records a listing of ObjectVersions when spMFTableAudit is processed.

Class Record Updates
--------------------

The Connector logs updates to the ClassTables and errors. These logs are
created when spMFUpdateTable is executed.

The Table MFUpdateHistory have details of every ClassTable update that
the Connector do against SQL and M-Files.

Procedure Processing logs
-------------------------

The processing of key processes with the associated procedures and
procedure steps are logged.  

Error logs
----------

System error is logged when it is triggered in any procedure. The Table
MFLog have details of the system errors reported by the Connector.

   errors entries in in MFLog Table triggers an email to the email
   address in the setting table SupportEmailRecipient

   An example of such an email is below
