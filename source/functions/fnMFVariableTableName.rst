
=====================
fnMFVariableTableName
=====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @TablePrefix nvarchar(100)
    Table name prefix
  @TableSuffix nvarchar(20)
    Table name suffix

Purpose
=======

Create Unique Table Name

Examples
========

.. code:: sql

    SELECT [dbo].[fnMFVariableTableName]( 'tmpTest','1')

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2018-02-28  LC         Include an alternative method of setting the file name based on unique identifyer. this is controlled by using a flag.
==========  =========  ========================================================

