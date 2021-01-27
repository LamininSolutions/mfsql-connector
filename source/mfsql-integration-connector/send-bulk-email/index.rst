Send Bulk Email
===============

Version 4.9.25.67 introduced a structured approach to send bulk emails using email templates. This allows to use data from M-Files to orchestrate sending out automatic or on demand emails using msdb database mail.

This section describe how to the setup, configuration and execution of sending emails to recipients using a email template and sending it through SQL Database mail fits together.

Components
----------

The capability has the following Components:
 -  :doc:`/tables/tbMFEmailLog` to track the sending of email
 -  :doc:`/tables/tbMFEmailTemplate` for defining each template
 -  :doc:`/procedures/spMFSendHTMLBodyEmail` to send one email, the parameters define the content of the email. The send process is recorded in MFEmailLog.
 -  :doc:`/procedures/spMFConvertTableToHTML` to convert a select statement output to HTML format
 -  :doc:`/procedures/spMFprepareTemplatedEmail` to compile the body of the email based on the template and call
 -  :doc:`/procedures/spMFSendHTMLBodyEmail` to sent email out.

Configuration
-------------

The following steps is required to prepare the environment

Add a valuelist and property 'Channel' on the class for the objects that will trigger the sending of a mail. Each Valuelist item will represent a specific email template. In this example the 'Channel' is set to 'Telefone' and the intent is to send an email to the contact when a phone confirmation was made with the contact.

create a lookup for the ValueList

 .. code:: sql

     exec spMFCreateValueListLookupView 'Channel','vwChannel','custom'
     select * from custom.vwChannel


Design the email template format by adding a row and columns in :doc:`/tables/tbMFEmailTemplate` for the elements of the email for a each email template.  We recommend to prepare the email body in notepad or another scripting tool using html formatting and test the email body using a browser.

The various sections of the email are then inserted into the table using the following sample insert statement. Replace the sample date with your specific data. Take into account:
- each template must have a unique name
- each row represent a specific template
- each template has a one to one correlation with the valuelist item in 'Channel'. The valuelist item is added in the channel column
- fromEmail and CCemail can include multiple addressed delimited by ';'
- The head, greeting, mainbody, signature and footer must be include html tags
- Three placeholders can be used optionally. Firstname, user and head. {head}, {firstname], {user}
- if the {head} placeholder is included then the default CSS from MFSettings will be used
- additional placeholders can be customised by addding a placeholder in the table and modifying custom.ChannelEmail to replace the text for each email.
- the email can include a table. The select statement for the table is handled in the custom.DoChannelEmail procedure.

.. code:: sql

      INSERT INTO MFEmailTemplate
      (
      Template_Name,
      Channel,
      FromEmail,
      CCEmail,
      Subject,
      Head_HTML,
      Greeting_HTML,
      MainBody_HTML,
      Signature_HTML,
      Footer_HTML
      )
      VALUES
      (  'DemoEmail',
      'Telefone',
      'noreply@lamininsolutions.com',
      'support@lamininsolutions.com',
      'Test',
      '{Head}',
      '<BR><p>Dear {FirstName}</p>',
      '<BR><p>this is test email<BR></p>',
      '<BR><BR><p>From {User}</p>',
      '<BR><p>Produced by MFSQL Mailing system</p>'
      )

To review table

.. code:: sql

      SELECT * FROM dbo.MFEmailTemplate AS et

To remove a template

.. code:: sql

      DELETE FROM MFEmailTemplate where template_Name = 'DemoEmail'

Processing
----------

The components is tied together with a custom procedure to stage and process the individual objects to be used in the email. Following is an example of a custom procedure.

 .. code:: sql

     CREATE PROC Custom.DoChannelEmail
     (@EmailTemplate_ID INT,
     @TestOnly INT = 1,
     @debug SMALLINT = 0 )
     AS
     SET NOCOUNT ON;
     DECLARE @ChannelID INT;
     DECLARE @RecipientEmail NVARCHAR(256);
     DECLARE @Doc_objid INT;
     DECLARE @id INT;
     DECLARE @TestEmail NVARCHAR(256) = N'support@lamininsolutions.com';

     SELECT @ChannelID = MFID_ValuelistItems
     FROM Custom.vwChannel               c
         INNER JOIN Custom.EmailTemplate t
             ON t.channel = c.name_ValuelistItems
     WHERE t.ID = @EmailTemplate_ID;

     IF
     (
         SELECT OBJECT_ID('tempdb..#Emaillist')
     ) IS NOT NULL
         DROP TABLE #Emaillist;

     CREATE TABLE #Emaillist
     (
         id INT IDENTITY PRIMARY KEY,
         doc_objid INT,
         RecipientEmail NVARCHAR(256)
     );

     INSERT INTO #Emaillist
     (
         doc_objid,
         RecipientEmail
     )

     --CUSTOMISE FOR SPECIFIC SOURCE TABLE ACCESS
     SELECT md.objid,
         Tenant_Email
     FROM MFMembershipDocs                                         md
         CROSS APPLY dbo.fnMFParseDelimitedString(Tenants_ID, ',') fn
         INNER JOIN MFtenant  mt
             ON fn.ListItem = mt.objid
         LEFT JOIN MFEmailLog el
             ON md.objid = el.document_ID
     WHERE md.Channel_ID = @ChannelID
           AND ISNULL(el.Template_ID, @EmailTemplate_ID) = @EmailTemplate_ID
           AND el.ID IS NULL
           AND mt.Tenant_Email IS NOT NULL;

     --END OF CUSTOMISATION

     SELECT @id = MIN(id)
     FROM #Emaillist;

     IF @debug > 0
         SELECT *
         FROM #Emaillist;

     WHILE @id IS NOT NULL
     BEGIN
         SELECT @RecipientEmail = RecipientEmail,
             @Doc_objid         = doc_objid
         FROM #Emaillist
         WHERE id = @id;

         IF @debug > 0
             SELECT Recipient = @RecipientEmail,
                 Document_ID  = @Doc_objid;

         IF @TestOnly = 1
             SELECT @RecipientEmail = @TestEmail;

         EXEC spMFprepareTemplatedEmail @RecipientEmail = @RecipientEmail,
             @Document_ID = @Doc_objid,
             @IncludeTable = 0,
             @Template_ID = @EmailTemplate_ID,
             @debug = @debug;

         SELECT @id =
         (
             SELECT MIN(id) FROM #Emaillist WHERE id > @id
         );

         IF @TestOnly = 1
             SELECT @id = NULL;
     END;

     IF @debug > 0
         SELECT *
         FROM MFEmailLog
         WHERE document_ID = @document_id;
     GO

Take care when testing the procedure to not send test emails to all the recipients.  Use the TestOnly parameter to test and debug the custom procedure. This will block sending emails to all the recipients and only send one email to the TestEmail in the procedure.

.. code:: sql

     exec custom.DoChannelEmail @EmailTemplate_ID = 1, @TestOnly = 1, @Debug = 1

 To send to all recipients

.. code:: sql

      exec custom.DoChannelEmail @EmailTemplate_ID = 1, @TestOnly = 0, @Debug = 0

 show the processing log

.. code:: sql

      Select * from MFEmailLog

The custom procedure is designed to block the sending of repeat emails for the same template to the same recipient.  It may be necessary to release this block and resend an email to a recipient. Delete the row in MFEmailog to this end.

.. code:: sql

     delete from custom.emaillog where document_id = 212326
