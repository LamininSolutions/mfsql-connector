
Working with date and time
==========================

Comparing date and time or producing reports with time comparisons necessitates a deeper understanding of how the Connector deals with dates.

M-Files store date and time of an object in UTC (universal time).  This is of importance for evaluating the time in the following columns.

=========================  =============
Property                   Property ID
=========================  =============
Last modified              21
Created                    20
Deleted                    27
Status Changed             24
Moved into current state   40
Accessed by me             81
Object Changed             89
=========================  =============

However, when a user look at the Created and Last Modified properties on the metadata card, it is displayed in local time.

The columns for these dates in every class table are also stored in UTC. The columns Last Modified, Created and Deleted would be by default on a class table. The other properties are optional. If the values in the class table is compared with the metadata card of an object it will be different, depending on the offset of the local time to UTC.

The "lastmodified" column in every class table is NOT the last modified date and time of the object.  This column shows the last time that the specific row was updated in SQL.  This is shown in local time.

The following list of columns and date all reflect local time

======================   =====================
Table Name               Date Column
======================   =====================
MFlog                    CreateDate
MFAuditHistory           TranDate
MFUpdateHistory          CreatedAt
MFObjectChangeHistory    CreatedOn
MFPublicLink             DateCreated
MFContextMenu            Last_Executed_Date
MFProcessBatchDetail     CreatedOn
======================   =====================

The column LastModifiedUTC in the MFObjectChangeHistory table, which shows the date and time of the change, is in UTC
MFProcessBatchDetail show the created date in both UTC and local time.

The following is an example of converting the last modified date to a local time date

.. code:: sql

      select objid
      , Name_Or_Title
      , MF_Last_Modified
      ,SWITCHOFFSET(MF_Last_Modified,datename(TZOFFSET,sysdatetimeoffset()))  MFLastModified_local_time
      , Customer
      from MFCustomer

SQL offers many data and time related data types and functions. The following includes some of the most pertinent related to UTC and local time conversions.

.. code:: sql

      select  getdate() sqllocaltime
      , getutcdate() utctime
      , sysdatetimeoffset() localtime_including_offset
      ,datename(TZOFFSET,sysdatetimeoffset()) offset
      ,SWITCHOFFSET(GETUTCDATE(),datename(TZOFFSET,sysdatetimeoffset()))
