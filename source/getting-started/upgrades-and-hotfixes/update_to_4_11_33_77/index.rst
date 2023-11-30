Update to version 4.11.33.77
============================

The package for Version 4.11.33.77 is published and available for `download <https://lamininsolutions.com/download-mfsql-connector/#MFSQL-download>`_

A listing of changes is in :doc:`/version-control/index`. The following guidance elaborate on the updates requiring your special consideration and attention.

This update involves changes to SQL, the assemblies and the Vault Application and introduces new functionality.  The upgrade will therefore affect both the SQL server and M-Files Server, and the new functionality may be applicable to your installation.

Package installation
--------------------

Running the package on the SQL server in a on premise installation will update the VAF in the M-Files server.  After running the package, restart the Vault to allow for the VAF to pull through and check with the Applications in M-Files that the latest version is 4.11.1.29

Installing the package in a M-Files cloud based requires addition steps.
 -  Run the package in workstation mode on the SQL server, or desktop.  This will place all the installation files on the server without performing the actual installation
 -  Find the certified and signed Vault application in the folder 60_AddOns under the installation folder for the package . This VAF installation package is pre-approved by M-Files and ready for installation.  If you are not able to install VAF packages on your cloud vault, then you should pass this package through to M-Files support for installation.

|image1|

 -  Soon after the VAF was installed in the cloud vault, you proceed to install the assemblies and scripts on the SQL server following the cloud installation guide :doc:`/getting-started/cloud-and-hosted-installation/index`

Improvements to task management in context menu applications
------------------------------------------------------------

This package allows for using the context menu functionality to be used in high volume applications.  Being able to process multiple tasks have opened up new horisons for triggering SQL processes from M-Files in the background.  Examples of such applications are:

 -  Using an event handler to detect when a sql operation should be triggered
 -  after check in changes event handler to trigger the updating of the changes for a specific object into SQL to achieve near realtime reporting
 -  Using workflow state changes to trigger further operations to be completed for related objects in the background.

Refer to the configuration of the context menu for more information :doc:`/getting-started/configuration-and-setup/installing-the-context-menu/index`

Improvement to handling of dates
--------------------------------

Several changes were made to improve the usage of date related operations, especially in scenarios where the M-Files server and SQL server are not in the same date region.  Although the M-files user interface show dates in the local time, the date is stored in UTC.  Refer to :doc:`/blogs/working_with_dates/index`

Improvements in handling last modified user
-------------------------------------------

New functionality is introduced to allow for setting the last modified user to another user than the default MFSQL Connector user.  This capability requires a setting in MFSetting. This functionality may impact existing procedures if the last modified user is not specifically set in the procedure. Refer to :doc:`/blogs/mf-last-modified-user-in-action/index` for more information.

New functionality for user analysis
---------------------------------------------

Getting a better understanding of the user categories and how they relate to user groups in a complex vault could be quite involved.  Improvements introduced in this regard include:

 -  The MFLoginAccount table now include vault roles. This is very handly to identify users with full admin or other special permissions.
 -  The procedure :doc:`/procedures/spMFUsersByUserGroup` allows for producing a listing of users and usergroups.

.. |image1| image:: Image1.png

