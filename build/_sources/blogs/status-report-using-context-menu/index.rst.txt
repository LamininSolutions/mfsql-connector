Status report using context menu
================================

orThis use case focus on the application of the context menu to provide
feedback to the user on a result of a calculation, status or summary.
The type of report would depend on the specific use of the vault but
could include something like a status report on cases closed in the last
hour or the financial summary of a customer’s invoices. The key is the
report should be simple, concise and suitable for display in a
messagebox text based report.

Graphics, multipage data, matrix data and similar complex reporting is
not suitable for this method.

In essence, the context menu provides the capability of actioning the
report calculation and to display the result in a feedback window. The
action can include the context of the underlying object to return a
report specific to the object.

The steps below highlights the elements to focus on for this type of
application.

--------------

Step 1:

Determine the class or classes of objects involved in the report; create
the classes in the Connector and update the data. refer to other
sections in the guide for more detail on how to do this.

Prepare the dataset for the report. Note that the result will be built
into a procedure with a single parameter (@output) as the formatted
result. The Objid and class of the Context object will be used as an
input parameter for selecting the data.

Step 2:

Format the output to show in standard text based Window. Note the
following

-  ‘\\n’ carriage return and a line feed. e.g. "this is first line" +
   "\\n" + "this is second line"

-  or CHAR(10) for line feed e.g. "this is first line" + CHAR(10) +
   "this is second line"

-  CHAR(09) for a tab

.. code:: sql

    DECLARE @CustomerName NVARCHAR(50),
            @totalOpportunities INT;
    SELECT @CustomerName
    FROM [dbo].[MFAccount] AS [ma]
    WHERE [ma].[ObjID] = @ObjectID;

    SELECT @totalOpportunities = SUM([mo].[Estimated_Sales_Value])
    FROM [dbo].[MFOpportunity] AS [mo]
    WHERE [mo].[Account_ID] = @ObjectID
          AND [mo].[State] = 'Won';

    SET @OutPut
        = 'Customer: ' + CHAR(09) + @CustomerName + CHAR(10) + 'Open Opportunities: ' + CHAR(09)
          + CAST(CONVERT(MONEY, @totalOpportunities) AS VARCHAR(10));

The procedure spMFResultMessageforUI is a good illustration of preparing
data for the UI Window. The @MessageOUT formatting applies to the
context menu UI.

Step 3:

Add the snippet of your procedure into the custom.CM.DoObjectAction
sample code. Rename procedure and modify the content to suite your
requirements.

Use the following method to debug the Context Menu action item if the
message does not appear.

.. code:: sql

    DECLARE @OutPut VARCHAR(1000);
    EXEC custom.[Report_Customer_Performance] @ObjectID = 22,   -- ID in the context menu in MF for the selected object
                                              @ObjectType = 124, -- Type in the context menu in MF for the selected object
                                              @ObjectVer = 7,  
                                              @ID = 45,         -- id of the action itemm in MFContextMenu
                                              @OutPut = @OutPut OUTPUT,                            -- varchar(1000)
                                              @ClassID = 49     -- int
    SELECT @output

Step 4:

Add a context menu Heading and action record. Note the action record
must have a action type = 3. Use helper procedures
spMFContextMenuActionItem and spMFContextMenuActionItem to add the items
to MFContextMenu.

Step 5:

In M-Files, select Customer, right click, select MFSQLConnector option
to open menu, and select report

|image0|

.. |image0| image:: img_1.jpg
