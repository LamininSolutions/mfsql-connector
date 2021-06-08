Content Package installation
============================

Release 4 installation package will automatically install a content
package with objects specifically related to MFSQL Connector.
Installation of the content package was optional prior to Release 4,
however, it is a requirement for the operations of the Connector from
Release 4.1.5.41 and later.

The Content package has changed from Release 4.3.9.48.

Content package
--------------------------

Object Type \:  MFSQL Connector
 -  Aliase \: oMFSQLConfiguration

Class: User Messages
 -  Aliase \: cUserMessages
 -  Purpose \: User messages objects

User messages properties:
 -  MFSQL Count \: p.MFSQL_Count \: object count
 -  MFSQL User \: p.MFSQL_User \: user
 -  MFSQL Class Table : p.MFSQL_Class_Table : User Message class table

Other properties
 -  MFSQL Process Batch : p.MFSQL_Process_Batch : Used in User Messages and on class table for the process batch id and relates to the MFProcessBatch Table
 -  MFSQL Message : p.MFSQL_Message : Used in User Messages and on class table for update messages from SQL
 -  MFSQL File Unique Ref p. MFSQL_File_Unique-Ref  Used in DB File connector imports

User Groups
 -  ContextMenu : UsrGrp_ContextMenu : user group to give access to the context menu

Workflow
 -  ContextMenuFlow : Sample workflow with actions scripts

Views 
 -  User Messages : Sample view for user messages


The content package does not have to be installed, and the objects can be deleted if not required

