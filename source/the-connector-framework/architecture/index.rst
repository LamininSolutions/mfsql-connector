Architecture
============

In order to expose the M-Files metadata, the Connector imports the data
from M-Files using the LSConnect Wrapper assembly that wraps the
interop.MFilesAPI and bi-drectionally update the SQL Server using a
range of T-SQL procedures that interacts with the assembly.

The current release of the Connector include most of the M-Files
metadata and object details of the target vault. 

The Connectors always operate on a single designated vault in the
M-Files Server. A separate Connector is required for every vault that
requires interaction.

The Connector is installed on the SQL server in a separate database.
This SQL server may be on the M-Files server or another server as long
as the Connector server and M-Files server can be connected.

Note that the Connector does not require nor use the standard M-Files
SQL vault database. The Connector operates a completely separate and
independent SQL Database from the internal M-Files SQL Database.
