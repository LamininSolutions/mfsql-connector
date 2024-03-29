Next Steps after installation
=============================

On completion of the installation for the first time, the application is ready to be provisioned for its specific use.

Always test the installation first (see below)
If the connection test fails, consult the common installation errors section to resolve it.
Thereafter, before using the Connector, the metadata structure must be updated, and the class tables must be setup.
This is achieved by either:

 - using the procedure :doc:`/procedures/spMFSetup_Reporting` as discussed in more detail in :doc:`/mfsql-data-exchange-and-reporting-connector/reporting/setup-reporting/index` , or
 - Follow the steps below or
 - see the section Using example scripts below and follow the script 'Getting Started' to complete the first steps and getting to know the Connector.

After the metadata structure is refreshed, and the targeted class tables are created, the Connector can be used.

Note that the steps below and all the different options
are discussed in much more detail in different sections in this guide.

Test installation
-----------------

The first step is to test that the installation was done correctly and
that the Connector can access the M-Files vault.

Execute the following procedure to test that the Connector can access
the vault.  This procedure can be executed even before metadata have
been synchronized.

.. code:: sql

    EXEC spMFVaultConnectionTest

Update metadata Structure
-------------------------

Update the metadata structure by using the following procedure

.. code:: sql

     EXEC spMFSynchronizeMetadata

The vault is now ready to design the usage of the Connector and add the
related Class tables. 

View available class tables
---------------------------

Use the following procedure to get a listing of all the classes in the
vault.  

.. code:: sql

      SELECT * FROM MFClass

Create first Class Table
------------------------

The following procedure will create a class table such as Customer.  

.. code:: sql

    EXEC spMFCreateTable @ClassName = 'Customer'

Note that the table will be created with the TableName as per the
MFClass Table. Perform a select statement on the table to view the
columns that has automatically be created.

Update Records in Class Table
-----------------------------

The records can now be updated from M-Files by executing the update
procedure. Note that class tables will take some time to update. If there are many records in the class then
consult the section on UpdateTable for further guidance when large
datasets are updated.

.. code:: sql

      EXEC spMFUpdateTable
             @MFTableName = N'MFCustomer'
           , @UpdateMethod = 1

Perform another select statement on the table to view the records.

Ready for real action
---------------------

You are now ready for real action. Follow the section on using the
Connector to plan and execute your application of the connector.  This will provide more information on how to use this guide.

Using example scripts
---------------------

Examples scripts for the most common procedures and functions are
included in the installation package. The scripts are also included as downloads in this guide in the sections where applicable.  The scripts are prepared using a standard M-Files Sample vault and will include illustrations usingobjects from this vault.

The scripts are located at:

-  InstallationFolder\\Laminin Solutions\\MFSQL Connector Release
   4\\DatabaseName\\Example Scripts

Open the scripts in SSMS. Follow the guidelines in the scripts to
select the instructions in blocks rather than executing the entire
script.

Use the scripts in conjunction with this guide. The script only
include a brief explanation or guide for the use of the different
procedures and is not intended to replace this guide.
