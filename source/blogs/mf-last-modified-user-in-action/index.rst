MF-Last-Modified-User in action
===============================

An important change was introduced in version 4.10.32.76 in the use of the last modified user in M-Files. Todate, when updating a record from SQL to M-Files the MFSQL Connector default user was used as the last modified by user without any option to change it.

From version 4.10.32.76 it is possible to set or modify the last modified user on a record.

The following rules apply
 -  When a new record is created in the class table and the MF-Last-Modified-User is not specifically set, it will default to the user set in the MFSettings table. This is the default MFSQL Connector user.
 -  To set or modify the last modified user, simply set the MF_Last_Modified_User_id (Property mfid 23) to the user id for the user making the change.  This id is the UserID in the MFUserAccount table.
 -  If an update is made to an existing record from SQL to M-Files and the update does not explicitly set the last modified user, then the value of this column before the update will be used. This implies that if an update was made in MF by user AlanK, and the record is then updated in SQL and the update does not specify the last modified user, then AlanK will be the last modified user of the update in M-Files.

This new feature allows for improved control over who initiated an action in SQL. For example:
 -  Where an update in M-Files triggers an action in SQL, the user that performed the update in M-Files can be used as the last modified update in SQL.  
 -  Where MFSQL is used to perform a corrective action on a object, the originating user can be set as the last modified user. 
 -  When a transaction originates in a third party system, the user in the third party system can be used to show who modified the record in M-Files.

This feature may impact adversely on existing customer procedures that does not take setting the last modified user into account, especially where the object is update in M-Files and in SQL.  In these cases the last modified user will continue to show as previous last modified user instead of being updated from MFSQL.