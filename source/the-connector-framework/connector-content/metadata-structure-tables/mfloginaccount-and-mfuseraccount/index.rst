MFLoginAccount and MFUserAccount
================================

.. container:: confluence-information-macro has-no-icon confluence-information-macro-information

   Description

   .. container:: confluence-information-macro-body

      The MFLoginAccount table and the MFUserAccount table have
      information about the M-Files users.

The MFLoginAccount will only include objects related to the vault.  It
does not include all the login accounts on the server.

.. container:: confluence-information-macro confluence-information-macro-information

   Availability

   .. container:: confluence-information-macro-body

      .. container:: table-wrap

         ============== ================= ========
         Module         Updated           Release#
         ============== ================= ========
          Data Exchange                   2.0.0.1 
         Data Exchange  MFID column added 3.1.2.38
         ============== ================= ========

.. container:: confluence-information-macro confluence-information-macro-tip

   .. container:: confluence-information-macro-body

      MFContextMenu columns Last_excecuted_by and ActionUser_ID  relates
      to MFID in this table

      The LoginName in MFUserAccount relates to the AccountName in this
      table

      The UserID in MFUserAccount relates to the MFID in this table.

      | 

Use spMFSynchronizeSpecificMetadata to update the login account or user
account tables after making changes in M-Files.

Updating is from M-Files to SQL only.  Updating from SQL to M-Files is
currently not allowed.

.. container:: confluence-information-macro confluence-information-macro-information

   Parameters

   .. container:: confluence-information-macro-body

      MFLoginAccount

      .. container:: table-wrap

         ============ ===========================================
         Column       Description
         ============ ===========================================
         ID           SQL internal id
         AccountName  Full name of account (e.g. domain\username)
         UserName     Name user sign in with
         MFID         M-Files internal ID for user
         FullName     Given full name in login account properties
         AccountType  M-Files or Windows account
         DomainName   Domain if windows user account type
         EmailAddress email in login account properties
         LicenseType  Named, concurrent, read only, none
         Enabled      is enabled = 1
         Deleted      is deleted in M-Files = 1
         ============ ===========================================

      MFUserAccount

      .. container:: table-wrap

         ============ ============================
         Column       Description
         ============ ============================
         UserID       M-Files internal ID for user
         LoginName    Name user sign in with
         InternalUser 1 = Internal user
                     
                      0 = External user
          Enabled     is enabled = 1
          Deleted      is deleted in M-Files = 1
         ============ ============================

.. container:: code panel pdl

   .. container:: codeContent panelContent pdl

      .. code:: sql

         SELECT * FROM [dbo].[MFLoginAccount] AS [mla]
         LEFT JOIN [dbo].[MFUserAccount] AS [mua]
         ON mla.mfid = mua.[UserID]

| 

| 
