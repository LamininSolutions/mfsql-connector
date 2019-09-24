spMFUpdateExplorerFileToMFiles
==============================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      MFSQL Connector file import provides the capability of attaching a
      file to a object in a class table.

      This functionality will:

      -  Add the file to an object.  If the object exist as a
         multidocument object with no files attached, the file will be
         added to the multidocument object and converted to a single
         file object.  If the files already exist for the object, the
         file will be added to the collection.
      -  The object must pre-exist in the class table. The class table
         metadata will be applied to object when adding the file. This
         procedure will add a new object from the class table, or update
         an existing object in M-Files using the class table metadata. 
      -  The source file will optionally be deleted from the source
         folder.

      | 

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ========= ========
         Module    Release#
         ========= ========
         Developer 4.3.9.48
         ========= ========

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      The procedure use the ID in the class table and not the objid
      column to reference the object.  This allows for referencing an
      record which does not yet exist in M-Files.

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== =====================================================================
         Type           Description
         ============== =====================================================================
         Procedure Name spMFUpdateExplorerFileToMFiles
         Inputs         FileName : name of file
                       
                        FileLocation: UNC path or Fully qualified path to file
                       
                        MFTableName: class table
                       
                        SQLID: the ID column on the class table.  
                       
                        IsFileDelete: set to 1 if the file should be deleted in folder
                       
                        ProcessBatch_ID: Output ID in MFProcessBatch for logging the process 
                       
                        Debug: 1 = Debug Mode; 0 = No Debug (default)
         Outputs        1 = success
         ============== =====================================================================

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         DECLARE @ProcessBatch_id INT;
         DECLARE @FileLocation NVARCHAR(256) = 'C:\Share\Fileimport\2\'
         DECLARE @FileName NVARCHAR(100) = 'CV - Tommy Hart.docx'
         DECLARE @TableName NVARCHAR(256) = 'MFOtherDocument'
         DECLARE @SQLID INT = 1


          EXEC [dbo].[spMFUpdateExplorerFileToMFiles] 
          @FileName = @FileName
          ,@FileLocation = @FileLocation 
          ,@SQLID = @SQLID    
          ,@MFTableName = @TableName                  
          ,@ProcessBatch_id = @ProcessBatch_id OUTPUT      
          ,@Debug = 0      
          ,@IsFileDelete = 0
                              
         SELECT * from [dbo].[MFFileImport] AS [mfi]   

| 
