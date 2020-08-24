====================================
Upgrading version 4.8.22.62 or later
====================================

Deleted objects
===============

Deleted objects can be shown in the class table.  By default, the procedure spmfUpdateTable will remove the deleted objects from the class table.  By setting the parameter @RetainDeletions = 1, the deleted records will be included in class table. Refer to Considerations for deleted objects for more detail about this functionality.

Prior to version 4.8.22.62 deleted objects are indicated in column 'Deleted' with a '1' in the column.
From version 4.8.22.62 the class table will include the property 27 'Deleted' as a datetime column. Note that the column will reflect the name of the property in the localised language.  When the column is null, the object is not deleted. The datetime in the column reflects the deletion time.

On updating to version 4.8.22.62 or later from a prior version, it is necessary to run an update to remove the old 'Deleted' column and add the new 'Property 27' column.  The deleted records will be shown as deleted after the next full update of the records in the class.
The update must be run manually as the first action after the upgrade.  They update is in the installation files.  There may be occasions where your application has custom constraints, statistics that will interfere with this update.  When the update show an error then manually delete the custom dependencies.  The update can be run multiple times until no further errors are reported.

C:\Program Files (x86)\Laminin Solutions\MFSQL Connector Release 4\[DatabaseName]\Database Scripts\V4.8.22.62\05_Updates_V4.8.22.62.sql

In cases where custom views or procedures includes conditions to include or exclude records based on the deletion status, you will have to make manual changes to the code.
The best method is to search on the term 'Deleted'.  Replace the condition deleted = 0 with deleted is null; and deleted = 1 with deleted is not null.

Other changes from version 4.8.22.62 related to changing the approach to reflecting deletions include:
a) MFUpdateHistory deleted column is redundant as the records are now included in column NewOrUpdatedObjectDetails.
b) NewOrUpdatedObjectDetails column has new details of each object: Deleted = "true" is shown when record is deleted. At the same time the Status = '3' for deleted records.
c) When a deleted record in the class table is marked for deletion with spMFDeleteObjectList the record will be removed from the class table.  
d) The procedure spmfGetDeletedObjects is redundant and has been removed. spMFGetObjectVer, spMFTableAudit, or spMFObjectTypeUpdateClassIndex can be used instead.
e) Using spmUpdateAllIncludeinAppTables has a switch to retain deleted records in the class tables. By default it is set to not retain deleted records.
f) spMFUpdateMFilestoMFSQL and spmfUpdateTableInBatches both allows for specifying to retain deletions in the class table. By default it is set to 'No'
g) To delete and object in M-Files from SQL, the procedure spMFDeleteObjectList (or spMFDeleteObject) must be used. The functionality does not provide for setting the process_id = 1 on the class table and to set a delete date.  


To switch from not showing deletions to deletions, it would be necessary to re-run a full update of the class table.

   DECLARE @MFLastUpdateDate SMALLDATETIME,
        @Update_IDOut        INT,
        @ProcessBatch_ID      INT;
    
    EXEC dbo.spMFUpdateMFilesToMFSQL @MFTableName = 'ClassTable',
        @MFLastUpdateDate = @MFLastUpdateDate OUTPUT,
        @UpdateTypeID = 0,
        @MaxObjects = 100000,
	    @RetainDeletions = 1,
        @Update_IDOut = @Update_IDOut OUTPUT,
        @ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
        @debug = 0


