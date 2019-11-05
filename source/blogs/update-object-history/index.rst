
Updating object change history
==============================

Version 4.4.13.54 introduces functionality to include the updating of the object change history in the scheduled updating of spmfUpdateAllIncludedInAppTables. After taking the steps outlined below this procedure will automatically include processing spMFGetHistory

The procedure spMFUpdateObjectChangeHistory and the table MFObjectChangeHistoryControl have been added in version 4.4.13.54.  The procedures allows for updating all of the tables and settings in the MFObjectChangeHistoryControl table to updated automatically.
 -  spMFGetHistory will be processed for each row in the control table (consisting of a valid class table name and a valid property column name)
 -  All records in the class table with values for the specific property will be included
 -  The start date of the update will be set to the last change date in for the specific class and property in the MFObjectChangeHistory table.
 -  The procedure will therefor only update new changes for the property. Previous changes of the property is in MFObjectChangeHistory

Insert records in MFObjectChangeHistoryControl
----------------------------------------------

Records must be added for your specific requirements in this table.  The procedure will have no impact if no records are found in this table.

.. code:: sql

   INSERT INTO dbo.MFObjectChangeHistoryUpdateControl(
   MFTableName,
   ColumnNames)
   VALUES
   (N'MFCustomer', N'City'),
   N'MFCustomer', N'Country_ID'),
   N'MFCustomer', N'State_ID'),
   N'MFPurchaseInvoice', N'State_ID');

Update object history for all the tables
========================================

There are various scenarios for updating object history:

Automatically schedule and update object history for all related class tables.
------------------------------------------------------------------------------

The procedure spMFUpdateAllIncludedInAppTables includes the updating of history using the spMFUpdateObjectHistory procedure.
This procedure is often included in an agent for scheduled updates or called by an Context Menu action

Update object history on demand
-------------------------------

Execute the following procedure after the table as outlined above has been updated.


Updating history for a specific class table during testing or development.
--------------------------------------------------------------------------

The following sample script demonstrates how to setup and run spMFGetHistory.

.. code:: SQL

   UPDATE [MFPurchaseInvoice]
   SET Process_ID = 5

   DECLARE @RC INT
   DECLARE @TableName NVARCHAR(128) = 'MFPurchaseInvoice'
   DECLARE @Process_id INT = 5
   DECLARE @ColumnNames NVARCHAR(4000) = 'State'
   DECLARE @IsFullHistory BIT = 1
   DECLARE @NumberOFDays INT  
   DECLARE @SearchString NVARCHAR(MAX) = null
   DECLARE @StartDate DATETIME --= DATEADD(DAY,-1,GETDATE())
   DECLARE @ProcessBatch_id INT
   DECLARE @Debug INT = 1
   DECLARE @Update_ID        INT

   EXEC [dbo].[spMFGetHistory] @MFTableName =  @TableName   -- nvarchar(128)
                           ,@Process_id = @Process_id    -- int
                           ,@ColumnNames = @ColumnNames   -- nvarchar(4000)
                           ,@SearchString = null  -- nvarchar(4000)
                           ,@IsFullHistory = @IsFullHistory -- bit
                           ,@NumberOFDays = @NumberOFDays  -- int
                           ,@StartDate = @StartDate     -- datetime
                           ,@Update_ID = @Update_ID OUTPUT                         -- int
                           ,@ProcessBatch_id = @ProcessBatch_id OUTPUT            -- int
                           ,@Debug = @debug         -- int

