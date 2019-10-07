Installing Database Mail
========================

The Connector uses Database mail to send email messages to the
designated recipient on SQL and system errors.  If database mail is not
setup the error messages are available in the table MFLOG

Show the most recent errors:

Select top 5 \* from MFLOG order by LogID Desc

More about error management and tracing in the `error logging
section <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/21200984/Error+tracing>`__.

Database Mail is not active on installation of SQL by default. To use
Database Mail, you must explicitly enable Database Mail by using either
the `Database Mail Configuration
Wizard <https://technet.microsoft.com/en-us/library/ms175951(v=sql.105).aspx>`__,
the sp_configure stored procedure, or by using the Surface Area
Configuration facet of Policy-Based Management.

Note that Database Mail is only available in SQL express with editions
2012 SP 1 and later.

Setup database mail with at least one mail account and profile.  Add the
profile to MFSQL Connector using



To get mail profile and account
-------------------------------

| select \* from msdb.dbo.sysmail_account
| select \* from msdb.dbo.sysmail_profile



To setup database mail
----------------------

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          USE [msdb]
         GO
         -- Create a Database Mail account
         EXECUTE msdb.dbo.sysmail_add_account_sp
             @account_name = 'MFSQL Connector',
             @description = 'Mail account for MFSQL Connector notifications.',
             @email_address = 'NoReply@YourDomain',
             @replyto_address = 'support@YourDomain.com',
             @display_name = 'MFSQL Connector notification',
             @mailserver_name = 'smtp.yourSMTPserver.com' ,
          @port =  25,
          @username = 'NoReply@YourDomain.com',
           @password = 'emailpassword',
           @enable_ssl = 1
          ;
         -- Create a Database Mail profile
         EXECUTE msdb.dbo.sysmail_add_profile_sp
             @profile_name = 'MFSQLProfile',
             @description = 'Profile used for MFSQLConnector.' ;


         --Assign MFSQLConnect Principle to the Profile (to allow Context Menu messages)
          EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
             @principal_name = 'MFSQLConnect',
             @profile_name = 'MFSQLProfile',
             @is_default = 1 ;

         -- Add the account to the profile
         EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
             @profile_name = 'MFSQLProfile' ,
             @account_name = 'MFSQL Connector',
             @sequence_number =1 ;



To update email settings for MFSQL Connector
--------------------------------------------

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          
         EXEC [dbo].[spMFSettingsForDBUpdate]
             @SupportEmailAccount = N''
           , -- nvarchar(100)
             @EmailProfile = N''

| 

| 

| 

| 

| 
