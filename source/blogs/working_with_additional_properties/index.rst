Working with Additional Properties
===================================

M-files allows users to add a property to a metadata card without defining the property in the class.  It is also possible to add properties using actions and rules defined on workflows, metadata card configuration or other similar methods.

When a new property is added to a class and the property is assigned a value on at least one object, MFSQL connector will automatically add the column to the class table when updating from M-Files to SQL.  The column is added to the end of the class table.  If the property is a lookup then both the label and the id column of the property will be added. However, if it is a new property in M-Files, the procedure :doc:`/procedures/spMFDropAndUpdateMetadata.html` must be run before updating the class with spMFupdatetable or one of its derivatives.

The procedure spMFDropAndUpdateMetadata can be built into your custom update procedure to check for any configuration changes before table updates are being performed. Including this routine in your custom procedure will have limited performance impact if no configuration changes have taken place, however, when a configuration change is detected, it could add a significant delay to the processing of the custom procedure.

It is also possible to check for additional properties on a class table with :doc:`/procedures/spMFClassTableColumns.html`.  Check the documentation of this procedure for all the different uses of this routine.

When a property, previous defined in M-Files as part of the metadata card, is removed from the definition and the property has values on at leastone object, then the values of the property will be retained on the metadata card (with a x next to the property to indicate it is additional) and the values will also continue to exist on the class table of the Connector.  This may give rise to the need to remove the unwanted properties from M-Files.  The procedure :doc:`/procedures/spMFDeleteAdhocProperty.html` is designed to assist with removing some or all of the values, and remove the column from the class.
When an update is performed from SQL to M-Files with the Connector then any values in the additional property columns will be added to the object in M-Files.  If the value is null and no further configuration is performed in the Connector, then the property will be maintained on the metadata card with a null value.   In some cases, additional properties should only appear on the metadata card if it has a value.  This can be achieved by configuring the property in the :doc:`/tables/tbMFClassProperty.html` table to not retain the property if is it null.  The procedure :doc:`/procedures/spMFSetAdditionalProperty.html` is used to configure this.


