spMFTableAuditinBatches
=======================

This procedure is used to update the object versions in the
MFAuditHistory table in batches.  This is particularly useful working
with large class tables.

The procedure will automatically batch the objids between the Fromobjid
and ToObjid and process the range in sequential batches.

Set the ToObjid to the maximum id for the object type to process all the
objects.

The result is saved in the MFAuditHistory table

| 

| 

.. container:: table-wrap

   ============== =============================================
   Type           Description
   ============== =============================================
   Procedure Name
   Inputs         Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== =============================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFTableAuditinBatches] @MFTableName = 'MFOtherDocument'                                
                                             ,@FromObjid = 1    -- int
                                             ,@ToObjid = 10000    -- int
                                             ,@WithStats = 1    -- bit
                                             ,@Debug = 101        -- int

         SELECT * FROM [dbo].[MFAuditHistory] ah
         INNER JOIN [dbo].[MFClass] AS [mc]
         ON ah.[Class] = mc.mfid
