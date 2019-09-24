Automated update of records from M-Files
========================================

The Connector uses the spMFUpdateTable procedure with update method 1 to
process updates from M-Files to SQL.  This procedure is not
automatically called on a change of a record in M-Files. There are
various methods that can be used to trigger this method.



Before making change in SQL
---------------------------

The general rule is to always update from M-Files before a record is
changed in SQL.  This is done by first calling the spMFUpdateTable with
method 1 for the records that will be updated and then to call
spMFUpdateTable with update method 0 after the the SQL record is update
to push to update back to M-Files

The procedure `spMFUpdateMFilesToSQL <page31817730.html#Bookmark43>`__
is particularly valuable in this regard.  Depending on the requirements
and volume of data to be taken into account other update procedures can
also be used as outline in section Insert Update of Class Records.



Using an agent
--------------

If the requirement is to refresh the class tables at intervals (for
instance overnight, or every 2 hours) an agent can be used with
`spMFUpdateAllIncludedinAppTables <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/46661654/Daily+Monthly+Routines+for+Agents>`__



On Demand in external application
---------------------------------

An action button in the external button (e.g. Code on Time action) can
call spmfUpdateTable with update method 1; alternatively
`spMFUpdateTablewithLastModifiedDate <page31817730.html#Bookmark43>`__
can be used.



Action from within M-Files using Context Menu
---------------------------------------------

The `M-Files Context Menu <page52625447.html#Bookmark73>`__ plug-in
allows to call any one of the updating procedures by activating the
update from within M-Files.  The two options include triggering the
procedure without any object level parameters and one that allows for
the selected object parameters to be passed through to the procedure.



Action as part of a workflow script
-----------------------------------

We are currently working on a method that will allow for calling the
procedure by using the context menu vault application from a workflow.
 This will trigger the update from the workflow state change.

| 

| 
