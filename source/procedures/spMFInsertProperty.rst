
==================
spMFInsertProperty
==================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Doc nvarchar(max)
    input XML
  @isFullUpdate bit
    When set to 1 is update of all properties
  @Output nvarchar(50) (output)
    return message
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

Insert Property details into MFProperty table. This procedure is used as part of the metadata structure update and is not used on its own.

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2018-11-04  LC         Enhancement to deal with changes in datatype
2017-12-28  DEV2       Change join condition at #1162
2017-11-30  LC         Remove duplicate _ID from State_ID
2017-11-23  LC         Localization of last modifed columns
2017-09-11  LC         Update constraints
2017-08-22  LC         Improve logging
2017-08-22  LC         Fix bug with contstraints
2015-07-14  DEV2       MFValuelist_ID column Added in MFProperty
2015-05-27  DEV2       New logic for inserting details from M-Files as per LeRoux
2015-05-15  DEV2       Checking for duplicate ColumnName and auto renaming if exists
==========  =========  ========================================================

