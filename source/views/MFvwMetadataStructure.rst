
=====================
MFvwMetadataStructure
=====================

Purpose
=======

This view allows for exploring the metadadata structure

Examples
========

review all the properties for a specific class

.. code:: sql

	SELECT *
	FROM   [MFvwMetadataStructure]
	WHERE  [class] = 'Customer' ORDER BY Property_MFID

----

review all the classes for a specific property

.. code:: sql

	SELECT class,*
	FROM   [MFvwMetadataStructure]
	WHERE  [Property] = 'Customer' ORDER BY class_MFID

----

review all the valueslists and their associated properties by class. Use to IsObjectType switch to show for valuelists or object types

.. code:: sql

   SELECT Valuelist, [mfms].[Property], class FROM [dbo].[MFvwMetadataStructure] AS [mfms]
   WHERE IsObjectType = 1

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-12-20  LC         Add MFDatatype_ID
2020-08-22  LC         Deleted column change to localisation
2020-07-08  LC         Add Valuelist Table name to columns
2020-03-27  LC         Add documentation for the view
==========  =========  ========================================================

