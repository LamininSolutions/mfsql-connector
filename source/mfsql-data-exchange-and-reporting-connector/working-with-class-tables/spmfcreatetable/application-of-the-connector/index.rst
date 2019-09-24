Application of the Connector
============================

.. toctree::
   :maxdepth: 4

   creating-a-special-application/index
   data-management/index
   integration/index
   reporting/index

The Connector can be deployed for a variety of different purposes. Some
scenarios for deployment include

-  Integration with other applications such as ERP, CRM, Operational
   systems
-  Deployment of special applications that extend the use of M-Files
-  Advanced data cleansing and data management
-  Reporting with the ability to update M-Files from the reports

The Connector allows for two way integration between M-Files and SQL and
a range of procedures and functions to work with the metadata. The
application of the Connector allows  using additional SQL procedures,
tables and views to extend the Connector or using SQL and other
development environments such as .Net or Web Application Generators such
as Code On Time to develop the extended applications.

.. container:: table-wrap

   ========================================================================================================================================================================================================================================================================================================================================================
   Warning
   ========================================================================================================================================================================================================================================================================================================================================================
   The Connector procedures, tables and functions can be used by other procedures. Care should be taken not the change the Connector procedures and tables as this will invalidate support for the Connector.  Upgrading the Connector to later versions will automatically overwrite any custom changes of the Connector tables, procedures and functions.
   ========================================================================================================================================================================================================================================================================================================================================================

.. container:: table-wrap

   +-----------------------------------------------------------------------+
   | **Related Topics**                                                    |
   +=======================================================================+
   | -  `Using the                                                         |
   |    Connector <https://lamininsolutions.atlassian.net/file:///O:/Devel |
   | opment/WebDev/DocBuild/MFSQLConnector/Chapter3/Wrapper_Applications.h |
   | tm#>`__                                                               |
   +-----------------------------------------------------------------------+
