
==================
spMFconnectionTest
==================

Return
  - 1 = Success
  - 0 = Error
Parameters
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

Rapid test of a connection to the SQL server

Examples
========

.. code:: sql

    Exec spmfconnectiontest @debug = 1

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-08-31  LC         Create procedure
==========  =========  ========================================================

