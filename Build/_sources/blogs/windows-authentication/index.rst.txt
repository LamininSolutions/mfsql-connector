
Using windows authentication
============================

The Connector uses a standard M-Files user to access M-Files from SQL. We recommend using a M-Files user type. However, when a windows user is used during installation of the package, additional steps are required to setup the user in SQL.

Step 1: Check the settings

Select * from MFVaultSettings

It is likely that the settings are incomplete after the installation.

Step 2: Reset the settings

EXEC dbo.spMFSettingsForVaultUpdate @Username = N'',
                                    @Password = N'',
                                    @MFAuthenticationType_ID = 3,
                                    @Domain = N''

