
=====================
spMFClassTableColumns
=====================

Return
  - 1 = Success
  - 0 = Partial (some records failed to be inserted)
  - -1 = Error
Parameters
  @ErrorsOnly bit
    returns a summary of properties with errors
    default is set to 1
  @IsSilent bit
    if set to 1 then no result will be shown
    default is set to 0 (no)
  @MFTableName 
    Result is shown for only specific table
    Default is all tables are shown
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

This special procedure analyses the M-Files classes and show types of columns and any potential anomalies between the metadata structure and the columns for the table in SQL.

The result is useful in trouble shooting.  It is also used internally during the synchronize metadata routines to trap errors.

Additional Info
===============

The report include some columns  to extract and compare data and other columns to interpret or report a status.  Each row represents a property / Class relationship. A listing by class would show all the properties applied on the class, both defined on the metadata card and added ad hoc to the class.  Filtered by property it will show all the classes where the property has been applied to.

Key result columns in report:

ColumnType
  Show the type of usage of the property:

  - Additional property
  - Lookup label
  - M-Files system (related to metadata class)
  - Excluded from M-Files (not related to M-Files properties)
  - MFSQL system property (used for SQL processes)
  - Not used (M-Files property not used in SQL)
Additional Property
  Property column is on class table, but the property is not included in the metadata configuration
Lookup type
  Show if the lookup property relates to a valuelist, another class table, or workflow
Column DataType Error
  Show if there is a miss match between the SQL column data type definition and M-Files data type definition.
Missing Columns
  Show properties on the metadata table that is not included in the class table
Missing Table
  Slow classes defined as included in property but the class table is missing
Redundant table
  Show if class table exist but it is not included in app in class table

The listing will identify the columns added to the table related to Additional properties.

It will also identify properties that is not used in any class tables, which is handy when trying to remove redundant properties from the vault.

The procedure combines the data from various dimensions including:

- MFProperty + MFClass + MFClassProperty for the M-Files property and class usage
- InformationSchema + MFDataType to compare the structure with the deployment of the structure in SQL

The following design considerations are supported by this result set:

- The use of ad hoc properties on classes.

Examples
========

Without setting any parameters and using defaults. This will only return a result for columns with errors

.. code:: sql

    EXEC [dbo].[spMFClassTableColumns] 

Set @ErrorsOnly to No. This will return a the full result

.. code:: sql

    EXEC [dbo].[spMFClassTableColumns] @ErrorsOnly = 0

Set @ErrorsOnly to No and a specific table. This will return a the full result for a specific table

.. code:: sql

    EXEC [dbo].[spMFClassTableColumns] @ErrorsOnly = 0, @mftableName = 'MFCustomer'

When using the procedure in other routines then set @IsSilent to yes to suppress the result. The global temporary table can then be used in the result

.. code:: sql

    EXEC [dbo].[spMFClassTableColumns] @IsSilent = 1
    SELECT * FROM ##spMFClassTableColumns where property_MFID = 27 

The view can also be used to review the class table columns.  Note this view is only up to date after the procedure was executed.

.. code:: sql

    EXEC [dbo].[spMFClassTableColumns] @IsSilent = 1
    Select * from MFvwClassTableColumns

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-01-31  LC         update to allow for multi language default columns
2020-12-31  LC         rework logic to show column types
2020-12-10  LC         update result to improve usage of the procedure
2020-12-10  LC         add new parameters to aid trouble shooting
2020-09-08  LC         Set single lookup column to error when not int
2020-01-24  LC         Fix multitext column showing false error
2019-11-18  LC         Fix bug on column width for multi lookup properties
2019-08-30  JC         Added documentation
2019-08-29  LC         Add predefined or automatic column
2019-06-07  LC         Add error for lookup column label with incorrect length
2019-03-25  LC         Add error checking for text columns that is not varchar 200
2019-01-19  LC         Change datatype from bit to smallint for error columns
==========  =========  ========================================================

