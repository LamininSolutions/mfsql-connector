
====================
spMFCreateAllLookups
====================

Return
  - 1 = Success
  - -1 = Error
Parameters
  @ProcessBatch\_ID int (optional, output)
    Referencing the ID of the ProcessBatch logging table
  @Schema nvarchar(20)
    - Default = 'dbo'
    - Which schema to operate on
  @IncludeInApp int (optional)
    - Default = 1
  @WithMetadataSync bit (optional)
    - Default = 0
    - 1 = call spMFDropAndUpdateMetadata internally
  @Debug smallint (optional)
    - Default = 0
    - 1 = Standard Debug Mode
    - 101 = Advanced Debug Mode

Purpose
=======

Prodecedure to create all workflow and Valuelist lookups that is used in the included in App class tables

Changelog
=========

==========  =========  ========================================================
Date        Author     Description
----------  ---------  --------------------------------------------------------
2019-08-30  JC         Added documentation
2019-01-30  LC         Valuelist name: Source Does not exist or is a duplicate
==========  =========  ========================================================

