
======================
spMFDropAllClassTables
======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @IncludeInApp int
    - Drop only tables with IncludeInApp value
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======

Drop all class tables.

Examples
========

.. code:: sql

    EXEC [spMFDropAllClassTables] 1, 0

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
==========  =========  ========================================================

