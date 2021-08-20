
======================
spMFProcessBatch_Mail
======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ProcessBatch_ID (Required)
    - Referencing the ID of :doc:`/tables/tbMFProcessBatch` to be included in the email
  @RecipientEmail (Optional)
    - If not provided will look for MFSettings setting Name = 'SupportEMailProfile'
  @RecipientFromMFSettingName (Optional)
    - if provided the setting will be looked up from MFSettings and added to the provided RecipientEmail if it too was provided.
  @ContextMenu_ID (Optional)
    - Will lookup recipient e-mail based on UserId of Context Menu [Last Executed By]
  @DetailLevel (Optional)
    - Default(0) - Summary Only
    - 1 Include MFProcessBatchDetail for LogTypes in @LogTypes
  @LogTypes (Optional)
    - If provided along with DetailLevel=2, the LogTypes provided in CSV format will be included in the e-mail 
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

To email MFProcessBatch and MFPRocessBatch_Detail along with error checking results from spMFCreateTableStats

Additional Info
===============

This procedures calls :doc:`/procedures/spMFResultMessageForUI`. The latter procedure formats the email body.

Setting the Detail level to 1 and defining the logTypes to 'Status' show extended details for processing.

Prerequisites
=============

When DetailLevel is set to 1 then logtype need to be specified.

Examples
========

Show the Records in MFProcessBatch and MFProcessBatchDetail 

.. code:: sql

    SELECT * FROM dbo.MFProcessBatch AS mpb
    INNER JOIN dbo.MFProcessBatchDetail AS mpbd
    ON mpbd.ProcessBatch_ID = mpb.ProcessBatch_ID
    WHERE mpb.ProcessBatch_ID = 3

Email with summary detail sent to email defined in MFSettings SupportEMailProfile

.. code:: sql

    EXEC spMFProcessBatch_EMail 
    @ProcessBatch_id = 191,
	@Debug = 0

Email with more detail on the processing steps

.. code:: sql

    EXEC spMFProcessBatch_EMail 
    @ProcessBatch_id = 191,
    @DetailLevel = 1,
    @Logtypes = 'Status',
	@Debug = 0
  
Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-02-25  LC         Showing processbatch detail with 
2017-12-28  LC         Allow for messages with detail from ProcessBatchDetail
2017-11-24  LC         Fix issue with getting name of MFContextMenu user
2017-10-03  LC         Add parameter for Detaillevel, but not yet activate.  Add selection of ContextMenu user as email address.
2017-02-01  AC         Create procedure
==========  =========  ========================================================

