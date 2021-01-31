Custom tables, views, procedures and functions
==============================================

The Connector allows adding additional tables to the Database for
add-hoc or application use. It is recommended that these tables follow a
different naming convention to the Connector tables for easy
identification. We suggest that custom tables, procedures, views and
functions all use the 'custom' schema.  We also recommend to script all
custom changes and to save the changes as re-executable files. This will
all for the easy restore and rebuild of any custom development.

Example of a re-executable procedure script.

.. code:: text

    PRINT SPACE(5) + QUOTENAME(@@SERVERNAME) + '.' + QUOTENAME(DB_NAME())
    + '.[custom].[DoAccountDocumentUpsert]';
    GO

    /*------------------------------------------------------------------------------------------------
    Author: 
    Create date: 
    Database: 
    Description: 

    PARAMETERS:
    ------------------------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------------------------
    MODIFICATION HISTORY
    ====================
    DATE NAME DESCRIPTION
    ------------------------------------------------------------------------------------------------*/
    /*-----------------------------------------------------------------------------------------------
    USAGE:
    =====
    EXEC [custom].DoAccountDocumentUpsert @withupdate = 1, @debug = 0


    -----------------------------------------------------------------------------------------------*/
    IF EXISTS
    (
    SELECT 1
    FROM [INFORMATION_SCHEMA].[ROUTINES]
    WHERE [ROUTINE_NAME] = 'DoAccountDocumentUpsert' --name of procedure
    AND [ROUTINE_TYPE] = 'PROCEDURE' --for a function --'FUNCTION'
    AND [ROUTINE_SCHEMA] = 'custom'
    )
    BEGIN
    PRINT SPACE(10) + '...Stored Procedure: update';
    SET NOEXEC ON;
    END;
    ELSE
    PRINT SPACE(10) + '...Stored Procedure: create';
    GO

    -- if the routine exists this stub creation stem is parsed but not
    executed
    CREATE PROCEDURE [Custom].[DoAccountDocumentUpsert]
    AS
    SELECT 'created, but not implemented yet.';
    --just anything will do

    GO
    -- the following section will be always executed
    SET NOEXEC OFF;
    GO
    ALTER PROCEDURE [Custom].[DoAccountDocumentUpsert]
    (your params)

    as

    Begin

    Your procedure

    End

    Go
