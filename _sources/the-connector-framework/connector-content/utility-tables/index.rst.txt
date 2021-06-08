Utility Tables
==============

A number of special tables is included in the Connector. The use and columns of these tables are described in the following sections


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


Note that the 'Time' datatype in M-Files converts a varchar value
to a valid time in M-Files. The input value in SQL for a time
based column must be a string of the format nn:nn using the 24
hour time format.  hours and minutes outside 1-24 and 0-59 will
result in a M-Files datatype error.

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


MFProcess table
---------------

Several process_IDs are used as a standard by the Connector to indicate
the status of a record in the ClassTable for processing. These IDs are
defined in the Process table. The following process_id are predefined
and must be retained in the settings table. Additional processes that is
application specific may be added to the table.
