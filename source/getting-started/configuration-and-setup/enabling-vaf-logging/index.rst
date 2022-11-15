========================================
Enabling and configuring the VAF logging
========================================

Release 4.10.30.74 of the Connector allows for the deployment of advanced logging for the VAF operations.  This is very useful
for monitoring and tracking of issues in the Context Menu operations.

Context Menu logging has two sides to it. The processing of each action taken by a user or triggered by a workflow state or event handler operation will be logged using the VAF logging for the VAF processes and will also use the MFProcessBatch and MFProcessBatchdetail table in the Connector database to log the SQL operations of the call.  The logging in these two tables are further expanded by adding log entry calls in the custom procedures that is called by the action.

The following steps highlights to most basic steps for setting up VAF logging.  This logging forms part of the new release of the VAF framework and are further described in the M-Files documentation at `<https://developer.m-files.com/Frameworks/Logging/>`_ .  The options available for configuration in a cloud vault is slightly different from on-premise and will be apparent in the configuration options of the cloud vault.

.. warning::
	Only enable detail logging if required for debugging and process tracking. Logging should be restricted to a minimum level of warning (the dafault) under normal operations.

To access the setup, expand the Logging Configuration in the MFSQL Connector VaultApp under Other Applications in the Configurations of M-Files admin. By default the logging is not enabled.

|Image1|

Enable logging to expand the additional options. As a minimum, Enable the Default Target.  This will allow for the log to be placed on the M-Files server in the Applogs sub folder for the vault under the M-Files\\Server Vault directory.
For example: C:\\Program Files\\M-Files\\Server Vaults\\VaultName\\Applogs\\GUID\\GUID\\0

Other methods of logging include pushing the log to a file target on a file location that is generally more accessible that the server; using the event log; pushing it to a database and setting it up to push the logs to an email.  Note that not all these options are available in the cloud.

|Image2|

If nothing else is configured then the logging will only show if fatal errors have been encountered.

For debugging set the Minimum Log level to Trace. This will show the full logging for the operation.

Restart the vault for the log setup to be activated. An example of the initial log is shown below.

|Image3|

One option for testing if logging is working is to set the minimum level to trace and to disable and re-enable logging.  Check the log destination to see if the logs came through.

When an context menu action is activated, it will automatically push debugging logs to the VAF logger.  It will also add a log at the start and end of the process to the ProcessBatchDetail table. Each action is represented by a unique VAF task number and is also assigned a MFProcessBatch id to encapsulate the entire process in SQL.



.. |image1| image:: Image1.png
.. |image2| image:: Image2.png
.. |image3| image:: Image3.png
