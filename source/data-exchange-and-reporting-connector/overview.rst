Overview
========

This module is used where the Connector is deployed to perform data exchange only with no need for extensive development of integrations and applications. The Integration module include a range of helper functions and procedures that may be useful in the case of extensive data exchange operations.

Examples of usage of this module:

- Extract metadata from M-Files into SQL for reporting, trouble shooting or analysis and data cleansing
- Upload metadata from SQL into M-Files. This is particularly relevant when the data preparation is complex or require the extensive data management tools of SQL.
- Simple extraction data from a third party system and updating the data into M-Files
- Combine M-Files metadata with other corporate data that is not in M-Files for reporting and analysis

Related Functional Procedures
-----------------------------

The following procedures and functions are included in data exchange:

- :ref:`data-exchange-and-reporting-connector/procedures/spMFVaultConnectionTest:spMFVaultConnectionTest`
- :ref:`data-exchange-and-reporting-connector/procedures/spMFSynchronizeMetadata:spMFSynchronizeMetadata`
- :ref:`data-exchange-and-reporting-connector/procedures/spMFSynchronizeSpecificMetadata:spMFSynchronizeSpecificMetadata`
- :ref:`data-exchange-and-reporting-connector/procedures/spMFDropAndUpdateMetadata:spMFDropAndUpdateMetadata`
- :ref:`data-exchange-and-reporting-connector/procedures/spMFCreateTable:spMFCreateTable`

.. - :ref:`data-exchange-and-reporting-connector/procedures/spMFUpdateTable:spMFUpdateTable`
   - :ref:`data-exchange-and-reporting-connector/procedures/spMFClassTableStats:spMFClassTableStats`
   - :ref:`data-exchange-and-reporting-connector/procedures/spMFDropAllClassTables:spMFDropAllClassTables`
   - :ref:`data-exchange-and-reporting-connector/procedures/spMFCreateAllMFTables:spMFCreateAllMFTables`
   - :ref:`data-exchange-and-reporting-connector/procedures/spMFUpdateAllncludedInAppTables:spMFUpdateAllncludedInAppTables`
   - :ref:`data-exchange-and-reporting-connector/procedures/spMFAliasesUpsert:spMFAliasesUpsert`
