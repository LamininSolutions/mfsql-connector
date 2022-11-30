
=================
FnMFGetCulture
=================

Return
  Culture of local database as short string

Purpose
=======

Used to return the culture code for use in Formatting

Examples
========

.. code:: sql

    Declare @Culture nvarchar(10)
	SET @Culture = fnMFGetCulture()

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2022-11-18  LC         Initial Version
==========  =========  ========================================================

