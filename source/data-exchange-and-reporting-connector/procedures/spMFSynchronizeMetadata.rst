spMFSynchronizeMetadata
=======================

Returns
    1 = success

Inputs
   Debug
      1 = Debug Mode; 0 = No Debug (default)
   ProcedureBatch\_ID
      null

Examples
--------

.. code:: sql

    DECLARE @return_value int

    EXEC @return_value = [dbo].[spMFSynchronizeMetadata]
      @Debug = 0

    SELECT 'Return Value' = @return_value

    GO

.. code:: sql

     EXEC [dbo].[spMFSynchronizeMetadata]

