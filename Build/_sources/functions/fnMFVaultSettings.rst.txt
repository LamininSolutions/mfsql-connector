
=================
FnMFVaultSettings
=================

Return
  VaultSettings as a string

Purpose
=======

Used to return the vault settings in a string for other procedures

Examples
========

.. code:: sql

    Declare @VaultSettings nvarchar(400)
	SET @VaultSettings = fnMFVaultSettings()

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2016-09-14  DEV2       Initial Version - QA
==========  =========  ========================================================

