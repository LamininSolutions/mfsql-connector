
==================
spMFUnDeleteObject
==================

Return
  - 1 = Success object undeleted
  - 2 =	Failed to undelete, object not found
  - -1 = SQL Error

Parameters
  @MFtableName nvarchar(128)
    Class table name
  @ObjID int
    Objid to undelete
  @RetainDeletions bit
    Default = 0 (will not retain deletions in the class table)
    Set to 1 if the deleted records are maintained in the class table
  @Output nvarchar(2000) (output)
    Output message
  @Update_ID Output
    - ID of the record in the MFUpdateHistory table
  @ProcessBatch_ID Output
    -ID of the record in the MFProcessBatch table
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

An object can be undeleted from M-Files using the ClassTable by using the spMFUnDeleteObject procedure. Is it optional to undelete the object in M-Files.


Warnings
========

To undelete an object the object must be deleted.

Examples
========

.. code:: sql

      DECLARE @Output NVARCHAR(2000),
      @ProcessBatch_ID INT;
      EXEC dbo.spMFUnDeleteObject @ObjectTypeId = 0,
                            @objectId = 139
                            @Output = @Output OUTPUT,
                            @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
                            @Debug = 1

                            SELECT @output

     SELECT @rt, @update_ID, @ProcessBatch_ID1
     SELECT * FROM dbo.MFUpdateHistory AS muh WHERE id = @update_ID
     SELECT * FROM dbo.MFProcessBatch AS mpb WHERE mpb.ProcessBatch_ID = @ProcessBatch_ID1
     SELECT * FROM dbo.MFProcessBatchDetail AS mpb WHERE mpb.ProcessBatch_ID = @ProcessBatch_ID1


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2022-02-09  LC         Create new  procedure and assembly method
==========  =========  ========================================================

