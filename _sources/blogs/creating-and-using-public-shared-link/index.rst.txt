Creating and using public shared link
=====================================

MFSQ: Connector allows for creating a public shared link to an object on
demand.

Currently this capability is limited to single file object. Multifile
objects and collections cannot be accessed. Accessing multifile objects
and collections is on the roadmap and is awaiting demand for the
functionality to prioritise the development.

It is simple to use: set the process\_id on the class table to say 6 for
all the target records; run procedure , spMFCreatePublicSharedLink; and
access the link in the table MFPublicLink.

Pre-requisits
-------------

M-Files must be setup for Web services and have the url in the M-Files Web setting in the vault properties.

The following two settings must be exist and be correct in MFSettings table:
 -  ServerURL
 -  VaultGUID
 
Use the following script to setup or change these settings.

.. code:: sql

    DECLARE @GUID NVARCHAR(100);
    DECLARE @WebURL NVARCHAR(100);

    SET @GUID = N'{5981E340-C62F-4DB0-8E22-684AD012E5F6}'; --replace this with the GUID, including the curley brackets
    SET @WebURL = N'http://lsuk-app03.lsusa.local'; --replace with your web url 

    IF EXISTS (SELECT * FROM dbo.MFSettings WHERE Name = 'VaultGUID')
     BEGIN
     EXEC dbo.spMFSettingsForVaultUpdate @VaultGUID = @GUID;
     END;
     ELSE
    BEGIN
    INSERT dbo.MFSettings
    (
        source_key,
        Name,
        Description,
        Value,
        Enabled
    )
    VALUES
    (N'MF_Default', N'VaultGUID', N'GUID of vault', @GUID, 1);
    END;

    IF EXISTS (SELECT * FROM dbo.MFSettings WHERE Name = 'ServerURL')
    BEGIN
    EXEC dbo.spMFSettingsForVaultUpdate @ServerURL = @WebURL;
    END;
    ELSE
    BEGIN
    INSERT dbo.MFSettings
    (
        source_key,
        Name,
        Description,
        Value,
        Enabled
    )
    VALUES
    (N'MF_Default', N'ServerURL', N'Web URL for M-Files', @WebURL, 1);
    END;

Step by step guide
------------------

Links can be created in bulk and on demand and can be built into other
procedures. For instance, the links can be created in the back ground
and added back as a property on the object. This allows for the link to
become available for use on the object itself. Another use case is to
bulk create the links and to include the links in an email to a
selection of customers.

    Example
    `http://ServerDNS/SharedLinks.aspx?accesskey=fd69f8b5e1a02a567ebd164dfea337b3fe2b92d3296df3d698bf6d2354cba983&VaultGUID={3E2585FF-ED4F-4EEF-888D-B7AD475195B9} <http://LSUK-APP03.LSUSA.LOCAL/SharedLinks.aspx?accesskey=fd69f8b5e1a02a567ebd164dfea337b3fe2b92d3296df3d698bf6d2354cba983&VaultGUID=%7B3E2585FF-ED4F-4EEF-888D-B7AD475195B9%7D>`__

--------------

Step 1: Update the process\_id of the target records

.. code:: sql

    --Update a record where singlefile = 1 and set process_ID = 1

    update [od]
    set [od].[Process_ID] = 1
    FROM   [MFOtherDocument] od where [Single_File] = 1 

Step 2: Set the expiry date and run the procedure

.. code:: sql

    DECLARE @Expiredate DATETIME = DATEADD(m, 1, GETDATE()) 
    -- set expiredate to 1 month from today
    EXEC [spMFCreatePublicSharedLink] @Tablename = 'MFOtherDocument'
    , @Expirydate = @Expiredate
    , @processID = 6

Step 3: Use the link from the public link table.

.. code:: sql

    --show links for a specific Project
    SELECT [mod].[Project], mod.[Name_Or_Title], mpl.link AS FileURL 
    FROM [dbo].[MFOtherDocument] AS [mod]
    INNER JOIN [dbo].[MFPublicLink] AS [mpl]
    ON [mod].objid=mpl.[ObjectID] AND mod.class_ID = mpl.[ClassID]
    WHERE [mod].[Project] = 'Office Design'


