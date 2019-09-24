spMFCreateObjectInternal
========================

This CLR procedure is at the heart of the exchange of the object data
between SQL and M-Files.  Understanding the inner workings of the
exchange of data between SQL And M-Files could help in some situations,
especially to related the results in MFUpdateHistory table.

The procedure cannot be executed on its own as it depends on the input
parameters in XML format.

.. container:: table-wrap

   ======================= ================================================================================================== ==================================================================== ==============================================================================================================================================
   ======================= ================================================================================================== ==================================================================== ==============================================================================================================================================
   @VaultSettings          controls access to M-Files and is dependent on  MFvaultsettings                                    SELECT [dbo].[FnMFVaultSettings]() returns the setting for parameter
   @XML                    XML formatted details of records:                                                                                                                                       | <form>
                                                                                                                                                                                                   | <Object id="165" sqlID="1">
                           -  If UpdateMethod 0 then XML include new/updated record of all items with process_id                                                                                   | <class id="97">
                           -  If updateMethod 1 then XML include on ObjecctType and Class for update.                                                                                              | <property id="0" dataType="1" />
                                                                                                                                                                                                   | <property id="1160" dataType="1" />
                           this input is shown in MFUpdateHistory.ObjectDetails                                                                                                                    | <property id="1156" dataType="5">2017-02-17</property>
                                                                                                                                                                                                   | <property id="1155" dataType="6">08:00:00.0000000</property>
                                                                                                                                                                                                   | <property id="27" dataType="7">0</property>
                                                                                                                                                                                                   | <property id="22" dataType="8">0</property>
                                                                                                                                                                                                   | <property id="1161" dataType="9">1</property>
                                                                                                                                                                                                   | <property id="1162" dataType="9">1</property>
                                                                                                                                                                                                   | <property id="1163" dataType="9" />
                                                                                                                                                                                                   | <property id="38" dataType="9" />
                                                                                                                                                                                                   | <property id="39" dataType="9" />
                                                                                                                                                                                                   | <property id="1147" dataType="10" />
                                                                                                                                                                                                   | <property id="1157" dataType="13">ground preparation</property>
                                                                                                                                                                                                   | </class>
                                                                                                                                                                                                   | </Object>
                                                                                                                                                                                                  
                                                                                                                                                                                                   </form>
   @ObjVerXmlString        this shows the object and version of the M-Files records in the scope of the filter that is in SQL only applies to update method 1 and 2                                | <form>
                                                                                                                                                                                                   | <ObjectType id="163">
                           this input is shown in MFUpdateHistory.ObjectVerDetails                                                                                                                 | <objVers objectID="1" version="3" objectGUID="{1926228B-E854-4F16-BBF7-FE754668E675}" />
                                                                                                                                                                                                   | <objVers objectID="2" version="3" objectGUID="{61C237D7-8DFC-4E4F-9868-D7E06AC0C9D8}" />
                                                                                                                                                                                                   | </ObjectType>
                                                                                                                                                                                                   | </form>
   @MFIDs                  List of ID's to be updated. Only visible in debug mode                                                                                                                 
   @UpdateMethod           0,1 or 2                                                                                                                                                               
   @MFModifiedDate         MFupdateTable filters                                                                                                                                                  
   @ObjIDsForUpdate                                                                                                                                                                               
   @XmlOUT OUTPUT          outputs the object and version of the new record created in M-Files to be updated in SQL           only when method is not 0                                            | <form>
                                                                                                                                                                                                   | <Object ID="470" objectId="2" objVersion="1" objectGUID="{3806F712-C9AE-4237-A9A8-0A0784820640}" />
                           this output is shown in [MFUpdateHistory].[NewOrUpdatedObjectVer].                                                                                                      | <Object ID="471" objectId="3" objVersion="1" objectGUID="{41ABADA5-4CB7-4DBA-8933-B455E3985841}" />
                                                                                                                                                                                                   | <Object ID="472" objectId="4" objVersion="1" objectGUID="{E66C4CEC-0C3D-45BE-9979-75344CB0E661}" />
                           |                                                                                                                                                                       | <Object ID="473" objectId="5" objVersion="1" objectGUID="{12D102E0-940C-4C3D-8595-DEEA11FD9595}" />
                                                                                                                                                                                                   | <Object ID="474" objectId="6" objVersion="1" objectGUID="{C2487B49-89FD-4AED-AE86-EFFAA86D2A65}" />
                                                                                                                                                                                                  
                                                                                                                                                                                                   </form>
   @NewObjectXml OUTPUT    output the object with property details of the updated/new record in M-Files to be updated in SQL  only when method is not 0                                            | <form>
                                                                                                                                                                                                   | <Object objectId="3" objVersion="1" objectGUID="{317B53EB-FE98-4806-8DF1-6BE7FC528123}" DisplayID="3">
                           this output is shown in  MFUpdateHistory].[NewOrUpdatedObjectDetails]                                                                                                   | <properties propertyId="0" dataType="MFDatatypeText" propertyValue="Donald John (J&amp;D Ground Works) (2/14/2017)" />
                                                                                                                                                                                                   | <properties propertyId="21" dataType="MFDatatypeTimestamp" propertyValue="15-02-2017 09:55" />
                           This data is updated into SQL                                                                                                                                           | <properties propertyId="22" dataType="MFDatatypeBoolean" propertyValue="No" />
                                                                                                                                                                                                   | <properties propertyId="23" dataType="MFDatatypeLookup" propertyValue="Demo User" />
                                                                                                                                                                                                   | <properties propertyId="23" propertyValue="31" />
                                                                                                                                                                                                   | <properties propertyId="100" dataType="MFDatatypeLookup" propertyValue="Site Visit" />
                                                                                                                                                                                                   | <properties propertyId="100" propertyValue="97" />
                                                                                                                                                                                                   | <properties propertyId="1147" dataType="MFDatatypeMultiSelectLookup" propertyValue="J&amp;D Ground Works" />
                                                                                                                                                                                                   | <properties propertyId="1147" propertyValue="105" />
                                                                                                                                                                                                   | <properties propertyId="1155" dataType="MFDatatypeTime" propertyValue="8:00 AM" />
                                                                                                                                                                                                   | <properties propertyId="1156" dataType="MFDatatypeDate" propertyValue="14-02-2017 00:00" />
                                                                                                                                                                                                   | <properties propertyId="1157" dataType="MFDatatypeMultiLineText" propertyValue="Leveling and clearing" />
                                                                                                                                                                                                   | <properties propertyId="1160" dataType="MFDatatypeText" propertyValue="Donald John (J&amp;D Ground Works) (2/14/2017)" />
                                                                                                                                                                                                   | <properties propertyId="1161" dataType="MFDatatypeLookup" propertyValue="Donald John (J&amp;D Ground Works)" />
                                                                                                                                                                                                   | <properties propertyId="1161" propertyValue="1" />
                                                                                                                                                                                                   | <properties propertyId="1162" dataType="MFDatatypeLookup" propertyValue="North Elevation Groundworks" />
                                                                                                                                                                                                   | <properties propertyId="1162" propertyValue="1" />
                                                                                                                                                                                                   | <properties propertyId="1163" dataType="MFDatatypeLookup" propertyValue="" />
                                                                                                                                                                                                   | <properties propertyId="1163" propertyValue="" />
                                                                                                                                                                                                   | <properties propertyId="20" dataType="MFDatatypeTimestamp" propertyValue="15-02-2017 09:48" />
                                                                                                                                                                                                   | <properties propertyId="25" dataType="MFDatatypeLookup" propertyValue="Demo User" />
                                                                                                                                                                                                   | <properties propertyId="25" propertyValue="31" />
                                                                                                                                                                                                   | </Object>
                                                                                                                                                                                                  
                                                                                                                                                                                                   </form>
   @SynchErrorObj OUTPUT   this output is shown in[MFUpdateHistory].[SynchronizationError]                                    only when method is not 0                                           
                                                                                                                                                                                                  
                           Process_id is set to 2                                                                                                                                                 
    @DeletedObjects OUTPUT this output is shown in[MFUpdateHistory].[DeletedObjectVer]                                        only when method is not 0 and filter is not@MFModifiedDate          
                                                                                                                                                                                                  
                           Deleted is set to 1                                                                                                                                                    
    @ErrorInfo OUTPUT      this output is shown in[MFUpdateHistory].[MFError]                                                                                                                      | <form>
                                                                                                                                                                                                   | <errorInfo sqlID="1" objID="" ErrorMessage="Please check the object (objID : 0@&#xA;Type mismatch.&#xD;&#xA;&#xD;&#xA;CoTypedValue.cpp, 365,
                           Process_id is set 3                                                                                                                                                     | </form>
   ======================= ================================================================================================== ==================================================================== ==============================================================================================================================================

| 

| 

| 

| 

| 

| 

| 

| 

| 

| 

| 

| 

| 

| 

| 

| 

| 
| , @DeletedObjects OUTPUT --Added new paramater
| , @ErrorInfo OUTPUT;
