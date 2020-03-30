
Metadata Management and data cleansing
======================================

MFSQL Connector has a range of capabilities and functionality to support metadata management.  In some cases there are specific procedures or functions that has been developed with data manipulation in mind. Many methods have multiple applications and and just require the specific use of the filters and parameters.

This blog highlights the data management capabilities and how to use the methods.

Metadata Structure
------------------

Exploring the metadata structure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A large part of the structure of the metadata is replicated in SQL.  The tables, outlined in :doc:`/the-connector-framework/connector-content/metadata-structure-tables/index` , is tied together with the view :doc:`/views/MFvwMetadataStructure` The section :doc:`/mfsql-integration-connector/exploring-metadata/index` illustrates how to use this view.

This view provides a unique insight into the metadata structure.  Some related questions include:
 -  The classes where a valuelist used 
 -  The names of all the properties that refers to a valuelist
 -  The classes where another class is referenced
 -  Which class table to create when a certain property or valuelist need to be updated or reviews
 -  Show all the properties set on the metadata card for a specific class
  
Exploring class tables and their columns
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following procedures and views allow digger deeper into the application of the structure in the class tables.

 -  :doc:`/views/MFvwClassTableColumns`
 -  :doc:`/procedures/spMFClassTableColumns`

These methods unique identify where properties are used as adhoc properties on an class.

Anomolies and errors with columns can be identified using the error columns in the result set.

The result also show the different types of columns that is used on a class.

Related blogs:
 -  

Updating aliases
~~~~~~~~~~~~~~~~



Discovery

Class Metadata
--------------

Class table re-alignment

Bulk Delete

Move from one class to another

Reset multi file document type to single file

Removing redundant properties

Move files from one object type to another

Changing the datatype of a property
	text to valuelist
	re-align valuelist items
	multi-lookup to single lookup
	
Deleting duplicate objects

Deleting history object versions

Mark for archiving

Realign the display ID (external ID)

Removing comments

Get deleted objects

Files
-----

Relocating files to a different object

Exporting files

Importing files

Valuelists
----------

Updating valuelist items



