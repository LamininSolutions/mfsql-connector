
====================
spMFUpdateItemByItem
====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName varchar(100)
    Name of table to be updated
  @WithTableAudit bit (optional) 
    Default = 0, if set to 1 then a table audit will be performed and only non processed items will be included
  @RetainDeletions bit (optional)
    - Default = 0; deletions removed by default, set to 1 to retain deletions in class table  
  @SingleItems bit (optional)
    - Default = 1; processed one-by-one, this is always the case   
  @SessionIDOut int (output)
    Output of the session id that was used to update the results in the MFAuditHistory Table
  @Debug smallint 
    Default = 0

Purpose
=======

This procedure is useful when forcing an update of objects from M-Files to SQL, even if the version have not changed.  This is particular handly when changes in M-Files has taken place that did not trigger a object version change such as changes to objects and valuelist labels and external repository changes.

This is also useful when there are data errors in M-Files and it is necessary to determine which specific records are not being able to be processed.

Additional Info
===============

Note that this procedure use updatemethod 1 by default.  It returns a session id.  this id can be used to inspect the result in the MFAuditHistory Table. Refer to Using Audit History for more information on this table

Examples
========

.. code:: sql

    DECLARE @RC INT
    DECLARE @MFTableName VARCHAR(100) = 'MFCustomer'
    Declare @WithTableAudit bit = 1
    DECLARE @Debug SMALLINT = 101
    DECLARE @SessionIDOut INT

    EXECUTE @RC = [dbo].[spMFUpdateItemByItem]
                        @MFTableName
                        ,@WithTableAudit
                       ,@Debug
                       ,@SessionIDOut OUTPUT

    SELECT @SessionIDOut

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-08-26  LC         fix return value to 1 for success
2021-08-26  LC         Add parameter for RetainDeletions
2021-03-27  LC         Change parameters
2021-03-27  LC         Add option to perform table audit
2021-03-09  LC         Update documentation
2020-08-28  LC         Set getobjver to date 2000-01-01
2020-08-22  LC         Update for new deleted column
2019-08-30  JC         Added documentation
==========  =========  ========================================================

