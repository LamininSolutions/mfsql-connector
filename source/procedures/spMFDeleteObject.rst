
================
spMFDeleteObject
================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ObjectTypeId int
    OBJECT Type MFID from MFObjectType
  @objectId int
    Objid of record
  @Output nvarchar(2000) (output)
    Output message
  @DeleteWithDestroy bit (optional)
    - Default = 0
    - 1 = Destroy

Purpose
=======

An object can be deleted from M-Files using the ClassTable by using the spMFDeleteObject procedure. Is it optional to delete or destroy the object in M-Files.

Warnings
========

Note that when a object is deleted it will not show in M-Files but it will still show in the class table. However, in the class table the deleted flag will be set to 1.

Examples
========

.. code:: sql

    DECLARE @return_value int, @Output nvarchar(2000)
    SELECT @Output =N'0'
    EXEC @return_value = [dbo].[spMFDeleteObject]
         @ObjectTypeId =128,-- OBJECT MFID
         @objectId =4700,-- Objid of record
         @Output = @Output OUTPUT,
         @DeleteWithDestroy = 0
    SELECT @Output as N'@Output'
    SELECT'Return Value'= @return_value
    SELECT @Output =N'0'
    GO

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2019-08-20  LC         Expand routine to respond to output and remove object from change history
2019-08-13  DEV2       Added objversion to delete particular version.
2018-08-03  LC         Suppress SQL error when no object in MF found
2016-09-26  DEV2       Removed vault settings parameters and pass them as comma separated string in @VaultSettings parameter.
2016-08-22  LC         Update settings index
2016-08-14  LC         Add objid to output message
==========  =========  ========================================================

