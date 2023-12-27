/*
LESSON NOTES
These examples are illustrations on the use of the procedures.
All examples use the Sample Vault as a base
*/

/*

UPDATING VALUELIST ITEMS FROM MFSQL CONNECTOR
*/

--SYNC VALUELIST ITEMS

--synchronising only valuelist items
--when updating valulist items from SQL to MF, then this becomes very useful

	TRUNCATE TABLE [dbo].[MFValueListItems]

	SELECT *
	FROM   [dbo].[MFValueListItems]

	EXEC [dbo].[spMFSynchronizeSpecificMetadata] @Metadata = 'ValuelistItems'

	--or

	EXEC [dbo].[spMFSynchronizeSpecificMetadata] @Metadata = 'ValuelistItem' -- varchar(100)
											   , @ItemName = 'Country'

--creating a valuelist lookup
--we recommend to use a schema 'custom' and a naming convention of the the view that is distict and not the same as the MFSQL connector standard.
--using a view for a specific valuelist is handy in code, as one does not then have to join MFValuelist and MFValuelistItem tables to get to all the reference columns

EXEC dbo.spMFCreateValueListLookupView @ValueListName = N'Country', -- nvarchar(128)
                                       @ViewName = N'vwCountry',      -- nvarchar(128)
                                       @Schema = N'custom',        -- nvarchar(20)
                                       @Debug = 0            -- smallint



	SELECT *
	FROM   custom.vwCountry

--CHANGING THE NAME OF VALUELIST ITEM (name, DisplayID)

	UPDATE [mvli]
	SET	   [Process_ID] = 1
		 , [mvli].[Name] = 'UK'
		 , [DisplayID] = '3'
	--select vc.*
	FROM   [MFValuelistitems] [mvli]
--	INNER JOIN [vwMFCountry] [vc] ON [vc].[AppRef_ValueListItems] = [mvli].[appref]
	WHERE  [mvli].[AppRef] = '2#154#3'


--INSERT NEW VALUE LIST ITEM (note only name process_id and valuelist id is required)
--display_id must be unique, if not set it will default to the mfid

	DECLARE @Valuelist_ID INT
	SELECT @Valuelist_ID = [id]
	FROM   [dbo].[MFValueList]
	WHERE  [name] = 'Country'

	INSERT INTO [MFValueListItems] (   [Name]
									 , [Process_ID]
									 , [DisplayID]
									 , [MFValueListID]
								   )
	VALUES ( 'Russia', 1, 'RU', @Valuelist_ID )


	INSERT INTO [MFValueListItems] (   [Name]
									 , [Process_ID]
									 , [MFValueListID]
								   )
	VALUES ( 'Argentina', 1, @Valuelist_ID )


--DELETE VALUELIST ITEM (note that the procedure will delete the valuelist item only and not the related objects)
--the record will not be deleted from the table, however, the deleted column will be set to 1.

	SELECT *
	FROM   custom.[vwCountry]

	UPDATE [mvli]
	SET	   [Process_ID] = 2
	--select *
	FROM   [MFValuelistitems] [mvli]
	WHERE  [mvli].[AppRef] = '2#154#9'


--PROCESS UPDATE
	EXEC [spMFSynchronizeValueListItemsToMFiles]

	SELECT *
	FROM   custom.[vwCountry]

--check the entry in FMValuelistItem, note IsNameUpdate is set to 1 
SELECT * FROM dbo.MFValueListItems AS mvli WHERE mvli.AppRef = '2#154#3'

--check class table with related valuelist item before Sync metadata - this should still show old item

SELECT * FROM dbo.MFCustomer AS mc

--then run spmfSynchronizeLookupColumnChange. Set TableName to null to include all related class tables
DECLARE @ProcessBatch_id1 INT;
EXEC dbo.spmfSynchronizeLookupColumnChange @TableName = null,                            -- nvarchar(200)
                                           @ProcessBatch_id = @ProcessBatch_id1 OUTPUT, -- int
                                           @Debug = 0                                   -- int

--check the class table again