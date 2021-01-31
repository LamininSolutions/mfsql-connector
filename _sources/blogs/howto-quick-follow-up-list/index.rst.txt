
How to generate a quick follow up list
======================================

Sometime you just want to have a list of objects that you can quickly follow up and work through the issues.

In MFSQL Connector it is easy and quick:

#  Create and update the source class table or tables
#  Prepare a script to extract the items to be followed up
#  Include a hyperlink to the object as a column. Note the formatting of the hyperlink below to automatically convert to a excel function.
#  Copy and past the results of the script to excel (right click on left top corner of script result tab and select copy with headers)

The result will be list of objects to follow up, with a link to M-Files to investigate it further and follow it up.

To keep the excel alive with the changes

#  Just produce the script again in SSMS and copy the result again to the spreadsheet
#  or - ceate a view from the script. Set the excel up with an ODBC link to the view
#  0r - use Interject tool to configure and design the excel interface to allow for the changes to be made in excel and push back to M-Files.

An example of using the Sales Pipeline objects to produce a list of renewals for quick follow up:

.. code:: sql

    SELECT msp.Sales_Pipelines_Type,
    msp.Sales_Pipelines_Type_ID,
    msp.State,
    msp.State_ID,
    msp.Company,
    msp.Potential_Laminin_Products,
    msp.Name_Or_Title,
    '=Hyperlink("' + dbo.fnMFObjectHyperlink('MFSalesPipeline', msp.ObjID, msp.GUID, 1) +   '","'+  msp.Name_Or_Title +'")' AS link
    FROM dbo.MFSalesPipeline AS msp
 
