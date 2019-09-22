Demonstrate new Release 4.3.9.48 functionality
==============================================

Release 4.3.9.48 introduces a range of improvements and new
capabilities. This blog provides a quick overview for the following:

Context menu

#. New method of managing connection string for context menu

#. Change in context menu security

Installation and upgrade

#. New installation and upgrade procedures

#. Improved validation of M-Files version change and MFSQL Connector API
   upgrade.

#. Improved validation of the connection

File Management

#. New ability to import files from explorer folders

#. Improved exporting of files

#. Improved File import table history

Large Vaults

#. New ability to get Object Version data in batches

#. Improved Table Audit procedure to get object versions

#. Improved Update M-Files to SQL for larger tables

Data management

#. Improved auto updating of changes to workflow state names

#. Improved validation of property and column usage on class tables

#. Improved Metadata structure view

#. Improved search for object

The upgrade include a several bug fixes and smaller improvements

--------------

UPGRADING FROM A PREVIOUS VERSION TO VERSION 4.3.9.48 HAS SPECIAL
CONSIDERATIONS. TAKE NOTE OF THE INSTRUCTIONS AND VIDEO.

--------------

Named value storage: New method of managing connection string
-------------------------------------------------------------

Using Context Menu features is dependent on the connection string to the
MFSQL Connector database in the M-Files vault. The Context Menu covers
all operations where a call is made from M-Files to SQL such as using
the action menu, workflow state actions or event handler actions.

Improvements in M-Files Vault Application Framework has made it possible
to manage the connection string in the named value storage. Switching
from using an object to store the connection string to named value
storage has a material impact on the installation and upgrade of the
Connector.

Context menu security
---------------------

The context menu no longer works with assigning security to all internal
users. It is now a requirement to maintain a user group with specific
users that is authorized to access the context menu and perform
individual actions.

Check the users in the ‘ContextMenu’ user group. Remove ‘all internal
users’ and assign the users either individually or as another user group
in the ContextMenu user group. Users not included in the ContextMenu
user group will not have visibility of the context menu action menu in
M-Files.

I addition, check the table MFContextMenu column UserGroupID. Assign a
user or usergroup to each action. Note that assigning ‘all internal
users’ (id 1) is no longer valid.

Upgrades from a version prior to 4.3.9.48 to 4.3.9.48 and later
---------------------------------------------------------------

Follow the video for upgrading from a previous version.

Follow the video for installing a new instance.

Checklist and tips:

#. Take vault offline and bring back online after M-Files Vault
   installation routines, application installation, license installation
   and configuration.

#. Check the vault application version, it should be 3.2.1.50 or later.

#. Ensure configuration is done with system admin credentials. If not,
   the configuration will appear empty.

#. Check if Context Menu displays in M-Files. If not, add users
   explicitly to the group to access the menu.

Importing files from explorer
-----------------------------

The new procedure
`spMFUpdateExplorerFileToMFiles <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/622493726/File+import+from+explorer+using+spMFUpdateExplorerFileToMFiles>`__
allows for importing a file or files from explorer into M-Files. In
simple terms an explorer file is matched with the record in the class
table and imported into M-Files.

-  The object can be created in M-Files using MFSQL Connector at the
   same time as importing the file.

-  If another file is added to a single file object, it would
   automatically be converted to a multifile document

-  The file in M-Files will be overwritten If the file already exists
   for the specific object

The following is required to make it all fit together:

-  The location of the file

-  The name of the file

-  The destination class table

-  The SQL id of the record in the class table to attach the file to.

The table MFFileImport show a history of the importing of files.

Refresh M-Files view or the object F5 after running procedure to show
the updated object

.. code:: sql

    DECLARE @ProcessBatch_id INT;
    DECLARE @FileLocation NVARCHAR(256) = 'C:\Share\Fileimport\2\'
    DECLARE @FileName NVARCHAR(100) = 'CV - Tommy Hart.docx'
    DECLARE @TableName NVARCHAR(256) = 'MFOtherDocument'
    DECLARE @SQLID INT = 1


     EXEC [dbo].[spMFUpdateExplorerFileToMFiles] 
     @FileName = @FileName
     ,@FileLocation = @FileLocation 
     ,@SQLID = @SQLID                         
     ,@ProcessBatch_id = @ProcessBatch_id OUTPUT      
     ,@Debug = 0      
     ,@IsFileDelete = 0
                         
    SELECT * from [dbo].[MFFileImport] AS [mfi]  

In some cases the name of the file and location of the file is derived
from another database.

Contact us if you would like to know more about using a powershell
utility to import the file names and folder locations of the files into
SQL as a preparatory step to match the files to the objects in the class
table.

Getting object version detail in batches
----------------------------------------

The procedure
`spMFTableAudit <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/686030990/Get+Object+version+with+spMFTableAudit>`__\ has
been in operation for some time. This procedure extracts the object
version (object id, version, object guid and object type).

Using the
`spMFTableAuditInBatches <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/685899953/Using+spMFTableAuditinBatches+for+large+class+tables>`__
will allow you to execute the spmfTableAudit procedure in batches. This
is used in cases where the number of objects in the class table exceeds
100 000.

