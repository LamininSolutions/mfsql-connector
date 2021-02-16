
===============
MFEmailTemplate
===============

Description
===========

This is a configuration table to allow for the setup of email templates. It is used in conjunction with spMPrepareTemplatedEmail

Columns
=======

ID int IDENTITY NOT NULL
 id of row
Template_Name NVARCHAR(128) NOT null
 - each template must have a unique name
 - each row represent a specific template
Channel NVARCHAR(12) not nULL
 - each template has a one to one correlation with the valuelist item in 'Channel'. The valuelist item is added in the channel column
FromEmail NVARCHAR(128) NOT null
 - fromEmail can include multiple addressed delimited by ';'
CCEmail NVARCHAR(128) null
 - CCemail can include multiple addressed delimited by ';'
Subject NVARCHAR(256) NULL
 - Subject of email. 
EmailProfile nvarchar(128) null
 - custom email profile.  if left blank the default profile in MFSettings will be used
Head_HTML NVARCHAR(max) NULL 
 - DEFAULT('<head></head>')
Greeting_HTML NVARCHAR(128) NULL
 - DEFAULT('<p></p>')
MainBody_HTML NVARCHAR(max) NULL 
 - DEFAULT('<p></p>')
Signature_HTML nvarchar(256) NULL
 - DEFAULT('<p></p>')
Footer_HTML nvarchar(256) NULL 
 - DEFAULT('<p></p>')

The head, greeting, mainbody, signature and footer must include html tags

Additional Info
===============

Email body consists of:
 - Greeting : Dear Sir  or Dear John
 - Main body : standard text of the email
 - Signature : From Customer care or From Peter
 - Footer : Company detail

All styling is done in the HEAD and as inline styling using CSS and HTML

Placeholders
============

 - Three placeholders can be used optionally. Firstname, user and head. {head}, {firstname], {user}
 - if the {head} placeholder is included then the default CSS from MFSettings will be used
 - additional placeholders can be customised by addding a placeholder in the table and modifying custom.ChannelEmail to replace the text for each email.

Example Insert statement
========================

..code:: sql

    INSERT INTO custom.EmailTemplate
    ( Template_Name,
    Channel,
    FromEmail,
    CCEmail,
    Subject,
    EmailProfile,
    Head_HTML,
    Greeting_HTML,
    MainBody_HTML,
    Signature_HTML,
    Footer_HTML)
    VALUES
    (  'DemoEmail',
    'Telefone',
    'noreply@lamininsolutions.com',
    'support@lamininsolutions.com',
    'Test',
    null,
    '{Head}',
    '<BR><p>Dear {FirstName}</p>',
    '<BR><p>this is test email<BR></p>',
    '<BR><BR><p>From {User}</p>',
    '<BR><p>Produced by MFSQL Mailing system</p>'
    )

To review table

..code:: sql

     SELECT * FROM custom.EmailTemplate AS et

To remove a template

..code:: sql

    DELETE FROM Custom.EmailTemplate where template_Name = 'DemoEmail'

Used By
=======

spMFPrepareTemplatedEmail

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-01-26  LC         Table designed
==========  =========  ========================================================

