spMFSynchronizeMetadata
=======================

| 

.. container:: table-wrap

   ============== =============================================
   Type           Description
   ============== =============================================
   Procedure Name spMFSynchronizeMetadata
   Inputs         Debug: 1 = Debug Mode; 0 = No Debug (default)
                 
                  ProcedureBatch_ID = null
   Outputs        1 = success
   ============== =============================================

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         DECLARE @return_value int

         EXEC @return_value = [dbo].[spMFSynchronizeMetadata]
           @Debug = 0

         SELECT 'Return Value' = @return_value

         GO

OR

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFSynchronizeMetadata]
