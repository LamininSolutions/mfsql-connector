
=========================
spMFPrepareTemplatedEmail
=========================

Return
1 = Success
-1 = Error

Parameters
   @RecipientEmail NVARCHAR(128)
   - email of recipient
   @Document_ID int
   - identity of related object such as objid
   @IncludeTable 
   - default = 0
   - if set to 1 then the email prepare will expect table to be added
   @Template_ID INT
   - id of the related template
   @ProcessBatch_ID (optional, output)
   - Referencing the ID of the ProcessBatch logging table
   @Debug (optional)
   - Default = 0
   - 1 = Standard Debug Mode

Purpose
=======

To customise the body of the email for each recipient and send the email.

The procedure will compile the email based on the columns in the email Template table for the object identified by the Document_ID and send it using spMFSendHTMLBodyEmail.

This procedure may have to be customised for your specific application and use.

Additional Info
===============

Set IncludeTable parameter to 1 and then customise the procedure to include the designated table in the code MODIFY THIS SECTION FOR SELECTION OF THE TABLE

If the placeholder of the body is defined as '{head}' then it would use the default CSS defined in MFSettings as the email head.

Two placeholders have been defined as examples : '{firstname}, {user}'. The use of the placeholders are optional.  Additional placeholders can be defined following the same pattern as these two placeholders.

Examples
========

.. code:: sql

    exec dbo.spMFPrepareTemplatedEmail 
    @RecipientEmail = '',
    @Document_ID = 90001,
    @IncludeTable = 0,
    @Template_ID = 1,
    @Debug = 0

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------

2020-01-26  LC         Create procedure
==========  =========  ========================================================

