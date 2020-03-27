
Metadata Management and data cleansing
======================================

MFSQL Connector has a range of capabilities and functionality to support metadata management.  In some cases there are specific procedures or functions that has been developed with data manipulation in mind. Many methods have multiple applications and and just require the specific use of the filters and parameters.

This blog highlights the data management capabilities and how to use the methods.

Metadata Structure
------------------

Exploring the metadata structure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A large part of the structure of the metadata is replicated in SQL.  The tables, outlined in :doc:`/the-connector-framework/connector-content/metadata-structure-tables/index` , is tied together with the view MFvwMetadataStructure. The blog :doc:`/blogs/exploring-valuelists-with-mfvwmetadatastructure/index` illustrates how to use this view.

This view provides a unique insight into the metadata structure.  Some related questions include:
 -  The classes where a valuelist used 
 -  The names of all the properties that refers to a valuelist
 -  The classes where another class is referenced
 -  Which class table to create when a certain property or valuelist need to be updated or reviews
 -  Show all the properties set on the metadata card for a specific class
 
Exploring class tables and their columns
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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



