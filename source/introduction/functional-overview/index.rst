Functional Overview
===================

The following is a functional overview of all the different aspects of
MFSQL Connector by package.   Refer to `Connector
Modules <./mfsql-connector-modules>`_ for more detail about the
different packages.

Overview of functional composition of the modules
-------------------------------------------------

The columns below reference the following modules

#. Data Exchange and Reporting Connector
#. Integration Connector
#. Database File Connector

============================================  ======  ======  ======
Functional element                            1       2       3
============================================  ======  ======  ======
**Metadata structure**                        |       |        |
Auto create metadata structure tables         |tick|  |tick|   |
Analyse and refresh metadata using SQL        |tick|  |tick|   |
Drop & recreate metadata                      |tick|  |tick|   |
Update names and aliases from SQL             |       |tick|   |
Insert new valuelist items from SQL           |       |tick|   |
Update aliases in bulk                        |       |tick|   |
============================================  ======  ======  ======

 Tables of object types, classes and properties and their relationships

 |tick|

 |tick|

| 

 Show login accounts, user accounts with email and other details in SQL

 |tick|

 |tick|

| 

 Show workflows and workflow states in SQL

 |tick|

|tick| 

| 

 Show valuelists and valuelist items in SQL

 |tick|

 |tick|

| 

 Show complex ownership relationships for valuelists and valuelist items

 |tick|

|tick| 

| 

 Get metadata structure version

| 

 |tick|

| 



Class Tables
~~~~~~~~~~~~

Create new class tables

|tick|

|tick|

| 

Drop and re-create all class tables

| 

|tick|

| 

Batch update of records

|tick|

|tick|

| 

 Allow for multiple update processes to run at the same time

| 

 |tick|

| 

Transact update of records

| 

|tick|

| 

Update from and to M-Files

|tick|

|tick|

| 

 Update records from specific date

| 

 |tick|

| 

 Update records with specific objids

| 

 |tick|

| 

 Update records changed by specific SQL user

| 

 |tick|

| 

Update all included in Application tables

| 

|tick|

| 

Update using filters

|tick|

|tick|

| 

Helper procedures to work with update filters

| 

|tick|

| 

Insert new records

|tick|

|tick|

| 

Get object hyperlink to show/open links in M-Files

| 

|tick|

| 

Get object hyperlink to public links

| 

|tick|

| 

Change classes and properties

|tick|

|tick|

| 

Delete records

|tick|

|tick|

| 

 Delete adhoc properties in bulk

 |tick|

 |tick|

| 

 Get objver (object versions) of object type in SQL 

| 

 |tick|

| 

Copy objects in M-Files

| 

|tick|

| 

 Add comments for objects

| 

|tick|

| 

Search objects

| 

|tick|

| 

Delete adhoc properties

| 

|tick|

| 

 Special SQL functions to work with delimited string objects

 |tick|

 |tick|

| 

 Special SQL function to remove special characters in naming of objects

 |tick|

 |tick|

| 

 Special SQL function to insert update multi lookup values

| 

 |tick|

| 

  **   Files**

 Export files from M-Files to Folders 

| 

|tick|

| 

 Use files to send out bulk emails with attachments

| 

|tick| 

| 

 Import files from Database Blobs into M-Files

| 

| 

|tick|

 Evaluate checksum of a file in M-Files to control external file changes

| 

| 

|tick|

 Import files from network folders using SQL.  Use power of SQL to
perform data cleansing before import.

| 

| 

|tick|

 View and search files in Database Blobs in M-Files without transferring
files (external repository objects)

| 

| 

|tick| 

 Promote external  repository objects as metadata

| 

| 

|tick|



Views and Reporting
~~~~~~~~~~~~~~~~~~~

Special views to explore full metadata structure

| 

|tick|

| 

 Create all related lookups in bulk

| 

|tick|

| 

Class Table Statistical report

| 

|tick|

| 

Special views to explore complex valuelist item ownership relations

| 

|tick|

| 

Export and views of M-Files event log

| 

|tick|

| 

 Export object history from M-Files

| 

|tick| 

| 

Produce process log summary for class tables

| 

|tick|

| 

View Error log

|tick|

|tick|

| 

Get and create comments of objects

| 

|tick|

| 

View Update History

|tick|

|tick|

| 

View Process Batch logs

| 

|tick|

| 

View User Messages

| 

|tick|

| 

View Audit History

| 

|tick|

| 



Working with valuelists and valuelist items
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create valuelist lookup views  with ownership relationships

| 

|tick|

| 

Create  workflow state lookup views

| 

|tick|

| 

Create/Update/Delete valuelist items from SQL

| 

|tick|

| 



Operations in M-Files 
~~~~~~~~~~~~~~~~~~~~~~

Configurable context menu with items

|tick|

|tick|

| 

Access Public/Intranet Website from within M-Files

|tick|

|tick|

| 

Execute procedure on object from within M-Files

|tick|

|tick|

| 

Execute procedure triggered by change of workflow state

| 

|tick|

| 

 Execute procedure triggered by change event handler

| 

|tick|

| 

Show user message

|tick|

|tick|

| 

Process procedure synchronously with feedback message

| 

|tick|

| 

Process procedure asynchronously (long running procedures)

| 

|tick|

| 

 Content package installation add object types, classes, properties,
user groups, workflows and views used by the connector

 |tick|

 |tick|

| 

| 



Error Handling
~~~~~~~~~~~~~~

Email notification of SQL errors

|tick|

|tick|

| 

User Messages

| 

|tick|

| 

Error logging

|tick|

|tick|

| 

Process logging

| 

|tick|

| 

 show user message from SQL in M-Files

| 

 |tick|

| 

 send formatted email notification of process results

| 

 |tick|

| 

 Show feedback message in M-Files of process result for synchronised
processing

| 

 |tick|

| 

 Validate email profile

| 

 |tick|

| 

Perform Class Table audits

| 

|tick|

| 

Delete history logs

| 

|tick|

| 



Special Applications
~~~~~~~~~~~~~~~~~~~~

Using external application user to filter updates

| 

|tick|

| 

Using ASPNET security provider for external application security (E.g.
Code on Time)

| 

|tick|

| 

 Action M-Files Reporting Data Export from SQL

 |tick|

 |tick|

| 

 Update metadata on demand, or scheduled with SQL agent to facilitate
near real time reporting

|tick|

|tick|

| 

 Include change history of any property of a class table for reporting
purposes

|tick|

|tick|

| 

.. _FunctionalOverview-Installation&Upgrade:

Installation & Upgrade
~~~~~~~~~~~~~~~~~~~~~~

Installation package 

||tick||

||tick||

|tick|

 Licence control by module

|tick|

|tick|

|tick|

 Installation configures default authentication for SQL

|tick|

|tick|

|tick|

 Auto and manual install of M-Files Content Package

|tick|

|tick| 

|tick|

 Auto and manual install of application packages

|tick|

|tick|

|tick|

 Auto and manual install of Assemblies on SQL server

|tick|

|tick|

|tick|

 Customise default settings 

|tick|

|tick|

|tick|

 Retain custom settings in settings tables when upgrading

|tick|

|tick|

|tick|

 Sample scripts to aid development

|tick|

|tick|

|tick|

Install connector for multiple vaults on the same servers

|tick|

|tick|

|tick|

 Maintains a control log of all versions of all procedures

|tick|

|tick|

|tick|

Upgrade packages

|tick|

|tick|

|tick|

| 

| 

| 

| 

| 

| 

| 

.. |tick| image:: img_1.png
   :class: emoticon emoticon-tick

