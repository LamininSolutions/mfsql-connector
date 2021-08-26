Configuring the File Connector
==============================

After you have successfully installed the connector, you should
configure a connection between a SQL Database and the document vault.
You may configure one or more connections.

Complete the following steps to configure a new connection:

| 
| 1. Open M-Files Admin.

2. In the left-side tree view, expand the desired connection to M-Files
Server.

3. In the left-side tree view, expand the document vault of your choice,
and then select Configurations.

| 4. In the gray navigation area, expand External Repositories and then
  select the SQLDatabaseConnector.
| 5. On the Dashboard tab, click Add Connection to configure a new
  connection, and then click OK at the prompt verifying that you want to
  add a new connection.

6. Click Configure on the Dashboard tab to configure the new connection.

7. On the Configuration tab, expand the General Settings section, and
modify at least the following settings:


General Settings
~~~~~~~~~~~~~~~~

Enabled Yes This setting enables the connection.

Display Name <user-defined> This setting is for specifying the display
name of the connection. The display name is shown in the home screen
under External Views

| Authentication:  Personal, Common,or Anonymous
| This setting is for defining the authentication mode for the
  connection. The available options are: 

-  Personal: Select this option if you want the vault users to use their
   personal credentials for accessing the Database. 
-  Common: Select this option if you want all vault users to share the
   same credentials for accessing the Database. 
-  Anonymous: This option is not available for Database connections.


Permissions
~~~~~~~~~~~

-  Use M-Files NACL:  Set to Always
-  M-Files NACL: Use the dropdown to select full control for all
   internal users, or an ACL group to restrict the users who should have
   access.


Automatic Association
~~~~~~~~~~~~~~~~~~~~~

Not applicable



Mapping
~~~~~~~

| Expand Object Types. 9. Click Add Object Type and edit the following
  settings:
| Object Type:

This setting is for associating an M-Files object type, such as
Document, with the files obtained via this connection.

-  M-Files Object Type: Always set to Document
-  External Type:   Leave this setting as the default ( \* ).  Note that
   filtering of records is done by using where clauses in the Connector
   View.  Refer to section on SQL Database.
-  Properties: This section is not applicable.

Property Definitions: This setting is for associating the M-Files
properties with the columns in the table. The properties will show on
metadata card of the file object.  Note that only text based properties
can be used.

Select to add a property.  For each property:

-  M-Files Property:  Select and existing M-Files property from the drop
   down.
-  External Property: Use the 'External Property' Name of the column as
   defined in the Connection-Specific Settings



Search Index
~~~~~~~~~~~~

The search index set the criteria for updating the search.  No change is
necessary in standard use cases.


