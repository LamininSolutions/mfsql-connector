Functional Checklist
====================

.. container:: table-wrap

   +-----------------+----------------------------+-----------------+----+
   | Function        | Description                | Minimum         |  V |
   |                 |                            | Requirement     | er |
   |                 |                            |                 | si |
   |                 |                            |                 | on |
   +=================+============================+=================+====+
   | Connection to   | Allow for M-Files IML to   |  Microsoft SQL  |  1 |
   | SQL Database    | connect to a SQL Database  | Server 2008 and |    |
   |                 | using ODBC driver          | above           | |  |
   |                 |                            |                 |    |
   |                 |                            | Oracle DB 11    |    |
   |                 |                            | and above       |    |
   |                 |                            |                 |    |
   |                 |                            | ProgresSQL is   |    |
   |                 |                            | currently being |    |
   |                 |                            | tested          |    |
   +-----------------+----------------------------+-----------------+----+
   | Get binary file | Get file data stored in    |                 | 1  |
   | data            | database table and show    |                 |    |
   |                 | file in M-Files in both    |                 |    |
   |                 | preview and open read only |                 |    |
   |                 | mode.                      |                 |    |
   +-----------------+----------------------------+-----------------+----+
   | Filtered data   | Use standard SQL views to  |                 | 1  |
   |                 | prepare data for the       |                 |    |
   |                 | connector. Multiple        |                 |    |
   |                 | connections with different |                 |    |
   |                 | filters can be used by     |                 |    |
   |                 | using different views is   |                 |    |
   |                 | SQL                        |                 |    |
   |                 |                            |                 |    |
   |                 | Each view will relate to a |                 |    |
   |                 | separate connection in the |                 |    |
   |                 | configurator               |                 |    |
   +-----------------+----------------------------+-----------------+----+
   | SQL Schemas     | SQL Schemas other than the |                 | 1  |
   |                 | default dbo schema can be  |                 |    |
   |                 | used                       |                 |    |
   +-----------------+----------------------------+-----------------+----+
   |  Multiple       | Each datasource can have   |                 | 1  |
   | Connections     | multiple connections       |                 |    |
   |                 | allowing for a single file |                 |    |
   |                 | data table to show         |                 |    |
   |                 | different hierarchies and  |                 |    |
   |                 | filters                    |                 |    |
   +-----------------+----------------------------+-----------------+----+
   |  Multiple       | Each Connection connects   |                 | 1  |
   | Databases       | to only one database       |                 |    |
   |                 | server.                    |                 |    |
   |                 |                            |                 |    |
   |                 | Connecting multiple        |                 |    |
   |                 | database servers to a      |                 |    |
   |                 | single vault is possible   |                 |    |
   +-----------------+----------------------------+-----------------+----+
   | Hierarchies to  | Use multiple hierarchies   |                 | 1  |
   | organise        | by referencing columns in  |                 |    |
   | unstructured    | the source view/table to   |                 |    |
   | data in M-Files | show the data in drop      |                 |    |
   |                 | downs in M-Files           |                 |    |
   |                 |                            |                 |    |
   |                 | Each connection has only   |                 |    |
   |                 | one definition for a       |                 |    |
   |                 | hierarchy.  Use multiple   |                 |    |
   |                 | connections to  show       |                 |    |
   |                 | another hierarchy for the  |                 |    |
   |                 | same data                  |                 |    |
   +-----------------+----------------------------+-----------------+----+
   | Promoting file  | The database File can be   |                 | 1  |
   | to standard     | promoted to a standard     |                 |    |
   | metadata object | M-Files Class object.  The |                 |    |
   |                 | File is retained in the    |                 |    |
   |                 | database.                  |                 |    |
   |                 |                            |                 |    |
   |                 | Promotion is based on      |                 |    |
   |                 | selecting an individual    |                 |    |
   |                 | item and changing the      |                 |    |
   |                 | class.                     |                 |    |
   +-----------------+----------------------------+-----------------+----+
   | Delete file     | When the file is deleted   |                 | 1  |
   | from database   | from the database it will  |                 |    |
   |                 | disappear from the M-Files |                 |    |
   |                 | view, unless it has been   |                 |    |
   |                 | previously promoted        |                 |    |
   +-----------------+----------------------------+-----------------+----+
   | Pull through    | Use MFSQL Connector to     | MFSQL Connector | 1  |
   | related data    | pull through the metadata  | modules         |    |
   | for the file    | (e.g. customer, project,   |                 |    |
   | object          | etc) related to the file.  |                 |    |
   |                 | This can be automated and  |                 |    |
   |                 | triggered by a workflow    |                 |    |
   |                 | state change.              |                 |    |
   +-----------------+----------------------------+-----------------+----+
   |  Search on any  |  M-Files automatically     |                 | 1  |
   | element of the  | crawls through the files   |                 |    |
   | content of the  | and related data to build  |                 |    |
   | file or the     | a fully searchable index.  |                 |    |
   | hierarchy and   |                            |                 |    |
   | properties      |                            |                 |    |
   +-----------------+----------------------------+-----------------+----+
   |  Show any data  |  The each database column  |  Property must  |    |
   | associated with | can be shown as a separate | be text.        |    |
   | the file from   | property.  This            |                 |    |
   | the database in | information is retained    |                 |    |
   | M-Files as a    | when the item is promoted. |                 |    |
   | separate        |                            |                 |    |
   | property        |                            |                 |    |
   +-----------------+----------------------------+-----------------+----+
   |  Promote files  |  This is already possible  |                 | no |
   | in bulk         | by using MFSQL Connector.  |                 | t  |
   |                 | However automating it      |                 | ye |
   |                 | within the context of the  |                 | t  |
   |                 | DB Connector is targeted   |                 | av |
   |                 | for a future release.      |                 | ai |
   |                 |                            |                 | la |
   |                 |                            |                 | bl |
   |                 |                            |                 | e  |
   +-----------------+----------------------------+-----------------+----+
