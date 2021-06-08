Table relations - views for reporting
=====================================

When doing data preparation for reporting it may be necessary to do some
joins to relate tables in the Connector with each other. This blog
highlights the relations.

Class tables was designed to support easy to use access to the M-Files
metadata. For many reports one would only have to access a single class
table without any additional joins.

-  The value of a lookup is (e.g. showing USA as the country instead of
   just the id of the lookup item) is included in the class table. This
   include Other objects (e.g. the Customer of the Contact), Valuelist
   item, workflow, workflow state, and several system based properties
   such as class, modified by, created by etc.

-  When the values is for a multi lookup, then the values will show as a
   comma delimited string.

It is only necessary to build a join with the class table if the report
requires or could benefit from using additional data that is in the
class table of a related object. (for example the phone number of the
Company for a Contact:

-  Example: Joining the Customer class table with the Contact Class
   Table

-  Join: Column\_ID with Objid of second table

.. code:: sql

    Select * from MFContact
    inner join MFCustomer
    on MFContact.Customer_ID = MFCustomer.Objid


