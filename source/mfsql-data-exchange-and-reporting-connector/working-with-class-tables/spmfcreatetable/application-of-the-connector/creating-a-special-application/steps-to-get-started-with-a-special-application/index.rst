Steps to get started with a special Application
===============================================

 

The Connector has a number of procedures to assist with the design and
deployment of a new special application.

Install Connector in new DB

Refresh Metadata

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFSynchronizeMetadata] @Debug = 0 -- smallint

Use MFClass to identify all the class tables that will be used in the
App.

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          SELECT * FROM [dbo].[MFClass] AS [mc]

Use an Update Statement on MFClass to update IncludeInApp column = 1 for
all the tables identified. (replace the id's in the statement with the
id's of the tables that you wish to create)

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          UPDATE mc
         SET [mc].[IncludeInApp] = 1
         FROM mfclass mc WHERE id IN(
         9,10,11,13,14,15,16,17,18,23,36,57,61,69,88,112)

Create all class tables simultaneously

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          EXEC [dbo].[spMFCreateAllMFTables] @Debug = 0 -- smallint

Update all class tables simultaneously

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          
         EXEC [dbo].[spMFUpdateAllncludedInAppTables] @UpdateMethod = 1, -- int
             @Debug = 0 -- smallint

Use the stats procedure to review all the tables created.  Note the
number of records created for each class table.

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         EXEC [dbo].[spMFClassTableStats]

 

If you made a mistake and would like to drop all the class tables then
use

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         EXEC [dbo].[spMFDropAllClassTables] @IncludeInApp = 1, -- int
             @Debug = 0 -- smallint

 

If you are using Code on Time then you are now ready for creating the
first iteration of the user interface into the tables for the
application.  Note that this guide is not intended to be a training
manual for Code on Time.

 
