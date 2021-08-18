Connector Specific Settings
===========================

.. toctree::
   :maxdepth: 4

   sql-database/index
   oracle-database-specific-settings/index

The Connector specific settings connects the Database and setup the
external repositories to access the files in the database tables within
M-Files

The SQLDBConnector can have multiple connections.  Each connection
points to one database and one repository.  The repository consists of
two parts: the table where the file data is stored, and the view/table
that will be used to provide the data to the connector.  These two parts
can be the same, but usually will not.

Review the section SQL Database for preparation of the data for the
connector.

It is a prerequisite to first prepare the SQL Database and then to
proceed with the Connector Specific Settings

Database Connection
-------------------

The database connection elements determine the parameters for making the
connection to the database.

=============================== =========================================================================== =================================================================================== ========================
Element                         Description                                                                 Notes                                                                               Example
=============================== =========================================================================== =================================================================================== ========================
SQL Server Name                 The full name of the server, including the instance and the port            Square brackets will automatically be added to encapsulate any spaces               localhost

                                                                                                                                                                                                ServerName\Instance,port

                                                                                                                                                                                                IPaddress
Database Name                   The Database Name                                                           Square brackets will automatically be added to encapsulate any spaces               SampleVault
 Connection Table/View          This table of view is the source of the data that will be shown on M-Files  Consult the section on SQL Database for more detail on requirements for this table  Customer_Files
Schema                          default to dbo                                                              Schema must exist prior to specifying the schema in this setting.                   custom

                                                                                                                                                                                                scu
 SQL Server Authentication Type Default to windows authentication                                           Both windows and SQL Server Authentication is allows                                SQLServer

                                Set to **SQLServer** to use SQL Server Authentication                       |
Database Type                   Default to SQL Server                                                       Available options:                                                                  leave blank for default

                                Set to Oracle for Oracle Databases                                          MF SQL

                                                                                                            Oracle
 ODBC                           Default to SQL ODBC                                                         Use name for Oracle ODBC setting                                                    leave blank for default
=============================== =========================================================================== =================================================================================== ========================



File Data Table
---------------

The settings for the File Data Table defines the source table holding
the file data that will be shown in M-Files. Only One File Data Table
can be defined per connection.

The File Data Table is not necessarily the source for the repository
data in M-Files.  It is highly likely that the file data table will be
used in a view with joins to other tables to setup the data for M-Files.

======================= ======================================= ==================================================================================================================== ========
Element                 Description                             Notes                                                                                                                Example
======================= ======================================= ==================================================================================================================== ========
File Data Table Name    Name of source table with File Data     Square brackets will automatically be added to encapsulate any spaces

                                                                Schema must be consistent with the schema defined in the Database Connection section
Unique Reference Column Unique column                           Column must be defined as *Not Null and Unique.* Likely to be the primary key of the column, but not necessarily.    GUID
                                                                                                                                                                                     ID
File Name Column        Name of file                            Filename must Include extension of file                                                                              FileName
 File Data Column        binary column with file data in a blob Defined as one of                                                                                                    FileData

                                                                Varchar(xxx)

                                                                NVarchar(Max)

                                                                Binary(Max)

                                                                |
======================= ======================================= ==================================================================================================================== ========



Hierarchy Folder Mapping
------------------------

This mapping is used to define the hierarchy of the unmanaged object.
Each element of the hierarchy must define the table column and the
target M-Files property. Only text properties can be used.  The
hierarchy is shown as the location in the metadata card

e.g. name of connection / column 1 / column 2

Click on Add Hierarchy

====================== ============================================================== ==================================== ============
Element                Description                                                    Notes                                Example
====================== ============================================================== ==================================== ============
Column Name            name of column in source view/table                            At least 1 hierarchy must be defined CustomerName
External Name          Name to appear in hierarchy in M-Files                                                              Account
Null Replacement name  Value to use as hierarchy where the item is null in the Table                                       NoAccount
====================== ============================================================== ==================================== ============



Other Columns
-------------

Other Columns is used to show additional information for the un
managed-object on the metadata card. This data is pulled from the
source view/table. Each additional property to show is added as a
property mapping.

Defining other columns is optional.

============= =================================== ===== ========
Element       Description                         Notes Example
============= =================================== ===== ========
Column Name   name of column in source view/table       LoanName
External Name name to appear in M-Files                 Loan
============= =================================== ===== ========
