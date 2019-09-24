spMFClassTableColumns
=====================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      This special procedure analyses the M-Files classes and show types
      of columns and any potential anomalies between the metadata
      structure and the columns for the table in SQL

      The report include some columns  to extract and compare data and
      other columns to interpret or report a status.  Each row
      represents a property / Class relationship. A listing by class
      would show all the properties applied on the class, both defined
      on the metadata card and added ad hoc to the class.  Filtered by
      property it will show all the classes where the property has been
      applied to.

      Key result columns in report:

      .. container:: table-wrap

         ===================== ===========================================================================================================
         Column                Usage
         ===================== ===========================================================================================================
         ColumnType            show the type of usage of the property:
                              
                               -  Additional property
                               -  Lookup lable
                               -  M-Files system (related to metadata class)
                               -  Excluded from M-Files (not related to M-Files properties)
                               -  MFSQL system property (used for SQL processes)
                               -  Not used (M-Files property not used in SQL)
         Additional Property   Property column is on class table, but the property is not included in the metadata configuration
         Lookup type           show if the lookup property relates to a valuelist, another class table, or workflow
         Column DataType Error Show if there is a miss match between the SQL column data type definition and M-Files data type definition.
         Missing Columns       Show properties on the metadata table that is not included in the class table
         Missing Table         Slow classes defined as included in property but the class table is missing
         Redundant table       Show if class table exist but it is not included in app in class table
         ===================== ===========================================================================================================

      The listing will identify the columns added to the table related
      to Additional properties

      The procedure combines the data from various dimensions including:

      -  MFProperty + MFClass + MFClassProperty for the M-Files property
         and class usage
      -  InformationSchema + MFDataType to compare the structure with
         the deployment of the structure in SQL

      The following design considerations are supported by this result
      set

      a) The use of ad hoc properties on classes.

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ========= ========
         Module    Release#
         ========= ========
         Developer 4.3.9.48
         ========= ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      | 

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      | 

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== =============================================
         Type           Description
         ============== =============================================
         Procedure Name spMFClassTableColumns
         Inputs         Debug: 1 = Debug Mode; 0 = No Debug (default)
         Outputs        1 = success
         ============== =============================================

      The procedure creates a global temporary table with the
      ##spMFClassTableColumns

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFClassTableColumns]  -- nvarchar(200)

         --review result

         SELECT * FROM ##spMFClassTableColumns 

.. container:: confluence-information-macro confluence-information-macro-information

   Use Cases(s)

   .. container:: confluence-information-macro-body

      | 

| 
