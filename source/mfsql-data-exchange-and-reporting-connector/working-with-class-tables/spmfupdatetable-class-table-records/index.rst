spMFUpdatetable Class Table Records
===================================

| 



Updating or inserting records
-----------------------------

Several procedures and methods are available to synchronize the class
records (such as customer, contacts, or file metadata)

Synchronization takes place in both directions. From M-Files to SQL and
from SQL to M-Files.  The procedures include an update method to control
the direction.  This is done by specifying the update method.

The spMFUpdateTable procedure is at the heart of updating or inserting
Class Table Objects.  Several other procedures applicable in different
use cases is built off this core procedure.

These procedures include:

-  spMFUpdateMFilesToSQL
-  spMFUpdateTablewithLastModifiedDate
-  spMFUpdateTableinBatches
-  spMFUpdateAllIncludedInAppTables

-  spMFUpdateItembyItem

Mode of update

Updates can take place on demand (batch mode) or when a records is
inserted/updated in the SQL table (transaction mode)

The on demand mode can be triggered by an execute agent to update at
specific times (e;g; at end of day, or before / after an application
procedure has been completed)

Note that the ability to trigger the update of SQL immediately when a
item is changed in M-Files is currently in development and due in a
future release.

Update method

The direction of update is determined by the update method specified in
the spMFUpdateTable procedure as a parameter

.. container:: table-wrap

   ========================================= ==================
   Used for                                  UpdateMethod value
   ========================================= ==================
   For all batch updates from SQL to M-Files 0
   For all batch update from M-Files to SQL  1
   ========================================= ==================

Using Filters

The spmfupdatetable procedure includes a number of filters that allows
for a range of different scenarios.

.. container:: table-wrap

   ============== ================================================================================================= =========================================================================================================================================== ===================================================================================================================================================================================================================================================================================================================================================================================================================================================
   Filter         Example value                                                                                     Use Cases                                                                                                                                   Key considerations
   ============== ================================================================================================= =========================================================================================================================================== ===================================================================================================================================================================================================================================================================================================================================================================================================================================================
   UserID         a single string value from column MX_UserID                                                       This filter is design to enforce updating of records for a specific application user only. Note that this is different to the M-Files user. The user_id from column MX_User_ID will be used to filter the records that is passed through for updating/inserting. This parameter is particular useful where multiple users are updating SQL and the updating of M-Files need to be controlled by the user.Set by default to Null. This will to include all application users.To set the MX_UserID include the column when updating / inserting a record with your custom application procedures.
   MFLastModified datetime value as a string. example. '2015-01-01'                                                 Only update records from M-Files that have been updated in M-Files on or after this datetime                                                Set by default to Null this will include all dates.Use only with updatemethod 1. This parameter is ignored when used with updatemethod 0 or 2.Note that when using this filter the update procedure will not update any deleted records from M-Files. Execute spmfTableAudit after using this procedure if there is a requirement to check for deleted records from M-Files. The time is shown in localtime.
   ObjIDs         objid of the record(s) that need to be updated as a comma delimited string. example '12,14,68,90' Use this filter when-ever the objid of the item requiring update is available.                                                              Set by default to Null to include all objid's. Use with updatemethod 0 and 1. Only items within the scope of this filter will be accesses and updated. This is by far the most productive update method when the objids of the items to be updated is known.
                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                Related functions to work with delimited strings are:
                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                -  fnMFCreateDelimitedString
                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                -  fnMFParseDelimitedString
   ============== ================================================================================================= =========================================================================================================================================== ===================================================================================================================================================================================================================================================================================================================================================================================================================================================



Using procedure spMFUpdateTable
-------------------------------

This is the core updating procedure.  It is very likely that this
procedure will be built into your application or own procedures as part
of the process of creating, updating, inserting records from your
application.

A number of quick procedures is included in the Connector that is
already using this procedure is included below.

