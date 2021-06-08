Metadata Management and Realignment
===================================

Brown MacFarlane, a steel merchant, selected MFSQL Connector for their integration between M-Files and Navision. Part of the project was to migrate and align the data from their previous ERP system with Navision and M-Files.

This process relied heavily on the power of SQL to compare, align, transform and update several sources and destinations of data tables.  MFSQL Connector built in tools and capabilities significantly reduced to time to prepare for and perform the metadata extract and alignment, and subsequently updating of the tabled data to and from M-Files.

Metadata re-alignment during the course of the analysis and design of the integration played a part in the project. This case study highlights some of the procedure, methods and approaches applied during this project.

Understanding what is in M-Files
--------------------------------

The following procedures and views was used the understand the metadata structure in M-Files

Fetch an overview of class objects in the entire vault with :doc:`/procedures/spMFObjectTypeUpdateClassIndex` and show the results with the view :doc:`/views/MFvwObjectTypeSummary`

.. code:: sql

    EXEC dbo.spMFObjectTypeUpdateClassIndex @IsAllTables = 1

    Select * from MFvwObjectTypeSummary

|Image0|

The volume of class data and the highest objid for each class can be determined from this table.  The underlying data is in the MFAuditHistory table.

Next step is to update the metadata structure with :doc:`/procedures/spMFDropAndUpdateMetadata` and survey the use of properties and classes in the vault with the view :doc:`/views/MFvwMetadataStructure`. This view is a window into the structure for a number of angles:

 - Properties by class
 - Use of a property across all classes
 - Properties/Classes/Workflow/Valuelist with no aliases
 - Identifying duplicate aliases
 - Classes by Object type
 - Classes with required workflows

.. code:: sql

    EXEC dbo.spMFDropAndUpdateMetadata

    SELECT * FROM dbo.MFvwMetadataStructure

Comparing and analysing the data sources
----------------------------------------

Making configuration changes to the M-Files
-------------------------------------------

.. code:: sql

    EXEC dbo.spMFDropAndUpdateMetadata @IsResetAll = ?,
    @WithClassTableReset = ?,
    @WithColumnReset = ?,
    @IsStructureOnly = ?,
    @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
    @Debug = ?

Updating M-Files with the results
---------------------------------

 .. |image0| image:: image_0.png
