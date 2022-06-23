
===============================
spMFUpdateAllncludedInAppTables
===============================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @UpdateMethod int
    - Default = 1
  @RemoveDeleted int
    - Default = 1
    - This parameter is redundant
  @IsIncremental int
    - Default = 1 (yes)
	- Set to 0 to perform a full refresh of the AuditHistory for the in app tables
  @RetainDeletions int
    - Default = 0 (n)
	- Set to 1 to retain deletions for all included in app tables
  @IncludeClass varchar
    - Default = '1,2'
    - update the class table with additional groupings using IncludeInApp column and then include the group in this parameter to override the default.
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

The purpose of this procedure is to allow for daily processing of all the class table tables with includedinapp = 1.

Updating the Object Change History, based on the entries in MFObjectChangeHistoryControl is also included in this routine.

This procedure can be used for initializing all the tables or to update only the differential.

Additional Info
===============

To run this procedure for different groupings of class tables, set this up in the MFClass table column IncludeInApp and then set the @IncludeClass to the designated setting in this column to only include tables of the grouping in the update.

Warning
=======

Updatemethod = 0 (From SQL to MF) is no longer a valid option for this procedure. The only valid option is the default (1).

Setting @IsIncremental to 0 and including a large number of tables with a large number of objects could take a considerable time to finish.

Setting the @RetainDeletions = 1 parameter will affect all the class tables.

Examples
========

.. code:: sql

    --example for incremental updates (to be included in agent for daily update)
    DECLARE @ProcessBatch_ID INT;
    EXEC dbo.spMFUpdateAllncludedInAppTables @UpdateMethod = 1,
                                         @RemoveDeleted = 1,
                                         @IsIncremental = 1,
                                         @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                                         @Debug = 0

.. code:: sql

    --example for initating all table - use only when small class tables are involved
    DECLARE @ProcessBatch_ID INT;
    EXEC dbo.spMFUpdateAllncludedInAppTables @UpdateMethod = 1,
                                         @RemoveDeleted = 1,
                                         @IsIncremental = 0,
                                         @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                                         @Debug = 0



Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2022-05-25  LC         Resolve loop bug with updating history
2021-12-20  LC         Add logging to improve performance analysis
2021-12-20  LC         Use same processbatchID for entire process
2021-09-01  LC         add parameter to retain deletions for all tables
2021-08-04  LC         add parameter to allow suppress of control report, default 0
2021-04-01  LC         add control report for updates
2021-03-17  LC         remove step to reset audit history to null if full
2021-03-17  LC         set history update flag to not update if control is empty
2020-06-24  LC         Add additional debugging
2020-06-06  LC         Add exit if unable to connect to vault
2020-03-06  LC         Include spMFUpdateChangeHistory through spMFUpdateMfilestoSQL
2020-03-06  LC         Exclude MFUserMessages
2019-12-10  LC         Functionality extended to intialise all tables
2019-11-04  LC         Include spMFUpdateObjectChangeHistory in this routine
2019-08-30  JC         Added documentation
2018-11-18  LC         Remove duplicat process
2017-08-28  LC         Convert proc to include logging and process batch control
2017-06-09  LC         Change to use spmfupdateMfilestoSQL method
2017-06-09  LC         Set default of updatemethod to 1
2016-09-09  LC         Add return value
2015-07-14  DEV2       Debug mode added
==========  =========  ========================================================

