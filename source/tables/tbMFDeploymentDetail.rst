
==================
MFDeploymentDetail
==================

Columns
=======

ID int (primarykey, not null)
  SQL Primary Key
LSWrapperVersion nvarchar(100)
  LS wrapper version
MFilesAPIVersion nvarchar(100)
  M-Files API version
DeployedBy nvarchar(250)
  Who deployed the connector
DeployedOn datetime
  When was the connector deployed

Additional Info
===============

This table is maintained by the connector.

Used By
=======

- spMFDeploymentDetails


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-09-07  JC         Added documentation
==========  =========  ========================================================

