spMFCreatePublicSharedLink
==========================

The following Hyperlinks can be created using the Connector

#. Show object view in Desktop Client
#. Show object view  in Web Access
#. Open object file in Desktop Client
#. View object file in Desktop Client
#. show metadata in Desktop Client
#. Edit object file in Desktop
#. Create/Update Public Hyperlink 



Public link procedure and table - spMFCreatePublicSharedLink
------------------------------------------------------------

The procedure spMFCreatePublicSharedLink will create or update the link
to the specified object and add the link in the MFPublicLink table.  A
join can then be used to access the link and include it in any custom
view

.. container:: confluence-information-macro confluence-information-macro-warning

   .. container:: confluence-information-macro-body

      This procedure will use the ServerURL setting in MFSettings and
      expects eiher 'http://' or 'https://' and a fully qualified dns
      name as the value. Example: 'http://Contoso.com'



spMFCreatePublicSharedLink Procedure for creating public share link
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The only required parameters are the class Table name and Expiry date.  

-  If process_id = 0 then all the records with singlefile = 1 will be
   updated in the class
-  Set the process_id to a number > 4 if you want to create the link for
   a set list of records
-  If you are making updates to a record and want to set the public link
   at the same time then run the shared link procedure after setting the
   process_id and before updating the records to M-Files
-  the expire date can be set for the number of weeks or month from the
   current date by using the dateadd function
   (e.g. Dateadd(m,6,Getdate()))
-  Use the objectID if you want to set the link for only a single record
-  The ClassID does not have to be set.

.. container:: table-wrap

   ============== =======================================================================================
   Type           Description
   ============== =======================================================================================
   Procedure Name ::
                 
                     spMFCreatePublicSharedLink
   Inputs         TableName = Name of class table
                 
                  ExpireDate = null set to getdata() + 1 month
                 
                  ClassID = Default is null. if not specified
                 
                  ObjectID = objid of the class record. Default = null
                 
                  ProcessID = default is set to 1.
   Outputs        1 = success
                 
                  The procedure creates/updates a public link for the object(s) in the MFPublicLink Table
   ============== =======================================================================================

**Execute Procedure**

.. container:: table-wrap

   ==================================================================================================================================================================================================================
   `` ``
   
   ``EXEC dbo.spMFCreatePublicSharedLink @TableName = 'ClassTableName', -- varchar(250)     @ExpiryDate = '2017-05-21', -- datetime     @ClassID = nul, -- int     @ObjectID = , -- int     @ProcessID = 0 -- int `` 
   ==================================================================================================================================================================================================================



MFPublicLink table
~~~~~~~~~~~~~~~~~~

.. container:: table-wrap

   ============ ============================================================================================================ ===============================================================================================================================================================================================================
   Column       Description                                                                                                  Example/Comment
   ============ ============================================================================================================ ===============================================================================================================================================================================================================
   ID           Automated Identity ID                                                                                       
   ObjectID     Objid column of the Record                                                                                   Use the combination of objid and class_ID to join this record to the class table
   ClassID      Class_ID of the Record                                                                                      
   ExpireDate   Expiredate used in Access Key                                                                                2017-01-01
   AccessKey    Unique key generated by M-Files using Assembly                                                               380e4605d3e295c63e7d98d9a1abec1c9109a09683890b64a13c9e392c09eb14
   Link         Constructed link                                                                                             http://LSUK-APP03.lsusa.local/SharedLinks.aspx?accesskey=0a5751ce3e7968dcf52942e9a9da57a32787b4495cc48d38c38d8cf6ec3b277f&VaultGUID={862A89B8-89CD-4AE0-98FF-8F32049F6DFC}
   HTMLLink     HTML constructed link to be used in emails. The name of the document is used as the friendly name f the link <a href="http://LSUK-APP03.lsusa.local/SharedLinks.aspx?accesskey=0a5751ce3e7968dcf52942e9a9da57a32787b4495cc48d38c38d8cf6ec3b277f&VaultGUID={862A89B8-89CD-4AE0-98FF-8F32049F6DFC}" >Extract from City Map</a>
   DateCreated                                                                                                               Date item was created
   DateModified                                                                                                              Date item was last udated
   ============ ============================================================================================================ ===============================================================================================================================================================================================================

| 

| 



Object hyperlink function - fnMFObjectHyperLink
-----------------------------------------------

| 

Use the following function to dynamically create a hyperlink to the
Class object in M-Files

.. container:: confluence-information-macro confluence-information-macro-note

   .. container:: confluence-information-macro-body

      The Weblink use the ServerURL in the MFSettings table to construct
      the external URL. Note that the http or https must be included in
      the serverURL e.g. http://contoso.com in the MFSettings table.

.. container:: table-wrap

   ============= ==================================================================================================================================================================================================
   Type          Description
   ============= ==================================================================================================================================================================================================
   Function Name dbo.fnMFObjectHyperLink
   Inputs        MFTableName = Name of Class Table
                
                 MFObject_MFID = ObjID column in Class Table
                
                 ObjectGuid = GUID column in Class Table
                
                 HyperlinkType =
                
                 -  1 for desktop show hyperlink;
                 -  2 for Web Access hyperlink;
                 -  3 for desktop view hyperlink
                 -  4 for desktop open hyperlink.
                 -  5 for show metadata hyperlink
                 -  6 for desktop edit hyperlink
   Return        Hyperlink to object
                
                 Web Access: ServerURL + GUID + Object Type
                
                 `serverurl.com/Default.aspx?#312E44F6-AE4B-4F5E-8784-9527260A5743/object/149/1/latest <http://cloud.lamininsolutions.com/Default.aspx#312E44F6-AE4B-4F5E-8784-9527260A5743/object/149/1/latest>`__
                
                 Desktop show:
                
                 ::
                
                    m-files://show/ + Vault GUID + Object GUID
                
                 ::
                
                    m-files://show/312E44F6-AE4B-4F5E-8784-9527260H5743/149-1?object={9521ED0A-47DD-4C4A-90DF-1292F58AF504}
                
                 Desktop Open:
                
                 ::
                
                    m-files://open/ + Vault GUID + Object GUID
                
                 ::
                
                    m-files://open/312E44F6-AE4B-4F5E-8784-9527260H5743/149-1?object={9521ED0A-47DD-4C4A-90DF-1292F58AF504}
                
                 | 
   ============= ==================================================================================================================================================================================================

.. container:: code panel pdl

   .. container:: codeHeader panelHeader pdl

      **Execute Procedure**

   .. container:: codeContent panelContent pdl

      .. code:: sql

         SELECT  
           dbo.[fnMFObjectHyperlink]('MFCustomer',mco.objid,mco.guid,1)
         FROM    [dbo].[MFCustomer] AS [mco] where objid = 40
          
         Returns: m-files://show/312E44F6-AE4B-4F5E-8784-9527260A5743/149-1?object={9521ED0A-47DD-4C4A-90DF-1292F58AF504}
          
          

| 

| 
