Deleting duplicate objects
==========================

It happens that objects in M-Files are duplicated.  Perhaps due to some
integration errors, or maybe just some finger trouble.  One way to
remove it is to work through M-Files and delete them one by one. Another
way is to use MFSQL Connector

It would involve the following steps

#. Update the class table in the Connector using spMFUpdatetable with
   updatemethod 1

#. Use SQL to isolate the duplicate records. The Row\_Number() over
   (partition by order by ) functions are used.   See below for a sample
   script highlighting SQL methods to identify records that are
   duplicated and to add a row number on each series.

#. Update the duplicate items process\_id to 1 in the class table

#. use spmfDeleleObjectList to delete the records

Sample Procedure

.. code:: sql


    /*identify and delete duplicate records in Mfiles*/
    UPDATE [mic2]
    SET [mic2].[Process_ID] = 5
    FROM [dbo].[MFInventoryCons] AS [mic2]
        INNER JOIN
        (
            SELECT [list2].[ObjID]
            FROM
            (
                SELECT [mic].[Cast],
                       [mic].[Mill_Plate],
                       [mic].[ObjID],
                       ROW_NUMBER() OVER (PARTITION BY [mic].[Cast],
                                                       [mic].[Mill_Plate]
                                          ORDER BY [mic].[Cast],
                                                   [mic].[Mill_Plate]
                                         ) [Rownr]
                FROM [dbo].[MFInventoryCons] AS [mic]
                    INNER JOIN
                    (
                        SELECT [mic].[Cast],
                               [mic].[Mill_Plate]
                        FROM [dbo].[MFInventoryCons] AS [mic]
                        GROUP BY [mic].[Cast],
                                 [mic].[Mill_Plate]
                        HAVING COUNT(*) > 1
                    ) [l]
                        ON [l].[Cast] = [mic].[Cast]
                           AND [l].[Mill_Plate] = [mic].[Mill_Plate]
            ) [list2]
            WHERE [list2].[Rownr] > 1
        ) [list3]
            ON [mic2].[ObjID] = [list3].[ObjID];

    EXEC [dbo].[spMFDeleteObjectList] @TableName = N'MFCertKey', -- nvarchar(100)
                                      @Process_id = 5,                 -- int
                                      @Debug = 0,                      -- int
                                      @DeleteWithDestroy = 0;          -- bit

And another example of isolating duplicates using the rank function and
cte.

.. code:: sql

    WITH [cte]
    AS (SELECT [mc].[ObjID],
               [mc].[Certkey_Name],
               [mc].[Mill_Standard],
               [mc].[Specification_Nav],
               [mc].[Description],
               [mc].[Specification_Group],
               RANK() OVER (PARTITION BY [mc].[Certkey_Name],
                                         [mc].[Mill_Standard],
                                         [mc].[Specification_Nav],
                                         [mc].[Description],
                                         [mc].[Specification_Group]
                            ORDER BY [mc].[ObjID]
                           ) AS [rnk]
        FROM [dbo].[MFCertkey] AS [mc])
     UPDATE mic
     SET process_id =5
    -- SELECT *
     FROM dbo.MFCertKey AS [mic]
     INNER JOIN cte [cte]
     ON cte.[ObjID] = mic.objid
    WHERE [cte].[rnk] > 1;
        
    EXEC [dbo].[spMFDeleteObjectList] @TableName = N'MFInventoryCons', 
                                      @Process_id = 5,                 
                                      @Debug = 0,                      
                                      @DeleteWithDestroy = 1;          
         

| 

| 

| 
