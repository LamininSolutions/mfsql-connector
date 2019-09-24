Metadata management Use Cases
=============================

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

      It happens that objects in M-Files are duplicated.  Perhaps due to
      some integration errors, or maybe just some finger trouble.  One
      way to remove it is to work through M-Files and delete them one by
      one. Another way is to use MFSQL Connector It would involve the
      following steps Update the class table in the Connector using
      spMFUpdatetable with updatemethod 1 Use SQL to isolate the
      duplicate records. The Row_Number() over (partition by order by )
      functions are used.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      Note that the following method should only be used where the
      source and target classes have the same object type. In this use
      case objects need to be move from one class to other.  The
      additional functionality of metadata configuration has made it
      possible to consolidate similar objects with slightly different
      processing requirements, instead of having separarate classes for
      each variety of object.  Having less classes reduces the
      complexity for the users and improves the analysis of the data.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      When valuelist items have owners (for example document type has
      class as the owner) then a valuelist item could be associated with
      more than one class resulting in a different id for each item.
      When a object is changed from one class to another, the valuelist
      item will not automatically be associated with the new class. This
      could result in the loss of data. Transitioning objects in bulk
      from one class to another in this scenario requires a sequence of
      steps.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      In this case the vault has a valuelist that is used accross
      multiple classes and object types. The objective is to consolidate
      and split the use of the valuelist items across all the tables. To
      determine in which classes the valuelist is being used, it is best
      to use a temporary view in M-Files and list all objects where the
      property in question is not null. Sub group this list by Class
      ensure that all the classes in the list created in the Connector
      as a class table.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      The use case is where there is some metadata in M-Files (or none)
      and data from an external system need to be imported into M-Files.
       If the external data is poorly aligned with the metadata of
      M-Files then using the power of SQL will greatly enhance to
      ability analyse and align the data. Having the metadata in SQL
      using the MFSQL Connector will further improve the efficiency of
      correlating the data.…

   .. container:: endsection

.. container:: blog-post-listing

   .. container:: wiki-content

      Sometimes a configuration change is made to elevate a property
      that is defined as text to become a valuelist.  In most cases the
      data in the text property need to be corrected to be consistent
      with the chosed valuelist items.  Using the power of SQL the text
      property can be analysed and updated. A temporary table with the
      adjusted valuelist items can be prepared.…

   .. container:: endsection


