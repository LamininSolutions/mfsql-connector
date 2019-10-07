Upgrade to version 4.3.9.48 and later
=====================================

Upgrading from a pre-4.3.9.48 release to a this or later release
requires some manual steps.

Watch the video

| 

| 

.. container::

   Follow the instructions for a normal Release for upgrade and pay
   special attention to the following

   #. The MFSQL Connector Vault application must be removed manually
      using M-Files admin.  The new vault application is available in
      the installation folders \ **C:\Program Files (x86)\Laminin
      Solutions\MFSQL Connector Release 4\your database\Vault
      Applications\MFSQL_VAF.** The VAF name to select
      is \ **MFSQLConnectorVaultApp.zip**
   #. The content package will make changes to the MFSQLConnector object
      in the Vault.  The configuration object is removed and the
      redundant properties are removed.  However, the content package
      will not delete the old User Messages class.  After upgrading
      there will be two classes for User Messages. The second Class with
      the name User Messages must be deleted manually.
   #. The location of the connection string for access SQL from M-Files
      using Context Menu functionality has changed.  After installation,
      the connection string must be re-configured following `these
      instructions  <page686030872.html#Bookmark56>`__

   | 
