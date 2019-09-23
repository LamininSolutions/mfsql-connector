Online Ordering of special stock
================================

In this use case special stock is managed in M-Files.  Customers are
able to order from the special stock using a standard website including
an ordering basket.  On completion of the order a transaction is posted
into M-Files to allow the company to assemble the special stock and
deliver the order to the customer

The deployment of this use case have the following elements

-  The stock details are managed in M-Files and synchronized with SQL
   using MFSQL Connector.  

-  A Web Application with membership control, basket, and access to the
   available stock is deployed using Code On Time Application generator.
   This application points the the SQL database for MFSQLConnector.

-  Additional procedures and functions is added in the SQL database to
   support the Web Application

-  On confirmation of the order, a new sales order is created in SQL and
   synchronized bank into M-Files.

-  A notification alerts the M-Files user that a new customer order was
   placed. The remainder of the process is completed in M-Files.


