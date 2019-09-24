Working with Object Version
===========================

The spMFTableAudit procedure gets the Object Version (Object ID,
Version, Object Type and Guid) and update the result in the
MFAuditHistory table. The procedure can be deployed in many different
scenarios.

The Audit History table is included to assist with the tracking of
objects and updates between M-Files and SQL.  This is useful when errors
or omissions need to be investigated.

This table can also be used to determine which objects had a change of
version and therefore requires updating.

There are two primary procedures for using this functionality

-  `spMFTableAudit <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/686030990/spMFTableAudit>`__
-  `spMFTableAuditInBatches <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/685899953/spMFTableAuditinBatches>`__

Procedures that automatically update MFAuditHistory include:

-  `spMFUpdateItemByItem <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/31817730/spMFUpdatetable+Class+Table+Records>`__
-  `spMFUpdateMFilesToSQL <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/31817730/spMFUpdatetable+Class+Table+Records>`__
-  `spMFClassTableStats <page22478933.html#Bookmark27>`__



MFAuditHistory table
--------------------

The Audit History table include the following records.

.. container:: table-wrap

   +--------+-------------------------------------------------------------+
   | Column | Description                                                 |
   +========+=============================================================+
   | ID     | identity int for records in the table                       |
   +--------+-------------------------------------------------------------+
   | RecID  | the id of the record in the class table. if null then the   |
   |        | record was not yet in the table when the session was        |
   |        | processed                                                   |
   +--------+-------------------------------------------------------------+
   | Sessio | sequential number for the session. Each update for a        |
   | nID    | specific class is regarded as a session. The latest session |
   |        | for a class represents the status of the records when the   |
   |        | audit history was last updated.                             |
   +--------+-------------------------------------------------------------+
   | TranDa | date that the session was processed                         |
   | te     |                                                             |
   +--------+-------------------------------------------------------------+
   | Object | MFID of the ObjectType of the class                         |
   | Type   |                                                             |
   +--------+-------------------------------------------------------------+
   | Class  | MFID of the Class                                           |
   +--------+-------------------------------------------------------------+
   | Objid  | Objid of the record from the Objver of the object in        |
   |        | M-Files                                                     |
   +--------+-------------------------------------------------------------+
   | MFVers | the version from the Objver when the object was processed   |
   | ion    |                                                             |
   +--------+-------------------------------------------------------------+
   | Status | 0 - the record MFversion in M-Files and SQL is identical    |
   | Flag   |                                                             |
   |        | 1 - the record MFversion in M-Files is higher than SQL.     |
   |        | This indicates a need for updating from Mfiles to SQL       |
   |        | (Updatemethod 1)                                            |
   |        |                                                             |
   |        | 2 - the SQL version is later than the M-Files version       |
   |        | (usually signalling a syncronisation error)                 |
   |        |                                                             |
   |        | 3 - the record in SQL is flagged as deleted in SQL and does |
   |        | not exist in M-Files                                        |
   |        |                                                             |
   |        | 4 - the record is not in M-Files and the record flag in SQL |
   |        | is not deleted. This usually indicate that the routine for  |
   |        | deleting records have not yet been processed.               |
   |        |                                                             |
   |        | 5 - when there is no record in SQL for an objver in         |
   |        | M-Files. This usually indicate that the records was created |
   |        | in M-Files and that the update routine has not yet been     |
   |        | run. This may indicate a need for updating from Mfiles to   |
   |        | SQL (Updatemethod 1)                                        |
   |        |                                                             |
   |        | Note that all templates in M-Files will also show as        |
   |        | statusflag 5 as templates are not inserted into SQL.        |
   |        | Execute spmfUpdateTable to move the template objects to     |
   |        | statusflag 6.                                               |
   |        |                                                             |
   |        | Also note that records showing persistly up as statusflag   |
   |        | 5, even after updating from M-Files could indicate that the |
   |        | Connector cannot access the record. A few examples of why   |
   |        | this happens have been identified:                          |
   |        |                                                             |
   |        | -  The text in a Multi-line property exceeds 4000           |
   |        |    characters                                               |
   |        | -  The object in m-files is a document collection.          |
   |        |                                                             |
   |        | 6- the Record is a template. This status flag is update by  |
   |        | spmfUpdateTable.                                            |
   |        |                                                             |
   |        | 7 - The record in SQL is marked as deleted but the record   |
   |        | exist in M-Files (likely to have been undeleted.            |
   +--------+-------------------------------------------------------------+
   | Status | Description of status                                       |
   | Name   |                                                             |
   +--------+-------------------------------------------------------------+
   | Update | this is the update status of spmfupdatetable when           |
   | Flag   | spmfupdateitembyitem is processed                           |
   +--------+-------------------------------------------------------------+

Note that the records in this table is not automatically deleted. It is
recommended that agent is used to delete old records in the table if
they are no longer required.

| 
