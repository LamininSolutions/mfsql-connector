Aligning valuelist items with different owners
==============================================

When valuelist items have owners (for example document type has class as
the owner) then a valuelist item could be associated with more than one
class resulting in a different id for each item.

When a object is changed from one class to another, the valuelist item
will not automatically be associated with the new class. This could
result in the loss of data. Transitioning objects in bulk from one class
to another in this scenario requires a sequence of steps.

#. Ensure that the class tables are up to date in SQL

#. Backup the source class table into another table :* select \* into
   backuptable from sourcetable*

#. Move the objects from one class to another using either M-Files
   client or SQL (see steps for this procedure in separate use case )

#. Create lookup view for the valuelist(s) that need to be transposed.
   Use \ * EXEC [dbo].[spMFCreateLookupView]*

#. Use a query similar to the one below to map the id's of the old
   valuelist item to the new valuelist item for the items used in the
   source table.

Execute Procedure

.. code:: sql

    This sample is based on a valuelist of document type.  
    SELECT DISTINCT [b].[Document_Type]
    , [b].[Document_Type_ID]
    , dt2.[MFValueListItems_MFID] 
    FROM TheoldversionBackup b 
    LEFT JOIN [dbo].[MFvwDocumentType] AS [mfdt] 
    ON b.[Document_Type_ID] = mfdt.[MFValueListItems_MFID]  
    INNER JOIN ( SELECT    [dt].[MFValueListItems_MFID]             
    , [dt].[MFValueListItems_Name]                      
    , [dt].[MFValueListItems_OwnerName]              
    FROM [dbo].[MFvwDocumentType] [dt]            ) [dt2] 
    ON [dt2].[MFValueListItems_Name] = [mfdt].[MFValueListItems_Name]
    WHERE [dt2].[MFValueListItems_OwnerName] =  'Help Files & How to'

#. then build the above query into a query to update the valuelist items
   from the oldversionbackup into the new class table using the MFID's
   for the valuelistitems that is owned by the new class.  See below for
   a sample of such a query

#. **Execute Procedure**

.. code:: sql

    UPDATE [mhfh] 
    SET    [mhfh].[Document_Type_ID] = [vli].[MFValueListItems_MFID]      
    , [mhfh].[Process_ID] = 1-- SELECT mhfh.objid
    , mhfh.[Document_Type_ID]
    , [b].[Document_Type_ID]
    , vli.[MFValueListItems_MFID] 
    FROM   [dbo].[NewClassTable] AS [mhfh] 
    INNER JOIN [dbo].[TheoldversionBackup] [b] 
    ON [b].[ObjID] = [mhfh].[ObjID] 
    LEFT JOIN ( SELECT DISTINCT[b].[Document_Type] 
    , [b].[Document_Type_ID]                  
    , [dt2].[MFValueListItems_MFID]             
    FROM   [dbo].[TheoldversionBackup] [b]             
    LEFT JOIN [dbo].[MFvwDocumentType] AS [mfdt] 
    ON [b].[Document_Type_ID] = [mfdt].[MFValueListItems_MFID]             
    INNER JOIN ( SELECT    [dt].[MFValueListItems_MFID]    
     , [dt].[MFValueListItems_Name]                                  
    , [dt].[MFValueListItems_OwnerName]                          
    FROM      [dbo].[MFvwDocumentType] [dt] ) [dt2] 
    ON [dt2].[MFValueListItems_Name] = [b].[Document_Type]             
    WHERE  [dt2].[MFValueListItems_OwnerName] = 'NewClassName' ) [vli] 
    ON [vli].[Document_Type] = [b].[Document_Type]                    
    AND [mhfh].[ObjID] = [b].[ObjID]

Finally, use spMFUpdateTable with update method 0 to update the new
class table.

|
