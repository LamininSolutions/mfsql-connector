Connector Content
=================

.. toctree::
   :maxdepth: 4

   assemblies/index
   metadata-structure-tables/index
   class-tables/index
   utility-tables/index
   logging-tables/index
   procedures-and-functions/index
   m-files-installation/index
   context-menu/index
   supporting-applications/index

The Connector components supplied as part of the deployment package include:

   - The :doc:`/the-connector-framework/connector-content/assemblies/index` are proprietary programs (.dll) to enable the interaction between M-Files and SQL. The main purpose of the assemblies is to wrap the standard M-Files API's into code classes that allows data to be extracted from M-Files into SQL tables and also to update M-Files from the SQL Tables. There are four assemblies included.

   - The :doc:`/the-connector-framework/connector-content/metadata-structure-tables/index` contain the metadata of the vault, settings, and transaction logging data. The Connector tables are all prefixed with **MF** to distinguish them from non Connector tables in the database. The Metadata tables is about metadata table contain the information about the structure of M-Files (e.g. classes, properties, valuelists etc. ) Connector Table related to this type of metadata include Object Types; Classes; Properties; ClassProperty; Valuelists; Valuelist items; Workflows; Workflow States; UserAccounts; LoginAccounts

     -  :doc:`/the-connector-framework/connector-content/utility-tables/index`  are Connector supporting tables and include: Datatypes; Settings; Process; DeploymentDetail
     -  :doc:`/the-connector-framework/connector-content/logging-tables/index` reference processing logs and unclude: MFLog; UpdateHistory; ProcessLog
     -  :doc:`/the-connector-framework/connector-content/class-tables/index` represent the data in the vault such as Customers, Contacts and any other class in the vault. Class tables are not created by default, but created when the data that is required for the specific    application has been determined. The Class Tables therefore represent the metadata of the specific classes of objects that the application will interact with.

   - :doc:`/the-connector-framework/connector-content/procedures-and-functions/index` are T-SQL procedures and functions to perform operations on the tables and the use the assemblies.

  - :doc:`/the-connector-framework/connector-content/context-menu/index` controls users interaction with SQL from within M-Files

  - :doc:`/the-connector-framework/connector-content/supporting-applications/index` include several utilities and sample files as general add-ons to the product

  - :doc:`/the-connector-framework/connector-content/m-files-installation/index` installs several components in the vault including: content package, vault applications and UI extensibility applications.
