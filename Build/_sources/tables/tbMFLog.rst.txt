
=====
MFLog
=====

Columns
=======

LogID int (primarykey, not null)
  Log id
SPName nvarchar(max)
  Store procedure name
Update\_ID int
  Update_ID from MFUpdateHistory
ExternalID nvarchar(50)
  not used
ErrorNumber int
  SQL Error number
ErrorMessage nvarchar(max)
  SQL Error description
ErrorProcedure nvarchar(max)
  Name of procedure with error
ProcedureStep nvarchar(max)
  Procedure step
ErrorState nvarchar(max)
  SQL Error state
ErrorSeverity int
  SQL Error severity
ErrorLine int
  Procedure line reference
CreateDate datetime
  Date of error

Indexes
=======

idx\_MFLog\_id
  - LogID

Usage
=====

SQL errors when a procedure runs will update MFLog table with details of the error.  If Database Mail have been setup the entry in the table will trigger sending an email to the support address in the MFSettings table.

The records in the MFLog table will only show the last 90 days of errors if the agent to delete log history is running.

Errors can be back tracked from this table

To get support send an email to support@lamininsolutions.com and include the following:

   - screenshot of the error
   - details of the actual error from the MFlog table. Copy and past the result of the query below to your email to show the full text

..code:: sql

SELECT TOP 5 ErrorMessage, CreateDate FROM MFlog ORDER BY logid desc

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-04-08  LC         Update documentation
2019-09-07  JC         Added documentation
==========  =========  ========================================================

