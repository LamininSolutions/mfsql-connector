spMFSynchronizeSpecificMetadata
===============================

Returns
   1 = success

Inputs
   @Metadata = one of the following
      -  ObjectType
      -  Properties
      -  ValueList
      -  ValueListItems
      -  Workflow
      -  States
      -  Class

   @IsUpdate
      0 = from M-Files to SQL (default)
      1 = From SQL to M-Files

   @ItemName (default = null)
      This applies to updating of ValuelistItems only. The update is filtered on the name of the valuelist.

   @Debug
      0 = no debugging
MFSQL Manager
   Operations/Metdata Refresh

Example
-------

.. code:: sql

     EXEC [dbo].[spMFSynchronizeSpecificMetadata]
        @Metadata = 'Class' -- required
      , -- varchar(100)
        @Debug = 0
      , -- smallint
        @IsUpdate = 0 -- smallint

