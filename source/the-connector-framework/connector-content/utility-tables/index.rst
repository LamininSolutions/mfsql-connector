Utility Tables
==============

A number of special tables is included in the Connector:

.. container:: table-responsive

   | 

   .. container:: table-wrap

      Utility Tables

MFDataType

MFDataTypes are used by the Connector to convert the M-Files datatypes
to SQL datatypes. This table should not be changed as it will make the
assemblies inoperable.

MFDeploymentDetail

Used to store the deployment details

MFSettings

Used to store the connection details to the Connector Database and other
settings

MFVaultSettings

Used to store the connection details to the M-Files Vault

MFProcess

Include the process id and description of the process.



MFDataType
----------

The MFDataType table allows for converting between the M-Files DataType
definitions and SQL datatype definitions. This table is used with
spMFCreateTable to set the columns of the class table.

.. container:: confluence-information-macro confluence-information-macro-tip

   Time Datatype

   .. container:: confluence-information-macro-body

      Note that the 'Time' datatype in M-Files converts a varchar value
      to a valid time in M-Files. The input value in SQL for a time
      based column must be a string of the format nn:nn using the 24
      hour time format.  hours and minutes outside 1-24 and 0-59 will
      result in a M-Files datatype error.

| 



MFDeploymentDetail
------------------

The MFdeploymentDetail table is maintained by the Connector and show the
latest version of the Connector that is deployed in the database.



MFSettings
----------

The Settings Table defines key settings that is used by the Connector.
It can also be used for other settings required in the application as
long as the structure of the table is not changed and the minimum
requirements for the Connector is met.

The table is used for the M-Files user and vault settings for the
Connector as outlined in the security section.

When use encrypt and decrypt procedures when the M-Files password is
updated in the settings table as described in the CLR integrated
security section

The table is also used for the email settings used by the Connector as
described in the error management section

Enable the SQL instance for Email Management and create email profile
for the Connector.  This email profile must be updated in the value
column of the setting SupportEMailProfile.

The following settings must be present for the Connector to operate:

| 

.. container:: table-wrap

   MFVaultSettings

Name

Description

Value

Username

Username

M-Files User name assigned to the Connector

Password

Password

Password of user

NetworkAddress

Network Address

server URL for vault

VaultName

Vault Name

Vault name on Server

ProtocolType

Protocol Type

TCP/IP, HTTPS and localhost is allowed. Default to TCP/IP

AuthenticationType

Authentication Type

M-Files, and Windows authentication is allowed. Default to M-Files
authentication

Endpoint

Endpoint

Port 2266 is default.

Domain

Domain

Default to null. Only required if windows authentication type is
selected

.. container:: table-responsive

   | 

   .. container:: table-wrap

      MFSettings

source_key

Name

Description

Value

MF_Login

Username

Username

M-Files User name assigned to the Connector

MF_Login

Password

Password

Password of user

MF_Login

NetworkAddress

NetworkAddress

server URL for vault

MF_Login

VaultName

VaultName

Vault name on Server

Email

SupportEmailRecipient

Email account for recipient of automated support mails

email address to receive error logs

Email

SupportEMailProfile

EMail Profile used for sending emails

SQL email profile to be used for system emails. uSE the SQL instance for
Email Management to obtain an email profile for the Connector.

MF_Default

VaultGUID

GUID of the vault

QUID of the target vault.

MF_Default

ServerURL

Server URL

The URL used to access the vault with Web or Mobile.

MF_Default

MFInstallPath

Path of MFiles installation on server

This is the path where M-Files is installed on the SQL Server. This path
defaults to C:\Program Files\M-Files. Note that his setting must be
correct to install the assemblies.

MF_Default

MFVersion

Version Number of MFiles

This is the installed version number of M-Files for example
11.2.4320.51. Note that this value must be correct to install the
assemblies. When M-Files is upgraded then this value must be updated in
the settings table before updating the assemblies.

App_Default

App_Database

.. container::
ui-input-text ui-body-inherit ui-corner-all app-static-text

   .. container:: app-field-Description app-field

      Database of Connector

Name of the database for the connector.

App_Default

App_DetailLogging

ProcessBatch Update is active

Default set to 0.  This switch will activate logging to the
MFprocessBatch and MFProcessBatchDetail tables.

App_Default

AssemblyInstallPath

Path where the Assemblies have been saved on the SQL Server

DBDeploy will access the assembly files from this folder that must be
accessible from the SQL Server. The default folder is c:\CLR.

App_Default

AppUserRole

Database App User role

The Connector will use this role to assign the required permissions and
settings during the installation. The default value is AppUserRole.

App_Default

AppUser

Database App User

The connector will use this login account as the user account. The
default value is MFSQLConnect.

| 

| 

| 

| 

| 

Error messages will be send by email to the email address in the setting
SupportEmailRecipient

An example of such an email is below 



MFProcess table
---------------

Several process_IDs are used as a standard by the Connector to indicate
the status of a record in the ClassTable for processing. These IDs are
defined in the Process table. The following process_id are predefined
and must be retained in the settings table. Additional processes that is
application specific may be added to the table.

| 
