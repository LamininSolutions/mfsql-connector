Building custom applications and integrations
=============================================

.. toctree::
   :maxdepth: 4

The main focus of the Connector is to allow for building small and large
custom applications and integrations around M-Files.  Building these
applications does not require deep knowledge of the M-Files API's or
.Net Application development although it may be useful in some cases.
The Connector is built for and is very useful in the hands of someone
with T-SQL query experience.

Using Code On Time
==================

`Code on Time <http://codeontime.com>`__ is a powerful Intelligent App
Generator.  It works well with SQL Server and we have used to generate a
number of applications to extend the functionality of M-Files.  MFSQL
Connector is a vital part of this architecture to enable Code On Time to
operate on the SQL tables and integrate the operations with M-Files.

Many of the Connector helper tools supports the development and
deployment of a Code on Time application.

Code on Time is entirely optional and is not a requirement for
the deployment of the Connector.  However it is a useful tool to rapidly
provide the user interface to the end user where the user cannot perform
the interaction using M-Files or another third party application.

This documentation does not provide detail guidance or training for the
use of Code On Time.  Consult the Code On Time website, training
material and forums that is dedicated for this purpose.  We do however
highlight guidance and applications specific to the Connector.

Updating M-Files from within CoT
--------------------------------

Different methods can be used to perform an update on records in CoT.
 The following highlights some of these methods:

Update in M-Files
~~~~~~~~~~~~~~~~~

Use CoT listing as read only and provide a link to the item in M-Files.
Use the Connector hyperlink function in a view  to generate the URL.  On the CoT Controller of the view add a action on
the grid with the item Command Name set to Navigate and the Command
Argument is set the \\_blank:{ColumnNameofURL}

hyperlink :doc:`/functions/fnMFObjectHyperlink`

Transaction based update
~~~~~~~~~~~~~~~~~~~~~~~~

On MFClass set IncludeInApp = 2 on the
class table that you want to update.  in CoT:  Using the Field property
window for process_id; Set the Code Value = 1.  When you make an update
in CoT using the standard create / edit actions in CoT, the record will
automatically be created in M-Files on save.

      The Class Table must be created with the IncludeInApp set to 2
      before the table is created.  When the IncludeInApp is changed to
      2 after the class table was created then either a) drop and
      recreate the table after the column was set to 2 or b) run the
      procedure spMFCreateClassTableSynchronizeTrigger for the table. 

Batched based update with low volume of updates at any one point in time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Set the class table column IncludeInApp = 1.  In CoT:  Using the Field
property window for process_id; Set the Code Value = 1.. Add an action
on the Controller : Command Name = SQL.  Add the standard procedure call
for updating records :doc:`/procedures/spMFUpdateTable` in the script section.

Batched based update for many records
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Set the class table column IncludeInApp = 1.  In CoT:  Using the Field
property window for process_id; Set the Code Value = 1. Add an action
on the Controller.  Instead of a simple SQL statement we recommend that
a business rule is used and that the appropriate updatetable procedure
is used as part of the deployment to `call a store procedure in a
business rule <https://codeontime.com/learn/business-rules/sql/calling-stored-procedure>`__
