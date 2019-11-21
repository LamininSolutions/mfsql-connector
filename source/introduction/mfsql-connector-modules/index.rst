MFSQL Connector modules
=======================

.. toctree::
   :maxdepth: 4

MFSQL Connector is available as separate modules with different
functionality and pricing.

This documentation describes the functionality of all the modules of
Release 4.  Contact support if your licensed package does not include a
specific procedure or functional element described in the documentation.

`MFSQL Connector Data Exchange <https://doc.lamininsolutions.com/mfsql-connector/mfsql-data-exchange-and-reporting-connector/index.html>`_
----------------------------------------------------------------------------------------------------------------------------------------------

This  module is used where the Connector is deployed to perform only
data exchange  with no need for extensive development of integrations
and applications using M-Files APIs.

Examples of usage of this module:

-  Extract metadata from M-Files into SQL for reporting, trouble
   shooting or analysis and data cleansing
-  Upload metadata from SQL into M-Files. This is particularly relevant
   when the data preparation is complex or requires the extensive data
   management tools of SQL.
-  Simple extraction of data from a third party system and updating the
   data into M-Files
-  Combine M-Files metadata with other corporate data that is not in
   M-Files for reporting and analysis

The data Exchange module includes the following:

-  Assemblies
-  Tables, Procedures and functions to allow exchange of class table
   data between M-Files and SQL 
- Context Menu in M-Files to action updates.

When to use Data Exchange instead of M-Files External Connectors

   ==================================== ====================================================
   **M-Files External Data Connectors** **MFSQL Connector: Data Exchange**
   ==================================== ====================================================
   ODBC connection                      Vault & Database in different locations
    Update timing is set on a schedule  Update is near immediate and is highly configurable 
   No data manipulation                 Encrypted data exchange
   Simple source data structures        Complex data management with conditional criteria
    Limited Valuelist lookups           Multiple joins and combinations
   Source and target data is similar    SQL based data preparation
   Limited triggers for update process  Alignment of source and target data
   |                                    Batch preparation of data updates
   |                                    Multiple triggers for data update
   ==================================== ====================================================

`MFSQL Integration Connector <https://doc.lamininsolutions.com/mfsql-connector/mfsql-integration-connector/index.html>`_
--------------------------------------------------------------------------------------------------------------------------

This module includes Data Exchange and additional procedures and
functions to assist the developer to develop extensive integrations and
applications around M-Files using SQL.  

Examples of use cases when this module is required:

-  Building complex integration services with third party application
-  Complex metadata structure management and analysis
-  Process management and error handling
-  Exploring M-Files Event Log in SQL
-  Optimising large volumes of data and updates.
-  Iterative development cycles using the helper functions and
   procedures

This Developer module add the following components:

-  Helper and accelerator procedures and functions
-  ETL module
-  ASPNET security provider for deployment of membership manager with
   Code On Time
-  Exporting M-Files Event Log
-  Integrating M-Files Reporting Tool with the Connector
-  Error Logging and analysis
-  Extended Context menu functionality allowing for calling an SQL
   Procedure from an action menu in M-Files, or workflow state change,
   or event handler.  
   
   Example uses include:
   
-  Accessing other intranet (and public) web applications using a menu
   option button in M-Files
-  Starting a SQL update process such as updating information from a
   third party system from within M-Files using a menu option button.
-  Performing a complex data preparation or copy function including
   multiple objects using a context sensitive button in M-Files
-  Automatically call a SQL store procedure to perform complex functions
   when a workflow state change takes place.

`MFSQL Database File Connector <https://doc.lamininsolutions.com/mfsql-connector/mfsql-database-file-connector/index.html>`_
------------------------------------------------------------------------------------------------------------------------------

The Database File Connector has two distinct parts:

-  A vault application that adds a connection of a SQL table to an
   M-Files document vault. The connector allows documents and other
   files residing in a SQL database to be viewed via the M-Files user
   interface in the same manner as other documents and objects in the
   vault.  Note that this feature requires the M-Files IML core license.
-  Procedures to `export files from Database Blobs into
   M-Files <https://doc.lamininsolutions.com/mfsql-connector/procedures/spMFExportFiles>`_.
   This export will transfer both files and associated metadata from the
   external database to M-Files. This feature requires the full MFSQL
   Connector suite, but does not require the IML License. This feature
   can be used in conjunction with the Database File Connector.
   
