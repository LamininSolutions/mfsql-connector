Frequently asked questions
==========================

A collection of frequently asked questions about MFSQL Connector

What is MFSQL Connector
~~~~~~~~~~~~~~~~~~~~~~~

MFSQL Connector is a developer platform of tools and capabilities to connect M-Files
with SQL Server bidirectionally without having to master the M-Files APIs.  :doc:`/introduction/purpose-and-scope/index`

Why use the Connector
~~~~~~~~~~~~~~~~~~~~~

The Connector liberates M-Files metadata to use the power of SQL to explore it, change it and link it with external applications and systems

What is the top 5 use cases
~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Extract data from M-Files for reporting and analysis
#. Exchange M-Files metadata with other systems
#. Reorganize and reclassify metadata in bulk
#. Remove objects and object versions
#. Reprocess complex data to align it with M-Files properties and structure

Why use MFSQL Connector for integration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

One of the core pillars of MFSQL Connector is the capability of using the tool to integrate between M-Files and any third party system using SQL as their backend.

This is particularly relevant when the connection is complex, must be flexible, and the business has skills with SQL capabilities.

Learn more about the it in the :doc:`/blogs/integration-whitepaper/index`

What is the rules for licensing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Each M-Files Server requires a separate MFSQL Connector license
#. The license is issued for the specific M-Files Serial nr and for the subscription period (a year)
#. The number of M-Files user licenses (named and concurrent) on the M-Files server determines the MFSQL licensing bracket (e.g. 1-49; 50 – 200 etc). Read only licenses are excluded in the count.
#. The usage of specific functions and features in MFSQL Connector (as outlined in the functional overview) determines the module (e.g. data exchange, integration or database file connector)
#. The number of vaults on the M-Files server is not restricted.
#. Separate M-Files servers that is used for replication, backup or any other vaults, are not taken into account as long as no MFSQL Connector connection to the vaults on these separate servers is used.
#. The number of users assigned to the vaults (irrespective if the vaults are using MFSQL Connector or not) are not relevant.
#. The number of SQL servers connected to the M-Files Server is not restricted
#. One MFSQL Connector license for a separate M-Files Server and serial nr, exclusively used for testing and prototyping,  is included at no additional cost.


Is it compatible with M-Files Cloud
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The M-Files Cloud vault can interact with MFSQL Connector database on premise or in another cloud.
From the MFSQL database to M-Files is a HTTPS secure connection. Optionally, action SQL operations from M-Files using webservices.

What can the Connector do with the Metadata in M-Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

MFSQL Connector allows for working with M-Files metadata by executing SQL procedures and exploring the underlying tables in SQL.  It provides full CRUD (Create, Read, Update and Delete) bi-directionally between an M-Files vault and the Connector Database.
:doc:`/blogs/metadata-management/index`

Can the Connector remove redundant object versions from an object history
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The connector allows for the removal of specific object versions from the object history in M-Files.  :doc:`/procedures/spMFDeleteObjectVersionList`

How to get support
~~~~~~~~~~~~~~~~~~

To get support send an email to `support <mailto:support@lamininsolutions.com>`__ and include the following:
 -  screenshot of the error
 -  details of the actual error from the MFlog table.  Copy and past the result of the query below to your email to show the full text

..code:: sql

     SELECT TOP 5 ErrorMessage, CreateDate FROM MFlog ORDER BY logid desc

Can the connector change or update the display id of an object in M-Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The column ''External_ID'' in the class table represents the display_id of the object. This column can be updated from SQL to M-Files. This is particularly useful when a external system made changes to the unique identifyer of an object and these changes need to be update into M-Files.

What file operations can be performed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 -  :doc:`/blogs/import-files-into-m-files-from-explorer/index`
 -  :doc:`/blogs/importing-files-from-a-database/index`
 -  :doc:`/procedures/spMFExportFiles`

How to count to number of objects in the vault
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use :doc:`/procedures/spMFObjectTypeUpdateClassIndex` to get all the object versions in the vault, and view the result with :doc:`/views/MFvwAuditSummary`
