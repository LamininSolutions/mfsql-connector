use master

-- use search and replace to reset the target database CSVIMPORT with your database

PRINT 'USE [' + DB_NAME() + '] ON [' + @@SERVERNAME + ']'
PRINT REPLICATE('-',80)
/**********************************************************************************
** SCRIPT VARIABLES
*********************************************************************************/
declare @Domain varchar(128) = DEFAULT_DOMAIN();
DECLARE @varAppDB varchar(128) = 'CSVIMPORT';
DECLARE @varAuthType varchar(10) =  'SQL' --'Options: SQL | WINDOWS;
DECLARE @varAppLogin_Name varchar(128) = 'MFSQLCONNECT';
DECLARE @varAppLogin_Password varchar(128) = 'Connector01';

SET @varAppLogin_Name = RTRIM('MFSQLCONNECT')

/**********************************************************************************
** CREATE DATABASES
*********************************************************************************/
BEGIN
PRINT 'CREATE DATABASES ON ' + QUOTENAME(@@SERVERNAME) 
DECLARE @dbName nvarchar(128)

SET @dbName = @varAppDB
	PRINT space(5) + 'CREATE [' + @dbName + '] database for use with MFSQL Connector' 
	IF NOT EXISTS (SELECT name 
					FROM sys.databases
					WHERE name = @dbName
					)
		BEGIN
			PRINT space(5) + '    -- creating database... ' 
			EXEC ('CREATE DATABASE [' + @dbName + ']')
		END
		ELSE
			PRINT space(5) + '    -- database exists. '

END

/**********************************************************************************
** CREATE SQL LOGINS
*********************************************************************************/
BEGIN
PRINT 'CREATE SQL LOGINS ON ' + QUOTENAME(@@SERVERNAME) 
DECLARE @login varchar(50)

