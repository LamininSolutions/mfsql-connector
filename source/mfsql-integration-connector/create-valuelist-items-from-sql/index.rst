Update / Create Valuelist Items from SQL
========================================



spMFSynchronizeValueListItemsToMFiles
-------------------------------------

The connector allows for creating or updating valuelist items from SQL
to M-Files.  This is process could apply as part of data take on or data
management operations, or be built into the processes when third party
data is integrated into M-Files.



Updating creating a valuelist item
----------------------------------

Follow these steps to update Valuelist items from SQL into M-Files

#. Determine which valuelist items should be updated:

   #. There are new items to be added, possibly derived from the
      external data source.
   #. Change to the name of an item as a result of some data analysis in
      the valuelist item table
   #. Valuelist tems that must be deleted that is no longer required.

#. All updates or inserts take place in MFValuelistItems table

   #. An existing item to be updated: use update procedure to change the
      name, and set process_id = 1
   #. An existing item to be deleted: use update procedure to set
      process_id = 2
   #. A new item

      #. Determine the ID of the valuelist in question.
      #. Create the valuelist in M-Files and synchronise valuelists If
         the valuelist have not yet been created
      #. Use insert statement to set the following columns

         #. Name
         #. MFValueListID  (note that this is the ID of the valuelist.
             Do not use the MFID of the valuelist )
         #. OwnerID: Set to MFID of the owner object. Set to 0 if there
            is no ownership relationship.
         #. Set process_id = 1

#. Execute spMFSynchronizeValueListItemsToMFiles

| 

| 

.. container:: table-wrap

   ============== =============================================
   Type           Description
   ============== =============================================
   Procedure Name spMFSynchronizeValueListItemsToMFiles
   Inputs         Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== =============================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFSynchronizeValueListItemsToMFiles]
                 @Debug = 0 -- smallint

OR

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFSynchronizeValueListItemsToMFiles]

| 

.. container:: confluence-information-macro confluence-information-macro-warning

   Valuelist settings

   .. container:: confluence-information-macro-body

      Note that the valuelist must allow users to update the valuelist
      to be able to run this procedure

      The valuelist must be created using M-Files admin or pre-exist.

      Ensure that the valuelist metadata synchronization is refreshed if
      any changes are made in M-Files to the valuelist such as changing
      the owner.

      M-Files does not check for duplicate names in a valuelist. Special
      care should be taken using SQL when adding new items to ensure
      that there is not an item with the same name in the same Valuelist

      The ownerID of an item can be added but not changed. Delete the
      unwanted item and create a new item. Note that this may involve
      moving existing data from one valuelist item to another.

      When Valuelist Item labels are changed in SQL to update M-Files,
      the labels will change in M-Files, however, the labels will only
      change in the Class table in SQL after the object had a version
      change and a new table update has been performed.
