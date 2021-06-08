Metadata Management and Realignment
===================================

Brown MacFarlane, a steel merchant, selected MFSQL Connector for their integration between M-Files and Navision. Part of the project was to migrate and align the data from their previous ERP system with Navision and M-Files.

This process relied heavily on the power of SQL to compare, align, transform and update several sources and destinations of data tables.  MFSQL Connector built in tools and capabilities significantly reduced to time to prepare for and perform the metadata extract and alignment, and subsequently updating of the tabled data to and from M-Files.

Metadata re-alignment during the course of the analysis and design of the integration played a part in the project. This case study highlights some of the procedure, methods and approaches applied during this project.

Understanding what is in M-Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
 - Properties and class used with an ownership relation

 Examples of the select statement for the view are below.

 The main aim for this exploration is to identify all the classes and properties to be included in the survey.

.. code:: sql

    EXEC dbo.spMFDropAndUpdateMetadata

    SELECT Property FROM dbo.MFvwMetadataStructure where class = 'Customer'
    Select Class FROM dbo.MFvwMetadataStructure where Property = 'Customer'
    SELECT distinct Class FROM dbo.MFvwMetadataStructure where ObjectType = 'Document'
    SELECT Class FROM dbo.MFvwMetadataStructure WHERE Workflow_MFID IS NOT null
    SELECT Property, class,  Valuelist_Owner,IsObjectType FROM dbo.MFvwMetadataStructure where Valuelist_Owner IS NOT null

Next, update the includedInApp column in the MFClass table for all the classes to be included in the data analysis and then create all the class tables with one instruction :doc:`/procedures/spMFCreateAllMFTables`.

.. code:: sql

    UPDATE mc
    SET mc.IncludeInApp = 1
    FROM MFclass mc WHERE name IN ('Customer','Employment Agreement','Purchase Invoice')

    EXEC dbo.spMFCreateAllMFTables @IncludedInApp = 1


Comparing and analysing the data sources
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The first step is to get access to the metadata.  With the SQL server of the external system on the same network, a link server was setup for easy access. The pull of data from the external system may include other methods such as Boomi, Talend, Jitterbit or other tools. The key is to get the data into SQL Server tables.
The next step is to get the M-Files data. This is where MFSQL Connector comes in.  It allows for pulling metadata from M-Files without resorting to APIs.  It also goes far beyond the capabilities of M-Files External Database Connector and is much easier to debug and control.  All the related class tables have been created in the previous step, but any additional class tables can be created with
:doc:`/procedures/spMFCreateTable`

Updating the class tables from M-Files to SQL should take into account the volume of data in the tables and selecting the right procedure for the job is key:

 -  Performing a quick update for smaller tables (< 10 000 records) or individual objects use :doc:`/procedures/spMFUpdateTable`
 -  Initialising larger tables in batch mode use :doc:`/procedures/spMFUpdateMFilesToMFSQL` with UpdateTypeID = 0
 -  Updating changed records for individual tables use :doc:`/procedures/spMFUpdateMFilesToMFSQL` with UpdateTypeID = 1
 -  Updating all class tables for changed records use :doc:`/procedures/spMFUpdateAllncludedInAppTables`
 -  Resetting a larger class table (only used in exception) use :doc:`/procedures/spMFUpdateTableInBatches`

All of the above procedures has different types of switches and parameters for different scenarios. Check out the documentation of the individual procedures for further examples.

The following is a list of tips and technigue scripts for data analysis and exploration.

Identifying duplicates
-----------------------

 Use 'group by' and 'having' method to identify duplicates

 .. code:: sql

     Select duplicateColumn from MFTableName
     group by duplicateColumn
     having count(*) > 1

Expand multi lookup property columns
------------------------------------

Use 'cross apply' method with MFSQL function :doc:`/functions/fnMFParseDelimitedString` to split out a multi lookup Property to work with the individual members of the lookup.

.. code:: sql

     Select * from MFClassTable
     cross apply fnMFParseDelimitedString(Multicolumn, ',')



Making configuration changes to M-Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is common to make changes in M-Files admin during the process of configuring M-Files to align with the data of the system.  The metadata structure must be re-synchronized after making changes in M-Files admin.  Using :doc:`/procedures/spMFDropAndUpdateMetadata` allows for different developer utilities to help with the process.

 -  Setting the IsResetAll = 1 will cancel all custom settings in SQL (such as column names and class table names) and reset it to the default.
 -  WithClassTableReset = 1 will drop all the class tables and recreate it. It will not refresh the data automatically.
 -  WithColumnReset = 1 will recreate the columns for properties where the datatype of the properties were changed.
 -  IsStructureOnly = 0 will update both structure changes and valuelist item changes.

 Setting these parameters is cummulative.  Normally, these switches will not be used in combination, but executed depending on the developer's requirement.

.. code:: sql

     EXEC dbo.spMFDropAndUpdateMetadata @IsResetAll = ?,
     @WithClassTableReset = ?,
     @WithColumnReset = ?,
     @IsStructureOnly = ?

Several configuration changes can be made in SQL and updated into M-Files.

 -   Add new valuelist items for a Valuelist
 -   Update the name, ExternalID, alias or owner for a valuelist and valuelist item
 -   Update aliases for workflow and workflow state

Updating M-Files with the results
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


 .. |image0| image:: image_0.png
