Integration with SAGE 200 - Case Management
===========================================

In this use case MFSQL Connector was used the integrate SAGE 200 with
M-Files. The customer use SAGE for case management and M-Files for
filing all the documents related to the cases. The objective was to
allow a user the create a new case in either M-Files or SAGE and to
update the other system automatically. It involved also ensuring that
the employee/user records in SAGE and M-Files stay in sync.

In simple terms the implementation involved identifying the tables in
SAGE related to the Case master record and ensuring that all the related
data has an equivalent object and properties in M-Files.

The key to the solution was to use a staging table to determine which
update is the latest and in which direction the update is taking place.
Updates from SAGE had to be triggered from M-Files as a pull, due to the
complication of SAGE not allowing adding triggers on the SAGE table
tables.

The Context Menu functionality was used to trigger the update of a Case
in M-Files directly into SAGE using an event handler to set MFSQL
Connector in motion to get the related data, convert it into SAGE speak,
check the staging table and perform the update into SAGE.

Another feature of the Context Menu was used to allow for the user to
pull updates for a specific object from SAGE. At the same time any other
updates are also performed at the same time.

When any update is taking place MFSQL Connector ensured that the
employee records of both systems are in sync.
