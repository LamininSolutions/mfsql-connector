
==========
MFSettings
==========

Columns
=======

ID int (primarykey, not null)
  SQL Primary key
Source_key varchar(20) (null)
  type of setting
Name varchar(50) (not null)
  Setting name
Description nvarchar(500)
  Describing the setting
Value SQL_Variant not null
  Value of setting
Enabled bit not null
  set to 1 to enable setting

Settings sets all the global parameters for the connector. Users can add additional settings for
	special applications but standard settings should not be changed or deleted.


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2016-8-22	lc		   Change primary key to include source_key
2018-4-28	lc		   Add new settings for user messages and vault structure id

==========  =========  ========================================================

