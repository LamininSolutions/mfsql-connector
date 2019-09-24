M-Files trigger for transactional update
========================================

MFSQL Connector allows for updates from SQL to M-Files to be automated
with a trigger on the MFClass Table.  When IncludeInApp column on the
class table is set to 2,  the trigger will automatically be created on
the Class Table when spmfCreateTable procedure is used to create the
table.  When an object is added or changed in the class table the
trigger will activate to automatically perform spmfUpdateTable with
updatemethod set to 0 for the table.  This implies that the update in
the class table will automatically update into M-Files without having to
run the update procedure.

This method is very appropriate in applications where single or a few
records are updated in a class table via a third party application or
procedure.  It is not appropriate for bulk updates procedures.

When it is determined that a class table is targeted for transactional
update, the IncludeinApp column in the MFClass table must be set to 2
for the table.  If the table has already been created then either of the
following two actions should be followed.

#. After updating the MFClass table with IncludeInApp column set to 2
   for the class table, drop the class table and recreate the table, 
   This will automatically set the trigger on the table.
#. In cases where the above action cannot be followed, the following
   procedure can be executed for the specific class
   table: spMFCreateClassTableSynchronizeTrigger

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      It is known for the trigger to interfere when the spmfUpdateTable
      procedure is called using a SSIS step. The transactional update
      method cannot be used in conjunction with SSIS.

| 
