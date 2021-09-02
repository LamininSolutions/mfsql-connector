Error tracing
=============

.. toctree::
   :maxdepth: 4

   correcting-synchronization-errors/index

Tracing MFSQL Errors has many different dimensions and investigating an
error may require several steps.

Error reporting
---------------

Errors becomes visible in different ways:

#. If Database mail was setup and the settings in MFSettings is setup
   for email notifications then the support email recipient will receive
   an email when one of the following errors happen:

   #. Synchronization error (process_id = 2)
   #. M-Files processing error (process_id = 3)
   #. SQL Database error (process_id = 4)

#. errors can be reviewed in table MFLog (Select \* from MFLog order by
   logid desc)
#. exec spmfClassTableStats will show a listing of all class tables and
   if it has errors.

Errors
------

All error details are logging into the MFLog and error details will send
as email to support email mentioned in the Setting table. MFLog is cross
referenced to MFUpdateHistory. This table includes the information on
the objects that were updated/produced an error.

If the error occurred during insert/update objects into the M-Files,
there are different types of errors

1. Error occurred while executing SQL script

2. Error occurred while executing Connector assembly codes

3. Error occurred while insert/update into M-Files.

3.1. Error due to version conflicts 

3.2. Error due to some validation fails from M-Files

4. Error occurred while insert/update records into MF Tables due to
converting values into specific data type.

If error type 1 & 2 occurs, execution will terminate and changes will
roll-back. If error type 3 & 4 occurs, execution will skip that record
and continue with next record and the error details will log into MFLog
table with ObjID, error message, Table Name. If error type 3 occurs,
then reference to MFUpdateHistory table also will be inserting in MFLog
table. So that you can cross check with MFUpdateHistory table and find
the record which failed to insert/update.

Errors are reported by email. See below for a sample of an email

Synchronization errors
----------------------

A syncronisation error will result where object version in SQL is
incompatible with the object version in M-Files. These errors can
include

-  When process_ID is 1, indicating an update from SQL to M-Files, and
   the M-Files version in M-Files is later than the M-Files version in
   SQL
-  When process_ID is 0, and update method 1 or 2 is used and the
   M-Files version in SQL is later than the M-Files version in M-Files.

A syncronisation error will result in a the Connector creating a new
object in SQL with a process_id of 2.

From version 3.1.2.38 functionality is included to allow for automatic
correction of synchronization errors.  This feature is explained in
detail in Correcting Synchronization Errors.

Common Errors
-------------

**Failed to insert ObjID**

Error message :Cannot insert the value NULL into column *Name of Column*, table *Name of Table*; column does not
allow nulls. INSERT fails. Cause for error. It is likely that a change
was made in M-Files changing a property to required and where there are
missing values in for the property in M-Files.

Corrective action.
-  option 1. Add the missing values in M-Files and retry the updating of
the table.
-  option 2: edit the table in SSMS and remove 'is not null'
from the column of the table. After the values have been added using
SSMS the column settings can be reset to 'is not null'.

**Unable to establish a correction**

A .NET Framework error occurred
during execution of user-defined routine or aggregate:  
System.Runtime.InteropServices.COMException: Network problems are
preventing M-Files from communicating with the server.  The RPC server
is unavailable.   

This error sometimes happen if establishing a
connection timed out which could related to the connection between the
SQL server and M-Files server.  It usually is sufficient to try again. 
if this issue persists then it requires deeper investigation. contact
support.

Error back tracking
-------------------

Investigating an error will depend on the nature of the error.  

-  Check the most recent entry in MFLog.  Copy and past the
   'ErrorMessage' column to notepad to see the entire error
-  View the transaction update that has caused the error by using the
   MFUpdateHistory.  Use spMFUpdateHistoryshow procedure to list the
   records
-  Get more detail on the actual procedure step that is causing the
   issue by using the MFProcessBatch and MFProcessBatchDetail tables.

The following script show the quick steps to follow to isolate an error

.. code:: sql

	--details of last errors
	Select top 10 CreateDate,ErrorMessage, spName, ProcedureStep, * from mflog order by logid desc

	--unprocessed errors in class tables (result should show none)
	Select * from ClassTableName where Process_ID <> 0

	--is flag for processes running OK: IsProcess running shouled be 0, date show last time it was called
	select * from MFContextMenu

	--if is IsProcessRunning = 1 and the procedure has not been called in the last 30 minutes then reset this flag
	update MFContextMenu
	set IsProcessRunning = 0
	where IsProcessRunning = 1

	--check outcome of processes
	Select * from MFProcessBatch order by ProcessBatch_ID desc

	--inspect details of a particular process
	Select * from MFProcessBatchDetail
	where ProcessBatch_ID = 1335 -- use result from previous script to get the number

**Related Topics**
------------------

-  :doc:`/mfsql-integration-connector/using-and-managing-logs/mfupdatehistory-for-logging-of-class-record-changes/index`
-  :doc:`/the-connector-framework/connector-content/logging-tables/index`
-  :doc:`/mfsql-integration-connector/using-and-managing-logs/index`
-  :doc:`/blogs/using-spmfclasstablestats/index`
