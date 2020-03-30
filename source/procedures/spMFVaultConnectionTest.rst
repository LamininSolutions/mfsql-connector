
=======================
spMFVaultConnectionTest
=======================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @IsSilent
    - Default = 0 : the procedure will display the result
    - Set to 1 if the connection test is used as part of a procedure.
  @MessageOut Output
    - Show the result of the test

Purpose
=======

Procedure to perform a test on the vault connection

Additional Info
===============

Performs a variety of tests when executed. These tests include

#. Validate login credentials

#. Validate the M-Files version for the assemblies

#. Validate license

Examples
========

.. code:: sql

    DECLARE @MessageOut NVARCHAR(250);
    EXEC dbo.spMFVaultConnectionTest @IsSilent = 0,
    @MessageOut = @MessageOut OUTPUT

----

.. code:: sql

   EXEC dbo.spMFVaultConnectionTest

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-03-29  LC         Add documentation 
2020-02-08  LC         Fix bug for check license validation
2016-08-15  DEV1       Create procedure
==========  =========  ========================================================

