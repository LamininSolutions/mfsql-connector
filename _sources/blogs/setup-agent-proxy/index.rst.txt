
Setup Agent Proxy for MFSQLConnect
==================================

It is possible to call a SQL procedure that in turns start an agent using the Context Menu in M-Files.  This provides many different types of opportunities for automation and flexibility.  

The Context Menu use the SQL authentication login account **MFSQLConnect** which is preconfigured to execute the standard MFSQL Connector procedures.  See the  :doc:`/the-connector-framework/security/index` section for the configuration of this login.

In some cases additional configuration is required to allow for the context menu to be used to trigger a SQL process. Calling a SSIS (SQL Server Integration System) package is one example where the standard MFSQLConnect profile is not sufficient because SSIS requires elevated security. Other examples would be file operations or powershell operations. 

Consult your DBA and Domain Security expects before configuring the SQL Server security. The guidelines in this section for additional configuration of access security is provided as an input to be considered by your organisations security advisors and the actual configuration may differ from organisation to organisation. 

When using the context menu with elevated security it would be necessary to setup an Agent Proxy account and assign MFSQLConnect to the proxy.  There are several steps to follow for configuring an agent with a proxy account.

A prerequisit for this section is to configure :doc:`/getting-started/first-time-installation/installing-the-context-menu/index`  and create a procedure which will call the agent. Script Example **70.104.Example - Start Job Wait - Agent** show how to setup a calling procedure.
 
Service account
---------------

The first step is to review the security for the standard SQL Server Agent security. It is important to set up SQL Server Agent Security on the principles of 'executing with minimum privileges', and ensure that errors are properly logged and alerts are set up for a comprehensive range of errors. SQL Server Agent allows fine-grained control of every job step that should allow tasks to be run entirely safely even if they occasionally need special privileges.

You may choose to use this standard agent service account that was originally setup with the installation of SQL, or may have to setup an additional service account specifically for excecuting the SSIS package. It really depends on what security will be required by the underlying operation and your organisations security policies.

Related link  <https://www.red-gate.com/simple-talk/sql/database-administration/setting-up-your-sql-server-agent-correctly/>`__ for a deeper understanding of agent security.  

Setup the agent security to use the service account by accessing the SQL Configuratiion Manager and assigning the service account to the SQL Agent 

|Image4|

Credential
----------

The next step is to setup a credential.  The credential will expose the service account to the proxy.  From SSMS Explorer, select the Credentials tab and add a new credential.  Add a name to identify the associated security credential and allocate the service account to the credential.

|Image1|
 
Setup the proxy
---------------

Use SSMS to expand the SQL Agent node to **proxies** and add a new proxy.  Link it to the credential.  Then select the appropropriate operation such as SSIS. 


|Image2|

 Use the principles tab to assign MFSQLConnect to the proxy.

|Image3|


Link proxy with agent
---------------------

The final step is to set the permissions on the agent to point to proxy.

Using SSMS, open the properties of the agent and the SSIS package step. Select the proxy in the **run as:** drop down.

|Image5|

Finally, test the agent by actioning the operation from the context menu action item.


.. |Image1| image:: img_1.png
.. |Image2| image:: img_2.png
.. |Image3| image:: img_3.png
.. |Image4| image:: img_4.png
.. |Image5| image:: img_5.png
