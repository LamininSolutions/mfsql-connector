
=====================
MFvwObjectTypeSummary
=====================

Purpose
=======

The view shows a summary of MFAuditHistory with the intent to get the number of objects in a class

Additional Info
===============

Use exec spMFObjectTypeUpdateClassIndex to process the data for either an individual or all classes in the vault

Only objects that have an lastmodified date after 2000-01-01 will be included.


Examples
========

.. code:: sql

   Select * from MFvwObjectTypeSummary order by class

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-08-27  LC         Repoint view to MFAuditHistory table and add columns
2019-04-11  LC         Extend view
2018-07-12  LC         Create view
==========  =========  ========================================================

