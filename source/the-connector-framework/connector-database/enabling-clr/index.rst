Enabling CLR
============

.. toctree::
   :maxdepth: 4

   using-clr/index

The SQL common language runtime (CLR) integration feature is off by
default, and must be enabled in order to use objects that are
implemented using CLR integration. The Connector use CLR as described in
Using CLR section.  To enable CLR integration, the \ **clr
enabled** option of the \ **sp_configure** stored procedure is set in
the installation scripts.  The following is included in the script
script.update_Assembly.sql.

TRUSTWORTHY will be set ON in order to create assembly with
PERMISSION_SET = UNSAFE.

sp_configure'show advanced options', 1; GO RECONFIGURE; GO
sp_configure'clr enabled', 1; GO RECONFIGURE; GO

CLR integration can be disabled by setting the clr enabled option to 0.
When CLR integration is disabled, SQL Server stops executing all CLR
routines and unloads all application domains. The Connector will not
function if CLR is disabled.

Learn more on the use of CLR in the Connector in the related
section \ `Using CLR <page21200962.html#Bookmark74>`__

 

 
