spMFClassTableColumns to explore column usage
=============================================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      The spMFClassTableColumns procedure is a helper routine to gather
      information related to the usage of columns (properties) in MFSQL
      Connector.

      It provides error information, usage information from different
      perspectives and are utilised in other procedures to aid error
      trapping.

      Running the procedure will produce a temporary table with the
      result. Do a select \* from ##spMFClassTableColumns.

      Each column is categories as one of the following:

      -  MFSystem property:  properties with MFID < 1000 such as
         created, Last modified etc.
      -  Metadata Card property: These properties are defined in M-Files
         as part of the metadata card
      -  Not used: these properties are not used in any of the class
         tables included in app.

      The Additional Property column show properties that have been
      added to a class but is not defined in the class definition.

      The Lookup Type show the name of the lookup and differentiate in
      either a structure table, class table, or valuelist.

      The datatype of the property definition and column definition are
      listed separately. The ColumnDataTypeError highlight any columns
      where the datatypes are not in sync.

      The missingColumn show items where the metadata configuration
      added a column, but the class table has not yet added the column
      to the table

      The missingTable show where the MFClass show a table that has been
      included in the app, but the table does not exist

      The RedundantTable show where a class table exist but it is no
      longer defined in the metadata

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============= ========
         Module        Release#
         ============= ========
         Data Exchange 4.2.8.46
         ============= ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      The procedure can be used in special applications to trap or
      prevent errors.  Use the procedure parameter to run it for
      specific table only.

      The result of the procedure is stored in the temp table
      ##spMFClassTableColumns

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      | 

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== =================================================================
         Type           Description
         ============== =================================================================
         Procedure Name spMFClassTableColumns
         Inputs         TableName: Default null. if default, then it will show all tables
                       
                        Debug: 1 = Debug Mode; 0 = No Debug (default)
         Outputs        1 = success
         ============== =================================================================

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFClassTableColumns] @TableName = 'Account'

         SELECT * FROM ##spmfclasstablecolumns 

.. container:: confluence-information-macro confluence-information-macro-information

   Use Cases(s)

   .. container:: confluence-information-macro-body

      | 

| 
