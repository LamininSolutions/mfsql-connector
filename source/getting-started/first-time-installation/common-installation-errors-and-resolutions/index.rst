Common installation errors and resolutions
==========================================

Release 4
---------

The following errors or issues may be experienced during the installation process


Unable to log into M-Files
~~~~~~~~~~~~~~~~~~~~~~~~~~

Probable causes:

- Corrupt / old connection remnant on server
- Unable to connect to M-Files using the login credentials

Solution:

 - Check the errorlog (see screenshot)
 - Delete content of the c:\_\users\_[loginuser]\_\AppData\_\MFSQL Vault Install folder
 - Alternatively one can delete the VaultSettings.xml file in the this folder
 - check the settings to log into the correct M-Files Server

|img1|

Example of error

|img2|

Watch the video

.. raw:: html

    <iframe width="560" height="315" src="https://www.youtube.com/embed/WVsB6MQ6cgg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Unable to connect to vault
~~~~~~~~~~~~~~~~~~~~~~~~~~

Probable causes:

 - The settings for connecting to the vault is incorrect or could not be installed
 - The server security settings does not allow powershell scripts
 - The M-Files password changed

Solution:

 - Update settings using spMFSettingsForVaultUpdate

|img3|

Exec spMFSyncronizeMetadata produces an error / email
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Probable causes:

- The licensing is not valid / or has not been activated

Solution:

- Install the license for MFSQL Connector and log into the vault using a desktop client

|img4|

Network connection error on login to the vault for the first time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Probable causes:

 - The connection string is invalid
 - The SQL licensing has not taken place and the connector will not operate.

Solution:

 - search for 'connectionstring' in the vault and update the connection string.
 - Log out of vault
 - Uninstall the MFSQL Connector vault application in M-Files, reinstall, and relicense
 - Log back into vault

|img5|

MFSQL Connector context menu error
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Probable causes:

- The connection string is invalid

Solution:

 - search for 'connectionstring' in the vault and update the connection string
 - log out and log back into vault.

|img6|

EmailProfile Error
~~~~~~~~~~~~~~~~~~

Probable causes:

- When procedures are executed  with an error the message appears
- Note that this error also indicates that there was an error 

Solution:

 - Install Database Mail and set the profile name to 'MailProfile' 
 - Check MFLog table for error messages

|img7|

MFLog shows error for invalid license
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Probable causes:

 - Indicates the license has an issue

Solution:

 - Check that license has been added to the vault application
 - Check Configurations / other applications / MFSQL Connector VaultApp Dashboard to see if it loading properly.  If it iscorrect, then uninstall and manually re-install the vault application from the installation files.

.. |img1| image:: img_4.jpg
.. |img2| image:: img_5.jpg
.. |img3| image:: img_6.jpg
.. |img4| image:: img_7.jpg
.. |img5| image:: img_8.jpg
.. |img6| image:: img_9.jpg
.. |img7| image:: img_10.jpg
