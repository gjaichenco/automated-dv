SELECT @@VERSION;
GO
CREATE LOGIN [dbt_user] WITH PASSWORD=N'9L05Qk~Alb', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
GO
CREATE DATABASE DBTVAULT_DEV;
GO
USE DBTVAULT_DEV;
GO
CREATE USER [dbt_user] FOR LOGIN [dbt_user] WITH DEFAULT_SCHEMA=[dbo];
GO
USE DBTVAULT_DEV;
GO
ALTER ROLE [db_owner] ADD MEMBER [dbt_user];
GO
CREATE DATABASE DBTVAULT_TEST;
GO
USE DBTVAULT_TEST;
GO
CREATE USER [dbt_user] FOR LOGIN [dbt_user] WITH DEFAULT_SCHEMA=[dbo];
GO
USE DBTVAULT_TEST;
GO
ALTER ROLE [db_owner] ADD MEMBER [dbt_user];
GO