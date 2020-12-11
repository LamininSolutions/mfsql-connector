M-Files automatic upgrade
=========================

M-Files automatically upgrades to keep the M-Files software up to date.

MFSQL Connector must response to the upgrade of M-Files on the SQL Server. MFSQL Connector requires M-Files Desktop on the SQL Server where MFSQL Connector is deployed. When M-Files upgrades on the SQL Server it moves the location of the MFilesAPI to the new installed version. MFSQL Connector must therefore be updated to repoint the MFileAPI in the CLR Assemblies to the new location.

Methods to update MFSQL Connector
---------------------------------

#. Automatic Update

The Connector checks to validate if M-Files has upgraded by running the procedure `spMFCheckAndUpdateAssemblyVersion <https://doc.lamininsolutions.com/mfsql-connector/procedures/spMFCheckAndUpdateAssemblyVersion>`_.  This procedure can be run manually using `spMFUpdateAssemblies <https://doc.lamininsolutions.com/mfsql-connector/procedures/spMFUpdateAssemblies>`_, using a `SQL agent <https://doc.lamininsolutions.com/mfsql-connector/getting-started/first-time-installation/using-agent-for-automated-updates/index.html>`_ , or using a `powershell utility <https://doc.lamininsolutions.com/mfsql-connector/getting-started/first-time-installation/setup-powershell-utilities/>`_.  Use the powershell utility for SQL Express installations.

#. Manual update

Set the parameter to the current version of M-Files on the SQL Server then execute.

.. code:: sql

    EXEC [dbo].[spMFUpdateAssemblies] @MfilesVersion = '19.9.8028.5'

#. Rerun the installation package

Another way to reset the assemblies is to re-run the installation package of the MFSQL Connector.

#. Check the M-files version on the SQL Server

.. code:: sql

    Declare @IsUpdateAssembly int, @MFilesVersion nvarchar(25)
    Exec spMFGetMFilesAssemblyVersion @IsUpdateAssembly = @IsUpdateAssembly output, @MFilesVersion = @MFilesVersion output
    Select @IsUpdateAssembly as IsUpdateRequired, @MFilesVersion as InstalledVersion

Assembly related errors
-----------------------

An error reporting a missing procedure or that the assembly could not be found is usually an indication that the updating of the assemblies did not work.

Check the following:

 - Check the agent or powershell utility to verify that the update is running as expected.
 - If the Connector is running updates regularly during the day, then it is advisable to ensure the agent runs say every half hour to catch any unexpected automatic M-Files updates.
 - Running the updates, especially with Connector versions prior to 4.8.24.65 may result in the dropping of the CLR assemblies, without reloading the assemblies.  Run exec spmfUpdateAssemblies @MfilesVersion = 'the current version on the SQL server' to fix.
