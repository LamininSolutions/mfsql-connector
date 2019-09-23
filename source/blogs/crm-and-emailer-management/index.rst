CRM and Emailer Management
==========================

This use case stem from the complexity  of managing and selecting
contacts and making information available to a Emailer system to manage
the bulk distribution of emails. It also includes the feedback from the
Emailer system to update the history data of the contact.

The deployment of these features are based upon the following elements:

-  Contacts and customers and prospects are managed in M-Files with all
   there associated characteristics such as regions, industries,
   interests, history of previous purchases etc 

-  Using MFSQL Connector the customer and contact data is synchronized
   with SQL.

-  SQL views and queries are used to perform different selection of the
   data.

-  These are exported to a CSV file in the format required by the
   Emailer system

-  This data is integrated with the Emailer own database.  After the
   completion of the campaign a CSV file is exported from the Emailer
   system.

-  SQL picks up the SCV, and aligns it with the customer and contact
   data.  It either create new records or updates records.

-  The updates are synchronized with M-Files and the users have full
   access of the email campaign history in M-Files.  This information is
   available for subsequent campaigns.


