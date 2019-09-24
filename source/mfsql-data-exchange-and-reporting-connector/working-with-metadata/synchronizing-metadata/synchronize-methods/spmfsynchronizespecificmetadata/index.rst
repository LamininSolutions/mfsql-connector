spMFSynchronizeSpecificMetadata
===============================

| 

| 

| 

.. container:: table-wrap

   ============== ================================================================================================================================
   Item           Comments
   ============== ================================================================================================================================
   Procedure Name ::
                 
                     spMFSynchronizeMetadata
   Inputs         Metadata = one of the following
                 
                  -  ObjectType
                  -  Properties
                  -  ValueList
                  -  ValueListItems
                  -  Workflow
                  -  States
                  -  Class
                 
                  IsUpdate: this defaults to 0. 0 = from M-Files to SQL. 1 = From SQL to M-Files
                 
                  ItemName: Default = null. this applies to updating of ValuelistItems only. The update is filtered on the name of the valuelist .
                 
                  debug: 0 = no debugging
                 
   Outputs        1 = success
   MFSQL Manager  Operations/Metdata Refresh
   ============== ================================================================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFSynchronizeSpecificMetadata]
             @Metadata = 'Class' -- required
           , -- varchar(100)
             @Debug = 0
           , -- smallint
             @IsUpdate = 0 -- smallint
