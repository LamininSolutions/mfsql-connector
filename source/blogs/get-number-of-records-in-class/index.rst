Get number of records in Class
==============================

Sometimes it is necessary to know the number of records in a particular
class or object type.

Using the procedure spMFObjectTypeUpdateClassIndex and then inspecting
the result will do just that.

First, process the update of the index. This can be done for a specific class, only for
classes included in MFSQL Connector, or for all classes.

Get the max objid and object count in a vault for all objects

.. code:: sql

    EXEC [dbo].[spMFObjectTypeUpdateClassIndex] @IsAllTables = 1 -- setting to 0 will only include includedinapp class tables
                                               ,@Debug = 0

Determine the max objid and object count for a specific class

.. code:: sql

   EXEC [dbo].[spMFObjectTypeUpdateClassIndex] @IsAllTables = 0
                                              ,@MFTableName = 'Customer'
                                              ,@Debug = 0

The view MFvwObjectTypeSummary will produce a stats table on the data in
the MFAuditHistory table to show all the classes by Object
Type with the record count, maximum object id and if it has a class
table or not.

|image0|

.. |image0| image:: img_1.png
