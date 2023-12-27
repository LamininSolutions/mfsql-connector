

/*
LESSON NOTES

How to export update history for a property into SQL.

This example show how to get the comments from an object (Use the Adding comments example to update comments from SQL to MF)

see example for adding comments to an object or add comments manually to customer to aid the example
04.160 adding comments

applies from version 4.1.4.40 
performance improvements from 4.6.15.57

All examples use the Sample Vault as a base
Consult the guide for more detail on the use of the procedures http:\\tinyurl.com\mfsqlconnector
*/

--get and review tables used in the example

-------------------------------------------------------------
-- update history for specific records
-------------------------------------------------------------

SELECT * FROM [dbo].[MFClass] AS [mc]

EXEC spmfcreatetable 'purchase invoice'
EXEC spmfupdatetable 'MFPurchaseInvoice',1

-- prepare table : mark the costomers for which the comment history is required

UPDATE [dbo].MFPurchaseInvoice
SET [Process_ID] = 5

--get comments

DECLARE @ProcessBatch_id INT;
EXEC [dbo].[spMFGetHistory]
    @MFTableName = 'MFPurchaseInvoice',
    @Process_id = 5,
    @ColumnNames = 'MF_Last_Modified' ,
    @IsFullHistory = 1,
    @ProcessBatch_id = @ProcessBatch_id OUTPUT,
    @Debug = 0

	SELECT * FROM [dbo].[MFProcessBatchDetail] AS [mpbd] WHERE [mpbd].[ProcessBatch_ID] = @ProcessBatch_id

--review results in history table

SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch2]

-------------------------------------------------------------
-- Updating incremental history 
-------------------------------------------------------------
--spmfUpdateObjectChangeHistory is specifically designed to
--to routinely update history for a specific property and table
--note that this procedure is built into spmfUpdateMFilesToSQL which will automatically keep the history up to date for tables in the control list.

--step 1 : Setup control table
--view table
SELECT * FROM dbo.MFObjectChangeHistoryUpdateControl AS mochuc

--update table
INSERT INTO dbo.MFObjectChangeHistoryUpdateControl
(
    MFTableName,
    ColumnNames
)
VALUES
(   N'MFCustomer', -- class table must already exist
    N'Name_or_title'  -- ColumnName insert 1 record for each column of a class
    )

--execute the proc with different options
--when @MFTableName is null then all tables in the control table will be included
--when @objids are specified (comma delimited string) then only these objects for the class will be updated
--when @Withclasstable update = 1 then the class table will be updated also

    EXEC dbo.spMFUpdateObjectChangeHistory @MFTableName = N'MFCustomer',        -- nvarchar(200)
                                           @WithClassTableUpdate = 1, -- int
                                           @Objids = null,             -- nvarchar(max)
                                           @ProcessBatch_ID = 0,      -- int
                                           @Debug = 0                 -- smallint
    
 SELECT * FROM dbo.MFObjectChangeHistory AS moch
 






	
