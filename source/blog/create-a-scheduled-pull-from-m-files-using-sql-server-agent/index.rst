Create a scheduled pull from M-Files using SQL Server Agent
===========================================================

In this use case we will setup a process using functionality exposed by
MFSQL Context Menu and SQL Server Agent in order to setup a scheduled
refresh from M-Files to SQL Server class table(s) for reporting
purposes.

The content will demonstrate how to avoid doing a refresh while another
process is still running as well as demonstrate some best practices
around building a stored procedure being called by SQL Server Agent Job.

The use case have the following components:

-  Stored Procedure to execute a controlled refresh

-  Custom View(s) to monitor SQL Agent Job execution

-  SQL Agent Job scheduled to perform the pull

Several MFSQL Connector tables and procedures will come into play:

-  MFContextMenu

-  spMFUpdateTable

-  MFClassTable


