Online Quote System
===================

In this use case M-Files include the product definition and all the
related metadata for generating a quote to the customer.  The quotation
system is very involved and dependent on a series of rules and
conditions. Customers can perform an online quote using a special
website, explore different options and finally confirm the quote.  On
confirmation of the quote a confirmed quote is posted directly into
M-Files to track the quotes and complete the remainder of the sales
processes.

The deployment of this use case involved the following:

-  Using MFSQL Connector all the related classes, valuelists and
   dependencies are synchronized with SQL

-  Additional tables and procedures are included in SQL to represent the
   rules and conditions engine to determine the pricing of the project.

-  A Web Application with membership control that links into the
   customer data from M-Files is built using Code On Time Application
   Generator, This includes history of previous orders and appropriate
   access to the dependencies from M-Files.

-  The customer is presented with pick and select alternatives to choose
   from different product options in the Web Application. The
   application store quotes in progress by customer.

-  On confirmation of the quote a record is created and updated in
   M-Files to trigger the new quote. 

-  The remainder of the provisioning for the order and invoicing process
   is then managed in M-Files.


