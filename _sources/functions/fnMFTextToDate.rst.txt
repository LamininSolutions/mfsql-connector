
==============
fnMFTextToDate
==============

Return
  - 1 = Success
  - 0 = Error
Parameters
  @TextDate NVARCHAR(25)
    Date in text format e.g. 1/13/2009
  @Character char
    Delimiter, i.e. '/'

Purpose
=======

Convert date in text format with different date layouts to datetime

Examples
========

.. code:: sql

    SELECT dbo.fnMFTextToDate('1/13/2009','/')
    Select dbo.fnMFTextToDate('1/13/2009 05:04:22.007','/')
    Select dbo.fnMFTextToDate('1/13/2009 05:04:22.007 a.m.','/')
	SELECT dbo.fnMFTextToDate('3/1/2017 10:47:44 AM','/')
    
Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-11-01  LC         Expand to include more date formats
2019-09-25  LC         Expand function to include other formats for general use
2019-09-10  LC         Create function for use in licensing
==========  =========  ========================================================

