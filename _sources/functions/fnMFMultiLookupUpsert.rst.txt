
=====================
fnMFMultiLookupUpsert
=====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ItemList nvarchar(4000)
    comma delimited list of items to add or remove
  @ChangeList nvarchar(4000)
    list to be changed
  @UpdateType smallint
    default = 1 - Add items in @itemlist to @ChangeList
    set to -1 to remove items in @itemlist from @changelist

Purpose
=======

This function is useful when changing the members of a multi lookup property. For example change a list "21,35,707" to "35,30"

Examples
========

.. code:: sql

    --update type 1 : add item in @listitem to @changelist 
    DECLARE @listItem NVARCHAR(4000)
    DECLARE @Changelist NVARCHAR(4000)

    SET @ListItem = '4'
    SET @Changelist = '3,5,8'

   SELECT dbo.fnMFMultiLookupUpsert(@listitem,@Changelist,1)

   GO
   --update type -1 : delete item in @listitem from @changelist
   DECLARE @listItem NVARCHAR(4000)
   DECLARE @Changelist NVARCHAR(4000)

   SET @ListItem = '4'
   SET @Changelist = '4,3,5,8'

   SELECT dbo.fnMFMultiLookupUpsert(@listitem,@Changelist,-1)
   GO

   --this returns the @changelist as the updatetype is not 1 or -1
   DECLARE @listItem NVARCHAR(4000)
   DECLARE @Changelist NVARCHAR(4000)

   SET @ListItem = '6'
   SET @Changelist = '4,3,5,8'

   SELECT dbo.fnMFMultiLookupUpsert(@listitem,@Changelist,0)

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-02-20  LC         Fix bug with delete
2020-02-20  LC         Add script to return changelist of type <> 1 or -1
2020-02-20  LC         Update documentation
2019-08-30  JC         Added documentation
2018-06-28  LC         Create function
==========  =========  ========================================================

