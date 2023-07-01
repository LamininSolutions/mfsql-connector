
====================
spMFUsersByUserGroup
====================

Return
  - 1 = Success
  - -1 = Error

  @Debug (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

To produce a report listing the members of each user group.  The report will include users where the usergroup included another usergroup.

Examples
========

.. code:: sql

    Exec spMFUsersByUserGroup

    select * from ##spMFUsersByUserGroup
    

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------

2023-05-25  LC         Create procedure
==========  =========  ========================================================

