Upgrade to version 4.10.30.74 and later
=======================================

This section applies when upgrading from a version prior to 4.10.30.74 to this version or any later version.

Significant changes are included in this version which requires careful consideration. It will require review and adjustment of your custom code if your installation previously used the context menu functionality of the Connector.

The changes to this version is outlined in :doc:`/version-control/index` and include changes in all the core components of the Connector:

  - SQL Procedures tables and views
  - Vault Application framework
  - Web API Service
  - Wrapper Assemblies

This implies that any upgrade to this version must include updates to both the SQL server and the M-Files Server at the same time.

The changes to the Vault Application framework and Web API Service is outline in :doc:`/blogs/update-to-VAF-4-10/index`.  If your use of the Connector include the use of the MFSQL Connector menus in M-Files, or the use of workflow state change and event handler triggers for running procedures then you must follow the instructions in this section to adapt your custom code to fit the new VAF module.

If you are not using the context menu functionality and have upgraded both SQL Server and M-Files Server with this release, then no special actions are required for upgrading this release.

Key functional improvements
----------------------------

There are substantial functionality improvements included in this release that may benefit your use of the Connector. Following are those prominent improvements.

   -  Use M-Files desktop to trigger a background operation using SQL for either a cloud vault or an on premise vault.
   -  Monitor progress and backtrack on processing with advanced logging of the Connector operations.
   -  Trigger multiple background operations from M-Files using the M-Files advanced task management system to control the completion of the tasks
   -  Delete and undelete objects using SQL
   -  Improved handling when deleted objects are retained in the class table to control reporting or further processing of the these items in third party systems
   -  Improved updating of objects M-Files and SQL to control locking and improve performance
   -  Configure additional property updates for a table to remove null valued additional properties from the metadata card

Steps to upgrade
----------------

Get download of latest release from website `<https://lamininsolutions.com/download-mfsql-connector/#MFSQL-download>`_
Stop all SQL agent jobs
Make a backup of the M-Files Vault and MFSQL Connector Database
Install the upgrade on the SQL Server first.
In the case of a cloud installation, install the Web API Service
Then install the upgrade on the M-Files Server.  In the case of a cloud installation, this is performed by M-Files support
Check that the new VAF is Installed
Restart the vault
Check the VAF licensing is valid, if not, reinstall the MFSQL license
Check the connection to SQL in the configurations Dashboard
Using SSMS check the connection to the vault from SQL
Refresh the metadata synchronization
In the case of using context menu functionality, follow the instructions to update the custom procedures.
Test the action buttons, workflow state changes and event handler triggers
