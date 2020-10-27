Using Agent for automated updates
=================================

      SQL Agent is not available for SQL Express editions.  Use the `powershell utilities <https://doc.lamininsolutions.com/mfsql-connector/getting-started/first-time-installation/setup-powershell-utilities/index.html>`__ for scheduled operations for SQL Express scenarios.

SQL Agent is used to schedule a range of operations for the Connector. 
The installation package will automatically install two agents.  Other
agents can be used to perform any number of operations. Updating class
table on a schedule is very common.

Agents will be installed for each Connector database for the following

#. MFSQL Delete History
#. MFSQL Validated M-Files Version

Update Class Tables
-------------------

The installation package does not automatically create an agent for
scheduling the update of the class tables.

If it is appropriate to update all class tables simultaneously on a
schedule then use spMFUpdateAllIncludedInAppTables in the agent. 
Include the following script as a step in the agent.

.. code:: sql

    EXEC [dbo].[spMFUpdateAllncludedInAppTables]
    @UpdateMethod = 1
   ,@RemoveDeleted = 1
   ,@IsIncremental = 1

Consider adding the powershell utility to update the M-Files version in combination with the agent when the SQL Server is separate from the M-Files server and the M-Files Version is likely to get out of sync between the servers.

Delete History Agent
--------------------

The agent calls spMFDeleteHistory and is set to run once a month to
delete history older than 90 days. The following tables are included in
the deletion:

-  MFLog
-  MFUpdateHistory
-  MFAuditHistory
-  MFProcessBatchDetail
-  MFProcessBatch

Validate M-Files Version Agent
------------------------------

The agent calls the procedure spMFCheckAndUpdateAssemblyVersion. It
can be set to run once a day or more regularly if required.  The time can be adjusted to fit in
with other scheduled agents.  Note that any other Connector operations
will fail during the time that the assemblies are updated.


Staging updates with agents
---------------------------

Sometimes it is necessary to ensure one agent is completed before
another kicks in, or to check if a agent is running before a procedure
is executed.  We included an example procedure in the Demonstrate
Functions '70.104.Eample - Start Job wait - Agent' to assist with this
type of operation.
