M-Files Installation
====================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      Release 4 introduces the installation of different parts in the
      M-Files Vault as an integral part of the Connector.  The connector
      will not operate without installing these components.

      The installation of the IML Database File Connector vault
      application is optional.  This module is dependent on a IML
      license.

      .. container:: table-wrap

         ========================================= ===================================================================================================================================================================== =========================================================================
         Component                                 Scope                                                                                                                                                                 Application 
         ========================================= ===================================================================================================================================================================== =========================================================================
         Content package                           Object type: MFSQL Connector                                                                                                                                           SQL user messages in M-Files
                                                                                                                                                                                                                        
                                                   Class: MFSQL Configuration; User Messages                                                                                                                             ODBC connection settings
                                                                                                                                                                                                                        
                                                   Properties:  MFSQL Class Table; MFSQL count; MFSQL File Unique Ref; MFSQL Message; MFSQL Process Batch; MFSQL User; MFSQL Configuration; SettingsDetail; SettingsName User feedback on objects
                                                                                                                                                                                                                        
                                                   User Group: ContextMenu; MFSQLConnector                                                                                                                               Database file imports
                                                                                                                                                                                                                        
                                                   Users:  MFSQLConnect                                                                                                                                                  SQL procedure calls from M-Files
                                                                                                                                                                                                                        
                                                   Views: User Message view                                                                                                                                              Security control of context menu
                                                                                                                                                                                                                        
                                                   Workflow: ContextMenuFlow; MFSQL Messages                                                                                                                            
                                                                                                                                                                                                                        
                                                   Scripts: Action script examples in ContextMenuFlow states                                                                                                            
         MFSQL Connector vault application         Licence control for MFSQL Connector                                                                                                                                    allows interaction between M-Files and SQL
                                                                                                                                                                                                                        
                                                   VAF application to control procedures between M-Files and SQL                                                                                                        
         Context Menu UI extensibility application M-Files user action menu                                                                                                                                               allows calling of procedures from M-Files in a variety of different ways
         Database File Connector IML application   Licence control for database file connector                                                                                                                            allows viewing and searching of database file blobs
                                                                                                                                                                                                                        
                                                   IML connector application for database files                                                                                                                         
         ========================================= ===================================================================================================================================================================== =========================================================================

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ======= ========
         Module  Release#
         ======= ========
         General 4.1.5.41
         ======= ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      The different components are installed as part of the installation
      routine.  All these components can be installed manually also by
      following the instructions in the installation section.

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      The connector will not operate without the installation of the
      M-Files components from release 4 
