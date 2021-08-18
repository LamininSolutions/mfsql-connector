
===============
spMFUpdateTable
===============

Return
  - 1 = Success
  - 0 = Partial (some records failed to be inserted)
  - -1 = Error
Parameters
  @MFTableName
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @Updatemethod
    - 0 = update from SQL to M-Files
    - 1 = update from M-Files to SQL
  @User_ID (optional)
    - Default = 0
    - User_Id from MX_User_Id column
    - This is NOT the M-Files user.  It is used to set and apply a user_id for a third party system. An example is where updates from a third party system must be filtered by the third party user (e.g. placing an order)
  @MFLastModified (optional)
    - Default = 0
    - Get objects from M-Files that has been modified in M-files later than this date.
  @ObjIDs (optional)
    - Default = null
    - ObjID's of records (separated by comma) e.g. : '10005,13203'
    - Restricted to 4000 charactes including the commas
  @Update_IDOut (optional, output)
    Output id of the record in MFUpdateHistory logging the update ; Also added to the record in the Update_ID column on the class table
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @SyncErrorFlag (optional)
    - Default = 0
    - This parameter is automatically set by spMFUpdateSynchronizeError when synchronization routine is called.
  @RetainDeletions (optional)
    - Default = 0
    - Set to 1 to keep deleted items in M-Files in the SQL table shown as "deleted" or the label of property 27 with the date time of the deletion.
  @IsDocumentCollection (optional)
    - Default = 0 (use default object type for the class)
    - Set to 1 to process objects with object type 9 (document collection) for the class.
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

This procedure get and push data between M-Files and SQL based on a number of filters.  It is very likely that this procedure will be built into your application or own procedures as part of the process of creating, updating, inserting records from your application.

When calling this procedure in a query or via another procedure it will perform the update in batch mode on all the rows with a valid process_id.

When the requirements for transactional mode has been met and a record is updated/inserted in the class table with process_id = 1, a trigger will automatically fire spMFUpdateTable to update SQL to M-Files.

A number of procedures is included in the Connector that use this procedure including:
- spMFUpdateMFilesToSQL
- spMFUpdateTablewithLastModifiedDate
- spMFUpdateTableinBatches
- spMFUpdateAllIncludedInAppTables
- spMFUpdateItembyItem

By default the object type of the class will get the object type from the MFclass Table (using the default object type of the class).  To process Document collection objects for the class, the @IsDocumentCollection must be set to 1.  

Prerequisites
=============

From M-Files to SQL
-------------------
Process_id in class table must be 0. All other rows are ignored.


From SQL to M-Files - batch mode
--------------------------------
Process_id in class table must be 1 for rows to be updated or added to M-Files. All other rows are ignored.

Warnings
========

When using a filter (e.g. for a single object) to update the table with Update method 1 and the filter object process_id is not 0 then the filter will automatically revert to updating all records. Take care to pass valid filters before passing them into the procedure call.

This procedure will not remove destroyed objects from the class table.  Use spMFUpdateMFilestoMFSQL identify and remove destroyed object.

This procedure will not remove objects from the class table where the class of the object was changed in M-Files.  Use spMFUpdateMFilestoMFSQL to identify and remove these objects from the class table.

Deleted objects will only be removed if they are included in the filter 'Objids'.  Use spMFUpdateMFilestoMFSQL to identify deleted objects in general identify and update the deleted objects in the table.

Deleted objects in M-Files will automatically be removed from the class table unless @RetainDeletions is set to 1.

The valid range of real datatype properties for uploading from SQL to M-Files is -1,79E27 and 1,79E27

Examples
========

.. code:: sql

    DECLARE @return_value int

    EXEC    @return_value = [dbo].[spMFUpdateTable]
            @MFTableName = N'MFCustomerContact',
            @UpdateMethod = 1,
            @UserId = NULL,
            @MFModifiedDate = null,
            @update_IDOut = null,
            @ObjIDs = NULL,
            @ProcessBatch_ID = null,
            @SyncErrorFlag = 0,
            @RetainDeletions = 0,
            @Debug = 0

    SELECT  'Return Value' = @return_value

    GO

Execute the core procedure with all parameters

----

.. code:: sql

    DECLARE @return_value int
    DECLARE @update_ID INT, @processBatchID int

    EXEC @return_value = [dbo].[spMFUpdateTable]
         @MFTableName = N'YourTableName', -- nvarchar(128)
         @UpdateMethod = 1, -- int
         @Update_IDOut = @update_ID output, -- int
         @ProcessBatch_ID = @processBatchID output

    SELECT * FROM [dbo].[MFProcessBatchDetail] AS [mpbd] WHERE [mpbd].[ProcessBatch_ID] = @processBatchID

    SELECT  'Return Value' = @return_value

Process document collection type objects for the class

----

.. code:: sql

    EXEC dbo.spMFUpdateTable @MFTableName = 'MFOtherDocument',
        @UpdateMethod = 1,
        @IsDocumentCollection = 1,
        @Debug = 101


Update from and to M-Files with all optional parameters set to default.

----

