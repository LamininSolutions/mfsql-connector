
===================
spMFSetup_Reporting
===================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Classes
    - Valid Class Names as a comma delimited string
    - e.g.: 'Customer, Purchase Invoice'
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

Custom script to prepare database for reporting

Additional Info
===============


The following will be automatically executed in sequence

- test Connection
- Update Metadata structure
- create class tables
- create all related lookups
- create menu items in Context menu

On completion login to vault and action update reporting data to update class tables from M-Files to SQL

Alternatively use spMFUpdateTable to pull records into class table

Warnings
========

The procedure is useful to create a limited number of classes for reporting (max 10) at a time.

Examples
========

.. code:: sql

    EXEC [spMFSetup_Reporting] @Classes = 'Customer, Drawing'
                                ,@Debug = 0   -- int

.. code:: sql

    SELECT * FROM MFContextMenu

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-27  LC         Adjust to setup context menu group for access
2019-05-17  LC         Set security for menu to MFSQLConnector group
2019-04-10  LC         Adjust to allow for context menu configuration in different languages
2019-01-31  LC         Fix bug for spmfDropandUpdateTable parameter
2018-11-12  LC         Create procedure
==========  =========  ========================================================