.. code:: sql

    EXEC [dbo].[spMFTableAuditinBatches] @MFTableName = 'MFCustomer' -- nvarchar(100)
                                        ,@FromObjid = 120   -- int
                                        ,@ToObjid = 130     -- int
                                        ,@WithStats = 1   -- bit
                                        ,@Debug = 0       -- int

The following is an example of the result if the option to show stats is
selected. It took 9 seconds to process 15 items starting from objid 120.

|image0|

Exporting of files
------------------

`Exporting files
f <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/57913733/spMFExportFiles+for+exporting+files+to+SQL>`__\ rom
M-Files using the Connector has been available for some time. The
primary use of this functionality is to get a file from M-Files and be
able to attach it to a database email, and therefore send bulk emails
with attachments.

The functionality has been enhanced to allow for multi-file document
objects and to include the file object id in MFExportFileHistory.

Related script to demonstrate function: 06.102.Exporting files from
M-Files

Change of workflow state names
------------------------------

When the name of a state is modified in M-Files, it does not trigger a
change of version of the underlying object and the name change there
does not replicate through to SQL. This is particularly relevant where
the state column in the class table is used in reporting.

The procedure
`spmfSynchronizeWorkFlowSateColumnChange <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/640614411/spMFSynchronizeWorkflowStateColumnChange+to+update+workflow+state+changes>`__\ will
run through the class tables and update all state name changes.

Related script to demonstrate function: 01.201.Resetting workflow state
names on all class tables

Property and column usage in SQL
--------------------------------

The procedure `spMFClassTableColumns
w <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/687374389/spMFClassTableColumns+for+analysis+property+usage>`__\ orks
through all the properties and related columns for class tables and
provide a report on the usage of properties in the Connector. This
report is particularly powerful in complex and vaults with multiple
integration points.

The result of the procedures is saved a temporary table. This table can
be used in subsequent processes detect potential anomalies and trigger
corrective action.

`spMFDropAndUpdateTable <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/36536345/spMFDropAndUpdateMetadata>`__
is improved to detect inconsistencies with column usage and
automatically update the metadata

`spMFUpdateTable <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/31817730/spMFUpdatetable+Class+Table+Records>`__
is improved to validate columns and automatically execute updating of
the metadata if the metadata has changes since the last update. Note
that this check could increase the run time for spMFUpdateTable
significantly when executed just after a metadata change in the vault.

Get object version for specific object or objects
-------------------------------------------------

The
`spMFTableAudit <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/686030990/Get+Object+version+with+spMFTableAudit>`__\ and
associated MFTableAuditHistory has been redesigned. The
MFTableAuditHistory table is changed to only show the latest result and
no longer inserts new records for every processing cycle. This
improvement had a major performance improvement on some processing.

It is now possible to use this procedure for specific objects or range
of objects. It is therefor possible to determine the update status of an
object and allow then to only update objects that have changed. This is
particularly relevant for large tables.

Performance improvements for spMFUpdateMFilestoSQL
--------------------------------------------------

The
`spMFUpdateMFilestoSQL <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/31817730/spMFUpdatetable+Class+Table+Records>`__
has been around for some time to update large tables from M-Files to
SQL. Several changes have been made to this table to improve
performance.

Improved validations during connection test
-------------------------------------------

The spMFVaultConnectionTest has been improved to perform a variety of
tests when executed. These tests include

#. Validate login credentials

#. Validate the M-Files version for the assemblies

#. Validate license

The procedure includes a new option to run silently, which allows the
procedure to be included in other procedures as part of a validation
test.

Extend importing files capability
---------------------------------

The Importing of files using spMFUpdateExplorerFileToMFiles will list
all the files imported, or rejected in the MFMfileImport table. The
results of each file import is shown in the column ImportError.

Extended columns in Metadata structure view
-------------------------------------------

The view MFvwMetadataStructure is a powerful tool to analyse the
relationships between different parts of the metadata structure of the
vault.

Managing updates to valuelists depends on if a valuelist has been
elevated to a full object type or not. When a valuelist is elevated the
controlling table changes from MFValuelist and MFValuelistItems to a
class table.

The column IsObjectType in the view will show if a valuelist has been
elevated or not.

Using this view as part of the design process, especially of a complex
vault, could be very handy It can also be used as a control measure to
validate metadata design changes that could impact on a integration
project.

Improve search for an object
----------------------------

One of the options when using spMFSearchForObject is to pipe the result
to a table. Previously, the result was piped to a separate permanent
table for each search, which could result in multiple tables
accumulating in the database. This permanent table has now been replaced
by a global temporary table. This allows for the automatic management of
tables that is no longer used in the process.

Validation of M-Files version and upgrade
-----------------------------------------

This release introduces the ability to automate the upgrade of MFSQL
Connector on the change of M-Files Version. See `separate
blog <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/blog/2018/11/22/610795521>`__
for more detail on the topic.

.. |image0| image:: img_1.png
