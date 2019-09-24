MFCLass and ClassTables
=======================

The whole purpose of the Connector is to interact with the metadata of
specific M-Files Classes.  Deploying the Connector does not
automatically create the class tables that is relevant for the specific
application.

Before creating the class tables it is necessary to determine which
classes should be included in the development or application of the
Connector.  Only create the tables that is necessary and when they are
required.

Synchronizing the metadata is a pre-requisite for creating a new class
table.  It is only necessary to perform the synchronization if the
metadata structure has changed in the vault, or on a first install.



Updating MFClass
~~~~~~~~~~~~~~~~

The MFClass table contains details of the class table that can be
created. 

SELECT \* FROM   [dbo].[MFClass]   AS   [mc]

The MFClass table contains columns from M-Files Admin and specific to
SQL that is used and managed throughout the operations.  

.. container:: table-wrap

   ================== =============================================================== ===============================================================================================================================================
   Column             Main use                                                        Notes
   ================== =============================================================== ===============================================================================================================================================
   ID                 primary key                                                     SQL id, not related to MF
   MFID               MF ID                                                           Assigned and maintained by MF
   Name               Class Name                                                      Per MF; Avoid duplicate class names;  avoid reserved names (report; assignment) Avoid special characters (% # \\ /)
   Alias              Alias from MF                                                   Can be created in bulk by connector
   IncludeInApp       1 = class table created                                         on creation of table is is automatically set
                                                                                     
                      2 = transactional processing                                    procedures often filter on this value to determine if class is used in SQL
   TableName          targeted Table name of class                                    This is preset by default to be prefixed with MF and to remove all special characters from class name. The name of the table is user defineable
   MFObjectType_ID    ID of the object type in MFObjectType table                     None this is NOT the MFID of the object type
   MFWorkflow_ID      ID of the workflow in assigned to the class in MFWorkflow table Note this is NOT the MFID of the workflow
   FileExportFolder   User assigned                                                   Used in the exporting of files from M-Files process
   SynchPrecendence   User assigned : 1 or 0 or null                                  used to assign presedence
   ModifiedOn         date last updated                                              
   CreatedOn          date initially created in SQL                                  
   Deleted            show deleted classed                                            Deleted classes records is automatically removed at next synchronisation
   IsWorkflowEnforced updated by MF                                                   controls the rules to force workflow on class table
   ================== =============================================================== ===============================================================================================================================================

Update the following columns in the class table for the desired classes:

-  IncludedInApp:  Set to 1 for all classes that should be included. Set
   to 2 if transaction based updates should be triggered.
-  TableName: The name in this column will be used as the Table Name for
   the class.  The default is set to prefix the class name with 'MF' and
   remove all special characters.  This name can be changed and the
   custom name will be maintained when a metadata synchronization takes
   place.
-  FilePath: The filepath is used to export the files when
   spMFExportFiles is executed. The default is set to
   'C:\MFSQLConnector_Files'.

UPDATE mc

SET[mc].[IncludeInApp] =1,TableName ='Desired Name', FilePath =
'NewPath'

FROM[dbo].[MFClass] AS[mc]

Where id = id of the class



Creating new ClassTable
~~~~~~~~~~~~~~~~~~~~~~~

To create a new class table execute the following procedure using the
'Name' Column in MFClass

EXEC [dbo].[spMFCreateTable]   @ClassName = N' '-- nvarchar(128)

| 

.. container:: table-wrap

   ======================
   Functional Description
   ======================
   ======================
