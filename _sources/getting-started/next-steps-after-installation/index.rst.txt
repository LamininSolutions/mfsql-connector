Next Steps after installation
=============================


Before using the Connector and metadata can be refreshed for the first
time the following must be in place

-  All tables and procedures must be deployed as decribed in the
   deployment section
-  Add security settings in the settings table as described in security
   section
-  Excecute password encryption as described in security section

After all the installation steps have been followed, the Connector is
ready for use.   Note that the steps below and all the different options
are discussed in much more detail in the section on using the Connector.



Test installation
-----------------

The first step is to test that the installation was done correctly and
that the Connector can access the M-Files vault.

Execute the following procedure to test that the Connector can access
the vault.  This procedure can be executed even before metadata have
been synchronized.

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         EXEC [dbo].[spMFVaultConnectionTest]



If not already done, then update all the metadata by using the following procedure

Update metadata
---------------

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         EXEC [dbo].[spMFSynchronizeMetadata] @Debug = 0 -- smallint

The vault is now ready to design the usage of the Connector and add the
related MFClass tables. 



View available class tables
---------------------------

Use the following procedure to get a listing of all the classes in the
vault.  

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         SELECT * FROM [dbo].[MFClass] AS [mc]



Create first Class Table
------------------------

The following procedure will create a class table such as Customer.  

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         EXEC [dbo].[spMFCreateTable] @ClassName = N'Customer' -- nvarchar(128)

Note that the table will be created with the TableName as per the
MFClass Table.  Perform a select statement on the table to view the
columns that has automatically be created.



Update Records in Class Table
-----------------------------

The records can now be updated from M-Files by executing the update
procedure. Note that class tables with take some time to update.  First
consult the section on UpdateTable for further guidance when large
datasets are updated.

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         EXEC [dbo].[spMFUpdateTable]
             @MFTableName = N'MFCustomer'
           , -- nvarchar(128)
             @UpdateMethod = 1

Perform another select statement on the table to view the records.



Ready for real action
---------------------

You are now ready for real action.  Follow the section on using the
Connector to plan and execute your application of the connector.

Using example scripts
=====================

Examples scripts for the most common procedures and functions  are
included in the installation package.  The scripts are prepared using a
standard M-Files Sample vault and will include illustrations using
objects from this vault.

The scripts are located at:

-  InstallationFolder\Laminin Solutions\MFSQL Connector Release
   4\DatabaseName\Example Scripts

Open the scripts in SSMS.  Follow the guidelines in the scripts to
select the instructions in blocks rather than executing the entire
script.

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      Use the scripts in conjunction with this guide.  The script only
      include a brief explanation or guide for the use of the different
      procedures and is not intended to replace this guide.


