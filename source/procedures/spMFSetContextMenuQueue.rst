========================
spMFSetContextMenuQueue
========================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ID   - id of Contextmenu

  @Updatetype 

    1 - insert new queue
    2 - update Task
    3 - initiate procedure
    4 - complete procedure
    5 - update error

  @Debug

Purpose
=======

MFContextMenuQueue is part of the queue processing procedures to process action types for context menu actions in M-Files. This particular procedure is designed to set and update entries in the MFContextMenuQueue.

Insert new queue - executed by VAF when call is received from M-Files
Update queue status - when VAF executes Task
Update queue status - when procedure is initiated
Update queue status - when procedure is completed

Additional Info
===============

It is used by the VAF to insert and update the status of the queue and must be included in the custom procedure to process the action.

Examples
========

update queue for contextmenu action 1,4 based procedure

.. code:: sql

    EXEC spMFSetContextMenuQueue @ID = 1, @UpdateType = 3

update queue for contextmenu action 3,5 based procedure

.. code:: sql

    EXEC spMFSetContextMenuQueue @ID = 1, @UpdateType = 4

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2020-01-07  LC         Add routine to clean up the queue
2019-12-06  LC         Create procedure
==========  =========  ========================================================