SET @login= @varAppLogin_Name

	PRINT space(5) + 'CREATE [' + @Login + '] SQL Login for SQL Authentication' 
	IF NOT EXISTS (SELECT name 
					FROM sys.server_principals
					WHERE name = @login
					)
		BEGIN
			PRINT space(5) + '    -- creating login... ' 
			EXEC ('CREATE LOGIN [' + @login + '] WITH PASSWORD = ''' + @varAppLogin_Password + '''') 
		END
		ELSE
			PRINT space(5) + '    -- login exists. '

			
END


GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

/*

*/

/**********************************************************************************
** AppDB: DATABASE LEVEL SETTINGS/AUTHENTICATION
**		  
*********************************************************************************/


USE CSVIMPORT
PRINT 'USE [' + DB_NAME() + '] ON [' + @@SERVERNAME + ']'
PRINT REPLICATE('-',80)
/**********************************************************************************
** SCRIPT VARIABLES
*********************************************************************************/

DECLARE @varAuthType varchar(10) = 'SQL';
DECLARE @varAppLogin_Name varchar(128) = 'MFSQLCONNECT';
DECLARE @varAppDBRole varchar(128) = 'DB_MFSQLCONNECT';

/*
DECLARE @varAuthType varchar(10) = 'SQL'
DECLARE @varAppLogin_Name varchar(128) = 'MFSQLConnect'
DECLARE @varAppDBRole varchar(128) = 'db_MFSQLConnect'
*/

/**********************************************************************************
** CREATE DATABASE ROLE(S)
*********************************************************************************/
BEGIN
DECLARE @dbrole NVARCHAR(50)
SET @dbrole = @varAppDBRole  -- {varAppDBRole}
		
		PRINT 'CREATE DATABASE ROLE [' + @dbrole + ']'
		IF NOT EXISTS(SELECT 1 FROM sys.database_principals WHERE name = @dbrole AND type = 'R')
		BEGIN
			PRINT SPACE(5) + '    -- adding database role... '
			EXEC ('CREATE ROLE [' + @dbrole +'] AUTHORIZATION [dbo]')
		END
		ELSE 
			PRINT space(5) + '    -- database role exists. '


/**********************************************************************************
** CREATE DATABASE SCHEMA(S)
*********************************************************************************/
BEGIN
DECLARE @schema NVARCHAR(50)
SET @schema = 'expl'

		PRINT 'CREATE SCHEMA [' + @schema + ']'
		IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = @schema)
		BEGIN
			PRINT SPACE(5) + '    -- adding schema... '
			EXEC ('CREATE SCHEMA [' + @schema + '] AUTHORIZATION [dbo]')
		END
		ELSE 
			PRINT space(5) + '    -- schema exists. '

SET @schema = 'Custom'

		PRINT 'CREATE SCHEMA [' + @schema + ']'
		IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = @schema)
		BEGIN
			PRINT SPACE(5) + '    -- adding schema... '
			EXEC ('CREATE SCHEMA [' + @schema + '] AUTHORIZATION [dbo]')
		END
		ELSE 
			PRINT space(5) + '    -- schema exists. '

END

/**********************************************************************************
** APPLY PERMISSIONS TO SCHEMAS
*********************************************************************************/
BEGIN
SET @dbrole = @varAppDBRole  -- {varAppDBRole}

SET @schema = 'dbo'
	PRINT 'APPLY PERMISSIONS ON SCHEMA [' + @schema + '] TO DATABASE ROLE [' + @dbrole + ']'
	PRINT space(5) + '    -- ' + 'GRANT DELETE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT DELETE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT INSERT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT INSERT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT SELECT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT SELECT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT UPDATE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT UPDATE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT EXECUTE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT EXECUTE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')

	PRINT space(5) + '    -- ' + 'GRANT ALTER ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT ALTER ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')



SET @schema = 'expl'
	PRINT 'APPLY PERMISSIONS ON SCHEMA [' + @schema + '] TO DATABASE ROLE [' + @dbrole + ']'
	PRINT space(5) + '    -- ' + 'GRANT DELETE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT DELETE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT INSERT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT INSERT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT SELECT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT SELECT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT UPDATE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT UPDATE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT EXECUTE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT EXECUTE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')

SET @schema = 'custom'
	PRINT 'APPLY PERMISSIONS ON SCHEMA [' + @schema + '] TO DATABASE ROLE [' + @dbrole + ']'
	PRINT space(5) + '    -- ' + 'GRANT DELETE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT DELETE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT INSERT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT INSERT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT SELECT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT SELECT ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT UPDATE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT UPDATE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')
	
	PRINT space(5) + '    -- ' + 'GRANT EXECUTE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT EXECUTE ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')

	PRINT space(5) + '    -- ' + 'GRANT ALTER ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']'
	EXEC('GRANT ALTER ON SCHEMA::[' + @schema + '] TO [' + @dbrole + ']')



END
/**********************************************************************************
** CREATE DATABASE USERS & PERMISSIONS
*********************************************************************************/

DECLARE @domain VARCHAR(50) = DEFAULT_DOMAIN()
DECLARE @dbuser NVARCHAR(128)
SET @dbrole = @varAppDBRole
IF @varAuthType = 'SQL'
BEGIN
	SET @dbuser= @varAppLogin_Name -- {varAppWebLogin_Name}

	PRINT 'CREATE DATABASE USER [' + @dbuser + ']'
	IF EXISTS (SELECT name 
					FROM master.sys.server_principals
					WHERE name = @dbuser
					)
		BEGIN
			IF NOT EXISTS (SELECT name
							FROM sys.database_principals
							WHERE name = @dbuser
							AND [type_desc] = 'SQL_USER'
							)
				BEGIN
					PRINT space(5) + '    -- creating user in [' + db_name() + '] database... '
					EXEC ('CREATE USER [' + @dbuser + ']')
				END
				ELSE
					PRINT space(5) + '    -- user exists in [' + db_name() + '] database. '

				IF isnull(IS_ROLEMEMBER(@dbrole,@dbuser),0) = 0
				BEGIN
						PRINT space(5) + '    -- adding to [' + @dbrole + '] database role... '
						EXEC sp_addrolemember @dbrole, @dbuser
				END
				ELSE
						PRINT space(5) + '    -- is member of [' + @dbrole + '] database role. '

		END
		ELSE
			 PRINT space(5) + '    -- login ' + QUOTENAME(@dbuser) + ' does not exist. '

END --IF @varAuthType = 'SQL'

end

/*
Setup database for importing staging csv imports

param: Database name
create schema 'Expl' if not exist
setup user if not exist (by default use MFSQLConnect and Connector01)
setup user security 
create proc for validating table

*/
go

use CSVImport

/*------------------------------------------------------------------------------------------------
	Author: LSUSA\LeRouxC
----------------------------------------------------------------------------------------------*/

PRINT SPACE(5) + QUOTENAME(@@SERVERNAME) + '.' + QUOTENAME(DB_NAME()) + '.[expl].[ValidateTable]';

IF EXISTS (	  SELECT	1
			  FROM		[INFORMATION_SCHEMA].[ROUTINES]
			  WHERE		[ROUTINE_NAME] = 'ValidateTable' --name of procedure
						AND [ROUTINE_TYPE] = 'PROCEDURE' --for a function --'FUNCTION'
						AND [ROUTINE_SCHEMA] = 'expl'
		  )
	BEGIN
		PRINT SPACE(10) + '...Stored Procedure: update';
		SET NOEXEC ON;
	END;
ELSE PRINT SPACE(10) + '...Stored Procedure: create';
GO

-- if the routine exists this stub creation stem is parsed but not executed
CREATE PROCEDURE [expl].[ValidateTable]
AS
	SELECT	'created, but not implemented yet.';
--just anything will do

GO
-- the following section will be always executed
SET NOEXEC OFF;
GO
ALTER proc expl.ValidateTable
(@TableName nvarchar(100),@ColumnList nvarchar(1000), @Return nvarchar(100) output)
as
set nocount on 
--declare @TableName nvarchar(100),@ColumnList nvarchar(1000)
--set @TableName = 'test1'
--set @ColumnList = 'ID,Value,name'
declare @TableColumns nvarchar(1000)
declare @rcount int
declare @TableCreate as table (colnr int identity(1,1),columnname varchar(100), datatype varchar(100), ind varchar(10))
insert into @TableCreate
(
    columnname
  , datatype
  ,ind
)
select value, 'nvarchar(100)' as datatype, 'Null' as ind from string_split(@ColumnList,',') as ss
begin

if  exists(select name from sys.tables where name = @Tablename)
begin


;with cte as
(select colnr,columnname from @TableCreate as tc
except
select c.ORDINAL_POSITION,c.COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS as c where Table_name = @TableName)
, cte2 as
(select c.ORDINAL_POSITION,c.COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS as c where Table_name = @TableName except select colnr,columnname from @TableCreate as tc)
select @rcount = count(*) from 
(select * from cte
union all
select * from cte2) t

if @Rcount > 0
Begin

exec(N'Drop table expl.' + @TableName + '')

end

End

if not exists(select name from sys.tables where name = @Tablename)
begin

--prepare columns for create
select @TableColumns = stuff((select ','+ columnname + ' ' + datatype + ' ' + ind  from @TableCreate
for xml path('')),1,1,'')

exec(N'Create Table expl.'+ @Tablename + '( ' + @TableColumns + ' )');

end
end

set @return = 'Table created'

return 1

go
