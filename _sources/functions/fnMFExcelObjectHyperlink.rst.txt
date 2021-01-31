
========================
fnMFExcelObjectHyperlink
========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName nvarchar(100)
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
  @MFObject\_MFID int (required)
    the objid column in the class table
  @ObjectGUID nvarchar(50) (required)
    the GUID column in the class table
  @HyperLinkType int
    1 = Desktop show
    2 = Web App
  @ReferenceColumn nvarchar(100)
   the column in the class table to be used as the label for the link (e.g. name_or_title)

Purpose
=======

Show a M-Files Object Hyperlink specifically formatted as a link in a excel spreadsheet
Use this function in the select statement for a view that is used in excel.

Additional Info
===============

The reference column is used to set the display of the link in excel to show this column, instead of the link.

Examples
========

.. code:: sql

   --desktop - show (option 1)
   select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],1) from [dbo].[MFAccount] AS mc

   --web (option 2)
   select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],2) from [dbo].[MFAccount] AS mc


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

