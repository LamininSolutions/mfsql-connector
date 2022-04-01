Using Agent for automated updates
=================================

SQL Agent is used to schedule a range of operations for the Connector. 
The installation package will automatically install two agents.  Other
agents can be used to perform any number of operations. Updating class
tables on a schedule is very common.

Agents will be installed for each Connector database for the following

#. MFSQL Delete History
#. MFSQL Validated M-Files Version

Update Class Tables
-------------------

The installation package does not automatically create an agent for
scheduling the update of the class tables.

For incremental updates use :doc:`/procedures/spMFUpdateAllncludedInAppTables` in the agent. 

This procedure provides for:
  - Update all tables included in the app.
  - Incremental updates for all changes in M-Files since the last class table update. This does not catch deleted and destroyed objects.
  - Full update to catch deleted or destroyed objects
  - Include deleted objects for all class tables.  By default, deleted records are removed from the class table.
  - Specify the update for a subset classes.  Include by default all the tables where IncludeInApp column in MFClass has 1. However, by setting the column to a different figure the tables can be grouped together.  This is particularly handy to run this procedure on subsets of class tables.
  - Email a status report for all tables with errors to a specified user

Include the following script as a step in the agent and schedule to job to run with your required intervals

The shortage interval should not be less that the run time of the procedure.

.. code:: sql

    EXEC [dbo].[spMFUpdateAllncludedInAppTables]
    @UpdateMethod = 1
   ,@IsIncremental = 1

For full updates use :doc:`/procedures/spMFUpdateAllncludedInAppTables` in the agent. 
Include the following script as a step in the agent.

.. code:: sql

      EXEC [dbo].[spMFUpdateAllncludedInAppTables]
      @UpdateMethod = 0
     ,@IsIncremental = 1

Delete History Agent
--------------------

The agent calls spMFDeleteHistory and is set to run once a month to
delete history older than 90 days. By default this job is not set to active on installation.

The following tables are included in the deletion:

-  MFLog
-  MFUpdateHistory
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

Sometimes it is necessary to ensure a job is completed before
it is proccessed again, or to check if a agent is running before a procedure
is executed. The following provides more details to assist with this
consideration.

.. toctree::
   :maxdepth: 1

   view-running-agent-job/index
   agent-job-wait-status/index
