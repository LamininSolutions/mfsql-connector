Schemas
=======

The Following database schemas are automatically created and permissions
are set to the default role.

.. container:: table-wrap

   ======== ============================================================================================================================================================================================================================================
   Schema   Use
   ======== ============================================================================================================================================================================================================================================
   dbo      The dbo schema is used for all core Connector objects. Objects in this schema should only be modified using the migration or installation packages. Customisation of these objects will be lost when a update of the Connector is processed.
   system   This schema is used for system related Connector objects.
   custom   This schema can be used for all your custom objects
   contmenu This schema is dedicated to objects related to the context menu add-in
   ======== ============================================================================================================================================================================================================================================
