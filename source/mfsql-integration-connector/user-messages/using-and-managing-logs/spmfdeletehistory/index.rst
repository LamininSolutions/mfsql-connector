spMFDeleteHistory
=================

The objective is this procedure is to allow for routinely deleting
history records that may build up otherwise.

The following tables with history will be affected

.. container:: table-wrap

   ==================== ======================================================================================
   Table name           Used for
   ==================== ======================================================================================
   MFLog                system error records
   MFUpdateHistory      history of updating of each M-Files transaction
   MFAutditHistory      records created by spmfAuditHistory. This procedure is used to get the Object Versions
   MFProcessBatch       record of outcome of batch processing
   MFProcessBatchDetail procedure step detail of batch processing
   ==================== ======================================================================================

The following view will show the number of records in each of these
tables

| 
| SELECT \* FROM dbo.MFvwLogTableStats

The following procedure will show the sizes of these tables

Exec spMFLogTableStats

.. container:: table-wrap

   ============== =================================================================================================
   Type           Description
   ============== =================================================================================================
   Procedure Name  spMFDeleteHistory
   Inputs         DeleteBeforeDate: all records in the above tables before this datetime parameter will be deleted.
   Outputs        1 = success
   ============== =================================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC dbo.spMFDeleteHistory @DeleteBeforeDate = '2017-01-08 04:52:03' -- datetime
