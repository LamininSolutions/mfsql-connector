
====================
spMFSetUniqueIndexes
====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======
This procedure sets the unique indexes for all class tables. The use of indexes on the objid and external ID is optional.  When the setting CreateUniqueClassIndexes are set to 1 in the MFSettings table then the indexes will automatically be created when the procedure spMFCreateTable is run.  The default setting in the MFSettings table is to not create indexes.  This allows installations to approach the management of the indexes differently.

Examples
========

.. code:: sql

   Exec spMFSetUniqueIndexes

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-09-09  LC         Remove unique condition for externalID, resolve bugs
2020-03-27  LC         Create Procedure
==========  =========  ========================================================

