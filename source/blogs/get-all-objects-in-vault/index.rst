Explore all the objects in the vault
====================================

A new procedure spMFObjectTypeUpdateClassClassIndex extracts
objectVersion data for all objects in the vault and update the
MFObjectTypeToClassObject table. The results of this process can be used
in a variety of different ways, the most obvious to assess to total
number of objects in the vault.

.. code:: sql

    --how to get the max id's in a vault
    EXEC [dbo].[spMFObjectTypeUpdateClassIndex] @IsAllTables = 1 -- setting to 0 will only include includedinapp class tables
                                               ,@Debug = 0       -- smallint

    SELECT mc.[TableName], mc.[IncludeInApp], COUNT(*), MAX([mottco].[Object_MFID]) FROM [dbo].[MFObjectTypeToClassObject] AS [mottco] 
    INNER JOIN MFClass mc
    ON mc.mfid = mottco.[Class_ID]
    GROUP BY mc.[TableName],mc.[IncludeInApp]

    --or
    SELECT * FROM [dbo].[MFvwObjectTypeSummary] AS [mfots]

|image0|

.. |image0| image:: img_1.jpg