M-Files event log
=================

The Connector includes the ability to export the event log from
M-Files.  The event log is save in SQL in XML format in the
MFEventLog_OpenXML table by executing the spMFGetMFilesLog  procedure. 
At the same time the MFilesEvents table is updated with details of the
individual events.

The events is analysed using SQL queries for the specific types of
events.

Using the export event export procedure and analysing the data is
described
in \ `spMFGetMfilesLog <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/55192419/spMFGetMfilesLog>`__

| 

| 
