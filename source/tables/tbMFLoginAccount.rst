
==============
MFLoginAccount
==============

Columns
=======

ID int (primarykey, not null)
  SQL primary key
AccountName nvarchar(250) (not null)
  Full name of account (e.g. domain\username)
UserName nvarchar(250) (not null)
  Name user sign in with
MFID int
  M-Files internal ID for user
FullName nvarchar(250)
  Given full name in login account properties
AccountType nvarchar(250)
  M-Files or Windows account
DomainName nvarchar(250)
  Domain if windows user account type
EmailAddress nvarchar(250)
  Email in login account properties
LicenseType nvarchar(250)
  Named, concurrent, read only, none
Enabled bit
  1 = enabled
Deleted bit
  1 = deleted in M-Files

Additional Info
===============

The MFLoginAccount will only include objects related to the vault. It does not include all the login accounts on the server.

Relation
========

MFContextMenu columns Last_excecuted_by and ActionUser_ID? relates to MFID in this table

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
2019-09-07  JC         Added documentation
2017-08-22  LC         Add MFID as a column to the table
2016-02-20  LC         Create table
==========  =========  ========================================================

