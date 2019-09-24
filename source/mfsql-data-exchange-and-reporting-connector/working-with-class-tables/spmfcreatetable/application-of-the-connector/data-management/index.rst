Data Management
===============

Significant data management challenges can arise when metadata
structures changes in M-Files. This could be the result of a introduce
additional functionality into M-Files or a change of approach.

To re-align metadata can be very cumbersome using M-Files client. A data
manager can use the Connector to analyse and modify the metadata in SQL,
and then update all the metadata in bulk into M-Files. Performing data
management between M-Files and the Connector will require advanced
knowledge of the data components of M-Files.

A number of features of the Connector are of particular importance.

#. The ClassTable contains both the value and the id of valuelist items
   which makes data analysis significantly easier.
#. The MFPropertyClass table contains an indicator to show that a
   property is marked as required on the class in M-Files
#. The MFProperty table contacts an indicator to show that the property
   contains a automation rule
#. Redundant metadata can be removed with the Connector by removing the
   additional properties with the Connector.
   The \ **spMFDeleteAdhocProperty** is used to perform this removal

.. container:: table-wrap

   +-----------------------------------------------------------------------+
   | **Related Topics**                                                    |
   +=======================================================================+
   | -  Insert hyperlink                                                   |
   +-----------------------------------------------------------------------+
