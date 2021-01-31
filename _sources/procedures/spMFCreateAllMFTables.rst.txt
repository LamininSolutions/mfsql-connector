
=====================
spMFCreateAllMFTables
=====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @IncludedInApp int
    Default = 1
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

Create all Class Tables for IncludedinApp = 1 by default, or as set in the @IncludedInApp parameter

Examples
========

.. code:: sql

    EXEC [spMFCreateAllMFTables]

-----

.. code:: sql

    UPDATE mc
    SET [mc].[IncludeInApp] = 4
    FROM MFclass mc
    INNER JOIN MFObjectType mo
    ON [mo].[ID] = [mc].[MFObjectType_ID]
    WHERE mo.name = 'Document' AND [mc].[IncludeInApp] IS NULL

    EXEC [spMFCreateAllMFTables] = 4

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-26  LC         Add parameter to allow for setting up custom list for creating tables
2019-08-30  JC         Added documentation
2016-04-01  DEV2       Create procedure
==========  =========  ========================================================

