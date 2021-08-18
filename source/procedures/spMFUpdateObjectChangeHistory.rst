
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
  - Default = 1 (yes)  

  @Objids nvarchar(4000)
  - comma delimited list of objids to be included 
  - if null then all objids for the class is included

  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

To process change history for a single or all class tables and property combinations 

Additional Info
===============

Update MFObjectChangeHistoryUpdatecontrol for each class and property to be included in the update. Use separate rows for for each property to be included. A class may have multiple rows if multiple properties are to be processed for the tables.

The routine is designed to get the last updated date for the property and the class from the MFObjectChangeHistory table. The next update will only update records after this date.

Delete the records for the class and the property to reset the records in the table MFObjectChangeHistory or to force updates prior to the last update date

This procedure is included in spMFUpdateMFilesToSQL and spMFUpdateAllIncludedInAppTables routines.  This allows for scheduling these procedures in an agent or another procedure to ensure that all the updates in the App is included.  

spMFUpdateObjectChangeHistory can be run on its own, either by calling it using the Context menu Actions, or any other method.

Prerequisites
=============

The table MFObjectChangeHistoryUpdatecontrol must be updated before this procedure will work

Include this procedure in an agent to schedule to update.

Warnings
========

Do not specify more than one property for a single update, rather specify a separate row for each property.

Examples
========

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

----updating a class table for specific objids

.. code:: sql

    exec spMFUpdateObjectChangeHistory @MFTableName = 'MFCustomer', @WithClassTableUpdate = 1, @ObjIDs = '1,2,3', @Debug = 0

----updating all class tables (including updating the class table)

.. code:: sql

    exec spMFUpdateObjectChangeHistory @MFTableName = null, @WithClassTableUpdate = 1, @ObjIDs = null, @Debug = 0

    or

    exec spMFUpdateObjectChangeHistory 
    @WithClassTableUpdate = 0, 
    @Debug = 0

    
Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-04-02  LC         Add parameter for IsFullHistory
2020-06-26  LC         added additional exception management
2020-05-06  LC         Validate the column in control table
2020-03-06  LC         Add MFTableName and objids - run per table
2019-11-04  LC         Create procedure

==========  =========  ========================================================

