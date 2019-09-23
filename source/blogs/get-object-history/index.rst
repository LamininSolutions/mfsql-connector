Get object history
==================

The Connector allows for extracting object history from M-Files into
SQL.

The operation will get the change history for specific objects and for
specific properties. It is not designed to get the change history for
every property on the object in a single process. The operation is
intended to be used where the target property and the specific object is
predetermined.

For instance the change history can be extracted for address changes in
all the customers ; the workflow state changes for purchase orders
approved in the last month can be extracted.

Volume warning
--------------

It is recommended to carefully consider the population of the extract
before executing the procedure. It is very easy to request the history
for a number of object and return many thousands of results. For
instance, getting the history of 4000 customers using 5 properties with
an average of 10 versions per customer would produce approx 200 000
history records.

Using filters
~~~~~~~~~~~~~

Several types of filters are available:

-  Exclude the objects where the data is no longer required or relevant:
   for instance if the report is targeting the approvals of invoices in
   the past month then only include the invoices where the
   MFLastModified date is in the last month by updating the process\_id
   = 5 only on these records.

-  Only include the properties on the object that is relevant for the
   report. The use of multiple properties should be reduced to the
   minimum.

-  Only use getting the full history if it is relevant, or the fist time
   that history is being updated. It would be more productive to
   initialize the data by getting the full history, and then to update
   the history by setting the start date or number of days filter.

-  The search string filter can be used to return a result for a
   specific value of change. For instance to only return the state
   change where the approval took place, instead of all the state
   change, set the search string value to the approval state ID.

Setup of the extract
--------------------

Each extract is based on two associated procedures.

#. Set the process\_id = 5 for the object in the class table which
   should be included in the extract.

#. Run the spmfGetHistory for the class table for the specific
   properties and with the most appropriate filters.

.. code:: sql

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

    SELECT * FROM [dbo].[MFObjectChangeHistory] AS [moch]

Working with the results
------------------------

Each time the procedure is run it will merge the result into the
MFObjectChangeHistory table. This table is therefor cumulative.

Old or redundant records are not automatically removed from the Change
History table. Consider the maintenance or deletion of the records
depending on the specific requirements for the data.

Consider that this table consist of the results for all class tables
with extracted change history when performing a delete on this table.
Always filter by class.

.. code:: sql

    DELETE FROM [dbo].[MFObjectChangeHistory]
     WHERE [Class_ID] IN (SELECT MFID FROM MFClass WHERE Name = 'Customer')