.. container:: table-wrap

   ============== ===================================================================================================================
   Type           Description
   ============== ===================================================================================================================
   Procedure Name  spMFUpdateTable
   Inputs         MFTableName : Pass the class table name, e.g.: MFCustomer
                 
                  Updatemethod : 0, 1 or 2,
                 
                  User_ID : User_Id from MX_User_Id column
                 
                  MFLastModified : 'YYYY-MM-DD'
                 
                  ObjIDs : ObjID's of records (separated by comma)   
                 
                  Update_IDOut: Output parameter referencing the id of the update result in MFUpdateHistory
                 
                  ProcessBatch_ID: Output parameter referencing the ID of the ProcessBatch logging table
                 
                  SyncErrorFlag: Default set to 0
                 
                  RetainDeletions: Default set to 0.  Set to 1 to keep deleted items in M-Files in the SQL table shown as deleted = 1
                 
                  Debug: 0 = Default no debug; 1 = Debug Mode; 2 = Include detail listing
   Outputs        1 = success
                 
                  0 = Partial (Some records failed to insert into MF Table
                 
                  -1 = Error
   ============== ===================================================================================================================



Updating or inserting records from SQL to M-Files
-------------------------------------------------

The objects to be updated/inserted must be prepared before the
spMFUpdateTable procedure is executed

Always set Process_id column on the Class Table to 1. This column flags
the records that will be included in the update.



 Create new record
~~~~~~~~~~~~~~~~~~

When creating a new record the following columns must be completed:

-  All required Properties as per the Metadata Card definition.

In the case of lookup properties it is only necessary to add the MFID of
the in the Column_ID. It is not required to add the description. M-Files
will automatically update this value

The following columns have defaults. Setting values are optional

-  Name_or_Title - when Name_or_title is auto calculated then setting
   value for Name_or_Title is optional
-  Class_ID - if not set it will default to the class id of the table
   that is being processed
-  IsSingleFile - default set to 0
-  FileCount - default set to 0
-  External_id - default is set to Objid



Update record
~~~~~~~~~~~~~

When an existing record is marked with process_id then all the columns
will be updated in M-Files.  Note that the description of a lookup is
ignored and only the ID is used.



Updating of columns
-------------------

The procedure will automatically update the following columns with the
result



Process_id
~~~~~~~~~~

Process_ID column will updated with 0, 2, 3 or 4 depending on error
condition.

-  0 - Change from 1 to 0 to indicate that record updated successfully
   in M-Files
-  2 - Synchronization error: Version conflict occurred on the object
   (triggers email notification)
-  3 - M-Files processing error: Failed to update the values because of
   error while updating M-Files. (triggers email notification)
-  4 - SQL processing error: Failed to update SQL because of an error
   generated by SQL (triggers email notification)



Update_ID
~~~~~~~~~

The record ID from MFUpdateHistory table is set in the Update_ID column,
showing the most recent update id.



MFVersion
~~~~~~~~~

The MFVersion number will be updated if changed.



FileCount
~~~~~~~~~

The value of the FileCount property from M-Files. It is automatically
updated and cannot be changed from SQL



LastModified
~~~~~~~~~~~~

The date and time in local time zone when the record was last modified
by the Connector

| 

**
**



**Execute the core procedure - all parameters: spMFUpdateTable
**
--------------------------------------------------------------

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         DECLARE @return_value int

         EXEC @return_value = [dbo].[spMFUpdateTable]
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

         SELECT 'Return Value' = @return_value

         GO

Showing the logging results

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         DECLARE @return_value int

         DECLARE @update_ID INT, @processBatchID int
         EXEC @return_value = [dbo].[spMFUpdateTable]
             @MFTableName = N'YourTableName'
           , -- nvarchar(128)
             @UpdateMethod = 1
           , -- int
           
             @Update_IDOut = @update_ID output
           , -- int
             @ProcessBatch_ID = @processBatchID output

         SELECT * FROM [dbo].[MFProcessBatchDetail] AS [mpbd] WHERE [mpbd].[ProcessBatch_ID] = @processBatchID

         SELECT 'Return Value' = @return_value

         GO

Using short notation: The following will update from and to M-Files with
all optional parameters set to default.

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

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



Using procedure spMFUpdateAllIncludedInAppTables
------------------------------------------------

This procedure will automatically update all the class tables with
includeInApp column = 1 using the MFLastModified filter to perform the
update.  This is a quick method to run an update on all tables.

.. container:: table-wrap

   ============== =============================================
   Type           Description
   ============== =============================================
   Procedure Name ::
                 
                     spMFUpdateAllncludedInAppTables
   Inputs         UpdateMethod = 0,1 or 2
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== =============================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFUpdateAllncludedInAppTables] @UpdateMethod = 0, -- int
             @Debug = 0 -- smallint



Using procedure spMFUpdateTableWithLastModifiedDate
---------------------------------------------------

This procedure will automatically determine what is the last time that
the table was updated from M-Files and perform an update for the table
based on the MFLastModified filter.

Note that running this procedure will not update deleted items from
M-Files

.. container:: table-wrap

   ============== ============================================================================================
   Type           Description
   ============== ============================================================================================
   Procedure Name ::
                 
                     spMFUpdateTableWithLastModifiedDate
   Inputs         UpdateMethod = 1 or 2
                 
                  Return_LastModified = output of Max(MFLastModified) after update was completed in local time
                 
                  TableName = name of table to be updated
                 
                  Update_IDOut: Output parameter referencing the id of the update result in MFUpdateHistory
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== ============================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          
         DECLARE @RC INT
         DECLARE @UpdateMethod INT = 1
         DECLARE @Return_LastModified DATETIME
         DECLARE @TableName sysname = 'MFCustomer'
         DECLARE @update_IDOut int

         EXECUTE @RC = [dbo].[spMFUpdateTableWithLastModifiedDate] 
            @UpdateMethod
           ,@Return_LastModified OUTPUT
          ,@update_IDOut = @update_IDOut output
           ,@TableName


         SELECT @Return_LastModified
         Select @update_IDOut



Using procedure spMFUpdateMFilestoMFSQL
---------------------------------------

This procedure include a number of sub procedures to optimize
spMFUpdatetable. 

