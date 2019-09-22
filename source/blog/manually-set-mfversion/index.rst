Manually set MFVersion
======================

M-Files is pushing upgrades of M-Files regularly. Refer to the blog
around setting up MFSQL Connector to detect changes in the M-Files
Version.

Sometimes it is necessary to intervene. It is likely to be triggered by
an error or email notification with an error referring to an issue with
the Interop.MFilesAPI assembly similar to

    A .NET Framework error occurred during execution of user-defined
    routine or aggregate "spMFGetMetadataStructureVersionIDInternal":
    System.IO.FileLoadException: Could not load file or assembly
    'Interop.MFilesAPI, Version=7.0.0.0, Culture=neutral,
    PublicKeyToken=f1b4733f444f7ad0' or one of its dependencies.
    Assembly in host store has a different signature than assembly in
    GAC. (Exception from HRESULT: 0x80131050) See Microsoft Knowledge
    Base article 949080 for more information.
    System.IO.FileLoadException: at
    LSConnect.MFiles.MFilesAccess..ctor(String VaultSettings) at
    MFilesWrapper.GetMFilesAccessNew(String VaultSettings) at
    MFilesWrapper.GetMetadataStructureVersionID(String VaultSettings,
    String& Result) .

To fix, follow these steps:

#. Check the M-Files Desktop version on the SQL Server.

#. Check the version in MFSettings

#. Update MFSettings to the version on the SQL Server if the installed
   version is different from MFSettings

#. Update the Assemblies

.. code:: sql


    DECLARE @MFVersion NVARCHAR(100) = '' -- example '19.9.8028.5'
    BEGIN

    UPDATE ms
    SET value = @MFVersion
    FROM mfSettings ms WHERE name = 'MFVersion'

    EXEC [dbo].[spMFUpdateAssemblies]

    END

    GO

