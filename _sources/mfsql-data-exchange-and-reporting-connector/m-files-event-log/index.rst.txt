M-Files event log
=================

.. toctree::
   :maxdepth: 4

   view-downloaded-files/index

The Connector includes the ability to export the event log from
M-Files.  The event log is save in SQL in XML format in the
MFEventLog_OpenXML table by executing the spMFGetMFilesLog  procedure. 
At the same time the MFilesEvents table is updated with details of the
individual events.

The events is analysed using SQL queries for the specific types of
events.

Using the export event export procedure and analysing the data is
described in :doc:`/procedures/spMFGetMfilesLog`


Export the event log
--------------------

.. code:: sql

    EXEC [dbo].[spMFGetMfilesLog] @IsClearMfilesLog = 0 -- bit  select 1 to delete the log in M-Files
                             ,@Debug = 0;

Review the result
-----------------

Record of each export in XML format

.. code:: sql

   SELECT * FROM [dbo].[MFEventLog_OpenXML];

Get listing of each exported event

.. code:: sql

    SELECT * FROM [dbo].[MFilesEvents] AS [mfe];

Analyse the events using XML queries
------------------------------------

Show objects that is not system objects

.. code:: sql

    SELECT [me].[ID]
      ,[me].[Category]
      ,[me].[CausedByUser]
      ,[me].[TimeStamp] 
      ,[me].[Events].[value]('(/event/data/objectversion/title)[1]', 'varchar(100)')              AS [NameOrTitle]
      ,[me].[Events].[value]('(/event/data/objectversion/objver/objtype/@id)[1]', 'varchar(100)') AS [ObjectType_ID]
      ,[me].[Events].[value]('(/event/data/objectversion/objver/objtype)[1]', 'varchar(100)')     AS [ObjectType]
      ,[me].[Events].[value]('(/event/data/objectversion/objver/objid)[1]', 'varchar(100)')       AS [Objid]
    FROM [dbo].[MFilesEvents] [me]
    WHERE [me].[Category] <> 'System';

------------

show files downloaded

.. code:: sql

    SELECT [me].[ID]
      ,[me].[Category]
      ,[me].[CausedByUser]
      ,[me].[TimeStamp]
      ,[me].[Events].[value]('(/event/data/objectversion/title)[1]', 'varchar(100)')              AS [NameOrTitle]
      ,[me].[Events].[value]('(/event/data/filename)[1]', 'varchar(100)')                         AS [FileName]
      ,[me].[Events].[value]('(/event/data/objectversion/objver/objtype/@id)[1]', 'varchar(100)') AS [ObjectType_ID]
      ,[me].[Events].[value]('(/event/data/objectversion/objver/objtype)[1]', 'varchar(100)')     AS [ObjectType]
      ,[me].[Events].[value]('(/event/data/objectversion/objver/objid)[1]', 'varchar(100)')       AS [Objid]
    FROM [dbo].[MFilesEvents] [me]
    WHERE [me].[Category] = 'FileAccess';

-----------

show public files downloaded

.. code:: sql

    SELECT [me].[ID]
      ,[me].[TimeStamp]   AS [Timestamp]
      ,[me].[Events].[value]('(/event/data/objectversion/title)[1]', 'varchar(100)')          AS [NameOrTitle]
      ,[me].[Events].[value]('(/event/data/filename)[1]', 'varchar(100)')                     AS [FileName]
      ,[me].[Events].[value]('(/event/data/ipaddress)[1]', 'varchar(100)')                    AS [IPAddress]
      ,[me].[Events].[value]('(/event/data/objectversion/objver/objtype)[1]', 'varchar(100)') AS [ObjectType]
      ,[me].[Events].[value]('(/event/data/objectversion/objver/objid)[1]', 'varchar(100)')   AS [Objid]
      ,[me].[Events].[value]('(/event/data/objectversion/objver/version)[1]', 'varchar(100)') AS [Version]
      ,[me].[Events]
    FROM [dbo].[MFilesEvents] [me]
    WHERE [me].[Type] = 'File downloaded via public link';

--------------

Performance of a process

.. code:: sql

     WITH [cte]
     AS (SELECT [me].[ID]
          ,[me].[TimeStamp]
          ,[me].[Events].[value]('(/event/data/objectversion/title)[1]', 'varchar(100)')          AS [NameOrTitle]
          ,[me].[Events].[value]('(/event/data/filename)[1]', 'varchar(100)')                     AS [FileName]
          ,[me].[Events].[value]('(/event/data/ipaddress)[1]', 'varchar(100)')                    AS [IPAddress]
          ,[me].[Events].[value]('(/event/data/objectversion/objver/objtype)[1]', 'varchar(100)') AS [ObjectType]
          ,[me].[Events].[value]('(/event/data/objectversion/objver/objid)[1]', 'varchar(100)')   AS [Objid]
          ,[me].[Events].[value]('(/event/data/objectversion/objver/version)[1]', 'varchar(100)') AS [Version]
          ,[me].[Events]
    FROM [dbo].[MFilesEvents] [me]
    WHERE [me].[Category] = 'NewObject')
    ,[CTE2]
    AS (SELECT [cte].[Objid]
          ,[cte].[NameOrTitle]
          ,LEAD([cte].[TimeStamp]) OVER (ORDER BY [cte].[ID]) [ProcessEnd]
          ,LAG([cte].[TimeStamp]) OVER (ORDER BY [cte].[ID])  [ProcessStart]
    FROM [cte])
    SELECT [CTE2].[Objid]
      ,[CTE2].[NameOrTitle]
      ,[CTE2].[ProcessStart]
      ,[CTE2].[ProcessEnd]
     ,DATEDIFF(MILLISECOND,CONVERT(DATETIME, SUBSTRING([CTE2].[ProcessStart],1,22)),CONVERT(DATETIME, SUBSTRING([CTE2].[ProcessEnd],1,22))) AS Diff
    FROM [CTE2];

------------------

show number of object created in a particular timeframe

.. code:: sql

    WITH [cte]
    AS (
    SELECT [me].[ID]
          ,CONVERT(DATETIME, SUBSTRING([me].[TimeStamp],1,22)) AS EventDate
          ,[me].[Events].[value]('(/event/data/objectversion/title)[1]', 'varchar(100)')          AS [NameOrTitle]      
          ,[me].[Events].[value]('(/event/data/objectversion/objver/objtype)[1]', 'varchar(100)') AS [ObjectType]
          ,[me].[Events].[value]('(/event/data/objectversion/objver/objid)[1]', 'varchar(100)')   AS [Objid]
          ,[me].[Events].[value]('(/event/data/objectversion/objver/version)[1]', 'varchar(100)') AS [Version]
    FROM [dbo].[MFilesEvents] [me]
    WHERE [me].[Category] = 'NewObject')
   SELECT ObjectType, MIN(EventDate) AS fromDate ,MAX(Eventdate) AS ToDate, COUNT(*) AS RecCount FROM [cte]
   GROUP BY ObjectType

