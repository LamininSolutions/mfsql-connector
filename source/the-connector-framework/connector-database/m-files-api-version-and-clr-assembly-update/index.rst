M-Files API version and CLR Assembly update
===========================================

The M-Files APIs is loaded into the Connector Database as part of
the assemblies of each database.  It is required to ensure that
the API version of the M-Files Client on the SQL Server remains
the same as the API version in the assemblies of the Database. 
When the M-Files Client on the SQL Server is upgraded to
assemblies will go out of sync and the Connector will stop
working.

Version 4.3.9.48 introduced an new method of automatically
monitoring the M-Files version change and updating the assemblies.

-  An agent is created during installation to run every day. This
   agent will check the installed M-Files version on the SQL
   server using spMFCheckAndUpdateAssemblyVersion. If the M-Files
   version changed, the MFSettings table is updated and the
   procedure spMFUpdateAssemblies are executed.
-  The procedure spMFUpdateAssemblies can be executed manually to
   update the assemblies.

MFSQL Connector will fail if the M-Files API (M-Files version
specific) changes without updating the assemblies in the database.

============== =============================================
Type           Description
============== =============================================
Procedure Name spMFUpdateAssemblies
Inputs         Debug: 1 = Debug Mode; 0 = No Debug (default)
Outputs        1 = success
============== =============================================
