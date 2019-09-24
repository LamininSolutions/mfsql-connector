Database file import into M-Files
=================================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      Use the spmfExportFiletoMFiles procedure to export a file in a
      database blob to M-Files.

      This will allow for a file that is stored in a database that is
      accessible as a view or table in MFSQL Connector database to be
      extracted and imported into M-Files.  There is a number of key
      elements and pre-requisites to set this up.

      -  A new text property with the name  Mfsql_File_Unique_Ref is
         added to the metadata of the target class.  For instance, if
         image files will be imported into the Drawing Class in M-Files
         then  Mfsql_File_Unique_Ref must be added in M-Files as a
         property and added to the Drawing Class in M-Files.
      -  Note the setting in MFSettings for the location of the
         temporary folder on the SQL server to be used during the
         processing of the file transfer.  The procedure will
         temporarily save the file in this folder, and then use M-Files
         API's to import the file into M-Files and link it with the
         metadata.
      -  A table or view must exist with the following minimum columns

         -  The Image in a blob format. This is usually a data type of
            bit or nvarchar(max)
         -  The name of the file
         -  A unique reference for the image

      -  Add or update the record to be updated in the MFSQL Connector
         class table by updating the Mfsql_File_Unique_Ref column and
         any additional metadata to be added / updated for the record. 
         This is usually done by having a select statement with a join
         between all the related data in the image file database to
         extract all the relevant data from the third party database. 
         Set the process_id of the table to 5.
      -   Execute the above procedure.

         -  if the record in the class table is new, a new single file
            object will be created in M-Files with the relevant metadata
         -  if the record exist and the file is new, the record will be
            set as a multi file document and the new file will be
            added.  A new file is where name of the file is different
            from another file in the multi-files of the specific object
         -  If the record exist and there is already a file in the
            multi-file document with the same name, then to file in
            M-Files will be overwritten.

      -  The procedure will allow for specifying the size of the batches
         to be imported. This will allow for importing larger volumes of
         files in segments. 

      | 

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         =========== ========
         Module      Release#
         =========== ========
         Integration 3.1.5.41
         =========== ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      The  Mfsql_File_Unique_Ref property is automatically added to the
      vault when the content package is installed during the
      installation routine.

      The folder on the SQL Server to be used as the temporary file
      export folder is automatically created during the installation
      routine as c:\MFSQL\FileImport.  

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      | 

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== =============================================
         Type           Description
         ============== =============================================
         Procedure Name
         Inputs         Debug: 1 = Debug Mode; 0 = No Debug (default)
         Outputs        1 = success
         ============== =============================================

| 

Review the folder location for the file import

| 

.. container:: code panel pdl

   .. container:: codeContent panelContent pdl

      .. code:: sql

         SELECT * FROM mfsettings WHERE name = 'FileTransferLocation'

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         -------------------------------------------------------------------------------------------------------------------------
         exec spMFCreateTable 'Drawing'
         exec spmfupdatetable 'MFDrawing',1
         select * from MFDrawing
         -------Add New File to existing object -----------------------
         update MFDrawing set Process_id=5 where fileobjectid='1'

         --in this example to ImageFiles view containts the extract of the files to be imported

         EXEC SynchronizeFilesToMFiles 'ImageFiles','ID','FileName','File','Drawing',500

         select * from ImageFiles

         -----------------Over write File-----------------------
         exec spmfupdatetable 'MFOrder',1
         update MFDrawing set Process_id=5 where fileobjectid='6'

         EXEC SynchronizeFilesToMFiles 'ImageFiles','ID','FileName','File','Drawing',500

         -------------------------------Adding File to MultiFile Document-----------------------

         update MFDrawing set process_id=5 where fileobjectid='2'

         EXEC SynchronizeFilesToMFiles 'ImageFiles','ID','FileName','File','Drawing',500

.. container:: confluence-information-macro confluence-information-macro-information

   Use Cases(s)

   .. container:: confluence-information-macro-body

      | 

| 
