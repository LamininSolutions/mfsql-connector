spMFCreateTable
===============

.. toctree::
   :maxdepth: 4

   application-of-the-connector/index
   m-files-trigger-for-transactional-update/index

Execute “spMFCreateTable” to create table for a class with associate
properties and other custom columns (like ID, GUID, MX_User_ID, MFID,
ExternalID, MFVersion, FileCount, IsSingleFile, Update_ID, and
LastModified).

.. container:: table-wrap

   ============== ===============================================
   Type           Description
   ============== ===============================================
   Procedure Name spMFCreateTable
   ClassName      Pass the class name as stored in MFClass Table.
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== ===============================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          DECLARE    @return_value int
          
         EXEC        @return_value = [dbo].[spMFCreateTable]
                                       @ClassName =  N'Customer'
          
         SELECT    'Return Value'  = @return_value
          
         GO

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      Consider if the table will be used for batch update or transaction
      update methods.

      The trigger to perform the transaction update method will only be
      created on the class table if the IncludeInApp column in the
      MFClass Table is set to 2 BEFORE the table is created.

| 

| 
