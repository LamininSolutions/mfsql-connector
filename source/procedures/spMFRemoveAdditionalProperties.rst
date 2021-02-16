
==============================
spMFRemoveAdditionalProperties
==============================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @Columns
    - default = null.  
    - If set to null then all columns with no data in that is not included in the metadatacard will be removed.
    - Set @Columns to a comma delimited string to validate and remove specific columns
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

M-Files allows for properties to be added to the metadata card as additional properties. Sometimes these properties becomes redundant.  The Connector will automatically create columns for properties when they are used. Over time this may add many columns on the class table that is no longer used or relevant.  This procedure will allow for identifying the empty columns, validated that they are no longer included in the metadata card specification and remove them.

Additional Info
===============

By default the column will only be removed if all data has been removed.  Property columns where property MFID < 1000 is ignored.

do a normal update from SQL to MF by setting the data in unwanted columns to null, and set the process_id = 1 to remove the data in unwanted columns.

When @Column is null then all additional property columns with null data will be removed.

To remove columns where the property MFID < 1000 the column must be specified e.g. @Columns = 'Is_Template'

Examples
========

deleting additional columns where all data is null

.. code:: sql

    DECLARE @ProcessBatch_ID1 INT;

    EXEC dbo.spMFRemoveAdditionalProperties @MFTableName = 'MFOtherDocument',
    @ProcessBatch_ID = @ProcessBatch_ID1 OUTPUT,
    @Debug = 1

----------------------------

Deleting specified columns

.. code:: sql

    DECLARE @ProcessBatch_ID1 INT;

    EXEC dbo.spMFRemoveAdditionalProperties @MFTableName = 'MFOtherDocument',
    @columns = 'Is_Template',
    @ProcessBatch_ID = @ProcessBatch_ID1 OUTPUT,
    @Debug = 1
   
Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------

2020-12-19  LC         Create procedure
==========  =========  ========================================================

