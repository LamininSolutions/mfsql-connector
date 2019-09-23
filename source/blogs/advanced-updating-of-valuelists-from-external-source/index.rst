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
       OR @Missing_State_Province_ID > 0
       )
      BEGIN 
        --Refresh from M-Files 
        --and update value list to see if anything still missing
        --add missing values to M-Files
        EXEC [dbo].[spMFSynchronizeSpecificMetadata]   @Metadata = 'ValueListItems'
         , @Debug = @debug
         , @IsUpdate = 0 --M-Files to MFSQL

       
                 --Value List Items are owner to states, therefor needs to be added to M-Files 1st     
          IF @Missing_State_Province_ID >0
          BEGIN
           EXEC [dbo].[spMFSynchronizeValueListItemsToMFiles] @debug 
          END           

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

      
                       END --IF EXISTS ( SELECT  1 FROM [dbo].[MFValueListItems] WHERE   [Process_ID] <> 0 )
      END --Process Missing Value List Items
     END -- PROCESS VALUELIST 

