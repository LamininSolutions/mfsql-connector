
======================
spMFCheckLicenseStatus
======================

Return
  - 1 = Success
  - 0 = Error
Parameters
  @InternalprocedureName
    - Procedure to be checked
  @ProcedureName
    Procedure from where the check is performed
  @ProcedureStep
    Procedure step for checking the license
  @ExpiryNotification
    Default to 30
    Sets the number of days prior to the license expiry for triggering notification
  @IsLicenseUpdate
    Default = 0
    Set to 1 to force a license update, especially after installing a new license file
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

The procedure performs a check of the license for a specific procedure. The license is controlled by vault application framework.

Additional Info
===============

The license will be checked on the M-Files server once a day.  The validity is based on the allocation of the procedure to a specific module.

Examples
========

Check the license for a procedure

.. code:: sql

    EXEC [dbo].[spMFCheckLicenseStatus] @InternalProcedureName = 'spMFGetclass' -- nvarchar(500)
                                   ,@ProcedureName = 'test'        -- nvarchar(500)
                                   ,@ProcedureStep = 'test'         -- sysname

----

Force the checking of the  license against the server

.. code:: sql

    EXEC [dbo].[spMFCheckLicenseStatus] @InternalProcedureName = 'spMFGetclass' -- nvarchar(500)
                                   ,@ProcedureName = 'test'        -- nvarchar(500)
                                   ,@ProcedureStep = 'test'         -- sysname
                                   ,@ExpiryNotification = 30    -- int
                                   ,@IsLicenseUpdate = 1
                                   ,@Debug = 1                 -- int

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-10-25  LC         Improve messaging, resolve license check bug
2019-09-21  LC         Parameterise overide to check license on new license install
2019-09-20  LC         Parameterise email notification, send only 1 email a day
2019-09-15  LC         Check MFServer for license once day
2019-09-15  LC         Modify procedure to include expiry notification
2019-09-15  LC         Redo licensing logic, only update license every 10 days
2018-07-09  LC         Change name of MFModule table to MFLicenseModule
2019-01-19  LC         Add return values
2017-04-06  DEV2       Create license check procedure
==========  =========  ========================================================

