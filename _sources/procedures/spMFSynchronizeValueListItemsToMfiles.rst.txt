
=====================================
spMFSynchronizeValueListItemsToMfiles
=====================================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table    
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

The purpose of this procedure is to synchronize Sql  MFVALUELISTITEM table to M-files. All items with process_id <> 0 will be considered for updating

Additional Info
===============

Set process_id = 1 to update valuelist item or create new
Set process_id = 2 to delete valuelist item

The name, owner, or display_id of the valuelist item can be changed.

The Valuelistid column in MFValuelistItems refers to the id in the MFValuelist table.

Prerequisites
=============

All items where process_id is 1 or 2 will be included in the update.  Set the process_id for the items to be update before running this procedure

When inserting a new valuelist item the minumum required columns in the table MFValuelistItems are: Name, ValuelistID and process_id


Examples
========

.. code:: sql

    Exec spMFSynchronizeValueListItemsToMfiles

------------------

When updating valulist items from SQL to MF, then synchronising only valuelist items for a specific valuelist becomes very useful

.. code:: sql

	EXEC [dbo].[spMFSynchronizeSpecificMetadata] @Metadata = 'ValuelistItems'

	--or

	EXEC [dbo].[spMFSynchronizeSpecificMetadata] @Metadata = 'ValuelistItem' 
											   , @ItemName = 'Country'

-----------

Create a specific valuelist lookup with the schema 'custom' and a naming convention of the the view that is distinct to improve the use of valuelists and valuelist items in procedures.

.. code:: sql

    EXEC dbo.spMFCreateValueListLookupView @ValueListName = N'Country', 
                                       @ViewName = N'vwCountry',    
                                       @Schema = N'custom',       
                                       @Debug = 0         
	SELECT * FROM   custom.vwCountry

--------------

CHANGING THE NAME OF VALUELIST ITEM (name, owner, DisplayID)

.. code:: sql

	UPDATE [mvli]
	SET	   [Process_ID] = 1
		 , [mvli].[Name] = 'UK'
		 , [DisplayID] = '3'
	FROM   [MFValuelistitems] [mvli]
	INNER JOIN [vwMFCountry] [vc] ON [vc].[AppRef_ValueListItems] = [mvli].[appref]
	WHERE  [mvli].[AppRef] = '2#154#3'

--------------

INSERT NEW VALUE LIST ITEM (note only name process_id and valuelist id is required); display_id must be unique, if not set it will default to the mfid

.. code:: sql

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

----------------

DELETE VALUELIST ITEM (note that the procedure will delete the valuelist item only and not the related objects)
the record will not be deleted from the table, however, the deleted column will be set to 1.

.. code:: sql

	UPDATE [mvli]
	SET	   [Process_ID] = 2
	FROM   [MFValuelistitems] [mvli]
	WHERE  [mvli].[AppRef] = '2#154#9'

    
Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-02-20  LC         Add set IsnameUpdate = 1 when update take place
2020-01-10  LC         Improve documentation, add debubbing
2019-08-30  JC         Added documentation
2018-04-04  DEV2       Added Licensing module validation code
==========  =========  ========================================================

