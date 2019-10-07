Content Package installation
============================

Release 4 installation package will automatically install a content
package with objects specifically related to MFSQL Connector.
Installation of the content package was optional prior to Release 4,
however, it is a requirement for the operations of the Connector from
Release 4.1.5.41 and later.

The Content package has changed from Release 4.3.9.48.



Content of content package
--------------------------



Objects
~~~~~~~

.. container:: table-wrap

   ============ ====================== ======================== ========================================================================================================== ==========
   Type         Objects                 Aliase                  Use                                                                                                        Deprecated
   ============ ====================== ======================== ========================================================================================================== ==========
   Object Type  MFSQL Connector         oMFSQLConfiguration     Object Type of classes                                                                                    
   Classes      User Messages           cUserMessages           User messages objects                                                                                     
    Properties   MFSQL Count           p.MFSQL_Count             User Messages object count                                                                               
                 MFSQL User            p.MFSQL_User              User Message user: valuelist item for user                                                               
                 MFSQL Class Table      p.MFSQL_Class_Table     User Message class table                                                                                  
                 MFSQL File Unique Ref p. MFSQL_File_Unique-Ref  Used in DB File connector imports                                                                        
                 MFSQL Process Batch   p.MFSQL_Process_Batch    Used in User Messages and on class table for the process batch id and relates to the MFProcessBatch Table 
                 MFSQL Message         p.MFSQL_Message          Used in User Messages and on class table forupdate messages from SQL                                      
    User Groups  ContextMenu           UsrGrp_ContextMenu       user group to give access to the context menu                                                             
                MFSQLConnector         ug.MFSQLConnector        User group to secure access to the configuration settings                                                 
    Workflow     ContextMenuFlow                                Sample workflow with actions scripts                                                                      
    Views       User Messages                                   Sample view for user messages                                                                             
   ============ ====================== ======================== ========================================================================================================== ==========

| 



Document Record
~~~~~~~~~~~~~~~

The connectionstring is imported and configured for the specific
database and vault.  Search 'connectionstring' to expose the object. It
is recommended to update the MFSQLConnector User group by removing the
'all internal users' and replacing it with the MFSQL Connector user for
the vault.

| 

| 

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      MFSQL Connector will not operate without installing the content
      package.
