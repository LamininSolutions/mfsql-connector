Setup powershell utilities
==========================

Powershell utilities is provided on an as-is basis to enhance the flexibility and deployment of distinct scenarios

The following utilities are available:
  - FolderExport_V3 is a utility to aid file importing routines and is used to get the file locations in a network drive into a SQL staging table.
  - FolderExport_V4 is an expansion of version 3 and include the ability to setup and import CSV files without the analysis and exporting of the folder structure.
  - SQLScheduler_V3.4 is a utility to use windows scheduler to run SQL procedures.

Location of powershell utilities
--------------------------------

The utilities is included in the installation package and can be found in the MFSQL Connector installation folder the 60_addOns subfolder.

The powershell utilities is provided as-is examples and applications to extent MFSQL Connector. We recommend to engage with us for the use and deployment of these utilities to complete the setup and running of the utilities in your environment.

The utilities require Powershell 5.0 + and SQLServer module to access the SQL Server.
To install powershell modules run \\library\\FE_Module_install in powershell as administrator in sequence.

Security considerations
-----------------------

The powershell utilities are designed to run with windows integrated security.  The context of the permissions of the underlying user shouled therefore have read.write access to the folders on the network and the target database.

If the powershell utility is triggered by a sql agent job, then the SQL Agent user must have permissions to the folders.  This may require setting up the agent with a certificated user. :doc:`/blogs/setup-agent-proxy/index` 

SQL scheduler
-------------

Automation and scheduling of procedures for SQL Express
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SQL Express does not allow the use of agents.  The Powershell utility SQLScheduler_V3.4 enables scheduled procedures for SQL Express scenarios.

This utility is intended as an alternative for using SQL Agent for scheduling MFQL Connector procedures
This is particularly relevant when using SQL Express for running the following processes for any number of databases in a server:

  - Automating the MFVersion update : MFVersionUpdate
  - Updating all class tables for reporting : UpdateAllTables
  - Deleting history : DeleteHistory

The utility can be included in windows task scheduler to be run with set intervals. Each Setup XML file points to a specific Server. The server can have multiple databases to be processed (e.g. production and test, or different vaults) and each database can have multiple predefined processes that can be scheduled in the task scheduler.    A separate bat file is required for each process.

The following bat file is provided as an example.
MFSQLSchedule_UpdateAllIncludedInAppTables.bat for running spMFUpdateAllIncludedInAppTables with @UpdateMethod = 1, @Isdeleted = 1

The results of the most recent update is recorded in the processlog. \\logs\\processeslog.txt
Any errors are recorded in the errorlog. \\logs\\errorlog.txt

SQL Scheduler Prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~~

 - Powershell 5.0 + is required.
 - SQLServer module is required to access the SQL Server.  Use the PS script in /library to test and install this module.
 - Run the routine with windows credentials with access to SQL and the MFSQL Connector database
 - The connection string is set to use windows integrated security. Run the bat file as administrator if the current user does not have admin rights and have execution rights on the SQL server and databases

Content of the package
~~~~~~~~~~~~~~~~~~~~~~~

 - MFSQLScheduler_Main.ps1 : this is the main routine. Use bat file to execute each procedure.  Do not execute the ps1 file directly.
 - xxx.bat : used to execute the main routine. A separate bat is used for each procedure. Refer to the section below for modifying bat file.
 - SQLScheduler.XML : The main configuration file. A separate configuration file is required for each database. Refer to different section to setup.
 - \\Library\\ : the library contains the functions called by the main routine.
 - \\Log\\ : error and processing log. folder and files are created by utility.

Setup
~~~~~

 - Open MFSQLScheduler.xml with notepad or a xml editor.

  - modify the SQLScheduler\\ApplicationPath to match the filepath where this utility is saved.
  - modify SQLScheduler\\TargetDB\\Server to set the target server for the SQL destination
  - modify SQLScheduler\\TargetDB\\Database to set the name of the Database to export to and enable disable each process to be included.

 - The main application makes provision for setting up multiple databases and multiple processes per database
 - DO NOT CHANGE the names of the processes. Only change the true / false for the IsIncluded attribute indicating if the process should be included for the specific database
 - Each process has been setup to use default parameters. Changes to these parameters are unique to the underlying procedure and should only be changed in exceptional cases.
 - The sample XML include sample data, including a sample second database for illustration. Delete the extra database node if you are not using multiple databases.

Bat File
~~~~~~~~

 - Use a separate bat file for each process. The app include sample bat files for the processes that can be used.
 - Open bat file with notepad
 - Modify the string after -Command to reference the path of the main routine + setupfilename + processname
 - spaces and case matters.

Example:
E:\\Development\\TFS\\LSApplications\\Powershell_Apps\\SQLScheduler\\MFSQLScheduler_Main.ps1 MFSQLScheduler.xml UpdateAllTables"

Windows task scheduler
~~~~~~~~~~~~~~~~~~~~~~

 - Schedule the process to run automatically at predefined intervals using windows task scheduler.
 - Execute the bat file using the standard windows task scheduler setup.
 - Run the bat file with windows permission as outlined above.

