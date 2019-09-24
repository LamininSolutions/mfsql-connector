MFExportFileHistory
===================

The MFExportFileHistory table contains a record of the files that is
exported using the spMFExportFiles procedure.

.. container:: table-wrap

   ============== ========================================================= ==============================================================================================================================================================================================
   Column         Related to                                                Notes
   ============== ========================================================= ==============================================================================================================================================================================================
   ID             Record id                                                
   FileExportRoot Rootfolder  +  FileExportFolder                           Rootfolder is automatically set to C:\MFSQL\FileExport and can be changed in MFSettings
                                                                           
                                                                            The FileExportFolder is class specific and is set in the MFClass table by class. It defaults to null. The FileExportFolder will separate the files for different classes in the folder system.
   Sub_Folder_1   parameter @PathProperty_L1                                This parameter is set in the spMFExportFiles procedure
   Sub_Folder_2   parameter @PathProperty_L2                                This parameter is set in the spMFExportFiles procedure
   Sub_Folder_3   parameter @PathProperty_L2                                This parameter is set in the spMFExportFiles procedure
   FileName       M-Files filename of the file                             
   ClassID        M-Files class ID of the related class table              
   Objid          M-Files Objid for the metadata object                    
   objectType     M-Files ObjectType for the class                         
    Version       Version no of the object that contained the exported file
    FileCheckSum   Calculated checksum for the exported file               
    FileCount      The count of the files in the object                    
   Created         The date and time of the export of the file             
   ============== ========================================================= ==============================================================================================================================================================================================

| 

A column with a datetime datatype will be displayed in the format
yyyy-mm-dd when specified as one of the folder parameters 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql


