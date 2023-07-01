
===================
MFFileExportControl
===================

Columns
=======

MFID int  not null
  MFID of the Class


Lastmodified datetime
  Show date and time of last  processing entry 

Additional Info
===============

The MFFileExportControl table is used to setup a multi class export of files and monitor the progress of the export.

Used By
=======

- spMFFileExportMultiClass

The following script will add/Update all classes into the table and set them by default to be inactive

INSERT dbo.MFFileExportControl 
(mfid, active)
select mfid, active from (select class as mfid, active = 0 from MFauditHistory h group by class) s
WHERE NOT EXISTS (SELECT MFID FROM dbo.MFFileExportControl t2 WHERE s.mfid = t2.mfid); 

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2023-02-22  LC         Table created
==========  =========  ========================================================

