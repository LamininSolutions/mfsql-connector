
========================
fnMFParseDelimitedString
========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @List varchar(max)
    Delimited list to convert to key value pair tabl
  @Delimeter char
    Delimiter, i.e. ','

Purpose
=======

Converts a delimited list into a table.

Examples
========

.. code:: sql

    SELECT * FROM dbo.fnParseDelimitedString('A,B,C',',')

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2017-12-17  LC         Increase size of listitem to ensure that it will catr for longer names
2014-09-13  AC         Initial Version - QA
==========  =========  ========================================================

