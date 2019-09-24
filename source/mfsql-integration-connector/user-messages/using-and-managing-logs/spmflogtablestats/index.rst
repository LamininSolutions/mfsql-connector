spMFLogTableStats
=================

The following procedure will show the size, records and earliest record
date for all the logging tables

.. container:: table-wrap

   ============== ====================================================================================================
   Type           Description
   ============== ====================================================================================================
   Procedure Name  spMFLogTableStats
   Inputs        
   Outputs        Table with columns: Name, rows, reservedKb, DataKb, reserverdIndexSize, reservedUnused, earliestDate
   ============== ====================================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

           EXEC [spMFLogTableStats]  

| 

| 