Folder & CSV export to SQL
-------------~~~~~~~~~~~~~

The Folder export utility (V4) has two functions:  
 -  Exporting the folder and file structure details to SQL tables
 -  Exporting a CSV or CSVs to SQL tables

The Folder exporting utility FolderExport gets the name and location of files in explorer or network drive.  A powershell utility is used to update SQL with the file and folder data from explorer.  The utility is designed to be run on the SQL server and the SQL server need access to target network folders

This utility will export structured folder and file data from explorer for a specific directory to a) CSV files b) tables in an SQL database.

The csv files and table names are based on the settings in the setup file and will be created automatically. When rerunning the process the csv files and tables will be reset.

The data includes the file hash for file extensions in the setup file.  Note that the inclusion of the hash will increase the runtime of the process significantly, especially has the hash extensions include large files such as videos, zip files etc.

Incorporating the CSV or tables in the application is further detailed in :doc:`/mfsql-integration-connector/working-with-files/index`

<<<<<<< Updated upstream
CSV Exporter Prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~

 - Powershell 5.0 + is required.
 - SQLServer module is required for the export to the SQL database
 - Run with windows credentials with access to SQL and the explorer file structure.
 - Access to SQL is based on using windows integrated security

=======
>>>>>>> Stashed changes
Setup of security
~~~~~~~~~~~~~~~~~

Setup a windows service account with access to the designated folders. Add the service account in SQL and assign it to the db_MFSQLConnector role in the MFSQL database.

File export content of the package
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 - FolderExport_Main.ps1 : this is the main routine.  Use FolderExport.bat to execute.
 - FolderExport.bat : used to execute the main routine. Refer to different section for modifying bat file.
 - FolderListExport.XML : the main configuration file. Refer to different section to setup.
 - \\Library\\ : the library contains the functions calls by the main routine.
 - \\Log\\ : error and processing log. folder is created by utility and level of logging is dependent on the options selected in the bat file.
 - \\CSV\\: csv output for the folder and file listing. file name is set in configuration file.

Output of File export
~~~~~~~~~~~~~~~~~~~~~

Related to files:

   - [FileName] - file name without path
   - [Extension] - file extension
   - [SubPath] - file path excluding the root
   - [FullPath] - full path including the file name
   - [Length] - length in bytes (devide by 1024 to get kilo bytes
   - [Creation] - file creation date
   - [LastAccess] - date when file was last accessed
   - [LastWrite] - date when file was last written
   - [Attributes] - file attributes
   - [IsContainer] - show if directory
   - [RootPath] - file root used in the extraction, as per setup file
   - [Hash] - file hash, include on files with extensions set it setup file

Related to folders

   - [Path] - path root
   - [Drive] - drive
   - [Parent] - parent name
   - [Folder] - folder name
   - [FullPath] - path, including root
   - [PathFileCount] - count of files in path
   - [PathSize] - total of all files in path
   - [FolderFileCount] - count of files in folder
   - [FolderSize] - total of files in folder
   - [Root] -  root used in the extraction, as per setup file

Setup of File export
~~~~~~~~~~~~~~~~~~~~

 - Open FolderlistExport.xml with notepad or a xml editor.

  - modify the FileImporter\\ApplicationPath to match the filepath where this utility is saved.
  - modify FileImporter\\Folders\\Folder\\Root to the root filepath where the files and folders for exporting is located
  - modify FileImporter\\Folders\\Folder\\ShortName to set the name of the CSV file and Database Table name.
  - modify FileImporter\\Folders\\Folder\\HasExtensions to set the file extensions for which to include the hash. List must be comma delimited and include the period. Generating the hash for the files significantly increase the run time. Hash is used to identify duplication files.
  - modify FileImporter\\Folders\\CSVlist\\CSVName to add a row for each CSV file to be imported(FolderExport_V4 only)
  - modify FileImporter\\TargetDB\\Server to set the target server for the SQL destination
  - modify FileImporter\\TargetDB\\Database to set the name of the Database to export to.

Setup of target database
~~~~~~~~~~~~~~~~~~~~~~~~

Download the script :download:`setupDatabase <setupDatabase.sql>` or in the application folder to set the permissions and users in the database.  Note this script need modifications for your specific environment and should be used as a baseline.

Download the script :download:`expl.ValidateDatabase <expl.ValidateDatabase.sql>` or in the application folder to update the procedure in the target database

File export Bat file
~~~~~~~~~~~~~~~~~~~~

Open FolderExport.bat with notepad. Modify the string after -Command to reference the path of the main routine.

Note this command line is set to use basic process logging (the default parameter)
There are three switches

 - Switch 1:  This switch are only used in exceptional cases. Should be set to $False
 - Switch 2:  Used for debugging individual file issues and produce detail record of updates when set to $True. Default is $False
 - Switch 3:  This switch will block updating SQL database tables automatically. Set this switch to $False if the csv files will be imported manually.
 

CSV Import bat file
~~~~~~~~~~~~~~~~~~~~~~~~~~

Open CSVImport.bat with notepad. Modify the string after -Command to reference the path of the main routine.

Note this command line is set to use basic process logging (the default parameter is $false)


