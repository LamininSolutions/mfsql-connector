Using Agent for automated updates
=================================

.. container:: confluence-information-macro confluence-information-macro-note

   .. container:: confluence-information-macro-body

      SQL Agent is not available for SQL Express editions.  Use the
      `powershell utilities <page686620697.html#Bookmark38>`__ for
      scheduled operations.

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

    EXEC [dbo].[spMFUpdateAllncludedInAppTables] @UpdateMethod = 1
                                                     ,@RemoveDeleted = 1

      Consider adding the powershell utility to update the M-Files
      version in combination with the agent when the SQL Server is
      separate from the M-Files server and the M-Files Version is likely
      to get out of sync between the servers.

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

The agent calls the procedure EXEC spMFCheckAndUpdateAssemblyVersion. It
is set to run once a day at 6am.  The time can be adjusted to fit in
with other scheduled agents.  Note that any other Connector operations
will fail during the time that the assemblies are updated.

This procedure performs several functions: 

-  Get the M-Files version of the M-Files Server using an API call to
   the M-Files installation
-  Get the M-Files version from the MFSettings Table
-  If no different is detected, the procedure will exit. 

   -  If different it will update MFSettings with the new Version and
      the perform  spMFUpdateAssembies.  This procedure in turn will

      -  drop all the CLR procedures in the Connector database
      -  reinstall the assemblies based on the settings in MFSettings
      -  re-install the CLR procedures.

In is important to note:

-  if the M-Files version on  the M-Files Server is different from the
   SQL Server then the procedure will attempt to update the SQL Server
   with the M-Files version on  the M-Files Server. This will result in
   an error and the a status that the CLR procedures are missing. Any
   attempt to run procedures will automatically fail.

Corrective action:

-  Step 1:  Manually update MFSettings 'MFVersion' with the correct
   version on the SQL Server.  (update MFSettings set value = 'New MF
   version such as 19.7.8208.7' where name = 'MFVersion')
-  Step 2 re-run spmfUpdateAssemblies.(exec spmfUpdateAssemblies)
-  Step 3 align the versions on the two servers
-  Step 4 rerun spMFCheckandUpdateAssemblies (just to test that it all
   is in order)

If updating the M-Files Server and SQL Server is likely to get out of
sync then de-active the agent and use the powershell utility to update
the version.

Staging updates with agents
---------------------------

Sometimes it is necessary to ensure one agent is completed before
another kicks in, or to check if a agent is running before a procedure
is executed.  We included a an example procedure in the Demonstrate
Functions '70.104.Eample - Start Job wait - Agent' to assist with this
type of operation.
