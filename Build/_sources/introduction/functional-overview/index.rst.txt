Functional Overview
===================

The following is a functional overview of all the different aspects of
MFSQL Connector by package.   Refer to `Connector
Modules <https://doc.lamininsolutions.com/mfsql-connector/introduction/mfsql-connector-modules/index.html>`_ for more detail about the
different packages.

Overview of functional composition of the modules
-------------------------------------------------

The columns below reference the following modules

#. Data Exchange and Reporting Connector
#. Integration Connector
#. Database File Connector

============================================  ======  ======   ======
Functional element                            1       2        3
============================================  ======  ======   ======
**Metadata structure**                        |       |        |
Auto create metadata structure tables         |tick|  |tick|   |
Analyse and refresh metadata using SQL        |tick|  |tick|   |
Drop & recreate metadata                      |tick|  |tick|   |
Update names and aliases from SQL             |       |tick|   |
Insert new valuelist items from SQL           |       |tick|   |
Update aliases in bulk                        |       |tick|   |
Analyse metadata structure relationships      |tick|  |tick|   |
Show login accounts, user accounts details    |tick|  |tick|   |
Show workflows and workflow states            |tick|  |tick|   |
Show valuelists and valuelist items           |tick|  |tick|   |
Auto Create valuelist and workflow views      |       |tick|   |
Show complex ownership relationships          |       |tick|   |
Explore metadata usage in vault               |tick|  |tick|   |
Get metadata structure version                |       |tick|   |
**Class Tables**                              |       |        |
Create new class tables                       |tick|  |tick|   |
Drop and re-create all class tables           |       |tick|   |
Batch update of records                       |tick|  |tick|   |
Update only changed records                   |tick|  |tick|   |
Concurrent update processes                   |       |tick|   |
Update from and to M-Files                    |tick|  |tick|   |
Update records from specific date             |       |tick|   |
Update records with specific objids           |       |tick|   |
Update records changed by specific SQL user   |       |tick|   |
Update all included in Application tables     |       |tick|   |
Update using filters                          |tick|  |tick|   |
Helper procedures for update filters          |       |tick|   |
Insert new records                            |tick|  |tick|   |
Hyperlinks to show and links in M-Files       |       |tick|   |
Format Hyperlinks for use in excel            |       |tick|   |
Get object hyperlink to public links          |       |tick|   |
Change classes and properties                 |tick|  |tick|   |
Delete records                                |tick|  |tick|   |
Delete adhoc properties in bulk               |tick|  |tick|   |
Get objver of objects                         |       |tick|   |
Copy objects in M-Files                       |       |tick|   |
Add comments for objects                      |       |tick|   |
Search objects                                |       |tick|   |
Delete adhoc properties                       |       |tick|   |
**Special Functions**                         |       |        |
Work with delimited string objects            |tick|  |tick|   |
Convert data into html format for reporting   |       |tick|   |
Include table in notification                 |       |tick|   |
Send html formatted email                     |       |tick|   |
Remove special characters in naming           |tick|  |tick|   |
Insert update multi lookup values             |       |tick|   |
Send bulk notifications using templates       |       |tick|   |
**Files**                                     |       |        |
Export files from M-Files to Folders          |       |tick|   |
Send bulk emails with attachments             |       |tick|   |
Import files from Database Blobs              |       |        |tick|
Checksum of a file in M-Files                 |tick|  |        |tick|
Import files from network folders             |       |tick|   |tick|
Get file size                                 |       |tick|   |
Get data on files without downloading file    |       |tick|   |
View and search files in Blobs in M-Files     |       |        |tick| 
Promote external Blobs as metadata            |       |        |tick|
**Views and Reporting**                       |       |        |
Explore full metadata structure               |       |tick|   |
Create views for related lookups in bulk      |       |tick|   |
Class Table Statistical report                |       |tick|   |
Explore use of columns and errors             |       |tick|   |
Explore valuelist item ownership relations    |       |tick|   |
Export and views of M-Files event log         |       |tick|   |
Export object history from M-Files            |       |tick|   |
Produce process log summary for class tables  |       |tick|   |
View Error log                                |tick|  |tick|   |
Get and create comments of objects            |       |tick|   |
View Update History                           |tick|  |tick|   |
View Process Batch logs                       |       |tick|   |
View User Messages                            |       |tick|   |
View Audit History                            |       |tick|   |
**Valuelists and valuelist items**            |       |        |
Create valuelist lookup views                 |       |tick|   |
Create  workflow state lookup views           |       |tick|   |
Create, update, delete valuelist items        |       |tick|   |
**Operations in M-Files**                     |       |        |
Configurable context menu with items          |tick|  |tick|   |
Access Website                                |tick|  |tick|   |
Execute procedure on object                   |tick|  |tick|   |
Execute procedure with workflow trigger       |       |tick|   |
Execute procedure event handler trigger       |       |tick|   |
Show user message                             |tick|  |tick|   |
Process procedures synchronously              |       |tick|   |
Process with feedback message                 |       |tick|   |
Process procedure asynchronously              |       |tick|   |
Using SQL actions with WebAPI in cloud vault  |       |tick|   |
**Error Handling**                            |       |        |
Email notification of SQL errors              |tick|  |tick|   |
User Messages                                 |       |tick|   |
Error logging                                 |tick|  |tick|   |
Email sent log                                |       |tick|   |
Process logging                               |       |tick|   |
show user message from SQL in M-Files         |       |tick|   |
Formatted emailed process results             |       |tick|   |
Show feedback message in M-Files              |       |tick|   |
Validate email profile                        |       |tick|   |
Perform Class Table audits                    |       |tick|   |
Delete history logs                           |       |tick|   |
**Special Applications**                      |       |        |
External application user to filter updates   |       |tick|   |
Action M-Files Reporting Data Export          |tick|  |tick|   |
Update metadata on demand                     |tick|  |tick|   |
Update metadata scheduled                     |tick|  |tick|   |
Change history of any class property          |tick|  |tick|   |
**Installation and upgrade**                  |       |        |
Installation package                          |tick|  |tick|   |tick|
License control by module                     |tick|  |tick|   |tick|
Auto setup of default authentication for SQL  |tick|  |tick|   |tick|
Auto and manual install                       |tick|  |tick|   |tick|
Customize default settings                    |tick|  |tick|   |tick|
Retain custom settings when upgrading         |tick|  |tick|   |tick|
Sample scripts to aid development             |tick|  |tick|   |tick|
Install connectors for multiple vaults        |tick|  |tick|   |tick|
Control log of all versions of procedures     |tick|  |tick|   |tick|
Upgrade packages                              |tick|  |tick|   |tick|
============================================  ======  ======   ======

.. |tick| image:: img_1.png
