
=====================================
spMFUpdateTable_ObjIDs_GetGroupedList
=====================================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ObjIds\_FieldLenth smallint
    Indicate the size of each group iteration CSV text field
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

The purpose of this procedure is to group source records into batches and compile a list of OBJIDs in CSV format to pass to spMFUpdateTable

Examples
========

.. code:: sql

    IF OBJECT_ID('tempdb..#ObjIdList') IS NOT NULL DROP TABLE #ObjIdList;
    CREATE TABLE #ObjIdList ( [ObjId] INT  PRIMARY KEY )

    INSERT #ObjIdList ( ObjId )
    SELECT ObjID
    FROM CLGLChart

    EXEC spMFUpdateTable_ObjIDS_GetGroupedList

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-04-08  LC         Resolve issue with #objidlist not exist 
2019-08-30  JC         Added documentation
2017-06-08  AC         Change default size of @ObjIds_FieldLenth 
==========  =========  ========================================================

