Lookup Views
============

Special procedures is included in the Connector to assist with the
creation of a valuelist item and workflow state lookup views. These
procedures will take input parameters and then automatically create a
view that can be used in special applications.

 



Lookup for Valuelist Items
==========================

The lookup can be created in the Connector Manager by selecting the
valuelist and 'create lookup' action button

.. container:: table-wrap

   ============== =========================================================================================
   Type           Description
   ============== =========================================================================================
   Procedure Name spMFCreateValueListLookupView
   Inputs         @ValueListName = N'@Name of the Valuelist', --Valid entries: Select name from MFValuelist
                 
                  @ViewName = N'@name of view', -- User defined name of view
                 
                  @Debug = 0 
   Outputs        1 = success
                 
                  0 = Error
   ============== =========================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         DECLARE @return_value int

         EXEC @return_value = [dbo].[spMFCreateValueListLookupView]
           @ValueListName = N'Country',
           @ViewName = N'vwCountries',

         SELECT 'Return Value' = @return_value

         GO



Lookup for Workflow State
=========================

The lookup can be created in the Connector Manager by selecting the
valuelist and 'create lookup' action button

.. container:: table-wrap

   ============== ======================================================================================
   Type           Description
   ============== ======================================================================================
   Procedure Name ::
                 
                     spMFCreateWorkflowStateLookupView
   Inputs         @WorklfowName = N'@Name of the Workflow', --Valid entries: Select name from MFWorkflow
                 
                  @ViewName = N'@name of view', -- User defined name of view
                 
                  @Debug = 0 
   Outputs        1 = success
                 
                  0 = Error
   ============== ======================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         DECLARE @RC INT

         -- TODO: Set parameter values here.

         EXECUTE @RC = [dbo].[spMFCreateWorkflowStateLookupView] 
            @WorkflowName = 'Processing job applications'
           ,@ViewName = 'vwMFJobApplicationLookup'
           ,@Debug = 0


         SELECT @RC

.. container:: table-wrap

   ================================================================================================================================================
   **Related Topics**
   ================================================================================================================================================
   -  `Valuelists and valuelist items <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/21201012/MFValuelist+and+MFValueListItems>`__
   ================================================================================================================================================
