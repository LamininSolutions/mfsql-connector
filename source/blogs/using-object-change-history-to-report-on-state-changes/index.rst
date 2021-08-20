Using object change history to report on state changes
======================================================

In this use case a report is required to show who and when did a state
change take place for a specific object.

Several MFSQL Connector Tables and procedures will come into play:

-  The Class table for the objects (e.g. MFPurchaseInvoice)
-  MFObjectChangeHistory
-  spMFGetHistory

The helper example **04.171.Get workflow state changes using Change
History.sql** available in the installation folder is used as a starting
point.

--------------

The procedure (spMFGetHistory) will extract the version history for a
M-Files property in a class with the following steps:

#. Set the process\_id = 5 for the records to be included in the extract
   on the target class table.

#. Execute spMFGetHistory with the filters will update/insert the change
   history in the table MFObjectChangeHistory.

#. Use a select statement with a join between the class table and the
   change history table to prepare the reporting data.

Additional joins may be necessary when the change history property is a
valuelist or a state change. The following example will illustrate it.

--------------

This use case will use the Purchase Invoice class in the sample vault
and show the state changes for approval of the invoices.

Set the process\_id for the records to be included. In this case only
invoices that is approved or paid will be included.

.. code:: sql

    UPDATE [dbo].[MFPurchaseInvoice]
    SET [Process_ID] = 5 WHERE workflow_state IN ('Approved','Paid' )

Process the extract of the history. In this case the full history for
the selected records have been set as the filters. Note that other
filters and parameters may apply in different circumstances. Refer to
the :doc:`/procedures/spMFGetHistory` for
more detail.

The extract will insert/update the history records in the
MFObjectChangeHistory table.

.. code:: sql

    EXEC [dbo].[spMFGetHistory] @MFTableName = 'MfPurchaseInvoice',
                                @Process_id = 5,
                                @ColumnNames = 'Workflow_State',
                                @IsFullHistory = 1


The MFObjectChangeHistory table includes the history extracts across
all classes and properties. In the illustration below the individual
changes for each version of the object 361 of class 2 for the property
39 is an id of the of the property 39. The change has taken place on the
lastModifiedUtc date and time by user in MFlastModifiedBy\_ID.

In other words: The class Purchase Invoice (2) and the object ‘Invoice
#1035 - Fortney Nolte Associates’ (361) was changed on 2010-06-23
11:59:54.000 by KimberleyM to workflowstate Checked, awaiting approval.

|image0|

There are several critical joins to take into account:

#. The main join is between the class table (MFPurchaseInvoice) and
   MFObjectChangeHistory. Note this join should always include both
   class\_id and Objid.

#. The MFUserAccount join is only included to get the name of the user
   that performed the change. Note that MFLoginAccount can also be used
   to show the common name, or email address of the user. this could be
   used to trigger an email notification for the change.

#. The MFWorkflowState join is to get the name of the state. In other
   cases where the propertyValue refers to another object (e.g. Customer
   id) or a valuelist id the joins should be with the source. Sources
   could be another class table, MFValuelistItems, MFUserAccounts
   depending on the property that is being reported on.

.. code:: sql

    SELECT [mpi].[Class_ID],
           [mpi].[ObjID],
           [moch].[MFVersion],
        mua.[LoginName],
           [mpi].[Name_Or_Title],
           [moch].[Property_Value],
        mws.[Name]
    FROM [dbo].[MFPurchaseInvoice] [mpi]
        INNER JOIN [dbo].[MFObjectChangeHistory] AS [moch]
            ON [moch].[Class_ID] = [mpi].[Class_ID]
               AND [moch].[ObjID] = [mpi].[ObjID]
        INNER JOIN [dbo].[MFUserAccount] AS [mua]
            ON [mua].[UserID] = [moch].[MFLastModifiedBy_ID]
        INNER JOIN [dbo].[MFWorkflowState] AS [mws]
            ON [moch].[Property_Value] = [mws].[MFID]
    WHERE mpi.[ObjID] = 361

The result of the above select statement

|image1|

.. |image0| image:: img_1.jpg
.. |image1| image:: img_2.jpg
