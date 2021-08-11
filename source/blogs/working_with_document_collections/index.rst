Working with Document Collections
=================================

Document collections in M-Files is a special object type that allows objects of a certain class to be related to other objects.

MFSQL Collector allows for extracting and updating the metadata of this type of object, similar to any other class object. This functionality has some restrictions.

 -  To update document collections the @IsDocumentCollection parameter must be set to 1 on the spMFUpdateTable procedure.
 -  If this parameter is not set, objects in the class that is not included in the default object type of the class, will be ignored.
 -  If this parameter is set, then only objects of the object type Document Collections for the specified class will be processed.
 -  Objects of both the default object type and Document Collection object type will be updated in the same class table.
 -  The Table MFAuditHistory show the object type of each object.  The class table does not show the object type of the object.
 -  The procedure spMFClassTableStats and the associated view AuditSummary show if document collections are used in a particular class.

 The following procedure will get objects in a class with a Document Collection object type

.. code:: sql

    EXEC dbo.spMFUpdateTable @MFTableName = 'MFOtherDocument',
        @UpdateMethod = 1,
        @IsDocumentCollection = 1,
        @Debug = 0

The following procedure will update or insert objects from SQL to M-Files as Document collections

.. code:: sql

    EXEC dbo.spMFUpdateTable @MFTableName = 'MFOtherDocument',
        @UpdateMethod = 0,
        @IsDocumentCollection = 1,
        @Debug = 0
