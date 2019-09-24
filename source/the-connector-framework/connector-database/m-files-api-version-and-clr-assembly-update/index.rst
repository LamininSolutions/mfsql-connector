M-Files API version and CLR Assembly update
===========================================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      The M-Files APIs is loaded into the Connector Database as part of
      the assemblies of each database.  It is required to ensure that
      the API version of the M-Files Client on the SQL Server remains
      the same as the API version in the assemblies of the Database. 
      When the M-Files Client on the SQL Server is upgraded to
      assemblies will go out of sync and the Connector will stop
      working.

      Version 4.3.9.48 introduced an new method of automatically
      monitoring the M-Files version change and updating the assemblies.

      -  An agent is created during installation to run every day. This
         agent will check the installed M-Files version on the SQL
         server using spMFCheckAndUpdateAssemblyVersion. If the M-Files
         version changed, the MFSettings table is updated and the
         procedure spMFUpdateAssemblies are executed.
      -  The procedure spMFUpdateAssemblies can be executed manually to
         update the assemblies. 

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ========= ========
         Module    Release#
         ========= ========
         Developer 4.3.9.48
         ========= ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      Consult \ `Updating Connector after M-Files had an
      upgrade. <https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/blog/2018/11/22/610795521>`__
      on how to update the assemblies after a change of version.

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      MFSQL Connector will fail if the the M-Files API (M-Files version
      specific) changes without updating the assemblies in the database.

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== =============================================
         Type           Description
         ============== =============================================
         Procedure Name spMFUpdateAssemblies
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
