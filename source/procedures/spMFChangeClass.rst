   
===============
spMFChangeClass   
===============
   
Return
- 1 = Success
- -1 = Error

Parameters
    @MFTableName
    - Valid Class TableName as a string
    - Pass the class table name, e.g.: 'MFCustomer'
    @RetainDeletions bit
    - Default = No
    - Set explicity to 1 if the class table should retain deletions
    @IsDocumentCollection
    - Default = No
    - Set explicitly to 1 if the class table refers to a document collection class table
    @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
    @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode
   
Purpose
=======

The purpose of this procedure is to move the records from one class table to another class table and synxhronize records into M-Files.
   
Additional Info
===============

A prerequisit for running this procedure is to set the new class_ID on the object and set the process_ID = 1 in the table set as @MFTableName.  Then run this procedure.  It will firstly update the records on the source table to M-Files, and then update the records in the destination table from MF to SQL.  Finally, the source table will be updated from MF to SQL to remove the objects where the class was changed.
   
Examples
========
   
.. code:: sql

    DECLARE	@return_value int,
	@ProcessBatch_ID int

    EXEC [dbo].[spMFChangeClass]
		@MFTableName = N'MFCustomer',
		@ProcessBatch_ID = @ProcessBatch_ID OUTPUT,
		@Debug = 0

Changelog
=========
   
==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2022-09-02  LC         Add additional parameters for spmfupdatetable
2020-08-22  LC         Deleted column change
2019-08-30  JC         Added documentation
2017-01-17  LC         Create procedure
==========  =========  ========================================================
   
