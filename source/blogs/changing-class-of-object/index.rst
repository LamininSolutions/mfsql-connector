Changing the class of an object
===============================

Sometimes a class of and object need to be changed.  In some cases the change is made in M-Files when the metadata of a document is updated.
In other use cases it my be necessary to change the class of a number of records in bulk as part of data cleansing.

Ad hoc changes of the class in M-Files
--------------------------------------

Special considerations applies when a class is included in MFSQL Connector and users change the class of the document.  The expectation is that the document should be removed from the class table if the record was previously updated into the table and now it does not belong the particular class.

The standard update procedures will detect the 'new' object in the destination class and update the other class table if it included in MFSQL Connector.

However, the standard incremental update procedures will not remove the item from the old class table unless the update procedures are set to perform a full update.

The following procedure parameters will remove the records no longer belonging to the class.

.. code:: sql

    DECLARE @ProcessBatch_ID3 INT;
    EXEC dbo.spMFUpdateAllncludedInAppTables @UpdateMethod = 1,
    @RemoveDeleted = 1,
    @IsIncremental = 0,
    @ProcessBatch_ID = @ProcessBatch_ID3 OUTPUT,
    @Debug = 0

    --or
    EXEC spMFUpdateAllncludedInAppTables 1,1,0

Note that IsIncremental is set to 0.

.. code:: sql

    DECLARE @MFLastUpdateDate SMALLDATETIME,
    @Update_IDOut         INT,
    @ProcessBatch_ID      INT;
    EXEC dbo.spMFUpdateMFilesToMFSQL @MFTableName = 'Table name',
    @MFLastUpdateDate = @MFLastUpdateDate OUTPUT,
    @UpdateTypeID = 0,
    @debug = 0

    --or
    Exec spMFUpdateMFilesToMFSQL @MFTableName ='tablename', @UpdateTypeID = 0

  Note that UpdateTypeID is set to 0.

  It is recommended to use spMFUpdateAllncludedInAppTables with the parameters set as above as the overnight update agent procedure when documents are regularly changing class in M-Files.

Change the class in bulk
------------------------

Using MFSQL Connector for data cleansing or metadata alignment sometimes require the change of class.  This can be done using SQL to make the class change and to update the records into M-Files.  The standard update procedures will automatically remove the object from the source class and add the record to the target class.  Using the following procedure will accomplish this task.

Before running the procedure below, the record in the class table must be updated by setting process_ID = 1 and the Class_ID to the new class MFID.  The target MFID for the new class can be obtained in the table MFClass.  Any other updates to the record can be performed at the same time.

.. code:: sql

    Exec spMFUpdateTable @MFTableName = 'Table name',
    @UpdateMethod = 0

    --or
    Exec spMFUpdateTable 'Table Name',0

Use the following procedure when a large number of updates must be processed in batch

.. code:: sql

    EXEC dbo.spMFUpdateTableinBatches @MFTableName = 'Table name',
    @UpdateMethod = 0,
    @WithStats = 1
