
==============
MFProtocolType
==============

Columns
=======

ID int (primarykey, not null)
  SQL Primary Key
ProtocolType nvarchar(250)
  MF protocol internal id
MFProtocolTypeValue nvarchar(200)
  Protocol description

Additional Info
===============

Allow for gRPC, HTTPS, IPS and localhost protocol Types and flexible port end points.

Used By
=======

- MFVaultSettings
- MFvwVaultSettings
- spMFVaultConnectionTest
- FnMFVaultSettings


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2022-06-21  LC         Add gRPC
2019-09-07  JC         Added documentation
2016-08-01  DEV        Created procedure
==========  =========  ========================================================

