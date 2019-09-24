Metadata Structure Tables
=========================

.. toctree::
   :maxdepth: 4

   metadata-table-columns/index
   mfclass/index
   mfvaluelist-and-mfvaluelistitems/index
   mfworkflow-and-mfworkflowstate/index
   mfloginaccount-and-mfuseraccount/index

The following tables relating to the metadata structure are part of the
Connector. The tables are created as part of the installation. These
tables are populated with the metadata syncronisation procedures.

These tables include several extensions of the standard M-Files Metadata
that is useful in special applications. These extensions are detailed in
the next section.

.. container:: table-responsive

   | 

   .. container:: table-wrap

      SQL Connector Tables

MFClass

| Used to store detail of the class object in M-Files. This table must
  be distinguished from the 'Class Tables' in the Connector. The MFClass
  table has special columns to extend the application of the class
  object. The 'Class Tables', on the other hand is a collective term
  referring to all the tables created by the connector representing a
  record for each object in a particular class such as Customers. The
  column 'IncludedInApp' show the class tables that is marked for
  inclusion in special applications. 
| The MFClass Table relates to properties through the MFClassProperty,
  to MFObjectType and to MFWorkflow.
| The Class Table Names are defined in this table.

MFProperty

| Used to store the Property details in M-Files.This table has
  additional columns to extend their use. 
| The property table relates to MFValuelist and to MFClass through
  MFClassProperty. The datatype of the property is shown in column
  'MFdataType_id. The Datatype ID relates to the MFDataType Table.
| The column names of the Class Tables are defined in this table. The
  column 'PredefinedOrAutomatic' show if the property has any special
  rules associated with it.

MFClassProperty

Used to index the relationship of Properties with Classes. The
'Required' column show if the property is required on the class.

MFLoginAccount

Used to store the login accounts in M-Files. It  shows the login
accounts for all users in vaults that the MFSQL Connector User have
access to .

MFObjectType

Used to store the Object types in M-Files.

MFObjectTypeToClass

Reference table to map Class Tables to ObjectTypes.

MFUserAccount

Used to store the User Account details in M-Files. The table relates to
the MFLoginAccount.

MFValueList

| Used to store the Value List details in M-Files. 
| The table is related to MFValuelistItems and MFProperty. The column
  'OwnerID' show the MFID of the object that owns the valuelist. This
  could be a class or workflow.

MFValueListItems

| Used to store the Value list items details in M-Files. 
| The table relates to MFvaluelist. The column 'OnwerID' show the MFID
  of the objects that owns the item. This is another ValuelistItem.
| The column 'App_Ref' is predefined unique value for each Valuelist
  item in the vault. This value allows for rapid referencing of a item
  without using joined tables to get to the MFID of the valuelist item.
  In the same way the column 'Owner_AppRef' references the owner with a
  unique id.

MFWorkflow

Used to store the work flow details in M-Files. This table relates to
MFWorkflowState.

MFWorkflowState

Used to store the work flow item details in M-Files. This table relates
to MFWorkflow.
