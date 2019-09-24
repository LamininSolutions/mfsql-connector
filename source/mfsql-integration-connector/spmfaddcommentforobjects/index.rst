spMFAddCommentForObjects
========================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      Add a new comment to an object, or objects using SQL with the
      procedure spMFAddCommentsForObjects.

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ========= ========
         Module    Release#
         ========= ========
         Developer 3.1.4.40
         ========= ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      Set the process_ID for the selected objects before executing the
      procedure.

      Use spGetHistory procedure to access the history of comments of an
      object in SQL

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      Note that adding a comment is a separate process from making a
      change to the object. The two processes must run one after the
      other rather than simultaneously

      The same comment will be applied to all the selected objects.

      | 

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== ==============================================================
         Type           Description
         ============== ==============================================================
         Procedure Name spMFAddCommentForObjects
         Inputs         @MFTableName = name of class table
                       
                        Process_ID = process id of the object(s) to add the comment to
                       
                        Comment = the text of the comment
                       
                        Debug: 1 = Debug Mode; 0 = No Debug (default)
         Outputs        1 = success
         ============== ==============================================================

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          
         UPDATE [dbo].[MFCustomer]
         SET process_id = 5
         WHERE id IN (1,3,6,9)

         DECLARE @Comment NVARCHAR(100)

         SET @Comment = 'Added a comment for illustration '

         EXEC [dbo].[spMFAddCommentForObjects]
             @MFTableName = 'MFCustomer',
          @Process_id = 5,
             @Comment = @Comment ,
             @Debug = 0

.. container:: confluence-information-macro confluence-information-macro-information

   Use Cases(s)

   .. container:: confluence-information-macro-body

      | 

| 
