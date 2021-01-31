
===================
fnMFObjectHyperlink
===================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName nvarchar(100) (required)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @MFObject\_MFID int (required)
    the objid column in the class table
  @ObjectGUID nvarchar(50) (required)
    the GUID column in the class table
  @HyperLinkType int
    Defaults to type 1
    1 - desktop show
    2 - Web link
    3 - desktop view
    4 - desktop open
    5 - desktop show metadata
    6 - desktop edit

Purpose
=======

Use this function in a select statement to have a M-Files Object Hyperlink with different settings

Examples
========

.. code:: sql

   --desktop - show (option 1)
   select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],1) from [dbo].[MFAccount] AS mc

   --web (option 2)
   select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],2) from [dbo].[MFAccount] AS mc

   --desktop - view (option 3)
   select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],3) from [dbo].[MFAccount] AS mc

   --desktop open (option 4)
   select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],4) from [dbo].[MFAccount] AS mc

   --desktop - show metadata (option 5)
   select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],5) from [dbo].[MFAccount] AS mc

   --desktop - edit (option 6)
   select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],6) from [dbo].[MFAccount] AS mc

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-05-18  LC         Update documentation
2019-08-30  JC         Added documentation
2019-05-15  LC         Update options available
2017-09-05  LC         UPDATE BUG IN URL
==========  =========  ========================================================

