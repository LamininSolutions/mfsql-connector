
==========================
spMFUpdateContextMenuQueue
==========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ID
    - id of the row in MFContextMenuQueue

Purpose
=======

This procedure is called by the trigger tMFContextMenuQueue_UpdateQueue on the table MFContextMenuQueue.  The entry into MFContextMenu is inserted by adding a row in the MFContextMenuQueue as part of the custom procedure to process action type 5 context menu actions in M-Files

Additional Info
===============

When triggered this procedure will update the row in the queue that has not been updated successfully.

Warnings
========

Examples
========

.. code:: sql

    EXEC spMFUpdateContextMenuQueue 1

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-12-06  LC         Create procedure
==========  =========  ========================================================

