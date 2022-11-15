
=========================
SpmfSetAdditionalProperty
=========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @MFTableName
    - Valid Class TableName as a string, comma delimited string is allowed
    - Pass the class table name, e.g.: 'MFCustomer'
  @MFProperty
    - Valid Property Name as a string, comma delimited string is allowed    
  @RetainIfNull (bit)
    - set to 1 to retain the property on the metadata card, even if null
    - default = 0
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

To change the behaviour of updating an additional property when the property value is null.

Additional Info
===============

By default, a property that is not defined on the metadata card will be not be added, or removed if the value of the property is null
When the property is set to retain if null, then the property will be updated and set on the metadata card, even if null

Properties defined on the metadata card will always be retained on the metadata card, even if they are null

To remove a property that is defined as an additional property, or changed from being on the metadata card, to not being on the metadata card, the following steps should be followed
 - After a change to the metadata definition, the procedure spMFDropAndUpdateMetadata must be run before an update is process from SQL to MF.
 - Ensure that the value of the property is null in the class table. Follow the instructions below in a case where the value is not null, and the property should be set to null and then removed.
 - Set the property definition for the class to not retain the property if null using this procudure. Note that the setting is by default set to 0.
 - Process an update to the object by setting the process_id = 1. Other updates to the class table is optional. When spmfUpdateTable is used to perform the update, the additional property should be removed from the metadata card.

To remove a property that is defined as an additional property with a current value that need to be removed from the metadata card of of the object. or changed from being on the metadata card, to not being on the metadata card, the steps to follow is slightly different from the above.
 - Before running spMFDropAndUpdateMetadata, first execute his procedure to set the property to retain the value if set to null. This step is required to allow for the removal of the value of the property.
 - If the property was removed from the metadata card, the procedure spMFDropAndUpdateMetadata must be run before further processing.
 - Set the value (s) of the property to be removed from the objects to null in SQL and process an update from SQL to MF.  This should set the value on the object to null.
 - Reset the property definition to not retain the property if null using this procudure. 
 - Process another update to the object by setting the process_id = 1. When spmfUpdateTable is used to perform the update, the additional property should be removed from the metadata card.

This procedure can be used to set or reset multiple properties by using a comma delimited string.  Note that all the properies in the list will be set to the same @RetainIfNull parameter.
The procedure can be also be used the set multiple classes by using a comma delimited string in @MFTableName. Note that the same rules will apply for the properties defined in the parameter for all classes.

Prerequisites
=============

Version 4.10.30.74 or higher.

This procedure does not reset the definition of the property in M-Files. Use M-Files admin to redefine the property in M-Files before using this procedure to manipulate the values of the properties.

Warnings
========

The property rule is set by class.  It will apply to all the objects that is included in the update routine. 

Examples
========

.. code:: sql

    exec spmfSetAdditionalProperty 'MFCustomer','Keywords',1  --set to retain null values

    exec spmfSetAdditionalProperty 'MFCustomer','Keywords',0  --reset to remove property if null

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2022-09-20  LC         Create Procedure
==========  =========  ========================================================

