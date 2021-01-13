
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
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

M-Files allows for properties to be added to the metadata card as additional properties. Sometimes these properties becomes redundant.  The Connector will automatically create columns for properties when they are used. Over time this may add many columns on the class table that is no longer used or relevant.  This procedure will allow for identifying the empty columns, validated that they are no longer included in the metadata card specification and remove them.

Additional Info
===============

By default the column will only be removed if all data has been removed.

Examples
========
   

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------

2020-12-19  LC         Create procedure
==========  =========  ========================================================