.. code:: sql

    --From M-Files to SQL
    EXEC [dbo].[spMFUpdateTable] @MFTableName = 'MFCustomer',
                                 @UpdateMethod = 1
    --or
    EXEC spMFupdateTable 'MFCustomer',1

    --From SQL to M-Files
    EXEC [dbo].[spMFUpdateTable] @MFTableName = 'MFCustomer',
                                 @UpdateMethod = 0
    --or
    EXEC spMFupdateTable 'MFCustomer',0

Update from and to M-Files with all optional parameters set to default.

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2022-06-21  LC         Modify proc to include document collections
2021-04-14  LC         fix timestamp datatype bug
2021-03-15  LC         fix changing of class in the same object type in MF
2021-03-11  LC         update maximum valid number range to between -1,79E27 and 1,79E27
2021-01-31  LC         Fix bug on insert new into audithistory
2020-11-28  LC         Improve collection of property ids
2020-11-28  LC         Resolve issue when fail message
2020-11-24  LC         New functionality to deal with changing of classes
2020-10-20  LC         Fix locationlisation for class_id 
2020-09-21  LC         Change column name Value to avoid conflict with property
2020-08-25  LC         Fix debugging and log messaging
2020-08-27  LC         Rework logic to deal with deleted objects
2020-08-29  LC         Update treatment of required workflow errors
2020-08-22  LC         Replace boolean column Deleted with property 27
2020-07-27  LC         Add handling of delete and check out status
2020-06-13  LC         Remove xml_document when transaction failed
2020-05-12  LC         Set last modified user to MFSQL
2020-04-20  LC         exclude last modified and and MF user to be modified
2020-03-09  LC         Resolve issue with timestamp format for finish formatting
2020-02-27  LC         Resolve issue with open XML_Docs
2020-01-06  LC         Resolve issue: variable is null: @RetainDeletions
2020-01-06  LC         Resolving performance bug when filtering on objids  
2019-12-31	DEV2	   New output parameter add in spMFCreateObjectInternal to return the checkout objects.
2019-10-01  LC         Allow for rounding where float has long decimals
2019-09-02  LC         Fix conflict where class table has property with 'Name' as the name V53
2019-08-24  LC         Fix label of audithistory table inserts
2019-07-26  LC         Update removing of redundant items form AuditHistory
2019-07-13  LC         Add working that not all records have been updated
2019-06-17  LC         UPdate MFaudithistory with changes
2019-05-19  LC         Terminate early if connection cannot be established
2019-01-13  LC         Fix bug for uniqueidentifyer type columns (e.g. guid)
2019-01-03  LC         Fix bug for updating time property
2018-12-18  LC         Validate that all records have been updated, raise error if not
2018-12-06  LC         Fix bug t.objid not found
2018-11-05  LC         Include new parapameter to validate class and property structure
2018-10-30  LC         Removing cursor method for update method 0 and reducing update time by 100%
2018-10-24  LC         Resolve bug when objids filter is used with only one object
2018-10-20  LC         Set Deleted to != 1 instead of = 0 to ensure new records where deleted is not set is taken INSERT
2018-08-23  LC         Fix bug with presedence = 1
2018-08-01  LC         Fix deletions of record bug
2018-08-01  LC         New parameter @RetainDeletions to allow for auto removal of deletions Default = NO
2018-06-26  LC         Improve reporting of return values
2018-05-16  LC         Fix conversion of float to nvarchar
2018-04-04  DEV2       Added Licensing module validation code.
2017-11-03  DEV2       Added code to check required property has value or not
2017-10-01  LC         Fix bug with length of fields
2017-08-23  DEV2       Add exclude null properties from update
2017-08-22  DEV2       Add sync error correction
2017-07-06  LC         Add update of filecount column in class table
2017-07-03  LC         Modify objids filter to include ids not in sql
2017-06-22  LC         Add ability to modify external_id
2107-05-12  LC         Set processbatchdetail column detail
2016-10-10  LC         Change of name of settings table
2016-09-21  LC         Removed @UserName,@Password,@NetworkAddress and @VaultName parameters and fectch it as comma separated list in @VaultSettings parameter dbo.fnMFVaultSettings() function
2016-08-22  LC         Change objids to NVARCHAR(4000)
2016-08-22  LC         Update settings index
2016-08-20  LC         Add Update_ID as output paramter
2016-08-18  LC         Add defaults to parameters
2016-03-10  DEV2       New input variable added (@ObjIDs)
2016-03-10  DEV2       Input variable @FromCreateDate  changed to @MFModifiedDate
2016-02-22  LC         Improve debugging information; Remove is_template message when updatemethod = 1
2015-07-18  DEV2       New parameter add in spMFCreateObjectInternal
2015-06-30  DEV2       New error Tracing and Return Value as LeRoux instruction
2015-06-24  DEV2       Skip the object failed to update in M-Files
2015-04-23  DEV2       Removing Last modified & Last modified by from Update data
2015-04-16  DEV2       Adding update table details to MFUpdateHistory table
2015-04-08  DEV2       Deleting property value from M-Files (Task 57)
==========  =========  ========================================================

