Creating a Special Application
==============================

.. toctree::
   :maxdepth: 4

   usage-examples-of-procedures-and-functions/index
   custom-tables-and-functions/index
   steps-to-get-started-with-a-special-application/index

The Connector is particularly useful when there is a requirement for
extending the functionality and use of M-Files by creating a special
application around M-Files using and updating the metadata as part of
the application.

This approach can be used in conjunction with, or to supplement the
functionality of M-Files Server Applications and UI-Extensibility
Framework.

The application of the Connector for generating a special application is
particularly useful where the application requires functions and
methods, and data components that goes beyond the scope and capabilities
of of M-Files but are intricately interwoven with the metadata in
M-Files.

Some particular features of the Connector to assist with the development
of a special application include

#. Update MFClass table to set tables to be included in Application as
   using this column to execute updates to tables in batch
#. Use MXuser_ID on each MFClass Table to control the updating of the
   record in SQL and which records are pushed to M-Files for updating.
   The spMFUpdateTable procedure has the ability to update records for a
   specific user only.
#. Add additional or adhoc columns to MFClass Tables with a prefix of
   MX\_ to extend the MFClass tables for additional data without
   impacting on M-Files.
#. Each Class table have two unique identifyers for each record. The ID
   column is a SQL based identity column; the ObjID column is the
   M-Files unique identifyer. The ClassTable can contain a record that
   is not (yet) in M-Files. There will then be no objid.
#. The MFValueListItem table has a unique identifier for each ValueList
   item in the AppRef column. This reference consists of the Valuelist
   MFID + Item MFID. This is of particular importance as the MFID is not
   unique accross multiple ValueLists and using this method avoid having
   to build a separate table for each Valuelist in the vault.

.. container:: table-wrap

   ==============================================================================================================================================================
   **Related Topics**
   ==============================================================================================================================================================
   -  `Connector Applications <https://lamininsolutions.atlassian.net/file:///O:/Development/WebDev/DocBuild/MFSQLConnector/Chapter3/Wrapper_Applications.htm>`__
   ==============================================================================================================================================================
