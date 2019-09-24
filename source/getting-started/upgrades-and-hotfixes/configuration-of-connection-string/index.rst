Configuration of connection string
==================================

.. container:: confluence-information-macro confluence-information-macro-note

   Configuration method

   .. container:: confluence-information-macro-body

      The configuration of the connection string to access SQL from
      M-Files has changed from Release 4.3.9.48.

      This instruction refers only to the new connection string
      configuration.

| 

Only a user with M-Files Server System Administrator credentials can
make changes to the configuration of the connection string.

Access the configuration using the \ **Configurations** option in the
vault administration window.

Select \ **Other Applications **\ and expand.

Select \ **MFSQL Connector Vault App**.  This will show the
configuration on the right.

Select \ **Configuration **\ tab. Then select the **ConnectionString  **

.. container:: confluence-information-macro confluence-information-macro-warning

   Nothing is showing

   .. container:: confluence-information-macro-body

      Nothing will show if the installation is for a release prior to
      4.3.9.48

Update the Servername, Username Password and databasename. 

-  The servername must include the instance and port if applicable.  
-  The default user name is MFSQLConnect.  This is a SQL Authentication
   user and is created with all the required authentication during
   installation. Another user can be used. However, the user must be
   added to the MFSQLConnect_db role in the database to operate
   seamlessly.
-  The default password for MFSQLConnect is Connector01.  Change the
   password in SQL.  Remember to update the password in the
   Configurator.
-  The database is the MFSQL Connector database for the specific vault
   created during first installation of the Connector.

Take vault offline and back online to activate the connection string.

Select \ **Dashboard **\ tab to validate the connection.

| 

| 

| 
