
Moving the Connector Database
=============================

Backup and restore of Connector
-------------------------------

The MFSQL Connector database should be backed up regularly as part of
daily maintenance routines.

It is advisable to maintain an extract of the custom scripts in a
Connector database (any tables, views, procedures and functions) as
separate offline script files to safeguard against loosing the
customization of the Connector for your purposes.  Using Right click on
the database, then Tasks\Generate Script\Choose Objects to export all
custom.xx objects.

Restoring the database backup to a database with the same name is in
order.

The installation files and some procedures are uniquely compiled during
installation for each database and cannot be re-used to create or update
a database with a different name.


Changing name of database
-------------------------


Changing the name of the Connector database by restoring and backup to a new name is not advisable.  We recommend to reinstall the connector using the installation software to a new database and to migrate any custom scripts and procedures to the new database.


Fixing orphaned user account
----------------------------

It is likely that MFSQLConnect user will be orphaned when restoring a MFSQL database to another server

To identify orphaned users:

.. code:: sql

    USE YourDatabase
    EXEC SP_CHANGE_USERS_LOGIN 'REPORT'
    GO

To fix the orphaned users

.. code:: sql

    USE YourDatabase
    exec sp_change_users_login AUTO_FIX, 'MFSQLConnect'
    Go
