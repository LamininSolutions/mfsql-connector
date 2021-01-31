
=========
fnMFSplit
=========

Return
  - 1 = Success
  - -1 = Error
Parameters
  @PropertyIDs varchar(max)
    Multiple property id's separated by ',' ie: 1,2,3
  @PropertyValues varchar(max)
    Multiple property values's separated by ',' ie: a,b,c
  @Delimiter char
    Delimiter, i.e. ','

Purpose
=======

Converts a delimited list into a table

Examples
========

.. code:: sql

    SELECT * FROM dbo.fnMFSplit('1,2,3','a,b,c',',')

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2014-09-13  AC         Initial Version - QA
==========  =========  ========================================================

