MFClass
=======

The MF Class table is pivotal for the Connector. Apart from the standard
class related metadata it also includes other special columns:

#. TableName: On initial syncronisation the Connector will automatically
   asign a name for the class tables. These name can be customised. When
   metadata is refreshed, the names will not be reset. Duplicate table
   names are not allowed. If two classes have the same name, which
   M-Files allows, then the Connector will automatically assign separate
   names. An error message will be created and sent to the support email
   address when this applies.
#. IncludedInApp: On first install the value of this column defaults to
   null.
#.     Setting this to 1 will indicate to the Connector that the
   specific class is relevant in the application of the Connector. 
#.     Setting this to 2 will activate the trigger on the class table to
   execute the spmfupdatetable procedure automatically.  This setting
   should only be used when class table updates must take place by
   transaction.
#. The Connector Management can be used to set the applicable tables and
   to create all the class tables in bulk. Refer to the use of class
   tables for more information on using this indicator for bulk updates.
