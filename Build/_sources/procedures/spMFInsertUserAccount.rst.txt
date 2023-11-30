
=====================
spMFInsertUserAccount
=====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @Doc nvarchar(max)
    listing of user accounts
  @isFullUpdate bit
    always 1
  @Output int (output)
    update result
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
   

Purpose
=======

The purpose of this procedure is to insert user account details into MFUserAccount table.


Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2023-10-12  LC         Update to insert or update changes and set deleted flag for deleted items
2023-05-24  LC         Add vault roles
2019-08-30  JC         Added documentation
==========  =========  ========================================================

