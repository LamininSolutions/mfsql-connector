Reporting - getting started
===========================

Why use MFSQL Reporting?
------------------------

  - It is simply to setup.  It also provides flexibility to do very involved and complex reporting.
  - Changes in M-Files is refreshed incrementally, providing near real time data access
  - It includes access to the M-Files event log. Report on event logs combined with other M-Files data
  - It allows for interactive reporting. Use interject with MFSQL Connector to view data in excel and perform updates to M-Files directly from excel

Review the `deployment plan <https://m-files.lamininsolutions.com/SharedLinks.aspx?accesskey=0563f41dc90d10648755e4b05f9629b51316d756c32b4cc7e20a6fe2090cdc07&VaultGUID=8775C4C3-A206-4CA0-BD0B-C795800F3DF7>`__
for a step by step guide for deployment.

Read the `whitepaper <https://m-files.lamininsolutions.com/SharedLinks.aspx?accesskey=1ff4e19514215d568f95a63dabc80f0d2df9a74cf250700cbb04221953b65166&VaultGUID=8775C4C3-A206-4CA0-BD0B-C795800F3DF7>`__ to get an overview the MFSQL Connector for reporting.

Best practices and things to think about
----------------------------------------

To get on the spot data or do a few reports, simply follow the step in :doc:`/mfsql-data-exchange-and-reporting-connector/reporting/setup-reporting/index`

For more advanced reporting and to explore the full capabilities of the Connector:

Adding class tables
-----------------------

:doc:`/procedures/spMFSetup_Reporting` can we used at any time to create additional class tables. Note that this procedure will perform a number of operations and will take some time.

Use :doc:`/procedures/spMFCreateTable` to create additional class tables without going through all the sub processes of the setup reporting routine. To create multiple class tables in one go use :doc:`/procedures/spMFCreateAllMFTables`

Keep class tables up to date
-----------------------------------

The procedure :doc:`/procedures/spMFUpdateTable` is useful in the initial stages of exploring the tables, unless the datasets are very large.  In the case of larger than 30 000 objects in a table, we recommend to use :doc:`/procedures/spMFUpdateTableinBatches`.

When scheduling regular updates for an individual class, use :doc:`/procedures/spMFUpdateMFilesToMFSQL`. This can be used for both small and large tables are able to perform both incremental and full updates.  It uses a process to determine only versions that have changed and will do the processing in batches. This allows for updates to run over for multiple hours in the case of large tables.

Scheduling the updates
----------------------

To schedule updates in predetermined intervals for all class tables use :doc:`/procedures/spMFUpdateAllncludedInAppTables`.  For more details on :doc:`/mfsql-data-exchange-and-reporting-connector/working-with-class-tables/automated-update-of-records-from-m-files/index`

Using a separate reporting database
-----------------------------------

building complex views
----------------------

Using the M-Files Event log
---------------------------


Step 1: Setup the class tables for reporting.  In this example three classes will be used for various reports: Customer, Other Document and Purchase invoice.

.. code:: sql

     EXEC dbo.spMFSetup_Reporting @Classes = 'Customer,Other Document, Purchase Invoice',
     @Debug = 0

Step 2: Initialise the class table.  Different procedures should be used if the class tables are large (more than 30 000 records)

.. code:: sql

    DECLARE @ProcessBatch_ID INT;

    EXEC dbo.spMFUpdateAllncludedInAppTables @UpdateMethod = 1,
        @RemoveDeleted = 1,
        @IsIncremental = 0,
        @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
        @Debug = 0

Step 3: Check the result

.. code:: sql

        EXEC dbo.spMFClassTableStats
            @IncludeOutput = 0

Watch the video on the youtube channel <https://www.youtube.com/user/lamininsolutions/videos>
