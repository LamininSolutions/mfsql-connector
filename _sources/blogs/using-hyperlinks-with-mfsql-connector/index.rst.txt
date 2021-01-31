Using hyperlinks with MFSQL Connector
=====================================

MFSQL Connector makes it easy to create and incorporate hyperlinks to
objects for use in different scenarios

It can be used to create various forms of desktop and web hyperlinks.
The link can be formatted to be html friendly.

The function
::doc`\functions\fnMFObjectHyperlink` is based on a specific class table and use the objid and guid columns of
the object as input. It also use a switch to determine the type of
hyperlink.

Switches:

#. Desktop - Show

#. Web

#. Desktop - view

#. Desktop - open

#. Desktop - show metadata

#. Desktop - edit

--------------

.. code:: sql

    --desktop - show (option 1)
    select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],1) from [dbo].[MFAccount] AS mc

    --desktop open (option 4)
    select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],4) from [dbo].[MFAccount] AS mc

    --desktop - view (option 3)

    select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],3) from [dbo].[MFAccount] AS mc

    --desktop - edit (option 6)

    select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],6) from [dbo].[MFAccount] AS mc

    --desktop - show metadata (option 5)

    select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],5) from [dbo].[MFAccount] AS mc

    --web (option 2)
    select [mc].[name_or_Title] AS Account, [dbo].[fnMFObjectHyperlink]('MFAccount',mc.[objid],mc.[guid],2) from [dbo].[MFAccount] AS mc
