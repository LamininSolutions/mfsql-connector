Oracle Database Specific Settings
=================================



Prerequisites
=============

To connect to a remote Oracle database it is necessary to ensure that
the Oracle Client is installed on the M-Files Server.  The Client is
available from the Oracle Website.



Oracle specific settings
========================

The following settings apply to the settings for an Oracle Database. Use
the common settings section for all other settings.

.. container:: table-wrap

   ========================== ============ ===========================================
   Setting                    Value        Comment
   ========================== ============ ===========================================
    Schema                                  Default to dbo
    SQL Server Authentication              Default to Windows Authentication
                                          
                                           Set to SQLServer 
   Database Type              Oracle      
   OdbcDriver                 Oracle in XE Get this value from the driver installation
                                           | 
   ========================== ============ ===========================================



ODBC Driver installation
========================

Follow the guide to setup the Oracle ODBC driver to enable to
connection.

.. container:: table-wrap

   ============================== ============================================================================================ ==============================
   Step                           Selection                                                                                    Example
   ============================== ============================================================================================ ==============================
   Control Panel                  Administrative tools                                                                         .. container:: content-wrapper
                                                                                                                              
   Administrative Panel           Select ODBC data Source as your system bit i.e. 32bit for 64bit and click on System DSN tab. .. container:: content-wrapper
                                                                                                                              
   ODBC Data Source Administrator Select add button on System DNS tab                                                          .. container:: content-wrapper
                                                                                                                              
                                  |                                                                                           
    Select Driver                                                                                                              .. container:: content-wrapper
                                  Select the oracle odbc driver                                                               
                                                                                                                                   
                                  Use the odbc driver name in the connector specific settings.                                
    Configurator / ODBC Driver    Add driver name                                                                              .. container:: content-wrapper
                                                                                                                              
                                                                                                                                   
   ============================== ============================================================================================ ==============================
