Connector Content
=================

.. toctree::
   :maxdepth: 4

   assemblies/index
   metadata-structure-tables/index
   class-tables/index
   utility-tables/index
   working-with-files/index
   logging-tables/index
   procedures-and-functions/index
   m-files-installation/index
   context-menu/index
   supporting-applications/index
   m-files-event-log/index



The Connector components supplied as part of the deployment package include:
----------------------------------------------------------------------------

`Assemblies <page21200934.html#Bookmark5>`__: These are proprietary
programs (.dll) to enable the interaction between M-Files and SQL. The
main purpose of the assemblies is to wrap the standard M-Files API's
into code classes that allows data to be extracted from M-Files into SQL
tables and also to update M-Files from the SQL Tables. There are four
assemblies included.

`Metadata Structure Tables <page21200936.html#Bookmark6>`__: These
tables contain the metadata of the vault, settings, and transaction
logging data. The Connector tables are all prefixed with \ **MF** to
distinguish them from non Connector tables in the database.\ `Metadata
tables <page21200936.html#Bookmark6>`__: The metadata about metadata
table contain the information about the structure of M-Files (e.g.
classes, properties, valuelists etc. ) Connector Table related to this
type of metadata include Object Types; Classes; Properties;
ClassProperty; Valuelists; Valuelist items; Workflows; Workflow States;
UserAccounts; LoginAccounts

-  `Utility tables <page21200964.html#Bookmark34>`__: These are
   Connector supporting tables and include: Datatypes; Settings;
   Process; DeploymentDetail
-  `Logging Tables <page21200944.html#Bookmark40>`__: These tables
   referencing processing logs and unclude: MFLog; UpdateHistory;
   ProcessLog
-  `M-Files Class Tables <page21200940.html#Bookmark24>`__: These table
   represent the data in the vault such as Customers, Contacts and any
   other class in the vault. Class tables are not created by default,
   but created when the data that is required for the specific
   application has been determined. The Class Tables therefore represent
   the metadata of the specific classes of objects that the application
   will interact with.

`SQL Procedure & functions <page21200956.html#Bookmark48>`__: These
T-SQL procedures and functions perform operations on the tables and the
assemblies.

`Context menu: <page51085316.html#Bookmark57>`__ The context menu
controls users interaction with SQL from within M-Files

`M-Files <page51085316.html#Bookmark57>`__\ `installation <page340197500.html#Bookmark56>`__:
Several components are installed in the vault including: content
package, vault applications and UI extensibility applications.

| 

.. container:: table-wrap

   =========================================================
   **Related Topics**
   =========================================================
   `The Connector Framework <page21200916.html#Bookmark1>`__
   =========================================================
