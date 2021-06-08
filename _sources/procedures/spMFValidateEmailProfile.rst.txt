
========================
spMFValidateEmailProfile
========================

Return
  - 1 = Profile is valid
  - -1 = Profile is invalid and no default profile exists
Parameters
  @emailProfile
   - if null is passed or the value passed in is invalid then the default profile will be returned
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

To validate the email profile or return the default profile from the settings table MFSettings.

Additional info
===============

This procedure will test any profile. if the parameter is null, it would automatically return the default profile, if the paramater is another profile, then it would return the default profile if the parameter profile is invalid, if both parameter profile is invalid and the default profile is invalid, it will return an error.

Examples
========

 .. code:: sql

    exec spmfvalidateEmailProfile 'MailProfile'  

Using a custom profile that is not the default profile

.. code:: sql

    DECLARE @profile NVARCHAR(100) = 'TestProfile'
    EXEC spMFValidateEmailProfile @emailProfile = @profile OUTPUT
    SELECT @profile

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-01-20  LC         Allow for multiple profiles
2017-05-01  LC         Fix validate profile
2016-10-12  LC         Change Settings Name
2016-08-22  LC         update settings index
2015-12-10  AC         Create procedure
==========  =========  ========================================================

