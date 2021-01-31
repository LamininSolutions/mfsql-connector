Creating multiple related objects on file import
================================================

In this use case we will review how to setup depended objects when importing a file from an external source such as a scanning process or getting a file into M-Files from a third party system.

This use case is of particular value when the scanned document have complex metadata to be associated with the document or has dependent objects that requires staging in sequence for the file document to be associated with. The M-Files importing tool may not be the best vehicle to accomplish advanced file scans and imports.

The routine to import the scanned document into M-Files and associating the metadata with the object is divorced. The file is scanned and imported using the scanning software,  Importing Tool or Folderwatcher. The only key requirements is that a unique reference is available to link the file with the associated metadata.  This unique reference can be built into the name of the file when it is saved by the scanning software, or alternatively simple OCR recognition can be used to pick up the unique reference from the content of the file.  MFSQL Connector automatically creates a property "MFSQL File Unique Ref" that can be used for updating this unique key.  If the name of the file is used to carry the unique reference then we would recommend to populate this special property, in addition to using it for the file name.  The name or title of the object is often changed or automated. This could break the link of the file to the underlying metadata during processing.

The metadata related to the file, including details of any dependent objects can then be processed in SQL.  It is often feasible for the scanning software to save the scanned document details directly to a SQL table.  The metadata may be partially dependent on third party systems.  it may be necessary to get some data from M-Files before the metadata of the file can be finalized.

The different stages required for processing would depend on each individual case but in essence would involve pulling the file object metadata into SQL using MFSQL  Connector, updating any associated class tables (such as vendor master), get the data from the scanning process, and finally pulling data from the third party system.

All of these processes are then streamed in custom store procedures in SQL to build the related data, create the dependent objects, and update the file metadata with the related properties.

The trigger to start the process is likely to be the importing of the file. We recommend to use MFSQL Connector Context Menu capability to start a SQL procedure to initiate the matching.  Context Menu allows for an action to start a context sensitive SQL procedure as a workflow step, event handler or initiated by a user in M-Files by picking an option in the action menu.
