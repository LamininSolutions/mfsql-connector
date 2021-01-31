
===================
spMFSearchForObject
===================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ClassID int
    ID of the class
  @SearchText nvarchar(2000)
    Pass name of the object for a specific record else pass NULL to get all objects
  @Count int (optional)
    - Default = 1
    - The maximum number of results to return. Specify 0 to return unlimited number of results.
  @OutputType int
    - 0 = output to XML (default)
    - 1 = output to temporary table and update MFSearchLog
  @XMLOutPut xml (output)
    Used if outputType = 0 then this parameter returns the result in XML format
  @TableName varchar(200) (output)
    Used if outputType = 1 then this parameter returns the name of the temporary file with the result
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

To search for objects with class id and name or title property.

Additional Info
===============

This procedure will call spMFSearchForObjectInternal and get the objects details that satisfies the search conditions and shows the objects details in tabular format.

The result is either:

- inserted in a temporary table. MFSearchLog is updated with the name of the table and summary of result.
- output as an XML output parameter.

One of the options when using spMFSearchForObject is to pipe the result
to a global temporary table table. The table is automatically dropped after a period of time of no use or when the SQL server is restarted.

Examples
========

result to table

.. code:: sql

     DECLARE @tablename AS sysname, @XMLOutput AS XML
    EXEC [dbo].[spMFSearchForObject] @ClassID = 78                  -- the class MFID: this can be obtained from select Name, MFID from MFClass
                                    ,@SearchText = 'A'              -- any text value, this can be a part text. It does not cater for wildcards
                                    ,@Count = 5                     -- used to restrict the number of search result returns.
                                    ,@Debug = 0
                                    ,@OutputType = 1                -- set to 1 to channel output to a table
                                    ,@XMLOutPut = @XMLOutPut OUTPUT -- is null 
                                    ,@TableName = @TableName OUTPUT;

                                                                    -- used in subsequent processing to process the search result.
    --show temp table name
    SELECT @TableName AS [TableName];

    --view search result
    SELECT *
    FROM [dbo].[MFSearchLog] AS [msl];
    GO

--------

result to XML

.. code:: sql

     DECLARE @tablename AS sysname, @XMLOutput AS XML
    EXEC [dbo].[spMFSearchForObject] @ClassID = 78                  -- the class MFID: this can be obtained from select Name, MFID from MFClass
                                    ,@SearchText = 'A'              -- any text value, this can be a part text. It does not cater for wildcards
                                    ,@Count = 5                     -- used to restrict the number of search result returns.
                                    ,@Debug = 0
                                    ,@OutputType = 0              -- set to 0 to channel output to a XML
                                    ,@XMLOutPut = @XMLOutPut OUTPUT 
                                    ,@TableName = @TableName OUTPUT;

     Select @XMLOutput


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2019-05-06  LC         Change destination of search to a temporary file
2018-04-04  DEV2       Added License Module validation code.
2016-09-26  DEV2       Removed vault settings parameters and pass them as comma separated string in @VaultSettings parameter.
2016-08-27  LC         Update variabletable function parameters
2016-08-24  DEV2       TaskID 471
2016-06-26  LC         Debugging added
2014-04-29  DEV2       RETURN statement added
==========  =========  ========================================================

