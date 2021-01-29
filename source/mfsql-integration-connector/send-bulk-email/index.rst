Send Bulk Email
===============

Version 4.9.25.67 introduced a structured approach to send bulk emails using email templates. This allows to use data from M-Files to orchestrate sending out automatic or on demand emails using msdb database mail.

This section describe how to the setup, configuration and execution of sending emails to recipients using a email template and sending it through SQL Database mail fits together.  This feature goes beyond the scope of standard M-Files notifications.  It allows for using different templates for different notifications, including place holders and the ability to include a tables. Any recipients can be included, not only users in M-Files.

Example of notification with a table
|Image0|

Components
----------

The capability has the following Components:
 -  :doc:`/tables/tbMFEmaillog` to track the sending of email
 -  :doc:`/tables/tbMFEmailTemplate` for defining each template
 -  :doc:`/procedures/spMFSendHTMLBodyEmail` to send one email, the parameters define the content of the email. The send process is recorded in MFEmailLog.
 -  :doc:`/procedures/spMFConvertTableToHtml` to convert a select statement output to HTML format
 -  :doc:`/procedures/spMFPrepareTemplatedEmail` to compile the body of the email based on the template and call
 -  :doc:`/procedures/spMFSendHTMLBodyEmail` to sent email out.

Use case
--------

This feature has may potential use cases, including, but not limited to
  - Send notification to all customers / suppliers
  - Send notification to a specific customer when the order was approved
  - Send notification to the supervisor when all the steps in a process is completed, including a table with delay times
  - Send invoice link (public link) to customer on completion of the invoice

  The code examples below is based on a use case of sending an email to customer on confirmation of recording a phone confirmation of approval.

Configuration
-------------

The following steps is required to prepare the environment
 - Create class tables for objects that would have the recipient email address and the triggering event to so send the emails
 - Configure the triggering event in M-Files. This may be the value of a certain property or lookup, a workflow state, or a event handler such as on check in.  Triggering the event may involve the use of :doc:`/the-connector-framework/connector-content/context-menu/index` functionality.   It would be helpful to create a custom lookup with :doc:`/procedures/spMFCreateValueListLookupView` if a valuelist is used.
 - Design the `Email Template`_
 - `Insert Template`_ into configuration table
 - Prepare a `Custom procedure for processing`_
 - `Testing`_ the procedure
 - `Staging`_ the notification using the trigger

Email Template
~~~~~~~~~~~~~~

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

Insert Template
~~~~~~~~~~~~~~~

Insert a record in MFEmailTemplate for each template.

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

Custom procedure for processing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The components is tied together with a custom procedure to stage and process the individual objects to be used in the email.

The elements of the custom procedure is likely to include the following:
 - Parameters to include: EmailTemplate_ID, TestEmail, Debug.  If the custom procedure is used with the Context menu then it should include additional parameters described in :doc:`/mfsql-data-exchange-and-reporting-connector/using-the-context-menu/index`
 - Refresh dependent class table to ensure that the latest object information is used.  If Context Menu with object sensitivity is used then the refresh can be minimised by only updating the underlying object.
 - Variables to include : Trigger element, RecipientEmail, object id, looping id
 - Temporary table to stage the objects to be include in the notification
 - Sub process to get value of trigger element (e.g. Channel in the example)
 - Sub process to insert values into temporary table
 - Looping process to send email to each object in temp table with :doc:`/procedures/spMFPrepareTemplatedEmail`

Following is an example of a custom procedure.

 .. code:: sql

     CREATE PROC Custom.DoChannelEmail
     (@EmailTemplate_ID INT,
     @TestEmail NVARCHAR(256) = N'support@lamininsolutions.com' ,
     @debug SMALLINT = 0 )
     AS
     SET NOCOUNT ON;
     DECLARE @ChannelID INT;
     DECLARE @RecipientEmail NVARCHAR(256);
     DECLARE @Doc_objid INT;
     DECLARE @id INT;

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

Testing
~~~~~~~

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

Staging
~~~~~~~

The final step is to stage the event that will trigger the notification.  This would depend on the use case but could include:
 - Process notifications daily in bulk based on the conditional value in a property or valuelist item. This is likely to use an agent to call the custom procedure.
 - Process the notification when the object changes in M-Files. This is likely to involve the deployment of the context menu functionality
 - Execute the procedure in SSMS. This is likely to apply where the sending of emails is not systemised and repetitive.

 .. |image0| image:: img_1.png
