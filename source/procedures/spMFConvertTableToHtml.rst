
======================
spMFConvertTableToHtml
======================

Return
1 = Success
-1 = Error

Parameters
==========

@SqlQuery 
  - The table select query to be converted
@TableBody OUTPUT
  - Output in html format
@ProcessBatch_ID (optional, output)
  - Referencing the ID of the ProcessBatch logging table
@Debug (optional)
  - Default = 0
  - 1 = Standard Debug Mode

Purpose
=======

Returns a HTML formatted text for a given select statement.

Additional info
===============

This procedure is useful to export the result of a select statement of a view or table for inclusion in an email, report or another result.

Past the content of the HTML outout variable to into a text file with extension .htm and open with a browser to view the result.


Examples
========

.. code:: sql

    DECLARE @Html AS VARCHAR(MAX)
    EXECUTE spMFConvertTableToHtml ' SELECT  * FROM MFclass ',@Html OUTPUT
    SELECT @Html

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-01-26  LC         Create procedure
==========  =========  ========================================================

