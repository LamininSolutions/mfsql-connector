
===================================
spMFSearchForObjectbyPropertyValues
===================================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ClassID int
    ID of the class
  @PropertyIds nvarchar(2000)
    Property IDs separated by comma
  @PropertyValues nvarchar(2000)
    Property values separated by comma
  @Count int
    The maximum number of results to return
  @OutputType int
    - 0 = output to XML (default)
    - 1 = output to temporary table and update MFSearchLog
  @XMLOutPut xml (output)
    Used if outputType = 0 then this parameter returns the result in XML format
  @TableName varchar(200) (output)
    Used if outputType = 1 then this parameter returns the name of the temporary file with the result

Purpose
=======

To search for objects with class id and some specific property id and value.

Additional Info
===============

This procedure will call spMFSearchForObjectByPropertyValuesInternal and get the objects details that satisfies the search conditions and shows the objects details in tabular format.

Examples
========

.. code:: sql

    DECLARE @RC INT
    DECLARE @ClassID INT
    DECLARE @PropertyIds NVARCHAR(2000)
    DECLARE @PropertyValues NVARCHAR(2000)
    DECLARE @Count INT
    DECLARE @OutputType INT
    DECLARE @XMLOutPut XML
    DECLARE @TableName VARCHAR(200)

    -- TODO: Set parameter values here.
    EXECUTE @RC = [dbo].[spMFSearchForObjectbyPropertyValues]
       @ClassID
      ,@PropertyIds
      ,@PropertyValues
      ,@Count
      ,@OutputType
      ,@XMLOutPut OUTPUT
      ,@TableName OUTPUT
    GO

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2019-08-13  LC         Added Additional option for search procedure
2019-05-08  LC         Change target table to a temporary table
2018-04-04  DEV2       Added License module validation code.
2016-09-26  DEV2       Removed vault settings parameters and pass them as comma separated string in @VaultSettings parameters.
2016-08-27  LC         Update variable function paramaters
2016-08-24  DEV2       TaskID 471
2014-04-29  DEV2       RETURN statement added
==========  =========  ========================================================

