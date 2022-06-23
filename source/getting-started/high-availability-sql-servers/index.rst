==========================================
High Availability SQL Servers installation
==========================================

MFSQL Connector can be used in a high availability SQL Server cluster.

To install and upgrade MFSQL Connector the following additional steps and considerations should be taken into account.

 -  M-Files Desktop must be installed on all the cluster member servers. It is imperative to maintain the same M-Files version on all members.
 -  Disable automatic upgrades for M-Files on every member server
 -  The standard SQL Server installation is performed on the main cluster server. Note that it is not necessary to perform the installation on every member server as SQL will automatically replicate the installation and any updates / customisations to the other members
 -  The MFSQL assemblies must be copied from the main cluster server to each member server.  For instance, copy the folder c:\MFSQL\Assemblies to each member server

Schedule quarterly upgrades for both M-Files and MFSQL Connector to ensure that the versions of both will be maintained on the cluster.  For an upgrade, the M-Files upgrades will have to be triggered manually on each member server. MFSQL Connector upgrade is only installed on the main server.  Only if the assemblies have changed, it is necessary to copy the assemblies over to the other members.

On completion of the installation, perform exec spMFUpdateAssemblies @MfilesVersion = 'Version of mfiles e.g. 22.6.3456.4'
