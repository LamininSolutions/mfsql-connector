spMFTableAudit
==============

spMFTableAudit will update MFAuditHistory and return the sessionid and
the M-Files objver of the selection class as a varchar that can be
converted to XML if there is a need for further processing of the
result.

At the same time spMFTableAudit will set the deleted flag for all the
records in the Class Table that is deleted in M-Files.  This is
particularly relevant when this procedure is used in conjunction with
the spMFUpdateTable procedure with the filter MFLastModified set.

See also `spMFTableAuditInBatches <page685899953.html#Bookmark72>`__ for
large scale class tables.

| 

.. container:: table-wrap

   .. container:: table-wrap

      ======================================= ================================================================================================================================================================
      .. container:: tablesorter-header-inner .. container:: tablesorter-header-inner
                                             
         Type                                    Description
      ======================================= ================================================================================================================================================================
      Procedure Name                          ::
                                             
                                                 spMFTableAudit
      Inputs                                  TableName = name of class table
                                             
                                              MFmodifieddate = filter by MFiles Last Modified date as a datetime string. Set to null if all records must be selected.
                                             
                                              Objids = filter by comma delimited string of objid of the objects to process. Set as null if all records must be included.
                                             
                                              Debug: 1 = Debug Mode; 0 = No Debug (default)
      Outputs                                 1 = success
                                             
                                              SessionIDOut = output of the session id used to update table MFAuditHistory
                                             
                                              NewObjectXml = output of the objver of the record set as a result in nvarchar datatype. This can be converted to an XML record for further processing
                                             
                                              DeletedInSQL = output the number of items that will be marked as deleted when processing the next spmfUpdateTable
                                             
                                              UpdateRequired = is set to 1 if any condition exist where M-Files and SQL is not the same.  This can be used to trigger a spmfUpdateTable only when it necessary
                                             
                                              OutOfSync = if > 0 then the next updatetable procedure will have synchronisation errors
                                             
                                              ProcessErrors = if > 0 then there are unresolved errors in the table with process_id = 3 or 4
                                             
                                              ProcessBatch_ID  this output id allows for this procedure to be incorporated in a ProcessBatch for logging.
      ======================================= ================================================================================================================================================================



View results
------------

A results summary of this table can be viewed using



MFvwAuditSummary
~~~~~~~~~~~~~~~~

This view summarizes the records in MFAuditHistory by SessionID and
StatusFlag.

| 

**Execute Procedure**

.. container::

   .. container:: syntaxhighlighter sh-emacs nogutter sql

      .. container:: table-wrap

         +-----------------------------------------------------------------------+
         | .. container::                                                        |
         |                                                                       |
         |    .. container:: line number1 index0 alt2                            |
         |                                                                       |
         |       `` ``\ ``SELECT``\  \ ``* ``\ ``FROM``\  \ ``[dbo].[MFvwAuditSu |
         | mmary] ``\ ``AS``\  \ ``[mfas] ``\ ``WHERE``\  \ ``[mfas].[SessionID] |
         |  = 22``                                                               |
         |                                                                       |
         |    .. container:: line number2 index1 alt1                            |
         |                                                                       |
         |       `` ``                                                           |
         +-----------------------------------------------------------------------+

| 

The procedure spMFTableAudit returns an XML with the object Version
details of the given class table.

.. container:: table-wrap

   ============== =============================================
   Type           Description
   ============== =============================================
   Procedure Name spMFTableAudit
   Inputs         Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== =============================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         DECLARE @SessionIDOut INT
         ,@NewObjectXml NVARCHAR(MAX)
         ,@DeletedInSQL INT
         ,@UpdateRequired BIT
         ,@OutofSync INT
         ,@ProcessErrors INT
         ,@ProcessBatch_ID INT;
          
         EXEC [dbo].[spMFTableAudit]
         @MFTableName = N'MFCustomer' -- nvarchar(128)
         ,@MFModifiedDate = null -- datetime
         ,@ObjIDs = null -- nvarchar(4000)
         ,@SessionIDOut = @SessionIDOut OUTPUT -- int
         ,@NewObjectXml = @NewObjectXml OUTPUT -- nvarchar(max)
         ,@DeletedInSQL = @DeletedInSQL OUTPUT -- int
         ,@UpdateRequired = @UpdateRequired OUTPUT -- bit
         ,@OutofSync = @OutofSync OUTPUT -- int
         ,@ProcessErrors = @ProcessErrors OUTPUT -- int
         ,@ProcessBatch_ID = @ProcessBatch_ID OUTPUT -- int
         ,@Debug = 0 -- smallint
          
          
         SELECT @SessionIDOut AS 'session', @UpdateRequired AS UpdateREquired, @OutofSync AS OutofSync, @ProcessErrors AS processErrors
         SELECT * FROM [dbo].[MFProcessBatch] AS [mpb] WHERE [mpb].[ProcessBatch_ID] = @ProcessBatch_ID
         SELECT * FROM [dbo].[MFProcessBatchDetail] AS [mpbd] WHERE [mpbd].[ProcessBatch_ID] = @ProcessBatch_ID
