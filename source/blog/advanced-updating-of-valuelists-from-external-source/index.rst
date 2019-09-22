Advanced updating of Valuelists from external source
====================================================

The following is an example of an advanced updating of multiple
dependent valuelists from an external source before processing the
update of the record from the external source.

.. code:: sql

     -------------------------------------------------------------
        -- PROCESS VALUELIST 
        -------------------------------------------------------------
     BEGIN
       --get division
                BEGIN
                      UPDATE    [Source]
                      SET       [Source].[MFDivision_ID] = [MF].[MFID_ValueListItems]
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      INNER JOIN [dbo].[MFvwValueList_Division] [MF] ON [MF].[Name_ValueListItems] = [Source].[DIVISION] AND [MF].[Deleted] = 0
                      WHERE     [Source].[MFDivision_ID] IS NULL
                                AND [Source].[DIVISION] IS NOT NULL

                      DECLARE @Missing_MFDivision_ID INT
                      SELECT    @Missing_MFDivision_ID = COUNT(DISTINCT [Source].[DIVISION])
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      WHERE     [Source].[MFDivision_ID] IS NULL
                                AND [Source].[DIVISION] IS NOT NULL
                END--get division
        
       --get terms
                BEGIN
                      UPDATE    [Source]
                      SET       [Source].[MFTerms_ID] = [MF].[MFID_ValueListItems]
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      INNER JOIN [dbo].[MFvwValueList_Terms] [MF] ON [MF].[Name_ValueListItems] = [Source].[TERMS] AND [MF].[Deleted] = 0
                      WHERE     [Source].[MFTerms_ID] IS NULL
                                AND [Source].[TERMS] IS NOT NULL

                      DECLARE @Missing_Terms_ID INT
                      SELECT    @Missing_Terms_ID = COUNT(DISTINCT [Source].[TERMS])
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      WHERE     [Source].[MFTerms_ID] IS NULL
                                AND [Source].[TERMS] IS NOT NULL
                END--get terms

       --get segment
                BEGIN
                      UPDATE    [Source]
                      SET       [Source].[MFSegment_ID] = [MF].[MFID_ValueListItems]
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      INNER JOIN [dbo].[MFvwValueList_Segment] [MF] ON [MF].[Name_ValueListItems] = [Source].[SEGMENT] AND [MF].[Deleted] = 0
                      WHERE     [Source].[MFSegment_ID] IS NULL
                                AND [Source].[SEGMENT] IS NOT NULL

                      DECLARE @Missing_Segment_ID INT
                      SELECT    @Missing_Segment_ID = COUNT(DISTINCT [Source].[SEGMENT])
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      WHERE     [Source].[MFSegment_ID] IS NULL
                                AND [Source].[SEGMENT] IS NOT NULL
                END--get segment

       --get GYR
                BEGIN
                      UPDATE    [Source]
                      SET       [Source].[MFGYR_ID] = [MF].[MFID_ValueListItems]
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      INNER JOIN [dbo].[MFvwValueList_GYR] [MF] ON [MF].[Name_ValueListItems] = [Source].[GYR] AND [MF].[Deleted] = 0
                      WHERE     [Source].[MFGYR_ID] IS NULL
                                AND [Source].[GYR] IS NOT NULL

                      DECLARE @Missing_GYR_ID INT
                      SELECT    @Missing_GYR_ID = COUNT(DISTINCT [Source].[GYR])
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      WHERE     [Source].[MFGYR_ID] IS NULL
                                AND [Source].[GYR] IS NOT NULL
                END--get GYR

       --get Territory
                BEGIN
                      UPDATE    [Source]
                      SET       [Source].[MFTerritory_ID] = [MF].[MFID_ValueListItems]
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      INNER JOIN [dbo].[MFvwValueList_Territory] [MF] ON [MF].[Name_ValueListItems] = [Source].[TERRITORY] AND [MF].[Deleted] = 0
                      WHERE     [Source].[MFTerritory_ID] IS NULL
                                AND [Source].[TERRITORY] IS NOT NULL

                      DECLARE @Missing_Territory_ID INT
                      SELECT    @Missing_Territory_ID = COUNT(DISTINCT [Source].[TERRITORY])
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      WHERE     [Source].[MFTerritory_ID] IS NULL
                                AND [Source].[TERRITORY] IS NOT NULL
                END--get Territory

       --get Sales Rep
                BEGIN
                      UPDATE    [Source]
                      SET       [Source].[MFSales_Rep_ID] = [MF].[MFID_ValueListItems]
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      INNER JOIN [dbo].[MFvwValueList_Sales_Rep] [MF] ON [MF].[Name_ValueListItems] = [Source].[SALESREP] AND [MF].[Deleted] = 0
                      WHERE     [Source].[MFSales_Rep_ID] IS NULL
                                AND [Source].[SALESREP] IS NOT NULL

                      DECLARE @Missing_Sales_Rep_ID INT
                      SELECT    @Missing_Sales_Rep_ID = COUNT(DISTINCT [Source].[SALESREP])
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      WHERE     [Source].[MFSales_Rep_ID] IS NULL
                                AND [Source].[SALESREP] IS NOT NULL
                END--get Sales Rep

       --get Country
                BEGIN
                      UPDATE    [Source]
                      SET       [Source].[MFCountry_ID] = [MF].[MFID_ValueListItems]
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      INNER JOIN [dbo].[MFvwValueList_Country] [MF] ON [MF].[Name_ValueListItems] = [Source].[BILL_COUNTRY] AND [MF].[Deleted] = 0
                      WHERE     [Source].[MFCountry_ID] IS NULL
                                AND [Source].[BILL_COUNTRY] IS NOT NULL

                      DECLARE @Missing_Country_ID INT
                      SELECT    @Missing_Country_ID = COUNT(DISTINCT [Source].[BILL_COUNTRY])
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      WHERE     [Source].[MFCountry_ID] IS NULL
                                AND [Source].[BILL_COUNTRY] IS NOT NULL
                END --get Country

       --get State_Province by Country
                BEGIN
                      UPDATE    [Source]
                      SET       [Source].[MFState_Province_ID] = [MF].[MFID_ValueListItems]
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      INNER JOIN [dbo].[MFvwValueList_StateProvince] [MF] ON [MF].[Name_ValueListItems] = [Source].[BILL_STATE]
                                                                             AND [MF].[OwnerName_ValueListItems] = [Source].[BILL_COUNTRY]
                        AND [MF].[Deleted] = 0
                      WHERE     [Source].[MFState_Province_ID] IS NULL
                                AND [Source].[BILL_STATE] IS NOT NULL

                      DECLARE @Missing_State_Province_ID INT
                      SELECT    @Missing_State_Province_ID = COUNT(DISTINCT ISNULL([Source].[BILL_COUNTRY], '')
                                                                   + ISNULL([Source].[BILL_STATE], ''))
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      WHERE     [Source].[MFState_Province_ID] IS NULL
                                AND [Source].[BILL_STATE] IS NOT NULL
                END --get State_Province by Country

      --Process Missing Value List Items
      IF (@Missing_MFDivision_ID > 0
       OR @Missing_Terms_ID > 0
       OR @Missing_Segment_ID > 0
       OR @Missing_GYR_ID > 0
       OR @Missing_Territory_ID > 0
       OR @Missing_Sales_Rep_ID > 0
       OR @Missing_Country_ID > 0
       OR @Missing_State_Province_ID > 0
       )
      BEGIN 
        --Refresh from M-Files 
        --and update value list to see if anything still missing
        --add missing values to M-Files
        EXEC [dbo].[spMFSynchronizeSpecificMetadata]   @Metadata = 'ValueListItems'
         , @Debug = @debug
         , @IsUpdate = 0 --M-Files to MFSQL

        IF @Missing_Country_ID > 0
        BEGIN 
         
                      UPDATE    [Source]
                      SET       [Source].[MFCountry_ID] = [MF].[MFID_ValueListItems]
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      INNER JOIN [dbo].[MFvwValueList_Country] [MF] ON [MF].[Name_ValueListItems] = [Source].[BILL_COUNTRY] AND [MF].[Deleted] = 0
                      WHERE     [Source].[MFCountry_ID] IS NULL
                                AND [Source].[BILL_COUNTRY] IS NOT NULL

                      SELECT    @Missing_Country_ID = COUNT(DISTINCT [Source].[BILL_COUNTRY])
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      WHERE     [Source].[MFCountry_ID] IS NULL
                                AND [Source].[BILL_COUNTRY] IS NOT NULL
          
         IF @Missing_Country_ID > 0
         BEGIN
          -- add missing value list items
            INSERT   [dbo].[MFValueListItems]
              ( [Name]
              , [MFValueListID]
              , [OwnerID]
              , [Process_ID]
              )
            SELECT DISTINCT
              [BILL_COUNTRY]
               , [MFVL].[ID]
               , 0
               , 1
            FROM    [Custom].[stageMFCustomer_FutNew]
            CROSS JOIN ( SELECT [ID]
                  , [Name]
                  , [MFID]
                FROM   [dbo].[MFValueList]
                WHERE  [Name] = 'Country'
                 ) [MFVL]
            WHERE   [MFCountry_ID] IS NULL
              AND [BILL_COUNTRY] IS NOT NULL

          --Value List Items are owner to states, therefor needs to be added to M-Files 1st     
          IF @Missing_State_Province_ID >0
          BEGIN
           EXEC [dbo].[spMFSynchronizeValueListItemsToMFiles] @debug 
          END           

            END --@Missing_Country_ID
        END --@Missing_Country_ID

        IF @Missing_State_Province_ID > 0
        BEGIN 
         
                      UPDATE    [Source]
                      SET       [Source].[MFState_Province_ID] = [MF].[MFID_ValueListItems]
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      INNER JOIN [dbo].[MFvwValueList_StateProvince] [MF] ON [MF].[Name_ValueListItems] = [Source].[BILL_STATE]
                                                                             AND [MF].[OwnerName_ValueListItems] = [Source].[BILL_COUNTRY]
                        AND [MF].[Deleted] = 0
                      WHERE     [Source].[MFState_Province_ID] IS NULL
                                AND [Source].[BILL_STATE] IS NOT NULL

                      SELECT    @Missing_State_Province_ID = COUNT(DISTINCT ISNULL([Source].[BILL_COUNTRY], '')
                                                                   + ISNULL([Source].[BILL_STATE], ''))
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      WHERE     [Source].[MFState_Province_ID] IS NULL
                                AND [Source].[BILL_STATE] IS NOT NULL
          
         IF @Missing_State_Province_ID > 0
         BEGIN
          -- add missing value list items
            INSERT   [dbo].[MFValueListItems]
              ( [Name]
              , [MFValueListID]
              , [OwnerID]
              , [Process_ID]
              )
            SELECT DISTINCT
              [Name]=[BILL_STATE]
               , [MFValueListID]=[MFVL].[ID]
               , [OwnerID]=[mvl_country].[MFID_ValueListItems]
               , [Process_ID]=1
            FROM    [Custom].[stageMFCustomer_FutNew] [source]
            CROSS JOIN ( SELECT [ID]
                  , [Name]
                  , [MFID]
                FROM   [dbo].[MFValueList]
                WHERE  [Name] = 'State / Province'
                 ) [MFVL]
            INNER JOIN [dbo].[MFvwValueList_Country] [mvl_country] ON  [source].[BILL_COUNTRY] = [mvl_country].[Name_ValueListItems]
            WHERE   [MFState_Province_ID] IS NULL
              AND [BILL_STATE] IS NOT NULL

            END --@Missing_State_Province_ID
        END --@Missing_State_Province_ID

        IF @Missing_MFDivision_ID > 0
        BEGIN 
         
          UPDATE  [Source]
          SET     [Source].[MFDivision_ID] = [MF].[MFID_ValueListItems]
          FROM    [Custom].[stageMFCustomer_FutNew] [Source]
          INNER JOIN [dbo].[MFvwValueList_Division] [MF] ON [MF].[Name_ValueListItems] = [Source].[DIVISION] AND [MF].[Deleted] = 0
          WHERE   [Source].[MFDivision_ID] IS NULL
            AND [DIVISION] IS NOT NULL

          SELECT  @Missing_MFDivision_ID = COUNT(DISTINCT [DIVISION])
          FROM    [Custom].[stageMFCustomer_FutNew] [Source]
          WHERE   [Source].[MFDivision_ID] IS NULL
            AND [DIVISION] IS NOT NULL

         IF @Missing_MFDivision_ID > 0
         BEGIN
          -- add missing value list items
            INSERT   [dbo].[MFValueListItems]
              ( [Name]
              , [MFValueListID]
              , [OwnerID]
              , [Process_ID]
              )
            SELECT DISTINCT
              [DIVISION]
               , [MFVL].[ID]
               , 0
               , 1
            FROM    [Custom].[stageMFCustomer_FutNew] [Source]
            CROSS JOIN ( SELECT [ID]
                  , [Name]
                  , [MFID]
                FROM   [dbo].[MFValueList]
                WHERE  [Name] = 'Division'
                 ) [MFVL]
           WHERE   [Source].[MFDivision_ID] IS NULL
            AND [DIVISION] IS NOT NULL

            END --IF @Missing_MFDivision_ID > 0 
        END --IF @Missing_MFDivision_ID > 0

        IF @Missing_Terms_ID > 0
        BEGIN 
         
         UPDATE  [Source]
         SET     [Source].[MFTerms_ID] = [MF].[MFID_ValueListItems]
         FROM    [Custom].[stageMFCustomer_FutNew] [Source]
         INNER JOIN [dbo].[MFvwValueList_Terms] [MF] ON [MF].[Name_ValueListItems] = [Source].[TERMS] AND [MF].[Deleted] = 0
         WHERE   [MFTerms_ID] IS NULL
           AND [TERMS] IS NOT NULL

         SELECT  @Missing_Terms_ID = COUNT(DISTINCT [TERMS])
         FROM    [Custom].[stageMFCustomer_FutNew] [Source]
         WHERE   [MFTerms_ID] IS NULL
           AND [TERMS] IS NOT NULL

         IF @Missing_Terms_ID > 0
         BEGIN
          -- add missing value list items
            INSERT   [dbo].[MFValueListItems]
              ( [Name]
              , [MFValueListID]
              , [OwnerID]
              , [Process_ID]
              )
            SELECT DISTINCT
              [TERMS]
               , [MFVL].[ID]
               , 0
               , 1
            FROM    [Custom].[stageMFCustomer_FutNew]
            CROSS JOIN ( SELECT [ID]
                  , [Name]
                  , [MFID]
                FROM   [dbo].[MFValueList]
                WHERE  [Name] = 'Terms'
                 ) [MFVL]
            WHERE   [MFTerms_ID] IS NULL
              AND [TERMS] IS NOT NULL
            END --@Missing_Terms_ID
        END --@Missing_Terms_ID

        IF @Missing_Segment_ID > 0
        BEGIN 
         
         UPDATE  [Source]
         SET     [Source].[MFSegment_ID] = [MF].[MFID_ValueListItems]
         FROM    [Custom].[stageMFCustomer_FutNew] [Source]
         INNER JOIN [dbo].[MFvwValueList_Segment] [MF] ON [MF].[Name_ValueListItems] = [Source].[SEGMENT] AND [MF].[Deleted] = 0
         WHERE   [MFSegment_ID] IS NULL
           AND [SEGMENT] IS NOT NULL

         SELECT  @Missing_Segment_ID = COUNT(DISTINCT [SEGMENT])
         FROM    [Custom].[stageMFCustomer_FutNew] [Source]
         WHERE   [MFSegment_ID] IS NULL
           AND [SEGMENT] IS NOT NULL

         IF @Missing_Segment_ID > 0
         BEGIN
          -- add missing value list items
            INSERT   [dbo].[MFValueListItems]
              ( [Name]
              , [MFValueListID]
              , [OwnerID]
              , [Process_ID]
              )
            SELECT DISTINCT
              [SEGMENT]
               , [MFVL].[ID]
               , 0
               , 1
            FROM    [Custom].[stageMFCustomer_FutNew]
            CROSS JOIN ( SELECT [ID]
                  , [Name]
                  , [MFID]
                FROM   [dbo].[MFValueList]
                WHERE  [Name] = 'Segment'
                 ) [MFVL]
            WHERE   [MFSegment_ID] IS NULL
              AND [SEGMENT] IS NOT NULL
            END --@Missing_Segment_ID
        END --@Missing_Segment_ID

        IF @Missing_GYR_ID > 0
        BEGIN 
         
         UPDATE  [Source]
         SET     [Source].[MFGYR_ID] = [MF].[MFID_ValueListItems]
         FROM    [Custom].[stageMFCustomer_FutNew] [Source]
         INNER JOIN [dbo].[MFvwValueList_GYR] [MF] ON [MF].[Name_ValueListItems] = [Source].[GYR] AND [MF].[Deleted] = 0
         WHERE   [Source].[MFGYR_ID] IS NULL
           AND [Source].[GYR] IS NOT NULL

         SELECT  @Missing_GYR_ID = COUNT(DISTINCT [GYR])
         FROM    [Custom].[stageMFCustomer_FutNew] [Source]
         WHERE   [Source].[MFGYR_ID] IS NULL
           AND [Source].[GYR] IS NOT NULL

         IF @Missing_GYR_ID > 0
         BEGIN
          -- add missing value list items
            INSERT   [dbo].[MFValueListItems]
              ( [Name]
              , [MFValueListID]
              , [OwnerID]
              , [Process_ID]
              )
            SELECT DISTINCT
              [GYR]
               , [MFVL].[ID]
               , 0
               , 1
            FROM    [Custom].[stageMFCustomer_FutNew]
            CROSS JOIN ( SELECT [ID]
                  , [Name]
                  , [MFID]
                FROM   [dbo].[MFValueList]
                WHERE  [Name] = 'GYR'
                 ) [MFVL]
            WHERE   [MFGYR_ID] IS NULL
              AND [GYR] IS NOT NULL
            END --@Missing_GYR_ID
        END --@Missing_GYR_ID

        IF @Missing_Territory_ID > 0
        BEGIN 
         
           UPDATE    [Source]
           SET       [Source].[MFTerritory_ID] = [MF].[MFID_ValueListItems]
           FROM      [Custom].[stageMFCustomer_FutNew] [Source]
           INNER JOIN [dbo].[MFvwValueList_Territory] [MF] ON [MF].[Name_ValueListItems] = [Source].[TERRITORY] AND [MF].[Deleted] = 0
           WHERE     [Source].[MFTerritory_ID] IS NULL
            AND [Source].[TERRITORY] IS NOT NULL

           SELECT    @Missing_Territory_ID = COUNT(DISTINCT [Source].[TERRITORY])
           FROM      [Custom].[stageMFCustomer_FutNew] [Source]
           WHERE     [Source].[MFTerritory_ID] IS NULL
            AND [Source].[TERRITORY] IS NOT NULL
          
         IF @Missing_Territory_ID > 0
         BEGIN
          -- add missing value list items
            INSERT   [dbo].[MFValueListItems]
              ( [Name]
              , [MFValueListID]
              , [OwnerID]
              , [Process_ID]
              )
            SELECT DISTINCT
              [TERRITORY]
               , [MFVL].[ID]
               , 0
               , 1
            FROM    [Custom].[stageMFCustomer_FutNew]
            CROSS JOIN ( SELECT [ID]
                  , [Name]
                  , [MFID]
                FROM   [dbo].[MFValueList]
                WHERE  [Name] = 'Territory'
                 ) [MFVL]
            WHERE   [MFTerritory_ID] IS NULL
              AND [TERRITORY] IS NOT NULL
            END --@Missing_Territory_ID
        END --@Missing_Territory_ID

        IF @Missing_Sales_Rep_ID > 0
        BEGIN 
         
                      UPDATE    [Source]
                      SET       [Source].[MFSales_Rep_ID] = [MF].[MFID_ValueListItems]
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      INNER JOIN [dbo].[MFvwValueList_Sales_Rep] [MF] ON [MF].[Name_ValueListItems] = [Source].[SALESREP] AND [MF].[Deleted] = 0
                      WHERE     [Source].[MFSales_Rep_ID] IS NULL
                                AND [Source].[SALESREP] IS NOT NULL

                      SELECT    @Missing_Sales_Rep_ID = COUNT(DISTINCT [Source].[SALESREP])
                      FROM      [Custom].[stageMFCustomer_FutNew] [Source]
                      WHERE     [Source].[MFSales_Rep_ID] IS NULL
                                AND [Source].[SALESREP] IS NOT NULL
          
         IF @Missing_Sales_Rep_ID > 0
         BEGIN
          -- add missing value list items
            INSERT   [dbo].[MFValueListItems]
              ( [Name]
              , [MFValueListID]
              , [OwnerID]
              , [Process_ID]
              )
            SELECT DISTINCT
              [SALESREP]
               , [MFVL].[ID]
               , 0
               , 1
            FROM    [Custom].[stageMFCustomer_FutNew]
            CROSS JOIN ( SELECT [ID]
                  , [Name]
                  , [MFID]
                FROM   [dbo].[MFValueList]
                WHERE  [Name] = 'Sales Rep'
                 ) [MFVL]
            WHERE   [MFSales_Rep_ID] IS NULL
              AND [SALESREP] IS NOT NULL
            END --@Missing_Sales_Rep_ID
        END --@Missing_Sales_Rep_ID

      
        --Write back to M-Files any missing values
        --update staging with newly created IDs
                    IF EXISTS ( SELECT  1
                                FROM    [dbo].[MFValueListItems]
                                WHERE   [Process_ID] <> 0 
           AND  [Deleted] = 0)
                       BEGIN
          -- At least one value list item needs to be updated     
                             EXEC [dbo].[spMFSynchronizeValueListItemsToMFiles] @debug

                            IF @Missing_Country_ID > 0
                                BEGIN 
             UPDATE    [Source]
             SET       [Source].[MFCountry_ID] = [MF].[MFID_ValueListItems]
             FROM      [Custom].[stageMFCustomer_FutNew] [Source]
             INNER JOIN [dbo].[MFvwValueList_Country] [MF] ON [MF].[Name_ValueListItems] = [Source].[BILL_COUNTRY] AND [MF].[Deleted] = 0
             WHERE     [Source].[MFCountry_ID] IS NULL
              AND [Source].[BILL_COUNTRY] IS NOT NULL
                                END --IF @Missing_Country_ID > 0

          IF @Missing_State_Province_ID > 0
          BEGIN 
             UPDATE    [Source]
             SET       [Source].[MFState_Province_ID] = [MF].[MFID_ValueListItems]
             FROM      [Custom].[stageMFCustomer_FutNew] [Source]
             INNER JOIN [dbo].[MFvwValueList_StateProvince] [MF] ON [MF].[Name_ValueListItems] = [Source].[BILL_STATE]
                          AND [MF].[OwnerName_ValueListItems] = [Source].[BILL_COUNTRY]
                           AND [MF].[Deleted] = 0
             WHERE     [Source].[MFState_Province_ID] IS NULL
              AND [Source].[BILL_STATE] IS NOT NULL
          END --IF @Missing_State_Province_ID > 0

          IF @Missing_MFDivision_ID > 0
          BEGIN 
            UPDATE  [Source]
            SET     [Source].[MFDivision_ID] = [MF].[MFID_ValueListItems]
            FROM    [Custom].[stageMFCustomer_FutNew] [Source]
            INNER JOIN [dbo].[MFvwValueList_Division] [MF] ON [MF].[Name_ValueListItems] = [Source].[DIVISION] AND [MF].[Deleted] = 0
            WHERE   [Source].[MFDivision_ID] IS NULL
              AND [DIVISION] IS NOT NULL
          END --IF @Missing_MFDivision_ID > 0

          IF @Missing_Terms_ID > 0
          BEGIN 
           UPDATE  [Source]
           SET     [Source].[MFTerms_ID] = [MF].[MFID_ValueListItems]
           FROM    [Custom].[stageMFCustomer_FutNew] [Source]
           INNER JOIN [dbo].[MFvwValueList_Terms] [MF] ON [MF].[Name_ValueListItems] = [Source].[TERMS] AND [MF].[Deleted] = 0
           WHERE   [MFTerms_ID] IS NULL
             AND [TERMS] IS NOT NULL
          END --IF @Missing_Terms_ID > 0

          IF @Missing_Segment_ID > 0
          BEGIN 
           UPDATE  [Source]
           SET     [Source].[MFSegment_ID] = [MF].[MFID_ValueListItems]
           FROM    [Custom].[stageMFCustomer_FutNew] [Source]
           INNER JOIN [dbo].[MFvwValueList_Segment] [MF] ON [MF].[Name_ValueListItems] = [Source].[SEGMENT] AND [MF].[Deleted] = 0
           WHERE   [MFSegment_ID] IS NULL
             AND [SEGMENT] IS NOT NULL
          END --IF @Missing_Segment_ID > 0

          IF @Missing_GYR_ID > 0
          BEGIN 
           UPDATE  [Source]
           SET     [Source].[MFGYR_ID] = [MF].[MFID_ValueListItems]
           FROM    [Custom].[stageMFCustomer_FutNew] [Source]
           INNER JOIN [dbo].[MFvwValueList_GYR] [MF] ON [MF].[Name_ValueListItems] = [Source].[GYR] AND [MF].[Deleted] = 0
           WHERE   [Source].[MFGYR_ID] IS NULL
             AND [Source].[GYR] IS NOT NULL
          END --IF @Missing_GYR_ID > 0

          IF @Missing_Territory_ID > 0
          BEGIN 
             UPDATE    [Source]
             SET       [Source].[MFTerritory_ID] = [MF].[MFID_ValueListItems]
             FROM      [Custom].[stageMFCustomer_FutNew] [Source]
             INNER JOIN [dbo].[MFvwValueList_Territory] [MF] ON [MF].[Name_ValueListItems] = [Source].[TERRITORY] AND [MF].[Deleted] = 0
             WHERE     [Source].[MFTerritory_ID] IS NULL
              AND [Source].[TERRITORY] IS NOT NULL
          END --IF @Missing_Territory_ID > 0

          IF @Missing_Sales_Rep_ID > 0
          BEGIN 
             UPDATE    [Source]
             SET       [Source].[MFSales_Rep_ID] = [MF].[MFID_ValueListItems]
             FROM      [Custom].[stageMFCustomer_FutNew] [Source]
             INNER JOIN [dbo].[MFvwValueList_Sales_Rep] [MF] ON [MF].[Name_ValueListItems] = [Source].[SALESREP] AND [MF].[Deleted] = 0
             WHERE     [Source].[MFSales_Rep_ID] IS NULL
              AND [Source].[SALESREP] IS NOT NULL
          END --IF@Missing_Sales_Rep_ID > 0

                       END --IF EXISTS ( SELECT  1 FROM [dbo].[MFValueListItems] WHERE   [Process_ID] <> 0 )
      END --Process Missing Value List Items
     END -- PROCESS VALUELIST 

