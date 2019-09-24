MFUserMessages Table
====================

The MFUserMessages table is a standard class table that will
automatically be created on installation of version 4.1.5.41 and later.

The installation of the content package also installs the following
objects related the user messages:

-  the User Message Class with properties 
-  a view for the user messages
-  Messages workflow to archive the user messages.

.. container:: table-wrap

   ==================== ======
   Class properties     Source
   ==================== ======
   MFSQL Class Table   
   MFSQL Count         
   MFSQL Message       
    MFSQL Process Batch
    MFSQL User         
    Name or title      
   ==================== ======

.. container:: confluence-information-macro has-no-icon confluence-information-macro-note

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         =========== ========
         Module      Release#
         =========== ========
         Integration 4.1.5.41
         =========== ========

This table contains messages emanating from the MFProcessBatch Table
intended for user consumption. 

The following standard procedures will generate a message in the
MFUserMessage table. 

| 
