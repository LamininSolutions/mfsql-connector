Database optimization
=====================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      MFSQL Connector does not automatically  create indexes, statistics
      and foreign keys for all columns with related tables. We believe
      that it is appropriate that these optimization methods should be
      considered and applied in each situation rather that as a general
      rule.

      We therefore recommend that indexes, statistics and where
      appropriate foreign keys are created as part of the development
      project.

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         =========== ========
         Module      Release#
         =========== ========
         Integration 4.1.5.41
         =========== ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      | 

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      Maintain a custom script for the creation / update of all settings
      on class tables.  These scripts will have to be manually run
      against the class tables when these tables are dropped as part of
      the development activity.

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

              CREATE INDEX [UDX_CLCustomer]
                 ON [dbo].[CLCustomer]
                 (
                     [Epicor_Company_ID]
                   , [Customer_Code]
                 )

| 
