
=============
MFUserAccount
=============

Columns
=======

UserID int (primarykey, not null)
  M-Files internal ID for user
LoginName nvarchar(250)
  Name user sign in with
InternalUser bit
  - 1 = Internal user
  - 0 = External user
Enabled bit
  1 = enabled
Deleted bit
  1 = deleted in M-Files

Indexes
=======

idx\_MFUserAccount\_User\_id
  - UserID

Additional Info
===============

The table include only user accounts that is related to the specific vault. 

The vaultroles column show three different types of roles
#. Full control of vault
#. Default roles when no special roles are select
#. Various roles when any special roles are selected. This column does not show the individual special roles of the user

Use spMFSynchronizeSpecificMetadata to update the login account or user
account tables after making changes in M-Files.

Updating is from M-Files to SQL only.? Updating from SQL to M-Files is
currently not allowed.

Relation
========

The MFID on the MFLoginAccount is related to UserID on MFUserAccount

.. code:: sql

         SELECT * FROM [dbo].[MFLoginAccount] AS [mla]
         LEFT JOIN [dbo].[MFUserAccount] AS [mua]
         ON mla.mfid = mua.[UserID]

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2023-11-30  LC         Fix incorrect default value and upgrade to include vault roles
2023-06-30  LC         Add vaultroles column
2019-09-07  JC         Added documentation
==========  =========  ========================================================

