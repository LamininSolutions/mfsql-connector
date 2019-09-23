Insert new records from SQL
===========================

MFSQL Connector allows for new records to be added from SQL to M-Files.
This blog illustrates some of the key considerations and methods
associated with inserting new records.

The key steps in adding records from SQL include:

#. Design the target class object in M-Files with all the required
   properties.

#. Update the metadata structure in SQL

#. Create the class table

#. Create script/procedure to insert records into the class table

#. Update from SQL to M-Files

Designing the target class
--------------------------

When designing the target class the following should be considered:

-  Using M-Files scripting or auto calculated properties to calculate
   values for properties is allowed. In some cases it is advisable to
   perform the calculation in SQL. See below for dealing with auto
   calculated properties in the SQL insert.

-  Adding a file and metadata is possible. There are several methods to
   achieve this. See separate blog for working with files.

-  It is good practice to use single lookup properties when only single
   lookup should be used. M-Files creates new Object Type and Valuelist
   properties by default as multi lookups. Working with multi lookups in
   SQL has different considerations. See the separate blogs on working
   with multi - lookups.

-  Scripting and compliance kit rules which operates on class could slow
   down the performance of updating records from SQL to M-Files.

Update the metadata structure
-----------------------------

Always update the metadata structure in the Connector after making
changes in M-Files. Use the short form of the procedure. It should deal
with most scenarios of update. Only use the optional parameters if there
is a specific reason for it.

.. code:: sql

    EXEC [dbo].[spMFDropAndUpdateMetadata]

-  Use the utilities to get a better handle on the metadata structure
   and errors.

.. code:: sql

    --review which tables are already included in the app
    SELECT includeinApp , * FROM [dbo].[MFClass] AS [mc]

    --review all the properties for a specific class
     SELECT *
     FROM   [MFvwMetadataStructure]
     WHERE  [class] = 'Customer' ORDER BY Property_MFID

    --review all the classes for a specific property
     SELECT class,*
     FROM   [MFvwMetadataStructure]
     WHERE  [Property] = 'Customer' ORDER BY class_MFID
     
     --review property and column usage and comparisons
    EXEC [dbo].[spMFClassTableColumns]
    SELECT * from ##spMFClassTableColumns

Create the class table
----------------------

If not already in existence, then create the class table

.. code:: sql

      EXEC [spMFCreateTable] 'Customer'
      --or
      EXEC [spMFCreateTable] @className = 'Customer'

It is a good practice to drop and recreate if the table exists and many
structural changes was made

When creating a new class table the MFClass table is automatically
updated with 'includeinApp' column to 1

.. code:: sql

    SELECT includeinApp , * FROM [dbo].[MFClass] AS [mc]

Use the utilities to speed up the design process.

.. code:: sql

    --CREATE ALL CLASS TABLES WITH INCLUDED IN APP 1 OR 2 IN ONE GO
     EXEC [spMFCreateAllMFTables]
     
    --DROP ALL CLASS TABLES WITH A SPECIFIC INCLUDED IN APP
     EXEC [spMFDropAllClassTables] 1 -- does not reset included in app to allow for recreation
    --or
     EXEC [spMFDropAllClassTables] @IncludeinApp = 1
     
    --UPDATE RECORDS FOR ALL CLASS TABLED WITH INCLUDEINAPP = 1
     EXEC [spMFUpdateAllncludedInAppTables] 1
    --or
     EXEC [spMFUpdateAllncludedInAppTables] @UpdateMethod = 1 

Create script / procedure to insert new records.
------------------------------------------------

Create an insert statement to the class table to add new records.
Consider the following

-  Always set process\_id = 1. this will allow the update procedure to
   identify the need for a SQL to M-Files operation.

-  Ignore the following columns. These columns are all managed by the
   Connector.

   -  .. code:: sql

          [GUID],[MX_User_ID],[Class],[Class_ID],[Created],[Created_by],[Created_by_ID]
          ,[MF_Last_Modified],[MF_Last_Modified_by],[MF_Last_Modified_by_ID]
          ,[Single_File],[LastModified],[ObjID],[ExternalID],[MFVersion]
          ,[FileCount],[Deleted],[Update_ID]

