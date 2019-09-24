spMFGetMfilesLog
================

The connector allows for exporting the M-Files Event Log into SQL for
further analysis.

The procedure extracts all the events in the log and automatically
create a table showing event type information and includes the detail of
the event as an XML record.  Below is some examples of extracting
specific information from the XML record.



Export Event Log
----------------

This procedure can be used on demand. Alternatively it can be included
in an Agent to schedule the export on a regular basis.  This may be
particularly relevant as M-Files automatically drops events and only
maintain the last 10 000 event records.

| 

.. container:: table-wrap

   ============== ===============================================================================================================================
   Type           Description
   ============== ===============================================================================================================================
   Procedure Name ::
                 
                     spMFGetMfilesLog
   Inputs         IsClearMFilesLog : 0 = Do not Clear
                 
                  1 = Clear Log in M-Files
   Output         Table MFEventLog_OpenXML will be updated with the XML for the entire current log
                 
                  At the same time table MFilesEvents will be updated showing the individual events with an XML of the data of the specific event
   ============== ===============================================================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFGetMfilesLog]
             @IsClearMfilesLog = 0 -- bit



MFilesEvents Table
------------------

The MFilesLog table show the events exported using the spMFGetMFilesLog
procedure.

The following columns are included:

.. container:: table-wrap

   =========== ========================================================
   Column      Use
   =========== ========================================================
   ID          Event log id
   Type        Type of event
   Category    Category of event
   TimeStamp   Time and date of event
   CauseByUser User ID that triggered event
   LoadDate    Date That XML was exported and last updated from M-Files
   Event       XML record of the full event
   =========== ========================================================

The XML of the event is a variable record and the data in each event
will depend on the type of event and if advanced event logging has been
installed or not.

A sample of an XML for a new object 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Sample Event XML**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          <event>
           <id>35543</id>
           <type id="NewObject">New document or other object</type>
           <category id="3">NewObject</category>
           <timestamp>2016-11-25 16:27:57.226000000</timestamp>
           <causedbyuser loginaccount="LS-CilliersL" />
           <data>
             <objectversion>
               <objver>
                 <objtype id="162">Test</objtype>
                 <objid>1163</objid>
                 <version>1</version>
               </objver>
               <extid extidstatus="Internal">1163</extid>
               <objectguid>{84E076F0-92A1-49CD-961E-D4A293512FC3}</objectguid>
               <versionguid>{6B2E37C4-2D8F-4B33-A5BE-A117BB9EF7D3}</versionguid>
               <objectflags value="64">
                 <objectflag id="64">normal</objectflag>
               </objectflags>
               <originalobjid>
                 <vault>{3F4B2DFA-6D56-4D2D-AC4C-8AB3EF7DFE54}</vault>
                 <objtype>162</objtype>
                 <id>1163</id>
               </originalobjid>
               <title>Lakeisha222</title>
               <displayid>1163</displayid>
             </objectversion>
           </data>
         </event>

Standard XML based queries can be used against this table to report on
or explore events.

Following is a some examples of the construct of these type of queries.



Query to show some details of objects that is not system objects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

           Select id 
          ,me.[Category]
          ,me.[CausedByUser]
          ,me.[TimeStamp]                                                               
         , Events.value('(/event/data/objectversion/title)[1]','varchar(100)') as NameOrTitle
         , Events.value('(/event/data/objectversion/objver/objtype/@id)[1]','varchar(100)') as ObjectType_ID
         , Events.value('(/event/data/objectversion/objver/objtype)[1]','varchar(100)') as ObjectType
         , Events.value('(/event/data/objectversion/objver/objid)[1]','varchar(100)') as [Objid]
         From [dbo].[MFilesEvents] me
         WHERE me.Category <> 'System'



Query to show files downloaded  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

           Select id 
          ,me.[Category]
          ,me.[CausedByUser]
          ,me.[TimeStamp]                                                               
         , Events.value('(/event/data/objectversion/title)[1]','varchar(100)') as NameOrTitle
         , Events.value('(/event/data/filename)[1]','varchar(100)') as [FileName]
         , Events.value('(/event/data/objectversion/objver/objtype/@id)[1]','varchar(100)') as ObjectType_ID
         , Events.value('(/event/data/objectversion/objver/objtype)[1]','varchar(100)') as ObjectType
         , Events.value('(/event/data/objectversion/objver/objid)[1]','varchar(100)') as [Objid]
         From [dbo].[MFilesEvents] me
         WHERE me.Category = 'FileAccess'



Query to show public file downloads
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

           Select id 
          ,CAST([me].[TimeStamp] AS DATETIME) AS [Timestamp]                                                              
         , Events.value('(/event/data/objectversion/title)[1]','varchar(100)') as NameOrTitle
         , Events.value('(/event/data/filename)[1]','varchar(100)') as [FileName]
         , Events.value('(/event/data/ipaddress)[1]','varchar(100)') as IPAddress
         , Events.value('(/event/data/objectversion/objver/objtype)[1]','varchar(100)') as ObjectType
         , Events.value('(/event/data/objectversion/objver/objid)[1]','varchar(100)') as [Objid]
         , Events.value('(/event/data/objectversion/objver/version)[1]','varchar(100)') as [Version]

         ,[me].[Events]
         From [dbo].[MFilesEvents] me
         WHERE me.[Type] = 'File downloaded via public link'
