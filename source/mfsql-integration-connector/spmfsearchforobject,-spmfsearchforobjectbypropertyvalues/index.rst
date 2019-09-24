spMFSearchForObject, spMFSearchForObjectbyPropertyValues
========================================================

There are two type of search methods available to search objects in
M-Files.



Search with class ID and name or title property
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use “spMFSearchForObject” procedure to search for objects with class id
and name or title property. This procedure will call
“spMFSearchForObjectInternal” and get the objects details that satisfies
the search conditions and shows the objects details in tabular format.

The result is either:

a) inserted in a temporary table. MFSearchLog is updated with the name
of the table and summary of result.

b) output as an XML output parameter.

.. container:: table-wrap

   ============== ========================================================================================================
   Type           Description
   ============== ========================================================================================================
   Procedure Name spMFSearchForObject
   Inputs         @ClassID : ID of the class
                 
                   @SearchText  : Pass name of the object for a specific record  else pass NULL to get all objects
                 
                   @Count : The maximum number of results to return. Specify 0 to return unlimited number of results.
                 
                  @outputType: 0 = output to XML; 1 = output to temporary table and update MFSearchLog
                 
                  @XMLOutput: if outputType = 0 then this parameter returns the result in XML format
                 
                  @TableName: if outputType = 1 then this parameter returns the name of the temporary file with the result
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== ========================================================================================================

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          DECLARE @XMLOutPut XML
                ,@TableName VARCHAR(200);

         EXEC [dbo].[spMFSearchForObject] @ClassID = 78                  -- the class MFID: this can be obtained from select Name, MFID from MFClass
                                         ,@SearchText = 'A'              -- any text value, this can be a part text. It does not cater for wildcards
                                         ,@Count = 5                     -- used to restrict the number of search result returns.
                                         ,@Debug = 0
                                         ,@OutputType = 1                -- set to 1 to channel output to a table
                                         ,@XMLOutPut = @XMLOutPut OUTPUT -- is null  
                                         ,@TableName = @TableName OUTPUT;

                                                                         -- used in subsequent processing to process the search result.                 
         --show temp table name
         SELECT @TableName AS [TableName];

         --view search result
         SELECT *
         FROM [dbo].[MFSearchLog] AS [msl];
         GO



Search with class ID and some specific property id and value.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| 

Use “spMFSearchForObjectbyPropertyValues” procedure to search for
objects with class id and some specific property id and value. This
procedure will call “spMFSearchForObjectByPropertyValuesInternal” and
get the objects details that satisfies the search conditions and shows
the objects details in tabular format.

| 

.. container:: table-wrap

   ============== =====================================================
   Type           Description
   ============== =====================================================
   Procedure Name spMFSearchForObjectbyPropertyValues
   Inputs         @ClassID  : ID of the class
                 
                  @PropertyIds : Property ID’s separated by comma
                 
                   @PropertyValues : Property values separated by comma
                 
                   @Count  : The maximum number of results to return.  
                 
                  Debug: 1 = Debug Mode; 0 = No Debug (default)
   Outputs        1 = success
   ============== =====================================================

| 

| 

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

          DECLARE @RC INT
         DECLARE @ClassID INT
         DECLARE @PropertyIds NVARCHAR(2000)
         DECLARE @PropertyValues NVARCHAR(2000)
         DECLARE @Count INT
         DECLARE @OutputType INT
         DECLARE @XMLOutPut XML
         DECLARE @TableName VARCHAR(200)

         -- TODO: Set parameter values here.

         EXECUTE @RC = [dbo].[spMFSearchForObjectbyPropertyValues] 
            @ClassID
           ,@PropertyIds
           ,@PropertyValues
           ,@Count
           ,@OutputType
           ,@XMLOutPut OUTPUT
           ,@TableName OUTPUT
         GO



