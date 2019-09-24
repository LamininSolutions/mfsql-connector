Connector Database
==================

.. toctree::
   :maxdepth: 4

   enabling-clr/index
   database-optimization/index
   database-mail/index
   m-files-api-version-and-clr-assembly-update/index
   backup-and-restore-of-connector/index

The SQL database targeted for the Connector is automatically created by
the deployment package.   The database can also be created in advance of
running the installation package.  



Create database
===============

The following should be considered when naming  the database:



Naming Convension: 
^^^^^^^^^^^^^^^^^^^

-  The Database will exclusively be used for the Connector and only
   contain one vault. Name the database to include easy reference to
   both connector and Vault.  We Recommend the naming convention
   'MFSQL_VaultName'



Size: 
^^^^^^

-  This database will contain a replica of the metadata structure of the
   specific M-Files Vault. These tables are generally small. It will
   also have all the class tables that is applied in the special
   application. The number of tables and record volume depends on the
   special application but is generally not very large.  The size of
   these tables will depend on usage and the number of records in the
   classes.  Note that these tables does not include file content which
   further restricts the size of tables. 
-  The largest tables in the database is likely to be the logging tables
   and class tables.  
-  When sizing and monitoring the growth of the database it is important
   to note the log files.  MFUpdateHistory in particular is likely to
   grow substantially, especially with high transaction volumes between
   M-Files and SQL. this table contains XML records of every update.



Access Security: 
^^^^^^^^^^^^^^^^^

-  The connector requires a login account that can access the database.
   The following rights should be granted to the user: execute for all
   store procedures in the database; create, update, delete tables and
   views in the database. Note that the installation will assign a
   default user and role and set the permissions. This can be changed if
   required.  Consult the security section regarding the security
   settings.



Enabling the database
=====================

The installation routine will automatically change the settings of the
database to enable CLR. The routines that is included in the
installation scripts is described in the next section.

| 

.. container:: table-wrap

   ==========================================================
   **Related Topics**
   ==========================================================
   -  `Security <page21200958.html#Bookmark90>`__
   -  `Enable CLR <page21201034.html#Bookmark73>`__
   -  `Updating Assemblies <page649035832.html#Bookmark88>`__
   -  `Backup and restore <page648937528.html#Bookmark89>`__
   ==========================================================
