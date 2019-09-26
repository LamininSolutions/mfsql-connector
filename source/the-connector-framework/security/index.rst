Security
========

.. toctree::
   :maxdepth: 4

   schemas/index

The Connector requires several aspects of authentication to be
considered and deployed.

The Connector uses both Specific Windows and M-Files authentication
to validate the user.  We recommend the use of a dedicated M-Files
user with a distinct name and a named user license.  The name of the
user will appear on all objects in M-Files that is updated or
created. A M-Files user 'MFSQLConnect' is automatically created as a
user when the content package is installed to improve visibility of
which modifications in M-Files is performed by the connector.  This
user can be removed if it is not used as the Connector user.

Assign administrator permissions in the vault to the user.  

The M-Files user for the connector must be assigned as a
server-administrator in M-Files for the duration of the
installation into the M-Files vault.  The installation of the
vault applications will fail if the user does not have this
required permissions.  The permissions of the installation user
can be downgraded to a vault administrator only when the
installation is complete.

From release 4 the installation package will allow you to connect to
M-Files and the vault and apply these credentials for the
Connector.  MFVaultSettings will be automatically updatedwith the
credentials used during installation. The connection settings can be
changed  in the **MFVaultSettings** table using the
spmfSettingsForVaultUpdate procedure or by rerunning the installation
package.

It is required for the SQL server to be installed with mixed mode
authentication to operate.

SQL server operations takes place from different angles.

-  Using SSMS to perform operations
-  Operations performs using the context menu and actions in M-Files
-  Using SSIS
-  Accessing third party databases

The Connector use an ODBC connection string for SQL operations from
M-Files to SQL.

The installation package automatically install and assign permissions
for SQL.  The SQL authentication login 'MFSQLConnect' is created and
assumes the permissions assigned to the db_MFSQLConnect role.  

Any other user (including windows authentication users) can be added
to the db_MFSQLConnect role to allow specific users to perform
Connector tasks.

The permissions delete, execute, insert, select and update are
associated with the db_MFSQLConnect role for the schemas: dbo, Setup,
custom, ContMenu.  Alter permission is applied to dbo and Custom
schema.

M-Files access the SQL database using a ODBC connection.  The
connection string is automatically installed in M-Files as part of
the content package installation.  The functionality to access SQL
from M-Files is only available in on-premise installations.  It is
not available in cloud installations.

Encryption of password in MFSettings

The M-Files user credentials used for the Connector is stored in
encrypted format using Microsoft cryptographic services. Cryptography
helps protect data from being viewed, provides ways to detect whether
data has been modified, and helps provide a secure means of
communication over otherwise nonsecure channels. For example, data can
be encrypted by using a cryptographic algorithm, transmitted in an
encrypted state, and later decrypted by the intended party. If a third
party intercepts the encrypted data, it will be difficult to decipher.

The Connector use **Secret-key encryption (symmetric
cryptography).** Secret-key encryption algorithms use a single secret
key to encrypt and decrypt data.

Two procedures are provided with the Connector to encrypt and decrypt
the passwords. You must secure these procedures from access by
unauthorized agents, because any party that has these procedures can use
it to decrypt the passwords in the Connector.
