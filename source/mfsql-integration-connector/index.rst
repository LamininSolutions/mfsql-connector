MFSQL Integration Connector
===========================

.. toctree::
   :maxdepth: 4

   exploring-metadata/index
   building-custom-applications-and-integrations/index
   property-and-column-usage/index
   metadata-search/index
   create-valuelist-items-from-sql/index
   user-messages/index
   lookup-views/index
   send-bulk-email/index
   working-with-files/index
   working-with-aliases/index
   change-of-vault/index
   daily-monthly-routines-for-agents/index
   tips-and-tricks-on-using-the-connector/index
   using-and-managing-logs/index
   working-with-object-version/index
   context-menu-queue/index
   mfsql_connector_addons/index

   M-Files External Connectors
   ---------------------------

   When to use MFSQL Connector instead of M-Files External Connectors.

   The standard M-Files External Connector is powerful and applicable in
   many case cases.  MFSQL Connector takes data exchange to the next level
   and overcomes some of the disadvantages and limitations of the external
   connector.  Some of the differences are highlighted below.

   Note that the same class table cannot be used to process records using a
   external connector and MFSQL Connector procedures at the same time.
   However, it is possible to use external connector for classes and MFSQL
   Connector for classes of a different object type.


   ================================================= ================================================================
   **M-Files External Data Connectors**              **MFSQL Connector**
   ================================================= ================================================================
   SQL server and vault must be in the same network  Vault & Database in different locations and networks
   ODBC is fundamentally a text based data exchange  Encrypted data exchange
   Update timing is set on a schedule                Update is near immediate and is highly configurable
   Limited data manipulation                         Extensive ability to prepare and manipulate data to be exchanged
   Simple source data structures                     Complex data management with conditional criteria
   Limited Valuelist lookups                         Multiple joins and combinations
   Source and target data is similar                 SQL based data preparation
   Limited triggers for update process               Alignment of source and target data
                                                     Batch preparation of data updates
                                                     Multiple triggers for data update
   ================================================= ================================================================
