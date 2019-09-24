Use cases: integration with third party applications
====================================================

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

      In this use case we would like to illustrate how an event handler
      can be used to trigger an SQL procedure using the Context Menu
      functionality. Refer to the following sections for more detail on
      using and setting up context menu related functionality: Using the
      context menu
      https://lamininsolutions.atlassian.net/wiki/spaces/MFSQL/pages/52625447/Using+the+Context+Menu
      Updating the context menu https://lamininsolutions.atlassian.…

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

      In this use case MFSQL Connector was used the integrate SAGE 200
      with M-Files. The customer use SAGE for case management and
      M-Files for filing all the documents related to the cases. The
      objective was to allow a user the create a new case in either
      M-Files or SAGE and to update the other system automatically. It
      involved also ensuring that the employee/user records in SAGE and
      M-Files stay in sync.…

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

      This use case stem from the complexity  of managing and selecting
      contacts and making information available to a Emailer system to
      manage the bulk distribution of emails. It also includes the
      feedback from the Emailer system to update the history data of the
      contact. The deployment of these features are based upon the
      following elements: Contacts and customers and prospects are
      managed in M-Files with all there associated characteristics such
      as regions, industries, interests,…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      In this use case M-Files include the product definition and all
      the related metadata for generating a quote to the customer.  The
      quotation system is very involved and dependent on a series of
      rules and conditions. Customers can perform an online quote using
      a special website, explore different options and finally confirm
      the quote.  On confirmation of the quote a confirmed quote is
      posted directly into M-Files to track the quotes and complete the
      remainder of the sales processes.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      In this use case special stock is managed in M-Files.  Customers
      are able to order from the special stock using a standard website
      including an ordering basket.  On completion of the order a
      transaction is posted into M-Files to allow the company to
      assemble the special stock and deliver the order to the customer
      The deployment of this use case have the following elements The
      stock details are managed in M-Files and synchronized with SQL
      using MFSQL Connector.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      In this use case navision is used for order management, inventory
      control and customer and supplier control. M-Files is used for
      advanced control of the related inventory certificates, and
      document control around all the ERP processes.  Some business
      processes originates in Navision with M-Files being dependent on
      the data from Navision, and other cases such as confirmation of
      certificates Navision is dependent on the data that originates
      from M-Files.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      In this use case manufacturing test results are produced by
      testing equipment. The test results consist of a file with
      readings and other data, and the manufacturing unit reference
      data.  These test results must all form part of the quality
      assurance documentation for each manufacturing unit. The quality
      control process, including all related documentation is maintained
      in M-Files.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      In this use case the sales invoices are prepared in M-Files.
       These invoices are the result of the quote to order to invoice
      management process which are all performed in M-Files.  On
      completion of the invoice in M-Files the resulting accounting
      transaction is posted into SAGE 50 for financial accounting. One
      of the key elements of this integration is that SAGE 50 does not
      allow any direct update into their databases and only allow
      integration by way of csv files.…

   .. container:: endsection


