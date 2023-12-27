

/*
LESSON NOTES

How to export update history for a property into SQL.

This example show how to get the Workflow States from an object 

applies from version 3.1.4.40 

All examples use the Sample Vault as a base

Consult the guide for more detail on the use of the procedures http:\\tinyurl.com\mfsqlconnector
*/

--get and review tables used in the example

SELECT * FROM [dbo].[MFClass] AS [mc]

EXEC spmfcreatetable 'purchase invoice'
EXEC spmfupdatetable 'MFPurchaseInvoice',1

SELECT * FROM [dbo].[MFPurchaseInvoice] AS [mpi]

-- prepare table : mark the costomers for which the comment history is required

UPDATE [dbo].MFPurchaseInvoice
SET [Process_ID] = 5

--get Workflow States
--This is the initial pull

DECLARE @ProcessBatch_id INT;
EXEC [dbo].[spMFGetHistory]
    @MFTableName = 'MFPurchaseInvoice',
    @Process_id = 5,
    @ColumnNames = 'Workflow_State_id' ,
    @IsFullHistory = 1,
    @ProcessBatch_id = @ProcessBatch_id OUTPUT,
    @Debug = 0

	SELECT * FROM [dbo].[MFProcessBatchDetail] AS [mpbd] WHERE [mpbd].[ProcessBatch_ID] = @ProcessBatch_id

--setup to include change history in daily updates

-- check current settings
SELECT * FROM dbo.MFObjectChangeHistoryUpdateControl
--insert new setting
INSERT INTO MFObjectChangeHistoryUpdateControl
(MFTableName,ColumnNames)
VALUES
('MFPurchaseInvoice','Workflow_State_id')

--setup to ensure that the history will be updated every time the table is updated
GO

DECLARE @MFLastUpdateDate SMALLDATETIME
EXEC dbo.spMFUpdateMFilesToMFSQL @MFTableName = N'MFPurchaseInvoice',            
                                 @MFLastUpdateDate = @MFLastUpdateDate OUTPUT, 
                                 @UpdateTypeID = 1,                                                                                
                                 @WithObjectHistory = 1      
								 
-- use the following procedure to update history regularly without updating the class table, especially if individual objects need to be updated

GO

DECLARE @ProcessBatch_ID INT;
EXEC dbo.spMFUpdateObjectChangeHistory @MFTableName = N'MFPurchaseInvoice',                       
                                       @WithClassTableUpdate = 0,                  
                                       @Objids = null,                              
                                       @IsFullHistory = 0,                         
                                       @ProcessBatch_ID = @ProcessBatch_ID OUTPUT, 
                                       @Debug = 0                                  


--review results in history table

SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch2]

-- use a join to show related information for reporting purposes

SELECT [mpi].[Class_ID],
       [mpi].[ObjID],
       [moch].[MFVersion],
	   mua.[LoginName],
       [mpi].[Name_Or_Title],
       [moch].[Property_Value],
	   mws.[Name]
FROM [dbo].[MFPurchaseInvoice] [mpi]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
        ON [moch].[Class_ID] = [mpi].[Class_ID]
           AND [moch].[ObjID] = [mpi].[ObjID]
    INNER JOIN [dbo].[MFUserAccount] AS [mua]
        ON [mua].[UserID] = [moch].[MFLastModifiedBy_ID]
    INNER JOIN [dbo].[MFWorkflowState] AS [mws]
        ON [moch].[Property_Value] = [mws].[MFID]
WHERE mpi.[ObjID] = 361 

	
-- who caused the workflow state change for the current object

SELECT [mpi].[Class_ID],
       [mpi].[ObjID],
       [moch].[MFVersion],
	   mua.[LoginName],
       [mpi].[Name_Or_Title],
       [moch].[Property_Value],
	   mws.[Name]
FROM [dbo].[MFPurchaseInvoice] [mpi]
    INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
        ON [moch].[Class_ID] = [mpi].[Class_ID]
           AND [moch].[ObjID] = [mpi].[ObjID]
		   AND moch.[MFVersion] = mpi.[MFVersion]
    INNER JOIN [dbo].[MFUserAccount] AS [mua]
        ON [mua].[UserID] = [moch].[MFLastModifiedBy_ID]
    INNER JOIN [dbo].[MFWorkflowState] AS [mws]
        ON [moch].[Property_Value] = [mws].[MFID]
WHERE mpi.[ObjID] = 361 