SQL Database
============

The SQL database has the file data in blobs in one or more tables. 

| 

Using schemas is optional

It is good practice to use a SQL view to define the columns required for
access in M-Files.  The views can be used to show the appropriate
columns for the Connector, join data from different tables and include
filters to exclude records that should not be shown in M-Files.

The columns must include the following

.. container:: table-wrap

   ========== ================================== ========================================================================= =========================================
   Type       Column                             Used for                                                                  Required 
   ========== ================================== ========================================================================= =========================================
   File Data  Unique id                          Referencing and showing file                                               Yes
                                                                                                                          
              Filename                                                                                                    
                                                                                                                          
              Binary Data                                                                                                 
   Hierarchy  One or more columns with labels    showing the data in M-Files in a hierarchy. For example: Customer/Project  At least 1 hierarchy column
   Properties One or more columns with text data showing each property as a field in M-Files on the object                 Optional.
                                                                                                                          
                                                                                                                           Will be shown as a text value in M-Files 
   ========== ================================== ========================================================================= =========================================

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      Minimum Requirements for accessing the blob

      The table containing the blob must have 

      #. Unique Reference for each blob record
      #. FileName including the extension
      #. BinaryData representing the file

.. container:: confluence-information-macro confluence-information-macro-information

   Types of Blobs

   .. container:: confluence-information-macro-body

      **BLOB :**

      ``BLOB`` (*Binary Large Object*) is a large object data type in
      the database system. ``BLOB`` could store a large chunk of data,
      document types and even media files like audio or video files.
      ``BLOB`` fields allocate space only whenever the content in the
      field is utilized. ``BLOB`` allocates spaces in Giga Bytes.

      **USAGE OF BLOB :**

      You can write a binary large object (``BLOB``) to a database as
      either binary or character data, depending on the type of field at
      your data source. To write a ``BLOB`` value to your database,
      issue the appropriate ``INSERT or UPDATE`` statement and pass the
      ``BLOB`` value as an input parameter. If your ``BLOB`` is stored
      as text, such as a SQL Server text field, you can pass the
      ``BLOB`` as a string parameter. If the ``BLOB`` is stored in
      binary format, such as a SQL Server image field, you can pass an
      array of type byte as a binary parameter.

      **DATA TYPES :**

      Binary: Fixed size up to 8,000 bytes.

      VarBinary(n): Variable size up to 8,000 bytes (n specifies the max
      size).

      VarBianry(max): Variable size, no maximum limit.
