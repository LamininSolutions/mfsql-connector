
======================
spMFCheckLicenseStatus
======================

Return
  - 1 = Success
  - 0 = Error
Parameters
  @InternalprocedureName
    - Procedure to be checked. Default is set to check for a module 1 procedure.
  @ProcedureName
    Procedure from where the check is performed. Default is set to 'Test'
  @ProcedureStep
    Procedure step for checking the license. Default is set to 'Validate Connection'
  @ExpiryNotification
    Default set to 30
    Sets the number of days prior to the license expiry for triggering notification
  @IsLicenseUpdate
    Default = 0
    Set to 1 to force a license update, especially after installing a new license file
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode. Will show additional licensing information.

Purpose
=======

The procedure performs a check of the license for a specific procedure. The license is controlled by vault application framework.

Additional Info
===============

The license will be checked on the M-Files server once a day.  The validity is based on the allocation of the procedure to a specific module.

Examples
========

Check the license for a specific procedure

.. code:: sql

    DECLARE @rt int
    EXEC @rt = [dbo].[spMFCheckLicenseStatus] @Debug = 0
    Select @rt

    --or, for more detail feedback

     DECLARE @rt int
    EXEC @rt = [dbo].[spMFCheckLicenseStatus] @Debug = 1
    Select @rt

----

Updating the license after installing the renewal in the vault application.  

.. code:: sql

    EXEC [dbo].[spMFCheckLicenseStatus] @IsLicenseUpdate = 1
                                   ,@Debug = 1 

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-03-15  LC         Set default schema for MFmodule
2021-01-06  LC         Debug module 2 license
2020-12-31  LC         update message for license expired
2020-12-05  LC         Rework core logic and introduce new supporting procedure
2020-12-03  LC         Improve error messages when license is invalid
2020-12-03  LC         Set additional defaults
2020-06-19  LC         Set module to 1 when null or 0
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

