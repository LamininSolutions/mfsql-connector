
=======================
MFvwObjectChangeHistory
=======================

Purpose
=======

To view the changes of an object by property with details of the display value

Examples
========

.. code:: sql

    Select * from MFvwObjectChangeHistory
    ORDER BY TableName, ObjID,
    Property_ID;

----

show the change history for a specific object in a table

.. code:: sql

    Select * from MFvwObjectChangeHistory where TableName = 'MFCustomer' and objid = 134
    ORDER BY Property_ID;
    
Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-10-13  LC         New view
==========  =========  ========================================================

