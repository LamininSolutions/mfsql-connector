MFSQL Data Exchange and reporting Connector
===========================================

.. toctree::
   :maxdepth: 4

   update-settings/index
   working-with-metadata/index
   working-with-class-tables/index
   using-the-context-menu/index

This  module is used where the Connector is deployed to perform data
exchange only with no need for extensive development of integrations and
applications.  The Integration module include a range of helper
functions and procedures that may be useful of in the case of extensive
data exchange operations.

Examples of usage of this module:

-  Extract metadata from M-Files into SQL for reporting, trouble
   shooting or analysis and data cleansing
-  Upload metadata from SQL into M-Files. This is particularly relevant
   when the data preparation is complex or require the extensive data
   management tools of SQL.
-  Simple extraction data from a third party system and updating the
   data into M-Files
-  Combine M-Files metadata with other corporate data that is not in
   M-Files for reporting and analysis

Content
~~~~~~~

| 



M-Files External Connectors
---------------------------

When to use Data Exchange instead of M-Files External Connectors.

The standard M-Files External Connector is powerful and applicable in
many case cases.  MFSQL Connector takes data exchange to the next level
and overcomes some of the disadvantages and limitations of the external
connector.  Some of the differences are highlighted below. 

Note that the same class table cannot be used to process records using a
external connector and MFSQL Connector procedures at the same time. 
However, it is possible to use external connector for classes and MFSQL
Connector for classes of a different object type.

| 

.. container:: table-wrap

   =========================================================================================================================================
   | 
   
   .. container:: table-wrap
   
      .. container:: table-wrap
   
         ================================================================== ================================================================
         .. container:: tablesorter-header-inner                            .. container:: tablesorter-header-inner
                                                                           
            **M-Files External Data Connectors**                               **MFSQL Connector: Data Exchange**
         ================================================================== ================================================================
         ODBC connection - SQL server and vault must be in the same network Vault & Database in different locations and networks
         ODBC is fundamentally a text based data exchange                    Encrypted data exchange
          Update timing is set on a schedule                                Update is near immediate and is highly configurable 
         Limited data manipulation                                          Extensive ability to prepare and manipulate data to be exchanged
         Simple source data structures                                      Complex data management with conditional criteria
          Limited Valuelist lookups                                         Multiple joins and combinations
         Source and target data is similar                                  SQL based data preparation
         Limited triggers for update process                                Alignment of source and target data
         |                                                                  Batch preparation of data updates
         |                                                                   Multiple triggers for data update
         ================================================================== ================================================================
   =========================================================================================================================================

| 



Related Functional Procedures
-----------------------------

The following procedures and functions are included in data exchange:

-  spMFVaultConnectionTest
-  spMFSynchronizeMetadata
-  spMFDropAndUpdateMetadata
-  spMFCreateTable
-  spMFUpdateTable
-  spMFSynchronizeSpecificMetadata
-  spMFClassTableStats
-  spMFDropAllClassTables
-  spMFCreateAllMFTables
-  spMFUpdateAllncludedInAppTables
-  spMFAliasesUpsert