spMFGetHistory
==============

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      spMFGetHistory allows to update MFObjectChangeHistory table with
      records with details of the change history of objects based on
      certain filters.

      The change history will show the version, date changed, property
      and property value, and in the case of state changes when the
      state was entered and when it was exited. Below is a sample join
      statement to show the results of the MFObjectChangeHistory table.

      When the history table is updated it will only report the versions
      that the property was changed. If the property included in the
      filter did not change, then to specific version will not be
      recorded in the table.

      Note that process_id is reset to 0 after completion of the
      processing.

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ========= ========
         Module    Release#
         ========= ========
         Developer 3.1.2.38
         ========= ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      This procedure can be used to show all the comments  or the last 5
      comments made for a object.  It is also handly to assess when a
      workflow state was changed.

      Note that the same filter will apply to all the columns included
      in the run.  Split the get procedure into different runs if
      different filters must be applied to different columns.

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      NOTE THAT THIS FUNCTIONALITY IS STILL GOING THROUGH SOME
      DEBUGGING.

      When using a lookup column, the name of the \ *ID column should be
      used e.g. State\_id or Customer*\ \_id

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== ============================================================================================================
         Type           Description
         ============== ============================================================================================================
         Procedure Name spMFGetHistory
         Inputs         TableName: name of class table to be updated
                       
                        Process_ID: all the records with this process id will be included in the procedure
                       
                        ColumnNames: comma delimited list of the columns to be included in the export
                       
                        IsFullHistory: = 1 will include all the changes of the object for the specified columnnames
                       
                        NumberOfDays : set this to show the last x number of days if changes,
                       
                        StartDate: set to a specific date to only show change history from a specific date (e.g. for the last month)
                       
                        ProcessBatch_ID processbatch id for logging
                       
                        | 
                       
                        Debug: 1 = Debug Mode; 0 = No Debug (default)
         Outputs        1 = success
         ============== ============================================================================================================

Sample code to get change history of address_line_1 and Address_line_2
of the Customer class records.

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         UPDATE mfcustomer
         SET Process_ID = 1
         FROM MFCustomer  WHERE id in (9,10)

         DECLARE @RC INT
         DECLARE @TableName NVARCHAR(128) = 'MFCustomer'
         DECLARE @Process_id INT = 1
         DECLARE @ColumnNames NVARCHAR(4000) = 'Address_Line_1,Address_Line_2'
         DECLARE @IsFullHistory BIT = 1
         DECLARE @NumberOFDays INT  
         DECLARE @StartDate DATETIME --= DATEADD(DAY,-1,GETDATE())
         DECLARE @ProcessBatch_id INT
         DECLARE @Debug INT = 0


         -- TODO: Set parameter values here.

         EXECUTE @RC = [dbo].[spMFGetHistory] 
            @TableName
           ,@Process_id
           ,@ColumnNames
           ,@IsFullHistory
           ,@NumberOFDays
           ,@StartDate
           ,@ProcessBatch_id OUTPUT
           ,@Debug

         SELECT * FROM [dbo].[MFProcessBatch] AS [mpb] WHERE [mpb].[ProcessBatch_ID] = @ProcessBatch_id
         SELECT * FROM [dbo].[MFProcessBatchDetail] AS [mpbd] WHERE [mpbd].[ProcessBatch_ID] = @ProcessBatch_id

Show the results of the table including the name of the property

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          SELECT toh.*,mp.name AS propertyname FROM mfobjectchangehistory toh
         INNER JOIN mfproperty mp
         ON mp.[MFID] = toh.[Property_ID]
         ORDER BY [toh].[Class_ID],[toh].[ObjID],[toh].[MFVersion],[toh].[Property_ID]
         GO

Show the results of the table for a state change

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         SELECT toh.*,mws.name AS StateName, mp.name AS propertyname FROM mfobjectchangehistory toh
         INNER JOIN mfproperty mp
         ON mp.[MFID] = toh.[Property_ID]
         INNER JOIN [dbo].[MFWorkflowState] AS [mws]
         ON [toh].[Property_Value] = mws.mfid
         WHERE [toh].[Property_ID] = 39
         ORDER BY [toh].[Class_ID],[toh].[ObjID],[toh].[MFVersion],[toh].[Property_ID]
         GO

::

.. container:: confluence-information-macro confluence-information-macro-information

   Use Cases(s)

   .. container:: confluence-information-macro-body

      #. Show coimments made on object
      #. Show a state was entered and exited
      #. Show when a property was changed
      #. Discovery reports for changes to certain properties 

| 
