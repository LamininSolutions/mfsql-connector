
=====================
spMFUpdateAssemblyLog
=====================

THIS PROCEDURE IS UNDER DEVELOPMENT

Return
  - 1 = Success
  - -1 = Error
Parameters  
  @ProcessBatch_ID (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode

Purpose
=======

To process the logging of the methods in the assembly for a specific procedure

The assembly will call this procedure to update the logging statistics in the MFAssemblyLog table.

Additional Info
===============


.. code:: sql

      EXEC spMFUpdateAssemblyLog 

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------

2022-01-04  DEV        Create procedure
==========  =========  ========================================================

