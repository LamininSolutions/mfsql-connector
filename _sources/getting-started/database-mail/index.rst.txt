Database Mail
=============

Send errors with database mail
------------------------------

The Connector will automatically send an email to the support email
account defined in MFSettings if an procedure error is encountered. The error email is triggered when a new record is inserted into the
MFLog table.

It is therefore
recommended to have a valid email profile in the database mail
configuration for the email notifications to be sent.  Sending
notifications will automatically be disabled if Database mail is not found or
has an invalid Profile.

Note that it is possible to review SQL errors using a select statement
on table MFLog.

.. code:: sql

     Select top 5 * from MFLOG order by LogID Desc

The default Connector database user 'MFSQLConnect' is preconfigured to have permission to use database
mail.

Error management and tracing is described in  doc:: `/mfsql-integration-connector/using-and-managing-logs/index`

Setup database mail
-------------------

Database Mail is not active on installation of SQL by default. To use
Database Mail, you must explicitly enable Database Mail by using either
the `Database Mail Configuration
Wizard <https://technet.microsoft.com/en-us/library/ms175951(v=sql.105).aspx>`__,
the or sp_configure stored procedure.

Note that Database Mail is only available in SQL express with editions
2012 SP 1 and later.

Setup database mail with at least one mail account and profile.  Use the default Connector profile 'MailProfile' or update the
profile in the table MFSettings.

The error mails will be sent to the email account defined in MFSettings.  By default this is set to support@lamininsolutions.com.  Replace this setting with your internal email account for monitoring errors. Feel free to retain the support email account in MFSettings. This will allow our support team to be notified when an error occurs.

scripting Database Mail create
------------------------------

The following script can be used to create database mail, the profile and the account if it is not
already available in the database.

Setup database mail

.. code:: sql

    USE [msdb]
    GO
    sp_configure 'show advanced options', 1;
    GO
    RECONFIGURE;
    GO
    sp_configure 'Database Mail XPs', 1;
    GO
    RECONFIGURE  GO

Create mail account

.. code:: sql

    EXECUTE msdb.dbo.sysmail_add_account_sp
     @account_name = 'MFSQL Connector',
    @description = 'Mail account for MFSQL Connector notifications.',
    @email_address = 'NoReply@yourmailbox.com',
    @replyto_address = 'support@yourmailbox.com',
    @display_name = 'MFSQL Connector notification',
    @mailserver_name = 'smtp.yourdomain.com' ,
    @port =  587,
    @username = 'NoReply@yourmailbox.com',
    @password = 'xxxxx',
    @enable_ssl = 1 ;

Create mail profile

.. code:: sql

    EXECUTE msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'MailProfile' ,
    @description = 'Profile used for MFSQLConnector.'  ;
    EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
    @principal_name = 'MFSQLConnect',
    @profile_name = 'MailProfile',
    @is_default = 1 ;

Add the account to the profile

.. code:: sql

    EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'MailProfile' ,
    @account_name = 'MFSQL Connector',
    @sequence_number =1 ;

Monitoring of database mail
---------------------------

  Review the setup and processing of mail with the following:

.. code:: sql

     select * from msdb.dbo.sysmail_account
     select * from msdb.dbo.sysmail_profile
     Select * from msdb.dbo.sysmail_log
     Select * from msdb.dbo.sysmail_mailitems