-  Optionally use the following

   -  Use ExternalID to add a unique reference of an external system.

   -  MX\_User\_ID to add reference to an external user (not included in
      M-Files

   -  MX\_any\_column\_name to add columns to be ignored by updates to
      M-Files

-  Lookup columns (columns with \_ID at the end.

   -  Get MFID or Objid for the related object. Comma delimit
      multi-lookup values

   -  Ignore the label columns for lookups.

   -  See separate blog for working with multi-lookups

-  Required

   -  Phantom value for all properties with a auto calculation in
      M-Files (scripting or Compliance kit based)

   -  Phantom value for all properties that are used in calculated
      values in M-Files

   -  Values for all required properties in M-Files. Use
      ``##spMFClassTableColumns`` to assess

Use utilities to support pre-processes for working with aliases,
valuelists and workflows

Aliases
^^^^^^^

.. code:: sql

    --Update alias. (for classes, properties, valuelists, valuelist items, workflows and workflow states)

    UPDATE [MFClass]
    SET [Alias] = 'c.customer'
    WHERE [Name] = 'Customer';

    --Process Table changes
    EXEC [spMFSynchronizeSpecificMetadata] @Metadata = 'Class'
                                          ,@IsUpdate = 1;
    EXEC [spMFSynchronizeSpecificMetadata] @Metadata = 'Class', @IsUpdate = 1;

    --bulk update aliases
    EXEC [dbo].[spMFAliasesUpsert]
        @MFTableNames = 'MFProperty', -- comma delimited string
        @Prefix = 'prop',
        @IsRemove = 0,
        @WithUpdate = 1
         
    --Removing all aliases with a prefix of ws from workflow states
    EXEC [dbo].[spMFAliasesUpsert]
        @MFTableNames = 'MFWorkflowstate',
        @Prefix = 'ws',
        @IsRemove = 1, -- set to 1 to remove all aliases
        @WithUpdate = 1 
     
     

     
      

Valuelist lookups
^^^^^^^^^^^^^^^^^

.. code:: sql

    -- create valuelist lookups   
    EXEC [dbo].[spMFCreateValueListLookupView] @ValueListName = 'Country' -- nvarchar(128)
                                              ,@ViewName =  'MFvwCountry'     -- nvarchar(128)
                                              ,@Schema = 'Custom'        -- nvarchar(20)

    SELECT *
    FROM   custom.[MFvwCountry]

Workflow lookups
^^^^^^^^^^^^^^^^

.. code:: sql

    --Create workflow views
     EXEC [spMFCreateWorkflowStateLookupView] 'Contract Approval Workflow'
                , 'MFvwContractApproval'

    --or

    EXEC [dbo].[spMFCreateWorkflowStateLookupView] @WorkflowName = 'Contract Approval Workflow' -- nvarchar(128)
                                                  ,@ViewName = 'MFvwContractApproval'     -- nvarchar(128)
                                                  ,@Schema = 'Custom'       -- nvarchar(20)

    SELECT *
    FROM   [MFvwContractApproval]

Update valuelist items
^^^^^^^^^^^^^^^^^^^^^^

.. code:: sql


    --Add new valuelist item


    --CHANGING THE NAME OF VALUELIST ITEM (name, DisplayID)

     UPDATE [mvli]
     SET    [Process_ID] = 1
       , [mvli].[Name] = 'United Kingdom'
       , [DisplayID] = '3'
     --select vc.*
     FROM   [MFValuelistitems] [mvli]
    -- INNER JOIN [vwMFCountry] [vc] ON [vc].[AppRef_ValueListItems] = [mvli].[appref]
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
     FROM   [MFvwCountry]

     UPDATE [mvli]
     SET    [Process_ID] = 2
     --select *
     FROM   [MFValuelistitems] [mvli]
     WHERE  [mvli].[AppRef] = '2#154#9'


    --PROCESS UPDATE
     EXEC [spMFSynchronizeValueListItemsToMFiles]

     SELECT *
     FROM   [MFvwCountry]

Update records from SQL to M-Files
----------------------------------

Executing spMFUpdateTable with Updatemethod = 0 will push rows with a
process\_id = 1 from SQL to M-Files

.. code:: sql

    EXEC [dbo].[spMFUpdateTable] @MFTableName = 'MFCustomer',    
                                 @UpdateMethod = 0 

Use the bulk upload procedure when updating a large number of records

.. code:: sql

    EXEC [dbo].[spMFUpdateTableinBatches] @MFTableName = 'YourTable' 
                                         ,@UpdateMethod = 0          
                                         ,@WithStats = 1          
                                         ,@Debug = 0;           

Exclude the stats when using the above procedure as part of a extended
procedure that is part of integration code

.. code:: sql

    EXEC [dbo].[spMFUpdateTableinBatches] @MFTableName = 'YourTable' 
                                         ,@UpdateMethod = 0         
                                         ,@WithStats = 0           
                                         ,@Debug = 0;               

