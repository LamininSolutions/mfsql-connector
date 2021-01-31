
===================================
spMFUpdateTableWithLastModifiedDate
===================================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @TableName sysname
    fixme description
  @UpdateMethod int
    fixme description
  @Return\_LastModified datetime (output)
    fixme description
  @Update\_IDOut int (output)
    fixme description
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @debug smallint
    fixme description

Purpose
=======
Procedure that update MF Class table using the last MFUpdate date and returning the new last Update date

Examples
========

.. code:: sql

    DECLARE @last_Modified datetime
    EXEC spMFUpdateTableWithLastModifiedDate
                @UpdateMethod = 1,
                @TableName = 'MFSOInvoiced',
                @Return_LastModified = @last_Modified output
    SELECT @last_Modified

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2019-07-07  LC         Change sequnce of paramters, add new method to include updating deletions.
2018-10-22  LC         Add 1 second to last modified data to avoid reprocessing the last record.
2018-10-22  LC         Modify logtext description to align with reporting
2017-11-23  LC         LastModified column name date localization
2017-06-30  AC         Update Logging to make use of new @ProcessBatchDetail_ID to calculate duration
2017-06-30  AC         Update Logging of MFLastModifiedDate as a Column and Value pair
2017-06-30  AC         Update LogStatusDetail to be consisted with convention of using Started and Completed as the status descriptions
2017-06-29  AC         Fix bug introduced by fix of Bug #1049
2016-10-08  LC         Fix bug with null values
2016-08-25  LC         Add the Update_ID from UpdateTable as an output on this procedure also to pass it through
==========  =========  ========================================================

