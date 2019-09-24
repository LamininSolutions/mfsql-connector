Template objects
================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      Objects that is marked as a template is treated differently in
      SQL.  Templates in M-Files does not have to comply with required
      properties. Template also do not have any purpose in SQL. 
      Excluding templates from SQL prevent data integrity conflicts in
      the tables. It also prevents the templates from being included in
      reports or processing. However, exluding template do have some
      considerations in SQL

      #. If an object is created as a template in M-Files, it will not
         be shown in SQL. 
      #. If a object has already been imported into SQL and subsequently
         changed to a template, it will continue to show in SQL and the
         column Is_Template will be added to the class table.

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ========= ========
         Module    Release#
         ========= ========
         Developer 3.1.2.x
         ========= ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      | 

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      | 

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== =============================================
         Type           Description
         ============== =============================================
         Procedure Name
         Inputs         Debug: 1 = Debug Mode; 0 = No Debug (default)
         Outputs        1 = success
         ============== =============================================

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          

.. container:: confluence-information-macro confluence-information-macro-information

   Use Cases(s)

   .. container:: confluence-information-macro-body

      | 

| 
