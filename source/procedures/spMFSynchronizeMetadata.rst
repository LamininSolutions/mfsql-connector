
=======================
spMFSynchronizeMetadata
=======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode


Purpose
=======
To pull M-Files Metadata during initialisation of MFSQL Connector

Prerequisites
=============
Vault connection is valid

Warnings
========
Custom settings in the metadata structure tables such as tablename and columnname will not be retained

Examples
========

.. code:: sql

    EXEC [dbo].[spMFSynchronizeMetadata]

----

.. code:: sql

    DECLARE @return_value int
    EXEC    @return_value = [dbo].[spMFSynchronizeMetadata]
            @Debug = 0
    SELECT  'Return Value' = @return_value
    GO

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2018-11-15  LC         Fix processbatch_ID logging
2018-07-25  LC         Auto create MFUserMessages
2018-04-30  LC         Add to MFUserMessage
2017-08-22  LC         Improve logging
2017-08-22  LC         Change processBatch_ID to output param
2016-09-26  DEV2       Removed Vaultsettings parametes and pass them as comma separated string in @VaultSettings parameter
2016-08-22  LC         Change settings index
2015-05-25  DEV2       UserAccount and Login account is added
==========  =========  ========================================================

