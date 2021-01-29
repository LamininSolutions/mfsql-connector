
=================================
spMFCreateWorkflowStateLookupView
=================================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @WorkflowName NVARCHAR(128)
    Name of the workflow
  @ViewName NVARCHAR(128)
    Name of view.  example  'vwContractApproval'
  @Schema NVARCHAR(20)
    Default = 'dbo'
    We recommend to set it as 'custom'
  @Debug SMALLINT = 0
   - Default = 0
   - 1 = Standard Debug Mode
   - 101 = Advanced Debug Mode

Purpose
=======

To automatically create a view showing all the related columns for the specific workflow

Additional Info
===============

The view has the following standard columns:
 - Name_Workflow : name of the workflow
 - Alias_Workflow : Alias of workflow
 - MFID_Workflow : M-files internal workflow id 
 - Name_State : name of the state
 - Alias_State : alias of the state
 - MFID_State: M-files internal state id
 - Deleted_State : set to 1 if the state has been deleted


Examples
========

.. code:: sql

    EXEC dbo.spMFCreateWorkflowStateLookupView @WorkflowName = 'Contract Approval Workflow',
    @ViewName = 'vwContractApproval',
    @Schema = 'custom',
    @Debug = 0

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2017-12-10	LC         Add Schema
2015-07-20  DEV2	   Created
==========  =========  ========================================================

