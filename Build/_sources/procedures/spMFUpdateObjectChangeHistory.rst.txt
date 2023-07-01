
=============================
spMFUpdateObjectChangeHistory
=============================

Return
  - 1 = Success
  - -1 = Error

  @MFTableName nvarchar(200)
  Class table name to be updated
  If null then all class tables in MFObjectChangeHistoryUpdateControl table is included.

  @WithClassTableUpdate int
  - Default = 0 (No)
  - The expectation is that the update history will run just after the class table was updated 

  @Objids nvarchar(4000)
  - comma delimited list of objids to be included 
  - if null then all objids for the class is included
  - can only be used in conjunction with a specific class table.

  @IsFullHistory int
   - default = 0 (no).  The history will be updated from the last transaction date for the property of the class
   - if set the full history then all the versions will be updated with a start date from 2020-01-01

  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

To process change history for a single or all class tables and properties as set in the MFObjectChangeHistoryUpdateControl table. 

Additional Info
===============

The procedure allows for three modes of operation:
  - specific objects defined as a comma delimited string of objid's. This only applies to a single table. 
  - pre selected objects, by setting the process_id on the class to 5 prior to running this procedure. All the properties specified in the control table will be updated.
  - for all objects in the class, by not setting the process_id in the class and setting @objids to null. All the properties specified in the control table will be updated.

For each mode there are various options available:
  - For all tables specified in the control table MFObjectChangeHistoryUpdateControl by setting @MFTableName to null
  - For a specific table
  - to perform a class table update at the same time by setting @WithClassTableUpdate to 1

Finally the update can be done incrementally or in full by setting @IsFullHistory.  

Update MFObjectChangeHistoryUpdatecontrol for each class and property to be included in the update. Use separate rows for for each property to be included. A class may have multiple rows if multiple properties are to be processed for the tables.

The routine is designed to get the last updated date for the property and the class from the MFObjectChangeHistory table. The next update will only update records after this date.

Delete the records for the class and the property to reset the records in the table MFObjectChangeHistory or to force updates prior to the last update date

This procedure is included in spMFUpdateMFilesToSQL and spMFUpdateAllIncludedInAppTables routines.  This allows for scheduling these procedures in an agent or another procedure to ensure that all the updates in the App is included.  

spMFUpdateObjectChangeHistory can be run on its own, either by calling it using the Context menu Actions, or any other method.

Prerequisites
=============

The table MFObjectChangeHistoryUpdatecontrol must be updated before this procedure will work.

This procedures is dependent on the object being present and up to date in the class table.

Include this procedure in an agent to schedule the update.

This procedure use a process_id = 5 internally.  Using 5 as a process id for other purposes may interfere with this procedure.

Examples
========

To insert the values in the control table.

.. code:: sql

	INSERT INTO dbo.MFObjectChangeHistoryUpdateControl
	(
		MFTableName,
		ColumnNames
	)
	VALUES
	(   N'MFCustomer', 
		N'State_ID'  
		),
	(   N'MFPurchaseInvoice', 
		N'State_ID'  
		)

updating a class table for specific objids

.. code:: sql

    exec spMFUpdateObjectChangeHistory @MFTableName = 'MFCustomer', @WithClassTableUpdate = 1, @ObjIDs = '1,2,3', @Debug = 0

----updating all class tables with full update (including updating the class table)

.. code:: sql

    exec spMFUpdateObjectChangeHistory @MFTableName = null, @WithClassTableUpdate = 1, @ObjIDs = null,  @IsFullHistory = 1, @Debug = 0

    or

    exec spMFUpdateObjectChangeHistory 
    @WithClassTableUpdate = 0,
     @IsFullHistory = 0,
    @Debug = 0

    
Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2023-03-21  LC         Remove debugging code
2022-11-30  LC         resolve issue with updates by objid
2021-12-22  LC         Update logging to monitor performance
2021-12-22  LC         Set default for withtableupdate to 0
2021-10-18  LC         The procedure is fundamentally rewritten
2021-04-02  LC         Add parameter for IsFullHistory
2020-06-26  LC         added additional exception management
2020-05-06  LC         Validate the column in control table
2020-03-06  LC         Add MFTableName and objids - run per table
2019-11-04  LC         Create procedure

==========  =========  ========================================================

