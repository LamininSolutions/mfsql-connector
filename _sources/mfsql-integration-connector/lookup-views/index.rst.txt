Lookup Views
============

Special procedures is included in the Connector to assist with the
creation of a valuelist item and workflow state lookup views. These
procedures will take input parameters and then automatically create a
view that can be used in special applications.  The benefit of the view is to replace having to use a join between MFValuelist and MFValuelistitems when applying a specific valuelist or Workflow

The following is an illustration on how the two methods and its differences. The objective is to map a external source with the valuelist item table to get the valuelist item id when inserting the record into the class table



The long method:

.. code:: sql

      SELECT vli.mfid, mc.country FROM Stagingtable AS mc
      INNER JOIN MFValuelistitems vli
      ON mc.Country = vli.name
      INNER JOIN MFvaluelist vl
      ON vl.id = vli.MFValueListID
      where vl.name = 'Country'

The short method:

.. code:: sql

      SELECT vc.MFID_ValuelistItems, mc. country FROM Stagingtable AS mc
      INNER JOIN custom.vwCountry vc
      ON mc.Country = vc.Name_ValueListItems

:doc:`/procedures/spMFCreateValueListLookupView` is used to create a lookup for a specific valuelist.

.. code:: sql

      EXEC dbo.spMFCreateValueListLookupView @ValueListName = 'Country',
      @ViewName = 'vwCountry',
      @Schema = 'custom',
      @Debug = 0

:doc:`/procedures/spMFCreateWorkflowStateLookupView` is used to create a lookup for a specific workflow.

.. code:: sql

      EXEC dbo.spMFCreateWorkflowStateLookupView @WorkflowName = 'Contract Approval Workflow',
      @ViewName = 'vwContractApproval',
      @Schema = 'custom',
      @Debug = 0
