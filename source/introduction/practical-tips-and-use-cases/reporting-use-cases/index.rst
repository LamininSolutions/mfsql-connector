Reporting Use Cases
===================

.. container:: blog-post-listing

   .. container:: wiki-content

      The Connector allows for extracting object history from M-Files
      into SQL. The operation will get the change history for specific
      objects and for specific properties. It is not designed to get the
      change history for every property on the object in a single
      process. The operation is intended to be used where the target
      property and the specific object is predetermined.…

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

      One of the hidden features of the Connector is to get the M-Files
      Event log and produce reports from it. This works with both
      standard and extended event log in M-Files. This illustration will
      focus on the extended event log. M-Files event log reports many
      different types of events. Each type of event will include a
      distinct set of properties recorded for the event. The properties
      are a rich set of information about what has happened in the
      vault,…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      Reporting need data and a user interface. The Connector provisions
      the data and the report designer of choice presents the data to
      the user. The Connector gets M-Files data and any other systems
      data and makes it available in tables, views and dynamically
      compiles it in store procedures. Other tools such as SQL Analytics
      or data warehousing can be used in conjunction with it. The data
      is one step removed from live data.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      Release 4.2.8.46 introduces a method to rapidly start-up the
      Connector for Reporting. Follow the link for a step by step guide
      of getting started
      https://cloud.lamininsolutions.com/SharedLinks.aspx?accesskey=ad33f6c77b6d68b8c26fa3bf6a32d830ba81ffc2f3bb33f037f22d410c59cba6&VaultGUID=312E44F6-AE4B-4F5E-8784-9527260A5743.
      Use the Whitepaper
      https://cloud.lamininsolutions.com/SharedLinks.aspx?…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      Release 4.2.7.46 introduces new procedures to rapidly get started
      with reporting from M-Files in just a few simple steps. Step 1:
      Install the MFSQL Connector and complete the license installation.
      Step 2: Use setup reporting in sample in C:\Program Files
      (x86)\Laminin Solutions\MFSQL Connector Release
      4\MFSQL_Release_46\Example Scripts\20.102.Setup_Reporting.sql to
      prepare the Connector. Step 3: Use Report designer of your choice
      (Excel, Power BI, Visual Studio Report Designer,…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      orThis use case focus on the application of the context menu to
      provide feedback to the user on a result of a calculation, status
      or summary. The type of report would depend on the specific use of
      the vault but could include something like a status report on
      cases closed in the last hour or the financial summary of a
      customer’s invoices. The key is the report should be simple,
      concise and suitable for display in a messagebox text based
      report. Graphics, multipage data,…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      In this use case we demonstrate how Power BI is connected to a
      Connector class table or view. Enabling the Connector for Power BI
      has a few steps to prepare the data. Once the data is prepared one
      need to consider the frequency or trigger for updating the data.
      Connecting Power BI with the data comes next and finally one need
      to consider how the user will trigger the report.. After
      installing the data exchange module of the Connector and
      refreshing the metadata structure,…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      This use case highlight how to setup a report with near real time
      data in M-Files. This is particularly relevant where the data from
      M-Files objects are used for ongoing performance management or
      monitoring of progress. The illustration use the following:
      M-Files is used for case management in a high performance
      environment. Many new cases are reported every day and requires
      management of progress based on key performance areas and strict
      rules for excessive waiting time.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      In this use case some metadata in M-Files is combined with data
      from other systems and the resulting management reports are then
      made available to the users with a intranet web portal.  The use
      case have the following components: The information that is
      required for the reports are synchronized with SQL overnight using
      MFSQL Connector with an agent running the procedure to update.…

   .. container:: endsection


