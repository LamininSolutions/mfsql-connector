
=====================
MFvwClassTableColumns
=====================

Purpose
=======

To view the definition of the class tables columns

The procedure spmfClassTableColumns provide a more indepth look at the class tables and column errors

Examples
========

.. code:: sql

   Select * from MFvwClassTablecolumns

----

.. code:: sql

    EXEC [dbo].[spMFClassTableColumns] 
    --review result
    SELECT * FROM ##spMFClassTableColumns



Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2022-09-27  LC         updates following changes to additional property identification
2021-10-26  LC         Set max columns to 10000
2018-11-01  LC         Create view
==========  =========  ========================================================

