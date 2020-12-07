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

Can the connector change or update the display id of an object in M-Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The column ''External_ID'' in the class table represents the display_id of the object. This column can be updated from SQL to M-Files. This is particularly useful when a external system made changes to the unique identifyer of an object and these changes need to be update into M-Files.

What file operations can be performed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 -  :doc:`/blogs/import-files-into-m-files-from-explorer/index`
 -  :doc:`/blogs/importing-files-from-a-database/index`
 -  :doc:`/procedures/spMFExportFiles`
