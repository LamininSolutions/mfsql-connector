Practical tips in using MFSQL Connector
=======================================

.. container:: blog-post-listing

   .. container:: wiki-content

      From version 4.4.13.53 the licensing module includes additional
      refinements. The license check no longer connects to M-Files for
      each process. It cycles through to update the validity
      occasionally and maintain the license check within SQL which
      significantly reduces the performance load on M-Files, especially
      for large scale updates. When the expiry date of the license
      reaches 30 days before expiry and email will be send once a day to
      warn of the eminent expiry.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      M-Files is pushing upgrades of M-Files regularly. Refer to the
      blog around setting up MFSQL Connector to detect changes in the
      M-Files Version. Sometimes it is necessary to intervene. It is
      likely to be triggered by an error or email notification with an
      error referring to an issue with the Interop.MFilesAPI assembly
      similar to A .NET Framework error occurred during execution of
      user-defined routine or aggregate
      "spMFGetMetadataStructureVersionIDInternal": System.IO.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      When doing data preparation for reporting it may be necessary to
      do some joins to relate tables in the Connector with each other.
      This blog highlights the relations. Class tables was designed to
      support easy to use access to the M-Files metadata. For many
      reports one would only have to access a single class table without
      any additional joins. The value of a lookup is (e.g. showing USA
      as the country instead of just the id of the lookup item) is
      included in the class table.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      MFSQL Connector allows for new records to be added from SQL to
      M-Files. This blog illustrates some of the key considerations and
      methods associated with inserting new records. The key steps in
      adding records from SQL include: Design the target class object in
      M-Files with all the required properties.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      The procedure spMFGetHistory creates rows for every change of the
      specific property or properties of the given class based on the
      filters specified. When the procedure is run for the same object
      and filters, it will update the existing row. If it finds a new
      change version for the same property on the same object then a new
      row will be created.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      MFSQL Connector is installed, so now what? Getting started could
      be overwhelming with the Connector’s wide range of capabilities
      and uses. This blog will guide you through the resources for
      specific use cases to get started. When you mastered the basics,
      you will discover more of the many capabilities that is installed
      with the product. However, it is likely that you are using the
      Connector to solve a specific use case or problem.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      M-Files users can delete, destroy and undelete a record. MFSQL
      Connector will remove deleted objects from the class table (or
      optionally retain the record with a deleted flag) and reinstate
      the record in the class table if it has been undeleted. It is also
      possible to delete or destroy records in M-Files in bulk from
      MFSQL Connector. This is particularly useful when a large number
      of records must be deleted in M-Files.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      The demand for managing metadata in large vaults is on the
      increase. MFSQL Connector can make a difference when the most
      appropriate tools are selected to deal with different scenarios
      and applications. This blog aims at providing perspective on the
      key considerations for large vaults. The number of objects and the
      complexity of the metadata design in a specific class is key to
      define a “large vault” in terms of the use and impact of MFSQL
      Connector. Anything over 75,…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      MFSQL Connector makes it easy to create and incorporate hyperlinks
      to objects for use in different scenarios It can be used to create
      various forms of desktop and web hyperlinks. The link can be
      formatted to be html friendly. For public hyperlinks
      https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/blog/2018/11/30/612073473/Creating+and+using+public+shared+link.
      The function fnMFObjectHyperlink
      https://lamininsolutions.atlassian.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      Release 4.3.9.48 introduces a range of improvements and new
      capabilities. This blog provides a quick overview for the
      following: Context menu New method of managing connection string
      for context menu Change in context menu security Installation and
      upgrade New installation and upgrade procedures Improved
      validation of M-Files version change and MFSQL Connector API
      upgrade.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      MFSQL Connector uses delimiter based operations, especially for
      multi lookups. These functions are useful in your custom
      development. This use case elaborate on the application of the
      functions. Parse Delimited String The function
      fnMFParseDelimitedString is a table based function to parse any
      string of multiple items split by any delimiter into a table with
      two columns: ID and ListItem. DECLARE @String NVARCHAR(1000) SET
      @string = 'item1, item 2, item 3' select \* from [dbo].…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      When developing a solution it is notoriously complex to get to
      grips with all the dimensions and relations of the use of
      valuelists and valuelist items to ensure that the data is properly
      aligned, prepared, or inserted. The special view
      MFvwMetadataStrcuture is especially helpful to the developer in
      this process as it offers exploration capabilities that is much
      easier to use that the M-Files Administration Panels. The
      following listing will show each valuelist, its associated
      properties,…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      Multi Select lookups adds a special dimension to be considered.
      M-Files allows for any lookup to be either multi select or single
      select. By default the system will create a property as a multi
      select lookup when a new object type, class or valuelist is
      created. When a multi lookup is used in M-Files and the property
      contains more than one item, the Connector will list the id's of
      all the items with a comma (“,”) delimited string as the IDs of
      the column.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      Version 4.3.8.48 introduced the capability to import files to an
      object in the class table from a explorer folder. The main use of
      this feature is create or update a record in the class table and
      associate a file or files from explorer at the same time.
      Prerequisites for the spMFUpdateExplorerFiletoMFiles routine are:
      New or existing record in Class table - @SQLID parameter refers to
      the id of the record. The record must pre-exist in the class
      table.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      The M-Files Property ‘Mark for Archiving’ is not added to a class
      table by default. However, it is possible to add the column to the
      class table, and to set the flag on the property to aid bulk
      update of this property from SQL. This is particular handy when
      advanced logic is used to determine if a record should be archived
      and to set the flag. The following steps illustrate adding the
      column,…

   .. container:: endsection


