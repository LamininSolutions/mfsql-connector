Report designers and the Connector
==================================

Reporting need data and a user interface. The Connector provisions the
data and the report designer of choice presents the data to the user.

The Connector gets M-Files data and any other systems data and makes it
available in tables, views and dynamically compiles it in store
procedures. Other tools such as SQL Analytics or data warehousing can be
used in conjunction with it. The data is one step removed from live
data. The data must be pushed or pulled from M-Files before the data can
be is available to the report.

Any report designer with the ability to link with an SQL database can be
used with the Connector. This include a wide range. The most popular
include:

-  Visual studio report designer

-  SQL Report Builder

-  Excel

-  Interject

-  Power BI

-  Tableau

-  SAP BusinessObjects (Chrystal Reports)

-  Qlikview

The choice between these report designer will depend an a wide range
considerations. For the purposes of using it with the Connector it is
important to consider the following:

-  Frequency of data refresh

-  Method of data refresh

-  Ability to use tables and/or views and/or procedures

It is worth noting that several report designers may be deployed in a
business for different use cases. Software application cost, complexity
of designer, type of report, complexity of report, internal design
capabilities and many other factors will contribute to the selection of
the designer. The selection of designer may impact on the approach used
to enable the Connector to provision the data.

Frequency of refresh and related methods
----------------------------------------

Key requirements
~~~~~~~~~~~~~~~~

Currently, context menu actions are not available for M-Files Cloud
installations. This is due to become available in 2019.

SQL Agent is not available in SQL Express edition. The Connector must be
deployed in SQL Standard Edition to use agents.

Data updates fundamentally use ODBC connections. It is therefore
important to ensure that the SQL Server and M-Files server is within the
same network or connected with a VPN to ensure data protection.

Near real time
~~~~~~~~~~~~~~

Reporting on M-Files data using the Connector will not be real time on
the change of data, but can be almost real time. To get near real time
reporting it is required to use one of the context menu action
capabilities. This include:

-  trigger update store procedure on workflow state change

-  trigger update store procedure with event handler on check in changes

On demand - triggered by context menu action
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Connector allows for updating actioned with a context menu action.
The following action options could be used:

-  Update triggered by user selecting an action from the menu

-  Update triggered by user selecting a context sensitive action with a
   right click on the object.

Both options can be either synchronous or asynchronous.

On demand - triggered by store procedure in report
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A store procedure can be built into the report to allow for pulling the
data update. This method is dependent on the report designer. Not all
report designers allows or enables this method.

Scheduled data update
~~~~~~~~~~~~~~~~~~~~~

Updating the data based on schedule can be triggered by an SQL Agent.
Note that SQL agent is not available in SQL Express. SQL Standard
edition must be used for this option.

A SQL agent can be deployed to update either a single class table, a
collection of class tables or all the tables included in the
application. The timeframe can be configured to be the same for all
tables, or differentiate depending on the use of the data for reporting.
In some cases it may be necessary to ping the update every few minutes
and in other cases it is acceptable for data to be refreshed say once a
day. SQL agents are highly configurable and adaptable to fit individual
use cases and requirements.

Scheduled updates is the most common option used in M-Files Cloud
installation to overcome the limitations on not being able to use the
context menu triggers.

Using store procedures in the report designer
---------------------------------------------

Triggering a store procedure directly from the report, or on report
refresh could have a material impact on the approach taken for updating
the data and provisioning the data to the report.

Using a trigger in the report to call a store procedure is one way of
overcoming the current limitations on using the context menu for M-Files
cloud installations.

Store procedures are used to:

-  Call a routine to get the latest data from M-Files.

-  Compile complex reports using dynamic queries, temporary tables or
   CTE operations and return a formatted dataset to the report designer

-  Update tables with the dataset to provision data in cases where the
   report designer does not allow inputs from dynamic queries and can
   only access data from tables or views.

Not all report designers allow for using SQL procedure triggers in the
report. Designers that are able to do it include:

-  Interject

-  Excel

-  Visual studio report designer

-  SQL report builder

Designers that is not able to perform a trigger operation successfully
include:

-  Power BI

Your input on report designers that may allow or prevent this is
appreciated.


