Integration with navision
=========================

In this use case navision is used for order management, inventory
control and customer and supplier control. M-Files is used for advanced
control of the related inventory certificates, and document control
around all the ERP processes.  Some business processes originates in
Navision with M-Files being dependent on the data from Navision, and
other cases such as confirmation of certificates Navision is dependent
on the data that originates from M-Files.

The deployment of this use case involves Navision updating supplier and
inventory data directly from Navision with the MFSQL class tables, which
in turn updates M-Files.  The certifaction of inventory, processed in
M-Files is continiously updated in SQL using MFSQL procedures.  This
data becomes available to navision using extended views and query
facilities in SQL to validate availability of inventory and supporting
certification documents.
