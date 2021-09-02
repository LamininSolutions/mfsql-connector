
========================
spMFAddCommentForObjects
========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName nvarchar(250)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @Process\_id int
    process id of the object(s) to add the comment to
  @Comment nvarchar(1000)
    the text of the bulk comment
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======

Add the same comment to a number of objects in the same class

Additional Info
===============

Set the process_ID for the selected objects before executing the procedure.
Use spGetHistory procedure to access the history of comments of an object in SQL

This procedure will get the latest version of the specified objects, then apply the bulk comment and then update the objects into M-Files.

Warnings
========

Adding bulk comments is a separate process from making a change to the objects. The two processes must run one after the other rather than simultaneously
The same comment will be applied to all the selected objects.

Adding object specific comments can be processed as part of the normal object updating process.

Examples
========

.. code:: sql

    UPDATE [dbo].[MFCustomer]
    SET process_id = 5
    WHERE id IN (1,3,6,9)

    DECLARE @Comment NVARCHAR(100)

    SET @Comment = 'Added a comment for illustration '

    EXEC [dbo].[spMFAddCommentForObjects]
        @MFTableName = 'MFCustomer',
        @Process_id = 5,
        @Comment = @Comment ,
        @Debug = 0

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-08-22  LC         change of deleted column definition
2019-11-23  LC         Redesign procedure
2019-08-30  JC         Added documentation
==========  =========  ========================================================

