Manual installation using scripts
=================================

In special use cases in may be required to install or re-install MFSQL Connector manually.  It is especially relevant when the developer or installer does not have sysadmin rights on the SQL Server to install software or perform the installation routine.


Key steps
---------

  - **Install package on workstation**
  
      -  The installation package of the Connector allows for creating the installation package on a workstation and then to use the components of the installation package for manual installation on the different servers.
      -  To prepare for manual installation the installation package must be installed on a workstation. The installation of M-Files Desktop on the workstation is a pre-requisit.
      -  Run the installation selecting the default paths.  When prompted log into M-Files and the target vault using the MFSQL Connector M-Files credentials. Do not select any installation options and proceed to connecting to the SQL Server.  Specify the SQL server to connect to and the MFSQL Connector database. Type in a new name if the database has not yet been created. Select next to complete the installation.
      -  The above installation will not perform any operations on M-Files Server or SQL Server.  However, it will place all the installation files in the installation folder on the workstation.

      -  The following installation files are relevant for the manual installation

        -  C:\\Program Files (x86)\\Laminin Solutions\\MFSQL Connector Release 4\\[Database Name]\\Content Package
        -  C:\\Program Files (x86)\\Laminin Solutions\\MFSQL Connector Release 4\\[Database Name]\Database Scripts
        -  C:\\Program Files (x86)\\Laminin Solutions\\MFSQL Connector Release 4\\[Database Name]\\Vault Applications

    -  Assemblies  (destination can be changed)

        -  C:\\MFSQL\\Assemblies

  - **Manual install of M-Files Server**
  
    - For M-Files Cloud installations: Request M-Files support to perform the installation.
    - For other M-Files Server manual installation scenarios: Manually install the content package, and Vault Applications in the installation folder
  
  - **manual install of SQL Server**
 
    - Copy Assemblies to SQL Server using the same directory structure as the workstation.
    - Install M-Files desktop on SQL Server
    - Run SQL Scripts in Database Scripts installation folder in sequence. 



