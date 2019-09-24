Metadata Search
===============

Metadata searches can be performed in SQL on the Class Tables or
directly into M-Files.  By keeping the metadata in the Class Tables up
to date, one does not have to access M-Files directly for a search.

However, searches can be performed on M-Files with the Connector
procedures.

There are two type of search methods available.

Search with class ID and name or title property

Use “spMFSearchForObject” procedure to search for objects with class id
and name or title property. This procedure will call
“spMFSearchForObjectInternal” and get the objects details that satisfies
the search conditions and shows the objects details in tabular format.

|  



*Input:*
^^^^^^^^

                              @ClassID             : MFID of the class

                              @SearchText      : name of the object for
a specific record
                                                           
               else pass NULL to get all objects

                                             @Count               : The
maximum number of results to return.
                                                                                         
Specify 0 to return unlimited number of results.

                                            



*Output:*
^^^^^^^^^

                                                            Search
details will display in tabular format.



*Execution Sample:*
^^^^^^^^^^^^^^^^^^^

                                             DECLARE            
@return_value int

 

EXEC       @return_value = [dbo].[spMFSearchForObject]

                              @ClassID = 78, --Customer Class ID

                              @SearchText = NULL,

                              @Count = 10

 

SELECT   'Return Value' = @return_value

 

GO

 

Search with class ID and some specific property id and value.

 

  Use “spMFSearchForObjectbyPropertyValues” procedure to search for
objects with class id and some specific property id and value. This
procedure will call “spMFSearchForObjectByPropertyValuesInternal” and
get the objects details that satisfies the search conditions and shows
the objects details in tabular format.

 



*Input:*
^^^^^^^^

                              @ClassID               : ID of the class

                       @PropertyIds       : Property ID’s or property
names separated by comma

                              @PropertyValues: Property values separated
by comma

                              @Count                 : The maximum
number of results to return.         
                                                            Specify 0 to
return unlimited number of results.   

 

 

 



*Execution Sample:*
^^^^^^^^^^^^^^^^^^^

                                             DECLARE            
@return_value int

 

EXEC       @return_value = [dbo].[spMFSearchForObjectbyPropertyValues]

                              @ClassID = 78,

                              @PropertyIds = N'1110,1101',

                              @PropertyValues = N'Davis, Cobb’,

                              @Count = 5

 

SELECT   'Return Value' = @return_value

GO

 

 

.. container:: table-wrap

   =============================================================================================================================================================
   `Functional Description <https://lamininsolutions.atlassian.net/file:///O:/Development/WebDev/DocBuild/MFSQLConnector/Chapter3/Functional_Description.htm>`__
   =============================================================================================================================================================
   =============================================================================================================================================================
