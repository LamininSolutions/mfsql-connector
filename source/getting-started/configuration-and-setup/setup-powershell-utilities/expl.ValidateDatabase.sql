

/****** Object:  StoredProcedure [EXPL].[ValidateTable]    Script Date: 30/11/2023 05:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER proc [EXPL].[ValidateTable]
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
GO
