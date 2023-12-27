
/*
NOTIFICATION

2021-01-30: We are incorporating all the examples into the documentation and guide. https://doc.lamininsolutions.com.  Over time the examples in this folder will reduce.  You will find them in the with more practical tips. Just search on the procedure or topic in the guide.

*/

/*
LESSON NOTES
These examples are illustrations on the use of the procedures.
All examples use the Sample Vault as a base
Consult the guide for more detail on the use of the procedures http:\\tinyurl.com\mfsqlconnector
To work through the examples, select the statement as execute (F5)
*/

/*
GETTING STARTED
check connector
synchronize metadata
create first class table
update first class table
*/


-- CHECK CONNECTION TO VAULT
EXEC [spMFVaultConnectionTest]

-- or

DECLARE @MessageOut NVARCHAR(250);
EXEC dbo.spMFVaultConnectionTest @IsSilent = 1,
                                 @MessageOut = @MessageOut OUTPUT
SELECT @MessageOut

--CHECK GENERAL SETTINGS
sELECT * from mfsettings

-- Before one can start to use the connector, it is necessary to pull the Metadata structure into SQL
-- If you cannot start the sync process it is likely that the installation of the vault applications have not been completed.  From Release 4 this operation is dependent on a valid license.

--SYNCHRONISE METADATA
	EXEC [spMFSynchronizeMetadata]

-- or 
DECLARE @ProcessBatch_ID INT;
EXEC dbo.spMFSynchronizeMetadata @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                                 @Debug = 0
SELECT * FROM dbo.MFProcessBatch AS mpb WHERE mpb.ProcessBatch_ID = @ProcessBatch_ID

--if error shown, then it would send email. if database mail not setup, then check error with the following 

SELECT * FROM mflog ORDER BY logid DESC

--During the development process, or any time after the initial build use the following to update the structure.  Note that this procedure is illustrated again in a next example

	EXEC [dbo].[spMFDropAndUpdateMetadata]
	       

--when you want to drop all metadata in SQL then use

	EXEC [dbo].[spMFDropAndUpdateMetadata]
	    @IsResetAll = 1 --setting to 1 will delete all the current structure data in SQL and rest it to M-Files	    

--this procedure has many more uses and switches for different scenarios - more about it later. below selections illustrate the default settings of the procedure

GO

DECLARE @ProcessBatch_ID INT;
EXEC dbo.spMFDropAndUpdateMetadata @IsResetAll = 0,
                                   @WithClassTableReset = 0,
                                   @WithColumnReset = 0,
                                   @IsStructureOnly = 0,
                                   @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                                   @Debug = 0
SELECT * FROM dbo.MFProcessBatch AS mpb WHERE mpb.ProcessBatch_ID = @ProcessBatch_ID
SELECT * FROM dbo.MFProcessBatchDetail AS mpbd WHERE mpbd.ProcessBatch_ID = @ProcessBatch_ID
	
--CHECK STRUCTURE TABLES.  Explore the results.

--view the classes
	SELECT *
	FROM   [MFClass] 

-- view the properties
	SELECT *
	FROM   [MFProperty] ORDER BY MFID

--view the valuelists
	SELECT *
	FROM   [MFValueListItems]

--other structure tables: MFObjectType, MFValuelist, MFworkflow, MFWorkflowstate, MFLoginAccount, MFUserAccount
--the relationships between these tables are explorered in another example

--explore metadata using a view

--review all the properties for a specific class
	SELECT *
	FROM   [MFvwMetadataStructure]
	WHERE  [class] = 'Customer' ORDER BY Property_MFID

--review all the classes for a specific property
	SELECT class,*
	FROM   [MFvwMetadataStructure]
	WHERE  [Property] = 'Customer' ORDER BY class_MFID

--review property and column usage and comparisons
    EXEC dbo.spMFClassTableColumns @ErrorsOnly = 0, -- select to only report column errors
                                   @IsSilent = 0,
                                   @MFTableName = 'MFCustomer',
                                   @Debug = 0
 --if is silent = 1 get result in   
SELECT * from ##spMFClassTableColumns 


--To get metadata from M-Files in SQL, it is necessary to create the class tables first.

--CREATE CLASS TABLE
		EXEC [spMFCreateTable] 'Customer'
		--or
		EXEC [spMFCreateTable] @className = 'Customer'

--CHECK THE CLASS TABLE. Note that is was created, but has no records
	SELECT *
	FROM   [MFCustomer]

--CHECK THE CHANGE IN MFCLASS. The 'includeinApp' column was automatically set to 1

SELECT includeinApp	, * FROM [dbo].[MFClass] AS [mc]

--UPDATE RECORDS IN CLASS TABLE
	EXEC [spMFUpdateTable] 'MFCustomer'
						 , 1

--Check the table again.  Note all the special columns created, and how the Connector handles the lookup properties (e.g. country)

SELECT * FROM mfcustomer

--the update procedure is at the heart of many operations. It has a number of other filters and flags. The defaults are shown below and the signficance of the options are explained in a later example.

GO
--or

DECLARE @Update_IDOut INT,
        @ProcessBatch_ID INT;
EXEC dbo.spMFUpdateTable @MFTableName = 'MFCustomer',
                         @UpdateMethod = 1,
                         @UserId = null,
                         @MFModifiedDate = null,
                         @ObjIDs = null,
                         @Update_IDOut = @Update_IDOut OUTPUT,
                         @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                     --    @SyncErrorFlag = ,
                         @RetainDeletions = 0,
                         @IsDocumentCollection = 0,
                         @Debug = 0
SELECT * FROM dbo.MFProcessBatch AS mpb WHERE mpb.ProcessBatch_ID = @ProcessBatch_ID
SELECT * FROM dbo.MFProcessBatchDetail AS mpbd WHERE mpbd.ProcessBatch_ID = @ProcessBatch_ID

--lets make an update in SQL



SELECT * FROM [dbo].[MFValueListItems] AS [mvli]
INNER JOIN [dbo].[MFValueList] AS [mvl]
ON [mvl].[ID] = [mvli].[MFValueListID]
WHERE mvl.[Name] = 'country'

UPDATE [dbo].[MFCustomer]
SET process_id = 1, [Country_ID] = 3
WHERE id = 1

EXEC [dbo].[spMFUpdateTable] @MFTableName = 'MFCustomer',    
                             @UpdateMethod = 0 
                            
SELECT * FROM [dbo].[MFCustomer] AS [mc]
