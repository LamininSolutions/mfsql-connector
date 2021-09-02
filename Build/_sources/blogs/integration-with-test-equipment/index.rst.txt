Integration with test equipment
===============================

In this use case manufacturing test results are produced by testing
equipment. The test results consist of a file with readings and other
data, and the manufacturing unit reference data.  These test results
must all form part of the quality assurance documentation for each
manufacturing unit. The quality control process, including all related
documentation is maintained in M-Files.

The deployment of this use case have the following elements:

-  The results of each test is compiled with Python and filed as a
   electronic file with an associated XML record with the reference data
   to a designated folder.

-  M-Files Importing Tool is used to watch the folder and automatically
   imports the test results. 

-  M-Files is used to manage the quality aspects of the testing process
   and the related class tables are synchronized using MFSQL Connector
   with SQL.

-  Python uses the data in SQL to perform additional validations for
   subsequent tests and update SQL directly with additional results.

-  These results are again synchronized with M-Files to support to
   further processing of the quality management.


