
======================
fnMFSplitPairedStrings
======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @PairColumn1 varchar(max)
    Multiple property id's separated by ',' ie: 1,2,3
  @PairColumn2 varchar(max)
    Multiple property values's separated by ',' ie: a,b,c
  @Delimiter char
    Delimiter, i.e. ','
  @Delimiter\_MultiLookup char
    Second delimited used to split multilookop value, e.g. '#'

Purpose
=======

Converts a delimited list with two pairing columns into a table, caters for a value as a delimited list

Examples
========

.. code:: sql

    SELECT * FROM dbo.fnMFSplitPairedStrings('1,2,3','a,b,c',',','#')

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2017-12-21  LC         Change name of function.  Allow for including multilookup value with multiDelimiter, change names of parameters
2014-09-13  AC         Initial Version - QA
==========  =========  ========================================================

