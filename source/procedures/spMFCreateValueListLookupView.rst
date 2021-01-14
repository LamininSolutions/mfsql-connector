
=============================
spMFCreateValueListLookupView
=============================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ValueListName NVARCHAR(128)
    Name of the valuelist
  @ViewName NVARCHAR(128)
    Name of view.  example  'vwCountry'
  @Schema NVARCHAR(20)
    Default = 'dbo'
    We recommend to set it as 'custom'
  @Debug SMALLINT = 0
   - Default = 0
   - 1 = Standard Debug Mode
   - 101 = Advanced Debug Mode

Purpose
=======

To automatically create a view showing all the related columns for the specific valuelist

Additional Info
===============

The view has the following standard columns:
 - Name_ValueListItems : name of the valuelist item
 - MFID_ValueListItems : M-Files internal id of the item
 - DisplayID_ValueListItems : M-files external (visible) id of the item
 - AppRef_ValueListItems : unique reference for item
 - GUID_ValueListItems : GUID if the item
 - OwnerName_ValueListItems : owner valuelist item
 - OwnerMFID_ValueListItems : internal id of owner - default to 0
 - OwnerAppRef_ValueListItems : unique reference for the owner
 - Name_ValueList : name of the valuelist
 - MFID_ValueList : Internal id of valuelist
 - ID_ValueList : SQL ID of the valuelist. This ID joins the valuelist and valuelist item tables
 - OwnerMFID_ValueList : Owner valuelist
 - Deleted : set to 1 if the valuelist item has been deleted
 - Process_ID : default is 0 this is used in processing the valuelist items

Warnings
========

Deleted items are not being pulled into the table when synchronising the valuelist items for the first time.  However, the deleted flag will be updated for items that has been deleted after the initial synchronisation

Examples
========

.. code:: sql

    EXEC dbo.spMFCreateValueListLookupView @ValueListName = 'Country',
    @ViewName = 'vwCountry',
    @Schema = 'custom',
    @Debug = 0

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2018-05-20	LC         Add error check that Valuelist exist
2017-12-10	LC         Add Schema
2017-07-25	AC         Update the join statement to fix error with ownership relationship
2017-05-12	LC         Add deleted = 0 as filter
2015-07-20  DEV2	   New Logic implemented
==========  =========  ========================================================

