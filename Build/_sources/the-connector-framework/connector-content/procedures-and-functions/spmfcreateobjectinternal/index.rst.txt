spMFCreateObjectInternal
========================

This CLR procedure is at the heart of the exchange of the object data
between SQL and M-Files.  Understanding the inner workings of the
exchange of data between SQL And M-Files could help in some situations,
especially to related the results in MFUpdateHistory table.

The procedure cannot be executed on its own as it depends on the input
parameters in XML format.

 -  @VaultSettings
      controls access to M-Files and is dependent on  MFvaultsettings
      SELECT [dbo].[FnMFVaultSettings]() returns the setting for parameter
	  
 -  @XML
      XML formatted details of records:
      If UpdateMethod 0 then XML include new/updated record of all items with process_id
      If updateMethod 1 then XML include on ObjecctType and Class for update. 
      this input is shown in MFUpdateHistory.ObjectDetails
	  
 -  @ObjVerXmlString
      this shows the object and version of the M-Files records in the scope of the filter that is in SQL only applies to update method 1 and 2
      this input is shown in MFUpdateHistory.ObjectVerDetails
	  
 -  @MFIDs
      List of ID's to be updated. Only visible in debug mode
	  
 -  @UpdateMethod
      0 or 1
	  
 -  @MFModifiedDate
      MFupdateTable filters
 -  @ObjIDsForUpdate
 
 -  @XmlOUT OUTPUT
      outputs the object and version of the new record created in M-Files to be updated in SQL
      only when method is not 0
      this output is shown in [MFUpdateHistory].[NewOrUpdatedObjectVer].
	  
 -  @NewObjectXml OUTPUT
      this output is shown in  MFUpdateHistory].[NewOrUpdatedObjectDetails] 
      This data is updated into SQL
	  
 -  @SynchErrorObj OUTPUT
      this output is shown in[MFUpdateHistory].[SynchronizationError]
      only when method is not 0 
      Process_id is set to 2 
	  
 -  @DeletedObjects OUTPUT 
      this output is shown in[MFUpdateHistory].[DeletedObjectVer]
      only when method is not 0 and filter is not@MFModifiedDate          
      Deleted is set to 1
	  
 -  @ErrorInfo OUTPUT
      this output is shown in[MFUpdateHistory].[MFError]
      Process_id is set 3
	  
 -  @DeletedObjects OUTPUT
      Added new paramater
	  
 -  @ErrorInfo OUTPUT;
 
