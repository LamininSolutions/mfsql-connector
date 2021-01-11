Create new class table
======================

A new class table for a class object (e.g. Customer) can be created using the Connector with :doc:`/procedures/spMFCreateTable`

Insert a new record in a class table and ensure that the minimum requirements for columns are met.

=================== ==========================================================================================================================
Column              default value
=================== ==========================================================================================================================
Process_ID          1
Valuelistitem \_ ID It is only necessary to include the MFID of the valuelistitem. There is no need to include the label of the valuelistitem.
Required properties Columns related to required properties must have data
Dependencies        If the property has scripting, automation or concatenation then the columns for all the dependent properties have data
=================== ==========================================================================================================================

The following select statement will show the required properties of a specific class

..code:: SQL

      SELECT mfms.TableName,
      mfms.ColumnName
      FROM dbo.MFvwMetadataStructure AS mfms
      WHERE mfms.Required = 1
      AND mfms.Property_MFID > 100
      ORDER BY mfms.Class;
