
===============
spMFGetLicense
===============

Return
  - 1 = Success
  - -1 = Error

Parameters
  @ModuleID nvarchar(10)
   input module to check
  @ExpiryDate datetime output
    output expiry date
    null of not exist
  @CheckStatus int output
    output precheck status
  @Status nvarchar(100) output
    output text for status
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

This is a internal procedure
Procedure is used as part of the license validation routine called by spMFCheckLicenseStatus
Execute spMFValidateModule and return the interpreted result

Examples
========

.. code:: sql

    DECLARE @ExpiryDate DATETIME,
    @Errorcode      NVARCHAR(10),
    @CheckStatus    INT,
    @Status         NVARCHAR(100);

    EXEC dbo.spMFGetLicense @ModuleID = 1,
    @ExpiryDate = @ExpiryDate OUTPUT,
    @Errorcode = @Errorcode OUTPUT,
    @CheckStatus = @CheckStatus OUTPUT,
    @Status = @Status OUTPUT,
    @Debug = 0;

    SELECT @ExpiryDate ExpiryDate,
    @Errorcode     Errorcode,
    @CheckStatus   Checkstatus,
    @Status        Status;

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-04-08  LC         Add check to validate connection
2021-01-06  LC         Fix bug with checking module 2 license
2020-12-04  LC         Create procedure to aid spMFChecklicense status
==========  =========  ========================================================

