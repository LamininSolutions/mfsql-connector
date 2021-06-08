Processing scanned documents
============================

In this use case we will focus on how and why use the Connector for
processing scanned documents.

Getting scanned documents into M-Files and classifying the document can
be very easy, and mostly is. M-Files provide powerful capabilities for
it out of the box. Specialist scanning software (such as Ancora,
chronoscan, ezescan, ABBYY and others) all include methods of processing
scanned documents into M-Files.

What role does the Connector play then? In our experience it comes into
play, usually in collaboration with the M-Files own tools, or any of the
tools, when the processing in the backend requires additional
intervention. The following scenarios could apply:

-  complexity of sourcing and validating the master data to file
   against;

-  quality and complexity of the scanned and acquired data;

-  merging the scanned data with external data;

-  advanced validating of the scanned data against data from different
   sources;

-  creating multiple and complex relationships between the objects in
   the upload process and further processing of the data

-  triggering workflows based on the characteristics and quality of the
   scanned data, or the availability of master data at the point of
   scanning.

Using the power of SQL, combined with the Connector allows for more
flexible and dynamic development of the backend process to tie the
scanned document to the correct objects and metadata without resorting
the API development.

--------------

The mechanism is quit simple:

Process the source file through the scanning software and push all the
scanned data into a SQL table. Ensure the name of the output file is
unique. Capture the name of the file into the SQL table. Allow the file
to be imported into M-Files using standard External File Connector
functionality.

Use a state change context menu action to trigger the MFSQL Connector
to:

-  get the new file object from M-Files

-  use SQL to perform all the complex processing

-  on completion update the result into M-Files which may include
   several new objects

The key is that the SQL process could include a whole host of operations
including getting or pushing data to other applications; validating the
data and matching; making the data decisions for all the options and
getting or pushing related objects to M-Files.
