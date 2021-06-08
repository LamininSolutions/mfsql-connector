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
