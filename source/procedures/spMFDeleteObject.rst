
================
spMFDeleteObject
================

Return
  - 1 = Success object deleted
  - -1 = Error
  - 2 =	Success object version destroyed
  - 3 =	Success object  destroyed
  - 4 = Failure object does not exist
  - 5 =	Failure object version does not exist
  - 6 =	Failure destroy latest object version not allowed

Parameters
  @ObjectTypeId int
    OBJECT Type MFID from MFObjectType
  @objectId int
    Objid of record
  @Output nvarchar(2000) (output)
    Output message
  @objectVersion int
    the object version to be removed. 
    default = 0 which indicates the delete the object rather than a version
  @DeleteWithDestroy bit (optional)
    - Default = 0
    - 1 = Destroy

Purpose
=======

An object can be deleted from M-Files using the ClassTable by using the spMFDeleteObject procedure. Is it optional to delete or destroy the object in M-Files.

The procedure can also be used to destroy a specific version of an object.  This is particularly useful when old or outdataed versions must be removed from the system.

Additional Information
======================

Use this procedure to delete or destroy a single object or object version.  spMFDeleteObjectList can be used to delete a series of objects.

Warnings
========

Note that when a object is deleted it will not show in M-Files but it will still show in the class table. However, in the class table the deleted flag will be set to 1.

To delete a object version, the specified version must exist.  Use spMFGetHistory to first pull all the versions of an object or objects, and then use the FObjectChangeHistory table to determine the object versions to be removed.

Deleting and object version performs a destroy of the version. There is no possibility to undelete a deleted version.

The latest version of the object cannot be specified as the object version to be destroyed.

Examples
========

Deleting and object
~~~~~~~~~~~~~~~~~~~

.. code:: sql

    DECLARE @return_value int, @Output nvarchar(2000)
    SELECT @Output =N'0'
    EXEC @return_value = [dbo].[spMFDeleteObject]
         @ObjectTypeId =128,-- OBJECT MFID
         @objectId =4700,-- Objid of record
         @Output = @Output OUTPUT,
         @DeleteWithDestroy = 0
    SELECT @Output as N'@Output'
    SELECT'Return Value'= @return_value
    SELECT @Output =N'0'
    GO

Delete object versions
~~~~~~~~~~~~~~~~~~~~~~

To delete an object version the objid and the version to delete is required.
Use spMFGetHistory to get the valid versions of an object
Then use spMFDeleteObject to destroy the specific version

.. code:: sql

    UPDATE Mcoa
    SET [mcoa].[Process_ID] = 5
    FROM [dbo].[MFCustomer] AS [mcoa]
    WHERE [mcoa].[ObjID] = 134
    DECLARE @Update_ID INT
    ,@ProcessBatch_id INT;
    EXEC [dbo].[spMFGetHistory] @MFTableName = 'MFCustomer'   
                           ,@Process_id = 5    
                           ,@ColumnNames = 'MF_Last_modified'  
                           ,@IsFullHistory = 1 
                           ,@NumberOFDays = null  
                           ,@StartDate = null     
                           ,@Update_ID = @Update_ID OUTPUT  
                           ,@ProcessBatch_id = @ProcessBatch_id OUTPUT 
                           ,@Debug = 0 
    SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch] WHERE [moch].[ObjID] = 134

Use a loop to destroy multiple versions of multiple objects

.. code:: sql

    DECLARE @Output NVARCHAR(2000);
    DECLARE @processBatch_ID INT;
    DECLARE @Return_Value int

    EXEC  @Return_Value = [dbo].[spMFDeleteObject] @ObjectTypeId = 136  
                             ,@objectId = 134 
                             ,@Output = @Output OUTPUT                                
                             ,@ObjectVersion = 9     -- set to specific version to destroy
                             ,@DeleteWithDestroy = 1 -- object version history is always destroy
							 ,@ProcessBatch_id = @processBatch_ID OUTPUT
                             
    SELECT @Return_Value

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-04-28  LC         Update documentation for Object Versions
2019-08-30  JC         Added documentation
2019-08-20  LC         Expand routine to respond to output and remove object from change history
2019-08-13  DEV2       Added objversion to delete particular version.
2018-08-03  LC         Suppress SQL error when no object in MF found
2016-09-26  DEV2       Removed vault settings parameters
2016-08-22  LC         Update settings index
2016-08-14  LC         Add objid to output message
==========  =========  ========================================================

