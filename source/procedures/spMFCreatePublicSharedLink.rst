
==========================
spMFCreatePublicSharedLink
==========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @TableName varchar(250)
    Name of class table
  @ExpiryDate datetime
    Set to NULL to getdata() + 1 month
  @ClassID int (optional)
    - Default = NULL
    - Class_ID of the Record
  @ObjectID int (optional)
    - Default = NULL
    - ObjID column of the Record
  @ProcessID int (optional)
    - Default = 1
    - set process_id = 0 to update all the records with singlefile = 1 in the class
    - set process_id to a number > 4 if you want to create the link for a set list of records

Purpose
=======

Create or update the link to the specified object and add the link in the MFPublicLink table. A join can then be used to access the link and include it in any custom view.

Additional Info
===============

If you are making updates to a record and want to set the public link at the same time then run the shared link procedure after setting the process_id and before updating the records to M-Files.

The expire date can be set for the number of weeks or month from the current date by using the dateadd function (e.g. Dateadd(m,6,Getdate())).

Warnings
========

This procedure will use the ServerURL setting in MFSettings and expects eiher 'http://' or 'https://' and a fully qualified dns name as the value. Example: 'http://contoso.com'

Examples
========

.. code:: sql

    EXEC dbo.spMFCreatePublicSharedLink
         @TableName = 'ClassTableName', 
         @ExpiryDate = '2017-05-21',    
         @ClassID = null,               
         @ObjectID = null ,                  
         @ProcessID = 0                 

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-03-04  LC         fix bug and add debugging
2020-08-22  LC         update for new deleted column
2019-08-30  JC         Added documentation
2018-04-04  DEV2       Added Licensing module validation code
==========  =========  ========================================================

