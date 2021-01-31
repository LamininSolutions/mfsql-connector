
Using M-Files External Connector
=================================

M-Files External Connection allows for M-Files to use this standard connector to update external information from SQL using an ODBC connection.

.. warning::
    M-Files External Connector must be removed from the Object Type of the class object before attempting to update the class using MFSQL Connector.  The update will fail if the external connection has not been removed.


This blog highlights the scenarios where the standard M-Files External Connection is likely to not meet your requirements. In these cases MFSQL Connector comes into play to extend the funcitonality of the standard system.

Provide more control over the data synchronization
--------------------------------------------------

This is by far the most important consideration. MFSQL Connector provides significantly more control of the update process and can

  -  Update based on data in a remote SQL database
  -  Update only the records that has changed
  -  Update specific records
  -  Trigger the update from a third party solution
  -  Trigger the update based on data conditions
  -  Perform data alignment before updating records

Control over the update process
---------------------------------------

  -  When the task involves more than just purely importing a fixed set of records from a table or a view
  -  Update / create records of multi classes in sequence
  -  First create and get the object id of a related class and then create a dependent object
  -  Update the record based on conditions in other records
  -  Set the external id based on conditions

Trigger synchronization from a M-Files client
---------------------------------------------

  -  Using the context menu functionality will allow a user to perform the update on demand
  -  Trigger the update as part of a workflow action

Automate import and export files from SQL databases
-----------------------------------------------------

  -  Allows for importing files from databases and aligning the file with the metadata of the external databases
