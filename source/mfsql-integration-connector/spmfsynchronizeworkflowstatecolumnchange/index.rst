spMFSynchronizeWorkflowStateColumnChange
========================================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      Use spMFSynchronizeWorkflowStateColumnChange to update the
      workflow state columns when the naming convention of states have
      changed.

      This is particularly relevant when a vault is being redesigned or
      changed and the states have been updated.  A naming change of a
      state will not trigger a version change of an object, and
      therefore will not trigger an update of the object from M-Files to
      SQL.  This could result in the labels of the states being
      incorrect in SQL, especially for reporting purposes. 

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ========= ========
         Module    Release#
         ========= ========
         Developer 4.3.9.48
         ========= ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      Use the following script to determine which tables are affected

      | SELECT class FROM [dbo].[MFvwMetadataStructure] AS [mfms]
      | INNER JOIN [dbo].[MFWorkflow] AS [mw]
      | ON [mfms].[Workflow_MFID] = mw.[MFID]
      | INNER JOIN [dbo].[MFWorkflowState] AS [mws]
      | ON [mws].[MFWorkflowID] = [mw].[ID]
      | WHERE mws.[IsNameUpdate] = 1
      | GROUP BY [mfms].[Class]

      | 

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      | 

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== ==========================================================================================================
         Type           Description
         ============== ==========================================================================================================
         Procedure Name [spmfSynchronizeWorkFlowSateColumnChange]
         Inputs         TableName: the table to updated. if not specified, all tables will be included where the workflow is used.
                       
                        Debug: 1 = Debug Mode; 0 = No Debug (default)
         Outputs        1 = success
         ============== ==========================================================================================================

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          DECLARE @ProcessBatch_id INT;

         EXEC [dbo].[spmfSynchronizeWorkFlowSateColumnChange] @TableName = 'MFContractorAgreement' -- nvarchar(200)
                                                             ,@ProcessBatch_id = @ProcessBatch_id OUTPUT         -- int
                                                             ,@Debug = 1     -- int

         --OR 


         EXEC [dbo].[spmfSynchronizeWorkFlowSateColumnChange]

.. container:: confluence-information-macro confluence-information-macro-information

   Use Cases(s)

   .. container:: confluence-information-macro-body

      When state names have changed and existing Class tables are
      affected.

| 
