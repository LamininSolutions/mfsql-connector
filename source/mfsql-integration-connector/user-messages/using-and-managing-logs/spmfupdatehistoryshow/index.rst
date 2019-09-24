spMFUpdateHistoryShow
=====================

use spMFUpdateHistoryShow to show the records that is included in the
MFUpdateHistory table. Refer to
`MFUpdateHistory <page21200982.html#Bookmark61>`__ for more information
on what is being logged in this table.

MFUpdateHistory is has columns which can contain large XML records and
could take some time if all the records are selected.  We recommend to
use the following statement to get the most recent entries:

SELECT TOP 5 \* FROM [dbo].[MFUpdateHistory] AS [muh] ORDER BY id desc 

.. container:: table-wrap

   ============== ==========================================================================================================
   Type           Description
   ============== ==========================================================================================================
   Procedure Name  spMFUpdateHistoryShow
   Inputs         Update_ID: the id of the record in MFUpdateHistory
                 
                  IsSummary: default = 1. Show summary information about all columns; 0 show detail of selected UpdateColumn
                 
                  UpdateColumn: Sets the column selection that will be displayed
                 
                  .. rubric:: UpdateColumn Options:
                     :name: Bookmark65
                 
                  .. container:: table-wrap
                 
                     +-----------------------+-----------------------+-----------------------+
                     | UpdateColummn         | ColumnName            | Update Description    |
                     +=======================+=======================+=======================+
                     | 0                     | ObjectDetails         | Object Details        |
                     +-----------------------+-----------------------+-----------------------+
                     | 1                     |  ObjecVerDetails      | Data from SQL to      |
                     |                       |                       | M-Files               |
                     +-----------------------+-----------------------+-----------------------+
                     | 2                     | NewOrUpdatedObjectVer | Object updated in     |
                     |                       |                       | M-Files               |
                     +-----------------------+-----------------------+-----------------------+
                     | 3                     | NewOrUpdateObjectDeta | Data From M-Files to  |
                     |                       | ils                   | SQL                   |
                     +-----------------------+-----------------------+-----------------------+
                     | 4                     | SyncronisationErrors  | Synchronization       |
                     |                       |                       | Errors                |
                     +-----------------------+-----------------------+-----------------------+
                     | 5                     | MFError               | M-Files Error         |
                     +-----------------------+-----------------------+-----------------------+
                     | 6                     | DeletedObjects        | Deleted Objects       |
                     +-----------------------+-----------------------+-----------------------+
                     | 7                     | ObjectDetails         |  New Object from SQL  |
                     +-----------------------+-----------------------+-----------------------+
                     |                       |                       |                       |
                     +-----------------------+-----------------------+-----------------------+
                 
                  | 
                 
                  | 
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== ==========================================================================================================

Example of producing the summary report

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFUpdateHistoryShow] @Update_ID = 217,    -- int
                                            @IsSummary = 1,    -- smallint
                                            @UpdateColumn = 0, -- int
                                            @Debug = 0         -- smallint

Below is a sample of the result:  Note that the result will vary
depending on the updatemethod of the process

.. container:: table-wrap

   ============= ========================================================================
   Update column Explanation of RecCount
   ============= ========================================================================
   0             Not Applicable
   1             Updatemethod 1: count of objects in SQL passed into M-Files for updating
                
                 Updatemethod 0: not applicable
   2             Updatemethod 1: NA
                
                 Updatemethod 0: count of objects in SQL passed into M-Files for updating
   3             count of properties being updated for all the objects
   4             count of objects with synchronisation errors
   5             count of objects with SQL errors
   6             count of deleted objects
   7             UpdateMethod 0: count of properties being updated from SQL to M-Files
   ============= ========================================================================

Listings of each column can be shown by using the same procedure with
IsSummary = 0 and selecting the column to be listed.

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFUpdateHistoryShow] @Update_ID = 217,    -- int
                                            @IsSummary = 0,    -- smallint
                                            @UpdateColumn = 3, -- int
                                            @Debug = 0         -- smallint

The records shown in the listing will depend on the column selected and
the updatemethod used

.. container:: table-wrap

   ====== =====================================================================================================
   Column Type of listing
   ====== =====================================================================================================
   1      current version of class table record for the object(s) passed into M-Files
   2      current version of class table record for the object(s) returned from M-Files
   3      listing of all the properties and values of all the objects received from M-Files for updating in SQL
   4      current version of class table records
   5      current version of class table records
   6      listing of object id of deleted records
   7      listing of all the properties and values passed into M-Files
         
          listing of the current version of the object in class table
   ====== =====================================================================================================
