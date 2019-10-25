Licensing Management
====================

License management use M-Files licensing method for vault applications. A separate license file
(.lic file) is issued for a specific type of license. 

Application licenses
--------------------

Separate license files are required for:
-  MFSQL Connector VaultApp: MFSQL Connector (Data Exchange and Integration)
-  SQLDatabaseConnector: MFSQL Database File Connector

License types
-------------

- Trial license:
   - 30 days only. 
   - Expires on license end date.
- Subscription: 
   - 1 year maximum.
   - Expires on license end date. 
   - License is issued for a specific M-Files license.
   - License is issued for specific modules and is subject to the order of the license.
   - Only valid with designated M-Files server. 
   - Separate license files are issued for Database File Connector and MFSQL Connector 
- NFR license: 
   Issued in terms of reseller agreement.

Installing the license
----------------------

The license file is installed using M-Files Admin.  Using the Applications window in M-Files Admin for the target vault, select the appropriate application for the license to be installed.
|Image0|

Click on License and browse to the license file.  Validate the license details and accept. 

Expiry notification
-------------------

Release 4.4.13.53 introduced a email notification when the license expires within 30 days. The notification relies on the database mail setup for error management.


.. warning::

   The will expiry on the license end date.  Renew the license before the expiry date.


.. |image0| image:: img_35.png
