License validity check
======================

From version 4.4.13.53 the licensing module includes additional
refinements.

The license check no longer connects to M-Files for each process. It
cycles through to update the validity occasionally and maintain the
license check within SQL which significantly reduces the performance
load on M-Files, especially for large scale updates.

When the expiry date of the license reaches 30 days before expiry and
email will be send once a day to warn of the eminent expiry. The
notifications are also updated in the MFLog table.

The license can be renewed ahead of the expiry date to avoid running out
by contacting your reseller.

After the license has been updated, the following procedure will force
check the license and cancel the expiry notification.

.. code:: sql

    EXEC [dbo].[spMFCheckLicenseStatus] @InternalProcedureName = 'spMFGetclass' -- nvarchar(500)
                                       ,@ProcedureName = 'test'        -- nvarchar(500)
                                       ,@ProcedureStep = 'test'         -- sysname
                                       ,@ExpiryNotification = 30    -- int
                                       ,@IsLicenseUpdate = 1
                                       ,@Debug = 1                 -- int

Processing will fail when the license is invalid for the process in the
modules included in the license.
