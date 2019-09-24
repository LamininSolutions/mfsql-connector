Building extended applications
==============================

.. container:: blog-post-listing

   .. container:: wiki-content

      Several procedures, functions and special columns in the metadata
      tables are specifically designed for using with building
      applications.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      In this use case we will setup a process using functionality
      exposed by MFSQL Context Menu and SQL Server Agent in order to
      setup a scheduled refresh from M-Files to SQL Server class
      table(s) for reporting purposes. The content will demonstrate how
      to avoid doing a refresh while another process is still running as
      well as demonstrate some best practices around building a stored
      procedure being called by SQL Server Agent Job.…

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

      The connector is geared toward making your life as developer
      easier when you iterate through the process of configuring M-Files
      and preparing the custom procedures for your application. Best
      practice is to create a script and add all the execution
      statements for the initialization of the application to it. Save
      the script in a project folder on your desktop as
      ‘script.InitializeApp’. Setup the individual statements in the
      script to be repeatable.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      The following whitepaper reviews the considerations for selecting
      MFSQL Connector as the framework of choice to develop integration
      between M-Files and other applications. MFSQL Connector
      Integration Whitepaper
      https://cloud.lamininsolutions.com/SharedLinks.aspx?accesskey=d070e83284dfecb661ae6d3129ef6fac4276bfc8aff2624305ad02fd148c9dec&VaultGUID=312E44F6-AE4B-4F5E-8784-9527260A5743
      integration customapp_usecase whitepaper

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      In this use case we will focus on how and why use the Connector
      for processing scanned documents. Getting scanned documents into
      M-Files and classifying the document can be very easy, and mostly
      is. M-Files provide powerful capabilities for it out of the box.
      Specialist scanning software (such as Ancora, chronoscan, ezescan,
      ABBYY and others) all include methods of processing scanned
      documents into M-Files. What role does the Connector play then? In
      our experience it comes into play,…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      This use case will illustrate how to setup an action to take place
      in SQL based on a workflow state change. When the purchase invoice
      is approved, SQL must be updated with the latest status of the
      object. It this use case only the specific object must be updated.
      An alternative method would be to update all changes in the class
      for all objects. This is a different method requiring a slightly
      different approach.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      This use case illustrate how to update only the records that have
      changed between M-Files and an a third party application. It is
      important to not not update every record, every time in M-Files to
      avoid a huge number of history records where no change has taken
      place. Step 1: Add the key values from the external tables into a
      temporary table. Create table #SalesOrders ( [SalesOrder]
      NVARCHAR(100), [ProgramOrder] NVARCHAR(100), [MainSerialNo]
      NVARCHAR(100), [SigmaProgram] NVARCHAR(100),…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      This use case focus on using the unique id from a third party
      application table as a key reference in SQL and M-Files. M-Files
      provides the capability on importing objects via External
      Connector to set the unique ID of a dataset to be imported as the
      objectID. The objectID is then shown on the metadata card as the
      ID of the object. The Connector provides the capability to use the
      same functionality. In additional it also provides the ability to
      update or change the objectID.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      It is good practice to use aliases instead of names or ids of
      objects such as states, classes etc when building applications.
      This use case apply workflows and workflow states and include to
      following connector objects MFWorkflow MFWorkflowState
      spMFAliasesUpsert Step 1: Create aliases for workflows and
      workflow states. DECLARE @ProcessBatch_ID INT; EXEC
      [dbo].[spMFAliasesUpsert] @MFTableNames = 'MFWorkflowState', --
      nvarchar(400) @Prefix = 'ws', -- nvarchar(10) @IsRemove = 0,…

   .. container:: endsection


