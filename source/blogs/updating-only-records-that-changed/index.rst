Updating only records that changed
==================================

This use case illustrate how to update only the records that have
changed between M-Files and an a third party application.

It is important to not not update every record, every time in M-Files to
avoid a huge number of history records where no change has taken place.

--------------

Step 1:

Add the key values from the external tables into a temporary table.

.. code:: sql

    Create table #SalesOrders
     (
                    [SalesOrder] NVARCHAR(100),
                     [ProgramOrder] NVARCHAR(100),
                    [MainSerialNo] NVARCHAR(100),
                    [SigmaProgram] NVARCHAR(100),
                    [CustomerPO] NVARCHAR(100),
                    [CustomerNo] NVARCHAR(100)
                );
          Insert into #SalesOrders
          ........
                

Step 1 : compare the temporary table and the class table

Using CTE with EXCEPT: This snippet is an example of comparing the Class
Table (MFSalesPack) with an extract from the Thirdparty application
tables (#SalesOrders) on key values (the columns to be compared) and
then updating process\_id on the class table with the values ready to be
updated into M-Files.

.. code:: sql

    WITH cte AS
    (   
      SELECT [msp].[Reference_no],
           [mc].[ExternalID],
           [msp].[Customer_po],
           [msp].[Program_order],
           [msp].[Sigma_Program_Name]
    FROM [dbo].[MFSalesPack] AS [msp]
        CROSS APPLY [dbo].[fnMFParseDelimitedString]([msp].[Customer_ID], ',') AS [fmpds]
        INNER JOIN [#SalesOrders] AS [so]
            ON [msp].[Reference_no] = [so].[SalesOrder]
        LEFT JOIN [dbo].[MFCustomer] AS [mc]
            ON [mc].[ObjID] = [fmpds].[ListItem]
    WHERE [msp].[Deleted] = 0
    EXCEPT
    SELECT [so].[SalesOrder],
           [so].[CustomerNo],
           [so].[CustomerPO],
           [so].[ProgramOrder],
           [so].[SigmaProgram]
    FROM [#SalesOrders] AS [so])
     UPDATE [msp]
                SET [msp].[Process_ID] = 1,
                    [msp].[Customer_ID] = [mc2].[ObjID],
                    [msp].[Customer_po] = [cte].[Customer_PO],
                    [msp].[Program_order] = [cte].[Program_Order]
                   [msp].[Sigma_Program_Name] = [so].[SigmaProgram]
                FROM [dbo].[MFSalesPack] AS [msp]
       INNER JOIN [cte]
       ON msp.[Reference_no] = cte.[Reference_no]
       LEFT JOIN [dbo].[MFCustomer] AS [mc2]
       ON mc2.[ExternalID] = cte.[ExternalID]

       

Step 3: Update the Class table

.. code:: sql

    DECLARE @Update_IDOut INT,
            @ProcessBatch_ID INT;
    EXEC [dbo].[spMFUpdateTable] @MFTableName = 'MFSalesPack',    -- nvarchar(200)
                                 @UpdateMethod = 0,   -- int                         
                                 @Update_IDOut = @Update_IDOut OUTPUT,                    -- int
                                 @ProcessBatch_ID = @ProcessBatch_ID OUTPUT
      

