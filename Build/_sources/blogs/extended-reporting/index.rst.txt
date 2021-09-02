Extended Reporting
==================

In this use case some metadata in M-Files is combined with data from
other systems and the resulting management reports are then made
available to the users with a intranet web portal. 

The use case have the following components:

-  The information that is required for the reports are synchronized
   with SQL overnight using MFSQL Connector with an agent running the
   procedure to update.

-  Data from other systems is added to SQL

-  SQL views are used to prepare the combined data into a suitable
   format for reporting.

-  Visual studio report designer is used to prepare to report formatting
   and publish the reports to SQL Reporting (SSRS)

-  A simple website is published using Code on Time Application
   Generator to give easy access to the reports from SSRS. The website
   includes additional instructions on usage of reports, security access
   by department.


