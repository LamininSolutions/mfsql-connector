=======================
Configuration and setup
=======================

.. toctree::
   :maxdepth: 1

   licensing-management/index
   update-settings/index
   installing-the-context-menu/index
   enabling-vaf-logging/index
   database-mail/index
   using-agent-for-automated-updates/index
   setup-powershell-utilities/index

Following the initial installation of the package, proceed with the enablement and configuration.

Required configuration
----------------------

Licensing
~~~~~~~~~

The connector will not operate unless a license is installed.  Follow the :doc:`/getting-started/configuration-and-setup/licensing-management/index` to install and update the license.

Update settings
~~~~~~~~~~~~~~~

A cloud installation will require the manual updating of the username and password. The same functionality can be used to update other settings : Refer to :doc:`/getting-started/configuration-and-setup/update-settings/index`.

Optional configuration
----------------------

Context menu
~~~~~~~~~~~~

Using the context menu functionality is optional. This functionality will allow M-Files to automatically trigger SQL procedures, or users to on demand trigger SQL operations.

Consult :doc:`/getting-started/configuration-and-setup/installing-the-context-menu/index` to get started with the Context Menu.

Database mail
~~~~~~~~~~~~~

Database mail is used for error messages to email and can also be used to send reports and other notifications to users and third parties.

Consult :doc:`/getting-started/configuration-and-setup/database-mail/index` for enabling database mail.

Logging
~~~~~~~

MFSQL Connector includes a range of logging features. By default detail logging is switched on. However, if the use of MFSQL Connector does not require any detail logging, then the following setting can be set to 0.

To view the current status of the setting

.. code:: sql

     Select value from mfsettings where name = 'App_DetailLogging'

To update the setting

.. code:: sql

     Update mfsettings
     set value = '0'
     Where name = 'App_DetailLogging'

Review :doc:`/mfsql-integration-connector/using-and-managing-logs/index` for more detail on how to logs fit together.

From version 4.10.30.74 the Context menu includes the ability to log context menu processing. The enabling of the logging for context menu is covered in :doc:`/getting-started/configuration-and-setup/enabling-vaf-logging/index`

Agents
~~~~~~

SQL Jobs with SQL Agents are often used in conjunction with MFSQL Connector procedures to automate processes. The following agents are automatically installed by the Connector

Consult :doc:`/getting-started/configuration-and-setup/using-agent-for-automated-updates/index` to enable the agents

Powershell utilities
~~~~~~~~~~~~~~~~~~~~

When SQL express is used, the SQL agent functionality for automation is not available.  To this end the connector includes a powershell utility to schedule procedures using windows task scheduler.

Consult :doc:`/getting-started/configuration-and-setup/setup-powershell-utilities/index` to enable this method of automating the procedures.
