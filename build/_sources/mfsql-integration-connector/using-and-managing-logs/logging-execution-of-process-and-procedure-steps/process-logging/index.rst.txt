Process Logging
===============

.. container:: table-wrap

   ============== ===============================================================================================================================
   Type           Description
   ============== ===============================================================================================================================
   Procedure Name spMFProcessBatch_Upsert
   Inputs         | ProcessBatch_ID: references the ProcessBatch_ID on the MFProcessBatch Table. If null then a new process record will inserted.
                  | ProcessType: Calling Procedure Name
                  | LogType : One of MFSQL, Your App Name
                  | LogText : Concatenation of all sub procedures
                  | LogStatus: on of Initiate, in progress or End
                  | EndTime: Used for setting the time at the end of the process. allways set this time to UTC time.
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        The output returns the ProcessBatch_ID
   ============== ===============================================================================================================================

Processing logging as two distinct stages in each procedure



Initiating the process
~~~~~~~~~~~~~~~~~~~~~~

It is not necessary to set ProcessBatch_ID or EndTime when the
ProcessBatch is initiated.

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         SET @ProcessType = 'Calling Procedure name'
         SET @LogType = 'Your App Name'
         SET @LogText = ''
         SET @LogStatus = 'Initiate'


         EXECUTE @RC = [dbo].[spMFProcessBatch_Upsert] 
            @ProcessBatch_ID
           ,@ProcessType
           ,@LogType
           ,@LogText
           ,@LogStatus
           ,@EndTime
           ,@debug

         SELECT @rc



Finalizing the process
~~~~~~~~~~~~~~~~~~~~~~

Set the ProcessBatch_ID to the calling procedure to finalise the item.
 Always set the end time in UTC time

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          SET @ProcessBatch_ID = @ProcedureBatch_ID
         SET @LogText = 'Processing ' + @ProcedureName + ' completed'
         SET @EndTime = GETUTCDATE()
         SET @LogStatus = 'Completed'
          
         EXECUTE @RC = [dbo].[spMFProcessBatch_Upsert] 
            @ProcessBatch_ID
           ,@ProcessType
           ,@LogType
           ,@LogText
           ,@LogStatus
           ,@EndTime
           ,@debug

         SELECT @rc


          

 

 
