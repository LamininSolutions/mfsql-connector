spMFUpdateClassAndProperties
============================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      The main objective of this procedure is to change the class and/or
      specific properties of a single object.

      Use this procedure to add some additional properties.  Note that a
      class change can also be included.

      After executing this procedure for an object,  the class of the
      object will update with new class in M-Files,  The object will
      delete from current Class Table and insert into the new Class
      Table..

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ========= ========
         Module    Release#
         ========= ========
         Developer 3.1.4.41
         ========= ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      The parameters 'ColumnNames' and 'ColumnValues'  follow this
      pattern.  'columnName1, ColumnName2', 'ValueforFirstColumn,
      ValueForSecondcolumn'

      Use # to separate the values of a multi lookup property.  e.g.
      'propvalue1,23#4#234,propvalue3

      To set a property to null: include the ColumnName, and a empty
      string in the ColumnValues. In the example the value of column2
      will be set to null.  (e.g. 'ColumnValue1,,ColumnValue3')

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      | 

      Use the Column with \ *ID in the case of a lookup column.  e.g.
      for including the Country Column in the procedure, then use the
      'Country_ID' * column in the ColumnNames parameter.   Similarly
      the ID values must be used in the case of  lookup.

      For columnNames and ColumnValues the single quote is only used at
      the start and end of the entire string (do enclose individual
      items in quotes)

      The number of items in columnNames must be exactly the same as
      ColumnValues.

      | 

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== =========================================================================================================================
         Type           Description
         ============== =========================================================================================================================
         Procedure Name spMFUpdateClassAndProperties
         Inputs         MFTableName : Pass the class table name, e.g.: MFCustomer
                        ObjectID : Pass ObjID of the object,
                        NewClassId : Pass new class ID
                        ColumnNames : Pass new property ID’s(separated by comma) both MFID or property or columnName can be used. (Optional)
                        ColumnValues : Value of the properties(separated by comma) Use # the separate the ids in case of a multilookup (Optional)
                        Debug: 1 = Debug Mode
         Outputs        Outputs
                        1 = success
                        0 = Partial (Some records failed to insert into MF Table
                        2 = Error
         ============== =========================================================================================================================

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          DECLARE @return_value int

         EXEC @return_value = [dbo].[spMFUpdateClassAndProperties]
         @MFTableName = N'MFCustomer',
         @ObjectID = 3,
         @NewClassId = 232,
         @ColumnNames = N'Keywords',
         @ColumnValues = N'thejus',
         @Debug = NULL

         SELECT 'Return Value' = @return_value

.. container:: confluence-information-macro confluence-information-macro-information

   Use Cases(s)

   .. container:: confluence-information-macro-body

      | 

| 
