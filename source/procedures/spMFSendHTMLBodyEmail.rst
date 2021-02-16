
=====================
spMFSendHTMLBodyEmail
=====================

Return
  - 1 = Success
  - -1 = Error
Parameters
   @Body 
     Body must be in HTML format
   @MessageTitle 
     Subject of email
   @FromEmail 
     email address for sender
   @ToEmail 
     email address of recipient. Delimited with ';' if multiples
   @CCEmail 
     email address of CC recipients. Delimited with ';' if multiples 
   @Mailitem_ID  output
     msdb database mail id
   @ProcessBatch_ID 
     will record processing in MFProcessBatch
   @Debug 
       Default = 0
       1 = Standard Debug Mode

Purpose
=======

This procedure will send a single email with a body is formatted in HTML format using msdb database mail manager

Additional Info
===============

The @body param must include the full body in HTML format, the following is the bare bones.

.. code:: HTML

    <html>
    <head> </head>
    <body> </body>
    </html>

Prerequisites
=============

msdb Database mail need to be activiated and configured.

Examples
========

.. code:: sql

    DECLARE @Mailitem_ID INT;
    DECLARE @Body NVARCHAR(MAX) = '<html>  <head>   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />   <style type="text/css">    div {line-height: 100%;}      body {-webkit-text-size-adjust:none;-ms-text-size-adjust:none;margin:0;padding:0;}     body, #body_style {min-height:1000px;font: 10pt Verdana, Geneva, Arial, Helvetica, sans-serif;}    p {margin:0; padding:0; margin-bottom:0;}    h1, h2, h3, h4, h5, h6 {color: black;line-height: 100%;}      table {     border-collapse: collapse;  ??      border: 1px solid #3399FF;  ??      font: 10pt Verdana, Geneva, Arial, Helvetica, sans-serif;  ??      color: black;        padding:5;        border-spacing:1;        border:0;       }    table caption {font-weight: bold;color: blue;}    table td, table th, table tr,table caption { border: 1px solid #eaeaea;border-collapse:collapse;vertical-align: top; }    table th {font-weight: bold;font-variant: small-caps;background-color: blue;color: white;vertical-align: bottom;}   </style>  </head><body><div class=greeting><p>Hi </p><br></div><div class=content><p> This is the body </p><br></div><div class=signature><p> yours sincerely Me </p><br></div><div class=footer><p>Company details</p></div></body></html>'
    EXEC dbo.spMFSendHTMLBodyEmail @Body = ,
    @MessageTitle = 'test',
    @FromEmail = 'support@lamininsolutions.com',
    @ToEmail = 'support@lamininsolutions.com',
    @CCEmail = 'support@lamininsolutions.com',
    @Mailitem_ID = @Mailitem_ID OUTPUT,
    @ProcessBatch_ID = null,
    @Debug = 1
    SELECT @Mailitem_ID

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2021-01-29  LC         Updated to allow for setting profile in MFEmailTemplate
2021-01-26  LC         Create procedure
==========  =========  ========================================================