If UpdateTypeID is set to 0 then to procedure will perform a full
refresh using updatemethod 1 for all records with no filters on
spMFUpdateTable.

If UpdateTypeID is set to 1 then to procedure will perform a incremental
using updatemethod 1.  The following key sub-processes are conducted:

-  Get all objectversions from M-Files
   (`spMFTableAudit <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/31817744/Working+with+Object+Version>`__)
-  Match objectversions with SQL to determine objid's that need updating
-  use spMFUpdateTable with a filter on the objid's that is different
   between M-Files and SQL
-  Determine that lastmodified date in M-Files and return it as output
   variable.

If UpdateTypeID is set to 2 then to procedure will perform a incremental
using updatemethod 1 using the method describe above, however it
includes an additional step to determine if any records have been
deleted in M-Files and to update SQL with the deletions.

| 

.. container:: table-wrap

   ============== ====================================================================================================
   Type           Description
   ============== ====================================================================================================
   Procedure Name spMFUpdateMFilestoMFSQL
   Inputs         MFTableName = name of table to be updated
                 
                  ProcessBatch_ID = 0 This parameter is used to stream this procedure as part of the calling procedure
                 
                  UpdateTypeID = 0 Full refresh of all records; 1 incremental update
                 
                  MFLastUpdateDate = date of last item updated (output)
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
                 
                  MFAstUpdateDate = date of last record updated in M-Files
                 
                  | 
   ============== ====================================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         Declare @UpdateDate smalldatetime
         EXEC [dbo].[spMFUpdateMFilesToMFSQL]
             @ProcessBatch_ID = 0
           , -- int
             @UpdateTypeID = 0
           , -- tinyint
             @MFTableName = N''
           , -- nvarchar(128)
             @MFLastUpdateDate = @UpdateDate output
           , -- smalldatetime
             @debug = 0 -- tinyint

         Select @UpdateDate



Using procedure spMFUpdateTableInBatches
----------------------------------------

spMFUpdateTableinBatchesshould be used when updating class tables with
large volumes especially during data takeon or metadata cleansing. Large
volume is defined as 50 000 + records.

The procedure can be used for both from M-Files to SQL and from SQL to
M-Files.

When updating from M-Files to SQL the update will be processed in series
starting the with objid 

.. container:: table-wrap

   ============== ===========================================================================================
   Type           Description
   ============== ===========================================================================================
   Procedure Name spMFUpdateTableInBatches
   Inputs         MFTableName: name of class table
                 
                  UpdateMethod: either 0 or 1
                 
                  MaxObjid: highest id in M-Files for the object type
                 
                  BatchesToRun: limit the number of batches to be processed. Only applies for update method 1
                 
                  MinObjid: default = 1. Set the starting point for update method 1
                 
                  WithStats: default = 1. Set 0 to suppress showing the statistics in the messages screen
                 
                  Debug: default = 0
   Outputs        Stats shown in messages tab
   ============== ===========================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         --With update method = 1 (From M-Files to SQL)

         EXEC [dbo].[spMFUpdateTableinBatches] 
         @MFTableName = 'MFLarge_Volume'  
         ,@UpdateMethod = 1 -- MF to SQL 
         ,@maxObjid = 60000 
         ,@BatchestoRun = 2 
         ,@MinObjid = 15000     -- default is 1 
         ,@WithStats = 1    -- default is 1 
         ,@Debug = 0        -- default is 0

         --With update method = 0 (From SQL to M-Files)
         EXEC [dbo].[spMFUpdateTableinBatches] 
         @MFTableName = 'MFLarge_Volume'  
         ,@UpdateMethod = 0 
         ,@maxObjid = 60000 
         ,@WithStats = 1    -- default is 1 
         ,@Debug = 0        -- default is 0

Demonstrate functionality

`03.151.using
spmfupdatet… <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/31817730/spMFUpdatetable+Class+Table+Records?preview=%2F31817730%2F615448667%2F03.151.using+spmfupdatetableInbatches+for+batch+updates.sql>`__



Using procedure spMFUpdateItembyItem
------------------------------------

This is a special procedure that is useful when there are data errors in
M-Files and it is necessary to determine which specific records are not
being able to be processed.

Note that this procedure use updatemethod 1 by default.  It returns a
session id.  this id can be used to inspect the result in the
MFAuditHistory Table. Refer to Using Audit History for more information
on this table

| 

.. container:: table-wrap

   ============== =======================================================================================================
   Type           Description
   ============== =======================================================================================================
   Procedure Name spMFUpdateItembyItem
   Inputs         TableName = name of table to be updated
                 
                  SessionIDOut = output of the session id that was used to update the results in the MFAuditHistory Table
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== =======================================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         DECLARE @RC INT
         DECLARE @TableName VARCHAR(100) = 'MFCustomer'
         DECLARE @Debug SMALLINT
         DECLARE @SessionIDOut INT

         -- TODO: Set parameter values here.

         EXECUTE @RC = [dbo].[spMFUpdateItemByItem] 
            @TableName
           ,@Debug
           ,@SessionIDOut OUTPUT


         SELECT @SessionIDOut




