Assemblies
==========

The Connectors use several assemblies to interact with T-SQL in
performing the Connector functions.

========================= ===================================================================
Entity Name               Remarks
========================= ===================================================================
CLRSerializer             Used to serialize the data exchange between the systems
Interop.MFilesAPI         M-Files interop assembly. This dll is part of the M-Files software.
LSConnectMFilesAPIWrapper This is the main Connector assembly that wraps the M-Files API's
Laminin.Security          Used to encrypt and decrypt password
========================= ===================================================================

The Connector package load the version of the M-Files interop.MFIlesAPI that is installed with the M-Files installation on the SQL Server.
