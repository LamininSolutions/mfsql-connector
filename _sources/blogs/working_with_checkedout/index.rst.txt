Working with checkedOut objects
===============================

The Connector will detect objects that is checked out.  When updating from M-Files to SQL nothing will be updating and the last record for the object in the class table will be retained.
When updating from SQL to M-Files the process_id will remain 1 and no update would take place. The return value of the update procedure will be 3, the next time the record is updated, it will be re-evaluated and if checked in, the update will take place.

It is not possible to force a check in or undo a check out using the Connector.

To detect if a checkedout object have been encountered, the update procedure must be evaluated.  The following procedure capture the return value of the update procedure. If the result is 3 then a checked out item was detected.

.. code:: sql

    DECLARE @return_value int
    EXEC @return_value = spmfupdatetable MFcustomer,0
    SELECT @return_value

The object that is checked out can be detected in the spMFAuditHistory

.. code:: sql

    SELECT * FROM dbo.MFAuditHistory AS mah
    WHERE mah.Class = 78 --MFCustomer class id
    AND mah.StatusFlag = 3

Checked out items can also be detected with the following

-  :doc:`/procedures/spMFClassTableStats`
-  :doc:`/views/MFvwAuditSummary`

Orphaned checkedOut objects
---------------------------

In some cases spMFAuditHistory will include checkedOut objects, however, when checking M-Files the objects are not visible to the user.

It is highly likely that the object was created but never checked in.  These objects can be detected in the M-Files SQL Database.

.. code:: sql

    Use YourVaultMFilesDatabase
    select  *  from [dbo].[OBJECTTYPEITEM] where CHECKEDOUTVERSION is not null

The workstation and user that checked out the object can be detected from this table.

The Connector does provide utilities to remove orphaned objects where the user or workstation is no longer available to check in these objects. Kindly contact us for more detail.
