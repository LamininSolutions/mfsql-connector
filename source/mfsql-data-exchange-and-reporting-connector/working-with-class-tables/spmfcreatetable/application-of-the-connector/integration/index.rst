Integration
===========

The Connector can be incorporated as part of the architecture to
integrate into another application such as CRM, ERP or any other
application that can use SQL data tables for integration.

The Connector will expose all the metadata that is required for a third
party application.  The ClassTables can either be used directly in the
architecture or perform as intermediary tables.

Updates to and from M-Files into the third party application is
accomplished by using the process_id setting in combination with the
spMFUpdateTable procedure and different updatemethod settings.

Setting process_id  to 1 on any ClassTable indicate to the procedure
that the record in SQL must be updated in M-Files

Use the following update methods with the update procedure
spMFUpdateTable

-  UpdateMethod 1: Update from M-Files to SQL
-  UpdateMethod 0: Update from SQL to M-Files

A number of features of the Connector is of particular importance for
integration.

#. When a metadata is deleted in M-Files it is not removed from SQL but
   instead the column Deleted is updated to 1.  This allows for third
   party applications to correctly deal with deleted items from M-Files.
    
#. Updates can be staged to be either in batch mode or transactional
#. Data manipulation to align and prepare data between M-Files and the
   external application can all be controlled in SQL rather than in .net
   code.
#. Error logging takes place in SQL
#. Updates can be triggered using the Connector Context Menu in M-Files

.. container:: table-wrap

   =========================
   **Related Topics**
   =========================
   -  Connector Applications
   =========================
