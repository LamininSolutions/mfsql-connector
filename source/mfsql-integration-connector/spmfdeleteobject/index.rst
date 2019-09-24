spMFDeleteObject
================



Delete individual object
------------------------

An object can be deleted from M-Files using the ClassTable by using
the spMFDeleteObject procedure. Is it optional to delete or destroy  the
object in M-Files.

| 

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      Note that when a object is deleted it will not show in M-Files but
      it will still show in the class table. However, in the class table
      the deleted flag will be set to 1.

.. container:: table-wrap

   ============== ==========================================================
   Type           Description
   ============== ==========================================================
   Procedure Name spMFDeleteObject
   Inputs         ::
                 
                     @ObjectTypeId = OBJECT Type MFID from MFObjectType
                     @objectId = Objid of record
                     @Output = output message 
                 
                  ::
                 
                     @DeleteWithDestroy = default = 0.  Set to 1 to destroy.
   Outputs        1 = success
                 
                  0 = Partial (Some records failed to insert into MF Table
                 
                  2 = Error
   ============== ==========================================================

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         DECLARE@return_value int, @Output nvarchar(2000)

         SELECT @Output =N'0'

         EXEC @return_value = [dbo].[spMFDeleteObject]
         @ObjectTypeId =128,-- OBJECT MFID
         @objectId =4700,-- Objid of record
         @Output = @Output OUTPUT,
         @DeleteWithDestroy = 0
         SELECT @Output as N'@Output'
         SELECT'Return Value'= @return_value
          
         SELECT @Output =N'0'

         GO



Delete Objects in bulk
----------------------

Use the following procedure to delete multiple objects in one procedure.

Set the process id on the table to a number above 6 on all the objects
that need to be deleted.  Then execute the procedure.

.. container:: table-wrap

   ============== ========================================================
   Type           Description
   ============== ========================================================
   Procedure Name spMFDeleteObjectList
   Inputs         ::
                 
                     @TableName Name of Class Table
                     @Process_ID process id set on the items to be deleted
                     @Debug Default 0
                 
                  ::
                 
                     @DeleteWithDestroy Default 0
   Outputs        1 = success
                 
                  0 = Partial (Some records failed to insert into MF Table
                 
                  2 = Error
   ============== ========================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFDeleteObjectList]
              @TableName = N'YourTableName'
            , -- nvarchar(100)
              @Process_id = 6
            , -- int
              @Debug = 0, -- int
          ,@DeleteWithDestroy = 0
