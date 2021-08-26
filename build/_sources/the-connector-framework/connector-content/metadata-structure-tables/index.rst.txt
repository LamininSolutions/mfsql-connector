Metadata Structure Tables
=========================

.. toctree::
   :maxdepth: 4


MFSQL Connector maintains a large portion of the data definitions of the metadata structure of the vault. It also includes additional columns not defined in M-Files. The tables are created as part of the installation and populated with the metadata syncronisation procedures.

The tables relate to the object types, classes, properties, valuelists and workflows in the vault. It also include tables for the login accounts and users.

The following additional columns are created on these tables to complement the M-Files data definitions

=========== ==============================================================
Column      Description
=========== ==============================================================
ID          SQL Identity column that represents the SQL - ID of the object
MFID        M-Files id if the object
Alias       The M-Files Alias
Modified on Date that the item was last modified in SQL
Created on  Date that the items was created in SQL
Deleted     Item is set to 1 by the Connector if it was deleted in M-Files
=========== ==============================================================

These tables include several extensions of the standard M-Files Metadata that is useful in special applications.

The columns and their usage for the metadata tables are outlined in the following sections

  -  :doc:`/tables/tbMFClass/`
  -  :doc:`/tables/tbMFProperty/`
  -  :doc:`/tables/tbMFClassProperty/`
  -  :doc:`/tables/tbMFObjectType/`
  -  :doc:`/tables/tbMFWorkflow/`
  -  :doc:`/tables/tbMFWorkflowState/`
  -  :doc:`/tables/tbMFUserAccount/`
  -  :doc:`/tables/tbMFLoginAccount/`
