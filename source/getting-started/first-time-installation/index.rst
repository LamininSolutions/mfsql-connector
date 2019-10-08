=======================
First time installation
=======================

.. toctree::
   :maxdepth: 4

   standard-new-installation/index
   content-package-installation/index
   installing-the-context-menu/index
   configuration-of-connection-string/index
   database-file-connector-installation/index
   using-agent-for-automated-updates/index
   installing-database-mail/index
   common-installation-errors-and-resolutions/index
   setup-powershell-utilities/index
   install-package-with-logging/index


Installation scenarios
----------------------

Different server configurations could give rise to different
installation methods.

Separate servers on premise
~~~~~~~~~~~~~~~~~~~~~~~~~~~
M-Files server and SQL Server is separate servers in the same domain network. This is the recommended and most common scenario for production environments.

Use the standard Installation method. Install the package on each server selecting the options for the server type. Start with M-Files Server.

Single Server
~~~~~~~~~~~~~
 M-Files Server and SQL Server is on the same box (server or workstation). This is the most common scenario for test and development environments.

 Use the standard installation and select all the installation options at the same time.

M-Files server and SQL Server on different domains
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The servers are not connected within a common domain. Consider the following:

  - Administrative access to install software on the servers
  - Access from M-Files server to SQL on the SQL server via ODBC
  - Sysadmin rights on the SQL Server

Manually, or partially manual installation is required when any of the above restrictions apply.

M-Files Cloud installation falls within this scope as administrative access to the M-Files Server is restricted to M-Files support only.

To perform any manual install it is required to first get access to the installation files. Follow the manual installation guide for this step.

  - **Manual install of M-Files Server**
    - For M-Files Cloud installations: provide M-Files support with the cloud installation instruction.
    - For other M-Files Server manual installation scenarios: Provide installation files to M-Files Server Administrator. Follow manual installation guide.
  - **manual install of SQL Server**
    - Copy Assemblies to SQL Server
    - Install M-Files desktop on SQL Server
    - Run SQL Scripts in installation folders in sequence. 


