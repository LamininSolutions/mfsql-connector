
====================
spMFUpdateItemByItem
====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @TableName varchar(100)
    Name of table to be updated
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode
  @SingleItems bit (optional)
    - Default = 1; processed one-by-one
    - 0 = processed in blocks
  @SessionIDOut int (output)
    Output of the session id that was used to update the results in the MFAuditHistory Table

Purpose
=======

This is a special procedure that is useful when there are data errors in M-Files and it is necessary to determine which specific records are not being able to be processed.

Additional Info
===============

Note that this procedure use updatemethod 1 by default.  It returns a session id.  this id can be used to inspect the result in the MFAuditHistory Table. Refer to Using Audit History for more information on this table

Examples
========

.. code:: sql

    DECLARE @RC INT
    DECLARE @TableName VARCHAR(100) = 'MFCustomer'
    DECLARE @Debug SMALLINT
    DECLARE @SessionIDOut INT

    -- TODO: Set parameter values here.
    EXECUTE @RC = [dbo].[spMFUpdateItemByItem]
                        @TableName
                       ,@Debug
                       ,@SessionIDOut OUTPUT
    SELECT @SessionIDOut

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-08-28  LC         Set getobjver to date 2000-01-01
2020-08-22  LC         Update for new deleted column
2019-08-30  JC         Added documentation
==========  =========  ========================================================

