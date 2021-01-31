Context Menu Procedures
=======================

The context menu relies on procedures with a predefined structure.

The procedure spMFGetContectMenu is used by the application and should
not be modified.

The functionality provides for two types of procedures to be executed:

#. Procedure without any input parameters
#. procedure using the object version of the of the M-Files object in
   context as input parameter.

The name of the procedure must be added in the column *Action* in
MFContextMenu table for the menu item that will be used to execute the
action.

The procedure will be executed when the menu item is select. The intent
is that this procedure will call the custom procedure that controls the
execution of the desired process. On completion the output message of
the this procedure will be return to the user in M-Files.



Procedure without input parameter (action type 1)
-------------------------------------------------

**Execute Procedure**

.. code:: sql

    CREATE PROCEDURE [contmenu].[procname]
    @OutPut varchar(1000) Output
    as
    Begin

      Begin Try
       --Call procedure to perform operation and return output message
       set @OutPut='Operation successful'
      End Try
      Begin Catch
       set @OutPut='Error:'
       set @OutPut=@OutPut+(select ERROR_MESSAGE())
      End Catch
    End



Procedure with object version as input parameter (action type 3)
----------------------------------------------------------------

**Execute Procedure**

.. code:: sql

    Create Procedure contmenu.procname
    @ObjectID int,
    @ObjectType int,
    @ObjectVer int,
    @OutPut varchar(1000) Output
    as
    begin
      Begin Try
    --Call procedure to perform operation using the object details as input and return output message
       set @OutPut='Operation successful'   
      End Try
      Begin Catch
       set @OutPut='Error:'
       set @OutPut=@OutPut+(select ERROR_MESSAGE())
      End Catch
    End

Formatting result message for UI
--------------------------------

The procedure spMFResultMessageForUI is specifically targeted at
providing a formatted message to be returned to the UI to improve the
user message on completion of the procedure.

This procedure is called from the main procedure than controls the
process to return and error or to return to successful completion.  It
also assumes that the main procedure utilizes the MFProcessBatch table
to log to outcome of the procedure.

the message returned is the result of the procedure as recorded in the
MFProcessBatch.

Line Breaks in output
~~~~~~~~~~~~~~~~~~~~~

insert '\n' in the string to insert line breaks in the output
message :

for example:

.. code:: text

    set @OutPut= 'ObjectID='+CAST(@ObjectID as varchar(10))+ '/n' + ' ObjectType='+cast(@ObjectType as varchar(10))+

.. code:: text

   + '/n' + ' ObjectVer='+ cast(@ObjectVer as varchar(10))

