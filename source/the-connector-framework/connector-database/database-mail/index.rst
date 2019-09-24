Database Mail
=============

The Connector will automatically send an email to the support email
account in the settings if an error is accountered. It it therefore
recommended to have a valid email profile in the database mail
configuration for the email notifications to take place.  Sending
notifications will automatically be disabled if DBmail is not set up or
has an invalid Profile.  

Note that is is possible to review SQL errors using a select statement
on table MFLog.

The Connector database user also need to have permission to use database
mail. These permissions are automatically set for the default Connector
Database user during installation.  

Errors during the installation process will also use the error logging
process to send out emails. It is therefore important to ensure that the
email Profile is valid and working effectively before the initial
installation of the Connector.

The error email is triggered when a new record is inserted into the
MFLog table.

The following script can be used to create database mail if it is not
already available in the database.

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         USE [msdb]GO
         sp_configure 'show advanced options', 1;  GO  
         RECONFIGURE;  GO  
         sp_configure 'Database Mail XPs', 1;  GO  
         RECONFIGURE  GO
           -- Create a Database Mail account
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
         -- Create a Database Mail profile
         EXECUTE msdb.dbo.sysmail_add_profile_sp    
         @profile_name = 'MailProfile' ,    
         @description = 'Profile used for MFSQLConnector.'  ;
         EXECUTE msdb.dbo.sysmail_add_principalprofile_sp    
         @principal_name = 'MFSQLConnect',    
         @profile_name = 'MailProfile',    
         @is_default = 1 ;

         -- Add the account to the profile
         EXECUTE msdb.dbo.sysmail_add_profileaccount_sp    
         @profile_name = 'MailProfile' ,    
         @account_name = 'MFSQL Connector',    
         @sequence_number =1 ;

.. container:: table-wrap

   ========================================================================================================================================================================================
   **Related Topics**
   ========================================================================================================================================================================================
   -  M\ `FLog Table <page21200944.html#Bookmark40>`__
   -  `MFUpdateHistory for logging of class record changes <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/21200982/MFUpdateHistory+for+logging+of+class+record+changes>`__
   ========================================================================================================================================================================================
