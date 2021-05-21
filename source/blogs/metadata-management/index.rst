
Metadata Management and data cleansing
======================================

MFSQL Connector has a range of capabilities and functionality to support metadata management.  In some cases there are specific procedures or functions that has been developed with data manipulation in mind. Many methods have multiple applications and and just require the specific use of the filters and parameters.

This blog highlights the data management capabilities and how to use the methods.

Learn more about using MFSQL Connector for `metadata management in the whitepaper <https://m-files.lamininsolutions.com/SharedLinks.aspx?accesskey=9123d002b8081a3bfa0cfd550793b1cb3d67357dc7e2574d2386f390139279a9&VaultGUID=8775C4C3-A206-4CA0-BD0B-C795800F3DF7>`_

Metadata Structure
------------------

Exploring the metadata structure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A large part of the structure of the metadata is replicated in SQL.  The tables, outlined in :doc:`/the-connector-framework/connector-content/metadata-structure-tables/index` , is tied together with the view :doc:`/views/MFvwMetadataStructure` The section :doc:`/mfsql-integration-connector/exploring-metadata/index` illustrates how to use this view.

The view :doc:`/views/MFvwMetadataStructure` provides a unique insight into the metadata structure.  Some example questions using this view include:

 -  On which classes are valuelist used
 -  The names of all the properties that refers to a valuelist
 -  The classes where another class is referenced
 -  Show all the classes used for a specific property
 -  Show all the properties on the metadata card for a specific class

Table Column discovery
~~~~~~~~~~~~~~~~~~~~~~

Explore the class tables and their column definition and related it to the properties and their datatypes with the following procedures and views:

 -  :doc:`/views/MFvwClassTableColumns`
 -  :doc:`/procedures/spMFClassTableColumns`

These methods unique identify where properties are used as adhoc properties on an class. Anomalies and errors with columns can be identified using the error columns in the result set. The result also show the different types of columns that is used on a class.

:doc:`/procedures/spMFClassTableColumns` is specifically geared towards trapping column errors.  Review the notes on this procedure for more detail on the different use cases.

Metadata structure manipulation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Connector allows for a range of operations to work with the metadata structure

Updating aliases
Reset multi file document type to single file
Updating valuelist items
updating metadata structure with different filters and operations
updating class and property names

Class table operations
----------------------

Class table status
~~~~~~~~~~~~~~~~~~

:doc:`/blogs/using-spmfclasstablestats/index` allows for an overview status of the operations of class tables.  It shows the number of records in M-files and in the class table and any outstanding processing

Class table metadata operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The primary objective of the Connector is to allow for full CRUD (Create, Read, Update and Delete) operations on the class table metadata. This is the same is the properties on the classes in M-Files.

 -  Create and update from SQL to M-Files with :doc:`/procedures/spMFUpdateTable` with updatemethod 0.
 -  Read from M-Files :doc:`/procedures/spMFUpdateTable` with updatemethod 1.
 -  Delete or destroy from SQL into M-Files with :doc:`/procedures/spMFDeleteObjectList`
 -  Move objects from one class to another with :doc:`/procedures/spMFUpdateTable` with updatemethod 0.
 -  Read deleted records from M-Files by using :doc:`/procedures/spMFUpdateTable` with updatemethod 1 and setting the flag ''RetainDeletions'' to 0

Metadata change history operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The object change history for specific properties can be read and deleted.
The most common use case for access the object change history is to report on state changes :doc:`/blogs/using-object-change-history-to-report-on-state-changes/index`
