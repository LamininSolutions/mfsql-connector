
/*
LESSON NOTES

This example show how to to create a comment for an individual object and to create the same comment for multiple objects.

to delete a comment the individual object version where the comment was created must be deleted

To get all the comments in SQL use the spmfGetChangeHistory procedure and join with the class table.

Note these examples apply from version 4.4.14.55

All examples use the Sample Vault as a base

Consult the guide for more detail on the use of the procedures https:\\doc.lamininsolutions.com
*/

--Adding comments in bulk: set process_id on the class objects to be included in the comment. Use any process_id excluding 1-4.

UPDATE [dbo].[MFCustomer]
SET process_id = 5
WHERE id IN (1,3,6,9)

DECLARE @Comment NVARCHAR(100)

SET @Comment = 'Added a comment 2 for illustration '

EXEC [dbo].[spMFAddCommentForObjects]
    @MFTableName = 'MFCustomer',
	@Process_id = 5,
    @Comment = @Comment ,
    @Debug = 101


--Add an individual comment

--The comments column is not automatially created on all classes when the class table is created.  The column can be added manually.

--the column name can be found in MFProperty for MFID = 33
SELECT ColumnName FROM MFProperty WHERE mfid = 33

ALTER TABLE dbo.MFCustomer
 ADD Comment NVARCHAR(8000)

--the comment for an individaul object can be added by updating the comment column in the class table and processing a standard update statement

UPDATE t
SET t.Process_ID = 1, Comment = 'This is an individual comment'
FROM MFCustomer t WHERE id = 7

EXEC spmfupdatetable 'MFCustomer',0

-- to get all the comments on an object

UPDATE t 
SET process_id = 5
FROM MFcustomer t WHERE id = 7

DECLARE @Update_ID INT,
        @ProcessBatch_id INT;
EXEC dbo.spMFGetHistory @MFTableName = N'MFCustomer',                         -- nvarchar(128)
                        @Process_id = 5,                            -- int
                        @ColumnNames = N'Comment',
						@IsFullHistory = 1

SELECT moch.Property_Value FROM dbo.MFObjectChangeHistory AS moch
INNER JOIN MFCustomer t
ON t.ObjID = moch.objid AND t.Class_ID = moch.Class_ID
WHERE moch.Property_ID = 33


