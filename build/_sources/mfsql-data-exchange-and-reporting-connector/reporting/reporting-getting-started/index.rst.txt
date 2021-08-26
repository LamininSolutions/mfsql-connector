Reporting - getting started
===========================

Rapidly start-up the Connector for Reporting. Follow the link for a step by step guide of getting
started https://m-files.lamininsolutions.com/SharedLinks.aspx?accesskey=0563f41dc90d10648755e4b05f9629b51316d756c32b4cc7e20a6fe2090cdc07&VaultGUID=8775C4C3-A206-4CA0-BD0B-C795800F3DF7

Use the Whitepaper https://m-files.lamininsolutions.com/SharedLinks.aspx?accesskey=1ff4e19514215d568f95a63dabc80f0d2df9a74cf250700cbb04221953b65166&VaultGUID=8775C4C3-A206-4CA0-BD0B-C795800F3DF7
 to get an overview the MFSQL Connector for reporting.

In simple terms, the following procedures will get you going with reporting in a few steps.

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
