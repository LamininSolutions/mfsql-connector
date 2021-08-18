
================
MFvwAuditSummary
================

Purpose
=======

To view a summary of AuditHistory by Flag and Class

Examples
========

.. code:: sql

    Select * from MFAuditHistory

----

show audit history for a specific class

.. code:: sql

    Select ah.*, mc.name from MFAuditHistory ah
    inner join MFClass mc
    on ah.Class = mc.mfid
    Where mc.name = 'Customer'
    
Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-03-27  LC         Add object type in view to catch collections
2020-03-27  LC         Add documentation
==========  =========  ========================================================

