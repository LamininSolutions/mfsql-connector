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

MFContextMenuQueue is part of the queue processing procedures to process action type 5 context menu actions in M-Files. This particular procedure is designed to reprocess events that has not processed on the first attempt.

Additional Info
===============

It is indented for a SQL agent to trigger this procedure frequently to check for and process unprocessed queue items.

When triggered this procedure will update the oldest row in the queue that has not been updated successfully. Each time it performed an attempted update the update cycle is incremented. The agent can then be tuned to stop after a number of cycles. It is set to 5 cycles by default

Examples
========

.. code:: sql

    EXEC spMFUpdateContextMenuQueue 1

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-01-07  LC         Add routine to clean up the queue
2019-12-06  LC         Create procedure
==========  =========  ========================================================

