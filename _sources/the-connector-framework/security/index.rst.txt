Security
========

.. toctree::
   :maxdepth: 4

   schemas/index

The Connector requires several aspects of authentication to be
considered and deployed. Security for accessing M-Files from SQL and accessing SQL from M-Files are different.

Credentials for accessing M-Files from SQL
------------------------------------------

SQL use a standard M-Files Connection to login to M-Files.

The Connector allows for both Specific Windows and M-Files authentication
as a user.  We recommend the use of a dedicated M-Files authentication 
user with a distinct name such as *MFSQL* or *MFSQLConnect* as a named user license.  The name of the
user will appear on all objects in M-Files that is updated or
created.

Assign administrator permissions in the vault to the user.  

The M-Files user for the connector must be assigned as a
server-administrator in M-Files for the duration of the
installation into the M-Files vault.  The installation of the
vault applications will fail if the user does not have this
required permissions.  The permissions of the installation user
can be downgraded to a vault administrator when the
installation is complete.

The M-Files user is automatically configured in the database on installation of the package.  These details are maintained in the table MFVaultSettings. Re-running the installation package will automatically update the
credentials. The connection settings can also be
changed  in the **MFVaultSettings** table using the
spmfSettingsForVaultUpdate procedure.

The password is stored in the MFVaultSettings table in encrypted format.

Credentials for accessing SQL from M-Files
------------------------------------------

On installation the package automatically configure the authentication for acc

It is required for the SQL server to be installed with mixed mode
authentication to operate.

The Context Menu functionality of the Connector uses an ODBC connection string for access to SQL operations from
M-Files to SQL. A webservices API method is available for Cloud installation

The connection method is configured in the M-Files Admin Configurator as part of the installation process. The password used in the configurator need to be reset in SQL before the connection from M-Files to SQL will be operational. 

The installation package automatically install and assign permissions
for the SQL operations.  An SQL authentication login 'MFSQLConnect' is created and
assumes the permissions assigned to the db_MFSQLConnect role in the database.

Another user (including windows authentication users) can be added
to the db_MFSQLConnect role to allow specific users to perform
Connector tasks.

The permissions delete, execute, insert, select and update are
associated with the db_MFSQLConnect role for the schemas: dbo, Setup,
custom, ContMenu.  Alter permission is applied to dbo and Custom
schema.

Encryption of password in MFVaultSettings
-----------------------------------------

The M-Files user credentials used for the Connector is stored in
encrypted format using Microsoft cryptographic services. The  **Secret-key encryption (symmetric
cryptography).** is used. Secret-key encryption algorithms use a single secret
key to encrypt and decrypt data.

Two procedures are provided with the Connector to encrypt and decrypt
the passwords. You must secure these procedures from access by
unauthorized agents, because any party that has these procedures can use
it to decrypt the passwords in the Connector.
