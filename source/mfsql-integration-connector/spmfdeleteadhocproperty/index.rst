spMFDeleteAdhocProperty
=======================

This procedure is specially useful when the metadata design in the vault
has changed over time and properties that is not used any longer is
still remaining on the metadata card.  Instead of manually deleted these
properties from the metadata card, they can be deleted in bulk using the
Connector.

When a class table is refreshed in SQL and the properties are not
defined on the metadata card, but are still on the object then it will
be added as a separate column towards the end of the Class Table list of
columns.

Using this procedure can delete these columns and delete it from the
metadata.

There is a few requirements or steps to be taken to use this procedure.

-  Identify the adhoc columns towards the end of the Class Table column
   list.
-  Any column that is not a default column can be specified.  
-  The property will only be removed from the metadata card if there are
   no objects with values for that property any longer. 
-  If the property is set on the metadata card it, the value will be set
   to Null but it will not be removed.  

.. container:: confluence-information-macro confluence-information-macro-note

   .. container:: confluence-information-macro-body

      When the operation includes a lookup column (e.g. a column with
      '_id') then both columns related to the lookup must be included in
      the ColumnNames string to ensure that both columns are deleted
      from the Class Table. (example: @ColumnNames =
      'Customer,Customer_ID')

.. container:: table-wrap

   ============== ==========================================================================================================================================================================
   Type           Description
   ============== ==========================================================================================================================================================================
   Procedure Name spMFDeleteAdhocProperty
   Inputs         MFTableName = Name of Table
                 
                  ColumnNames = Name of the column to be removed
                 
                  Process_id = use any flag that is not 0 = 4 to indicate the records that should be included. Set the flag on all records if the adhoc property should be removed from all.
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== ==========================================================================================================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          DECLARE              @return_value int


         EXEC       @return_value = [dbo].[spMFDeleteAdhocProperty]
                                       @MFTableName =  N'MFCustomer',
                                       @columnNames =  N'Address',
                                       @process_ID = 5,
                                       @Debug =  NULL
         SELECT   'Return Value'  = @return_value


         GO

| 

| 
