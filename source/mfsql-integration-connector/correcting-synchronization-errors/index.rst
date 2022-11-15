Correcting Synchronization errors
=================================

Synchronization errors may happen during execution of spMFUpdateTable,
or any of the procedures that calls the update method.  The error is
caused when the version of the object is out of synchronization with the
version in SQL. Refer to :doc:`/mfsql-integration-connector/using-and-managing-logs/error-tracing/index` for more detail.

When a synchronization error takes place the process_id column of the
object is set to 2.  An email notification is also sent.

Causes
------

Synchronization errors can be indicative of

-  Processing changes in SQL is taking place before fetching the latest
   version of the object from M-Files 
-  Allowing updates in M-Files on objects that is only processed from
   SQL where users inadvertently make a change in M-Files and the SQL
   procedures does not expect it.

Correction
----------

Correcting a synchronization error can following different paths.

Manual correction
~~~~~~~~~~~~~~~~~

When the email is received, the object is investigated, and the root
cause is investigated and adjusted.  The process_id of the object must
be reset to 0,  spMFUpdateTable with updatemethod 1 is performed and the
processing in SQL can be redone.



Auto update using precedence.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Precedence is when either M-Files or SQL is set to be taken as the
master when a change has taken place in both systems.  When M-Files has
precedence changes in SQL will be ignored in the case of a conflict. 
When SQL has precedence then changes in M-Files will be ignored.

Precedence is set by class table using  MFClass table by setting the
SynchPrecedence column.  By default the column is null, which indicates
no precedence is set.  0 indicates SQL precedence and 1 indicates
M-Files precedence.

When  spMFUpdateSynchronizeError is executed, objects with process_id =2
will be processed and the precedence rule will be applied.

#. When Precedence is set to M-Files for the class, the changes in SQL
   will be ignored and the latest version from M-Files will be pulled
   into SQL.
#. When Precedence is set to SQL then M-Files will be updated with SQL. 
   Any prior changes in M-Files will be part of the history tracking of
   the object in M-Files.

To apply precedence the procedure calling spMFUpdateTable must check for
synchronization errors and submit spMFUpdateSynchronizeError to correct
the error.

Use the following code block in your procedure  to process a correction

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          
         EXEC [dbo].[spMFClassTableStats]
          @ClassTableName = @TableName, @IncludeOutput = 1;

         IF ( SELECT SUM([syncError])FROM   [##spMFClassTableStats] ) > 0
          EXEC [dbo].[spMFUpdateSynchronizeError]
           @TableName = @TableName -- varchar(250)
            , @Debug = 0;

The following code block illustrate the different scenarios of this
functionality

.. container:: table-wrap

   ================== =============================== =======================================================
   Scenario           settings                        expected outcome
   ================== =============================== =======================================================
   No precedence set  set parameters:                 sync error email sent

                      @ChangeText to a new test value process_id remains 2

                      @SynchPrecedence = null         no correction
   M-Files precedence set parameters:                 sync error email sent

                      @ChangeText to a new test value process_id  = 0

                      @SynchPrecedence = 1            ChangeText not update (reflects value in M-Files
   SQL precedence     set parameters:                 sync error email sent

                      @ChangeText to a new test value process_id  = 0

                      @SynchPrecedence = 0            ChangeText updated. Any changes in M-Files overwritten.
   ================== =============================== =======================================================

|

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          
         /*
         SAMPLE CODE TO DEMONSTRATE SYNC PRECEDENCE
         PRE-REQUISIT: 'OTHER DOCUMENT' CLASS TABLE EXISTS
         */
         DECLARE
         @TableName   NVARCHAR(100) = 'MFOtherDocument'
           , @SQL  NVARCHAR(1000)
           ,@Params  NVARCHAR(1000)
           , @ChangeText   NVARCHAR(100) = 'Test11'
           , @SynchPrecedence INT = 0;
           -- null = no precedence, 0 = SQL precedence, 1 = M-Files precedence

         --SET SYNC PRECEDENCE ON CLASS
         UPDATE [mc]
         SET  [mc].[SynchPrecedence] = 0
         FROM [dbo].[MFClass] AS [mc]
         WHERE [MFID] = 1;
         --REVIEW MFCLASS
         SELECT
           [mc].[SynchPrecedence], *
         FROM [dbo].[MFClass] AS [mc]
         WHERE [TableName] = @TableName;

         --SHOW PROCESS_ID OF OBJECT BEFORE UPDATE
         SET @Params = N'@ChangeText NVARCHAR(100)'
         SET @sql = N'
         SELECT
           [mod].[Process_ID], [mod].[MFVersion], [mod].[Keywords], *
         FROM ' + @TableName + ' AS [mod]
         WHERE [ID] = 1;'
         EXEC (@SQL)

         --UPDATE OBJECT FORCING A SYNCRONIZATION ERROR
         SET @sql = N'
         UPDATE [mfod]
         SET
           [mfod].[Process_ID] = 1, [mfod].[Keywords] = @ChangeText, [MFVersion] = 1
         FROM ' + @TableName + ' AS [mfod]
         WHERE [ID] = 1;
         '
         EXEC sp_executeSQL @SQL, @params , @ChangeText=@ChangeText

         --SHOW PROCESS_ID OF OBJECT AFTER UPDATE OF OBJECT WITH SAMPLE CHANGES
         SET @sql = N'
         SELECT
           [mod].[Process_ID], [mod].[MFVersion], [mod].[Keywords], *
         FROM ' + @TableName + ' AS [mod]
         WHERE [ID] = 1;'
         EXEC (@SQL)

         --UPDATING OBJECT.  THIS WILL PRODUCE A SYNCRONIZATION ERROR
         EXEC [dbo].[spMFUpdateTable]
          @MFTableName = N'MFOtherDocument' -- nvarchar(128)
           , @UpdateMethod = 0;

         --SHOW PROCESS_ID STATUS WITH SYNC ERROR
         SET @sql = N'
         SELECT
           [mod].[Process_ID], [mod].[MFVersion], [mod].[Keywords], *
         FROM ' + @TableName + ' AS [mod]
         WHERE [ID] = 1;'
         EXEC (@SQL)

         -- CHECK FOR SYNC ERROR AND AUTO CORRECT

         EXEC [dbo].[spMFClassTableStats]
          @ClassTableName = @TableName, @IncludeOutput = 1;

         IF ( SELECT SUM([syncError])FROM   [##spMFClassTableStats] ) > 0
          EXEC [dbo].[spMFUpdateSynchronizeError]
           @TableName = @TableName -- varchar(250)
            , @Debug = 0;    -- int

         --SHOW PROCESS_ID STATUS AFTER CORRECTING SYNCRONISATION ERROR
         SET @sql = N'
         SELECT
           [mod].[Process_ID], [mod].[MFVersion], [mod].[Keywords], *
         FROM ' + @TableName + ' AS [mod]
         WHERE [ID] = 1;'
         EXEC (@SQL)

|

 
