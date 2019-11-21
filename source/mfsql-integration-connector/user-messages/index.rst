User Messages
=============

.. toctree::
   :maxdepth: 4

User messages can be generated in a variety of different ways, depending
on the type of message and user requirements.

User Messages
-------------

The installation of the content package installs the following
objects related the user messages:

-  the User Message Class table with properties 
-  a view for the user messages
-  Messages workflow to archive the user messages.

This table contains messages emanating from the MFProcessBatch Table
intended for user consumption. 

The following standard procedures will generate a message in the
MFUserMessage table. 

Auto generated
~~~~~~~~~~~~~~

The following messages / notifications are generated automatically:

#. System error notifications: System failure messages are logged in the
   MFLog table and automatically sent by email to the support email
   address specified in MFSettings. The notification is conditional on
   database mail being setup in the system.
#. Core process messages are send to the MFUserMessages table and shown
   in M-Files in the User Messages View. The following core processes
   will generate a message for the MFUserMessages table.

   #. spMFUpdateTable
   #. spMFAliasInsert
   #. spMFCreateAllLookups
   #. spMFDeleteAdHocProperty
   #. spMFDeleteObjectList
   #. spMFDropAndUpdateMetadata
   #. spMFGetHistory
   #. spMFSynchronizeFilesToMFiles
   #. spMFSynchronizeMetadata
   #. spMFTableAudit
   #. spMFUpdateClassAndProperties
   #. spMFUpdateMFilestoSQL

#. Content menu actions for synchronous processes will provide user
   feedback on completion of the operation. 

Optional messages
~~~~~~~~~~~~~~~~~

#. Custom procedures can be setup to send updates to MFUserMessage table
#. Content menu actions for asynchronous processes can be configured to
   send a email message with preformatted content on completion
#. Custom procedures can be configured to send email messages

Logging
~~~~~~~

#. Processes are logged and can be analysed. 

Setup and triggering messages for MFUserMessage table
-----------------------------------------------------

The Connector includes a mechanism to generate and trigger user
messages.  This is built into the `process batch
logging <https://doc.lamininsolutions.com/mfsql-connector/mfsql-integration-connector/using-and-managing-logs/index.html>`_ 
When an entry is made in the MFProcessBatch with a LogType of 'Message' 
a trigger will update an entry in the
MFUserMessages table using the spMFResultMessageForUI procedure.

Example of script to trigger a message in the MFUserMessage table

      **Execute Procedure**

 .. code:: sql

          SET @Msg = 'Session: ' + CAST(@SessionIDOut AS VARCHAR(5))   
         IF @UpdateRequired > 0    
         SET @Msg = @Msg + ' | Update Required: '+ CAST(@UpdateRequired AS VARCHAR(5));   
         IF @LaterInMF > 0   
         SET @Msg = @Msg + ' | MF Updates : ' + CAST(@LaterInMF AS VARCHAR(5));   
         IF @Process_id_1 > 0   
         SET @Msg = @Msg + ' | SQL Updates : ' + CAST(@Process_id_1 AS VARCHAR(5));   
         IF @Process_id_1 > 0   
         SET @Msg = @Msg + ' | SQL New : ' + CAST(@NewSQL AS VARCHAR(5));

         Set @logText = @Msg


         EXEC [dbo].[spMFProcessBatch_Upsert] @ProcessBatch_ID = @ProcessBatch_ID OUTPUT                                            
         ,@ProcessType = @ProcessType                                            
         ,@LogType = N'Message'                                            
         ,@LogText = @LogText                                            
         ,@LogStatus = @LogStatus                                            
         ,@debug = @Debug;

