
===============
fnMFSplitString
===============

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Input nvarchar(max)
    Multiple column Name's separated by ',' ie: 1,2,3
  @Character char
    Delimiter, i.e. ','

Purpose
=======

Used to Converts a delimited list into a table

Examples
========

.. code:: sql

    SELECT * FROM dbo.fnSplitString('a,b,c',',')

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2015-05-14  DEV2       Initial Version - QA
==========  =========  ========================================================

