
================
spMFDeleteObject
================

Return
  - 1 = Success object deleted
  - 2 =	Success object version destroyed
  - 3 =	Success object destroyed  
  - 3 = Successfully destroyed deleted object (when the object is already deleted)
  - 4 = Failed to destroy, object not found
  - 5 =	Failed to delete, object not found
  - 6 = Failed to remove version, version not found

  - -1 = SQL Error

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

When DeleteWithDestroy = 1 the objectversion specified in ObjectVersion will be ignored and the ObjectVersion will automatically be set to -1.  This will trigger the method to destroy the whole object.  There is no need to manually set the ObjectVersion to -1.  A status code 3 will be returned.
When DeleteWithDestroy = 1 and the objectversion is set to 0 then the object will be destroyed.
When DeleteWithDestroy = 1 and the object does not exist an error code of 4 will be returned 

When DeleteWithDestroy = 0 and the ObjectVersion is set to 0 the whole object will be deleted. Status code 1 is returned.
When DeleteWithDestroy = 0 and an ObjectVersion less that the latest object version is specified the ObjectVersion will be removed.  A status code 2 is returned

When DeleteWithDestroy = 0 and an ObjectVersion that is equal to latest object version is specified the delete will fail with error 6 returned
When DeletedWithDestroy = 0 and the object does not exist an error code 4 will be returned
When DeletedWithDestroy = 0 and the object version does not exist, is not 0 and is not the latest version of the object then an error code 5 will be returned


Warnings
========

To delete an object the object version must be set to 0 and DeleteWithDestroy must be set to 0.

Note that when a object is deleted it will not show in M-Files but it will still show in the class table. However, in the class table the deleted column will have a date.

To delete a object version, the specified version must exist.  Use spMFGetHistory to first pull all the versions of an object or objects, and then use the MFObjectChangeHistory table to determine the object versions to be removed.

Deleting and object version performs a destroy of the version. There is no possibility to undelete a deleted version.

The latest version of the object cannot be specified as the object version to be destroyed.  When the latest version of the object is specified the object will be deleted.

Examples
========

Deleting and object
~~~~~~~~~~~~~~~~~~~

.. code:: sql

    DECLARE @return_value int, @Output nvarchar(2000)

    EXEC @return_value = [dbo].[spMFDeleteObject]
         @ObjectTypeId =128,-- OBJECT MFID
         @objectId =4700,-- Objid of record
         @Output = @Output OUTPUT,
         @DeleteWithDestroy = 0
    SELECT @Output as N'@Output'
    SELECT'Return Value'= @return_value


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
2021-08-15  LC         Remove incorrect license check
2021-05-05  LC         Align single delete object without class table with wrapper
2020-12-08  LC         Change status messages and validate different methods
2020-04-28  LC         Update documentation for Object Versions
2019-08-30  JC         Added documentation
2019-08-20  LC         Expand routine to respond to output and remove object from change history
2019-08-13  DEV2       Added objversion to delete particular version.
2018-08-03  LC         Suppress SQL error when no object in MF found
2016-09-26  DEV2       Removed vault settings parameters
2016-08-22  LC         Update settings index
2016-08-14  LC         Add objid to output message
==========  =========  ========================================================

