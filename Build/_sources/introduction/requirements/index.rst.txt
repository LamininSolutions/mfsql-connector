Requirements
============

Summary
~~~~~~~

M-Files: Version 20.5 or later; On premise or Cloud; 1 Named User
dedicated to MFSQL Connector; M-Files desktop on server

SQL: MS SQL 2016 to 2019; (Express or Standard); M-Files Desktop on
server.

Detail
~~~~~~

**M-Files Version**

 - M-Files version 20.5 and later
 - M-Files IML (Intelligent Metadata Layer) Core licence is required for the DB File Connector module

**M-Files User**

 - The connector requires a dedicated M-Files user with admin rights to the vault.  During installation the M-Files user must have Server Admin rights
 - It is recommended to assign a named user license to the user

**M-Files Database**

 - Firebird and SQL vaults allowed

**M-Files Installation**

 - Target vault must be pre-existing
 - M-Files client must be installed on SQL Server
 - Powershell version 5 or later must be installed and enabled on the SQL and M-Files server. The vault settings and application installation can be updated manually if powershell is not enabled
 - M-Files desktop client must be installed on M-Files Server
 - Each Vault requires a dedicated database
 - In it recommended to use a database naming conversion to link the database with the vault
 - It is recommended to have separate installations for Development and Production

**Powershell**

 - The Advanced installer use powershell as part of the installation on both SQL and M-Files server
 - If powershell is not enabled or restricted, the manual installation process must be followed.

**SQL Database**

 - SQL Server 2016, Express, Standard or Enterprise and later
 - All features is not supported in Express such as using agents and performance limitation
 - SQL Server must be installed with `Mixed Mode Authentication <https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/change-server-authentication-mode>`__ during the setup of the instance

**M-Files to SQL connection**

 - When the SQL server and M-Files server is in the same domain, then MFSQL Connector will use a ODBC connection or a web service to connect from M-Files to the SQL database.
 - When the SQL server and M-Files server is not in the same domain, for instance with M-Files Cloud then the web service App should be installed and deployed.

**Size allocation of database**

 - Database is automatically created with default size and file locations.   The size of the database is not expected to be large or requiring any special requirements except if the M-Files vault is excessively large and the application requires a significant number of Class Tables. A Log Table purging methodology should be implemented to prevent excessive growth of application logs. By default log tables are kept indefinitely.
 - The database recovery model will follow the default of the server and is most likely to be set the Full.  It is possible to set the recovery model to simple to restrict the growth of the log files as it is unlikely that database recovery will require a log file recovery.

**SQL Server Configuration**

 - Database mail is required for SQL error notifications
 - Optional. Error messages are also available from MFLog table

**DotNet Framework**

 - MFSQL Connector .Net 4.6
 - MFSQL Web Services appliction .net 4.6.1
 - MFSQL Database File Connector .Net 4.6.1
 - ContextMenu Vault Application Framework .Net 4.6.1
 - Installer TLS 1.2 compliant

**Experience level of SQL Development**

 - Moderate experience with using MS-SQL queries are required

Reserved words
~~~~~~~~~~~~~~

MFSQL Connector has several reserved words to be aware of.  The
following should be not be used in M-Files as names of properties

-  "Process" or "Process ID"
-  GUID
-  ID
-  "Update" or "Update ID"
-  LastModified
-  FileCount
-  "State", "State_ID" or "State ID"

Rename the default for property 39 'State' to something like 'Workflow
state' if another property with the name 'State' is required;
alternatively, rename the customer property to 'StateID'

Class Table Names cannot be the same as any of the default list of
tables created during installation (Such as Process) 

Reserved characters
~~~~~~~~~~~~~~~~~~~

MFSQL Connector will not perform properly when the following characters are used in M-Files in Metadata

 - comma in a class table name
 - hidden hex characters such as HEX 0x01 , 0x19 , 0x14 , 0x19

Assumptions and constraints
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Connector is intended to be used by an experienced consultant or
developer with a good knowledge of M-Files configuration and T-SQL . It
is not targeted to be an end user application and assumes that the end user
will interact with the data via another user interface.

-  M-Files permission settings does not constrain access to the data in
   SQL. The data in SQL relies on access control implemented in SQL.
