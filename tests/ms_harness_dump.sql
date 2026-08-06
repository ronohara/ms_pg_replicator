USE [master]
GO
/****** Object:  Database [ms_ref_harness]    Script Date: 06/08/2026 08:03:03 ******/
CREATE DATABASE [ms_ref_harness]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ms_ref_harness', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ms_ref_harness.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ms_ref_harness_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ms_ref_harness_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ms_ref_harness].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ms_ref_harness] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ms_ref_harness] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ms_ref_harness] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ms_ref_harness] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ms_ref_harness] SET ARITHABORT OFF 
GO
ALTER DATABASE [ms_ref_harness] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ms_ref_harness] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ms_ref_harness] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ms_ref_harness] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ms_ref_harness] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ms_ref_harness] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ms_ref_harness] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ms_ref_harness] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ms_ref_harness] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ms_ref_harness] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ms_ref_harness] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ms_ref_harness] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ms_ref_harness] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ms_ref_harness] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ms_ref_harness] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ms_ref_harness] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ms_ref_harness] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ms_ref_harness] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ms_ref_harness] SET  MULTI_USER 
GO
ALTER DATABASE [ms_ref_harness] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ms_ref_harness] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ms_ref_harness] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ms_ref_harness] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ms_ref_harness] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ms_ref_harness] SET QUERY_STORE = OFF
GO
USE [ms_ref_harness]
GO
ALTER DATABASE SCOPED CONFIGURATION SET ACCELERATED_PLAN_FORCING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ADAPTIVE_JOINS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DEFERRED_COMPILATION_TV = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_ONLINE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_RESUMABLE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET GLOBAL_TEMPORARY_TABLE_AUTO_DROP = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET INTERLEAVED_EXECUTION_TVF = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ISOLATE_SECURITY_POLICY_CARDINALITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LAST_QUERY_PLAN_STATS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ROW_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET TSQL_SCALAR_UDF_INLINING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET VERBOSE_TRUNCATION_WARNINGS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_PROCEDURE_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_QUERY_EXECUTION_STATISTICS = OFF;
GO
USE [ms_ref_harness]
GO
/****** Object:  Table [dbo].[boolean_types]    Script Date: 06/08/2026 08:03:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[boolean_types](
	[id] [bigint] NULL,
	[row_label] [nvarchar](50) NULL,
	[col_bool] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[currency_types]    Script Date: 06/08/2026 08:03:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[currency_types](
	[id] [bigint] NULL,
	[row_label] [nvarchar](50) NULL,
	[col_currency] [decimal](19, 4) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[datetime_types]    Script Date: 06/08/2026 08:03:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[datetime_types](
	[id] [bigint] NULL,
	[row_label] [nvarchar](50) NULL,
	[col_date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[decimal_types]    Script Date: 06/08/2026 08:03:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[decimal_types](
	[id] [bigint] NULL,
	[row_label] [nvarchar](50) NULL,
	[col_currency] [decimal](19, 4) NULL,
	[col_dec_0] [decimal](19, 4) NULL,
	[col_dec_2] [decimal](19, 4) NULL,
	[col_dec_6] [decimal](19, 4) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[float_types]    Script Date: 06/08/2026 08:03:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[float_types](
	[id] [bigint] NULL,
	[row_label] [nvarchar](50) NULL,
	[col_single] [float] NULL,
	[col_double] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[guid_types]    Script Date: 06/08/2026 08:03:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[guid_types](
	[id] [bigint] NULL,
	[row_label] [nvarchar](50) NULL,
	[col_guid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[integer_types]    Script Date: 06/08/2026 08:03:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[integer_types](
	[id] [bigint] NULL,
	[row_label] [nvarchar](50) NULL,
	[col_byte] [smallint] NULL,
	[col_int] [int] NULL,
	[col_long] [bigint] NULL,
	[col_bigint] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[text_types]    Script Date: 06/08/2026 08:03:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_types](
	[id] [bigint] NULL,
	[row_label] [nvarchar](50) NULL,
	[col_text_50] [nvarchar](50) NULL,
	[col_memo] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[boolean_types] ([id], [row_label], [col_bool]) VALUES (1, N'TRUE', 1)
INSERT [dbo].[boolean_types] ([id], [row_label], [col_bool]) VALUES (2, N'FALSE', 0)
INSERT [dbo].[boolean_types] ([id], [row_label], [col_bool]) VALUES (3, N'NULL', 0)
INSERT [dbo].[currency_types] ([id], [row_label], [col_currency]) VALUES (1, N'zero', CAST(0.0000 AS Decimal(19, 4)))
INSERT [dbo].[currency_types] ([id], [row_label], [col_currency]) VALUES (2, N'positive', CAST(12345.6789 AS Decimal(19, 4)))
INSERT [dbo].[currency_types] ([id], [row_label], [col_currency]) VALUES (3, N'negative', CAST(-99.9900 AS Decimal(19, 4)))
INSERT [dbo].[currency_types] ([id], [row_label], [col_currency]) VALUES (4, N'NULL', NULL)
INSERT [dbo].[datetime_types] ([id], [row_label], [col_date]) VALUES (1, N'2026-01-15', CAST(N'2026-01-15T12:00:00.000' AS DateTime))
INSERT [dbo].[datetime_types] ([id], [row_label], [col_date]) VALUES (2, N'epoch', CAST(N'1899-12-30T00:00:00.000' AS DateTime))
INSERT [dbo].[datetime_types] ([id], [row_label], [col_date]) VALUES (3, N'NULL', NULL)
INSERT [dbo].[decimal_types] ([id], [row_label], [col_currency], [col_dec_0], [col_dec_2], [col_dec_6]) VALUES (1, N'zero', CAST(0.0000 AS Decimal(19, 4)), CAST(0.0000 AS Decimal(19, 4)), CAST(0.0000 AS Decimal(19, 4)), CAST(0.0000 AS Decimal(19, 4)))
INSERT [dbo].[decimal_types] ([id], [row_label], [col_currency], [col_dec_0], [col_dec_2], [col_dec_6]) VALUES (2, N'positive', CAST(12345.6789 AS Decimal(19, 4)), CAST(42.0000 AS Decimal(19, 4)), CAST(123.4500 AS Decimal(19, 4)), CAST(0.1235 AS Decimal(19, 4)))
INSERT [dbo].[decimal_types] ([id], [row_label], [col_currency], [col_dec_0], [col_dec_2], [col_dec_6]) VALUES (3, N'negative s0', NULL, CAST(-7.0000 AS Decimal(19, 4)), NULL, NULL)
INSERT [dbo].[decimal_types] ([id], [row_label], [col_currency], [col_dec_0], [col_dec_2], [col_dec_6]) VALUES (4, N'negative s2', NULL, NULL, CAST(-99.9900 AS Decimal(19, 4)), NULL)
INSERT [dbo].[decimal_types] ([id], [row_label], [col_currency], [col_dec_0], [col_dec_2], [col_dec_6]) VALUES (5, N'negative s6', NULL, NULL, NULL, CAST(0.0000 AS Decimal(19, 4)))
INSERT [dbo].[decimal_types] ([id], [row_label], [col_currency], [col_dec_0], [col_dec_2], [col_dec_6]) VALUES (6, N'negative currency', CAST(-99.9900 AS Decimal(19, 4)), NULL, NULL, NULL)
INSERT [dbo].[decimal_types] ([id], [row_label], [col_currency], [col_dec_0], [col_dec_2], [col_dec_6]) VALUES (7, N'scale=6 small', NULL, NULL, NULL, CAST(1.0000 AS Decimal(19, 4)))
INSERT [dbo].[decimal_types] ([id], [row_label], [col_currency], [col_dec_0], [col_dec_2], [col_dec_6]) VALUES (8, N'NULL', NULL, NULL, NULL, NULL)
INSERT [dbo].[float_types] ([id], [row_label], [col_single], [col_double]) VALUES (1, N'zero', 0, 0)
INSERT [dbo].[float_types] ([id], [row_label], [col_single], [col_double]) VALUES (2, N'pi', 3.1415901184082031, 3.14159265358979)
INSERT [dbo].[float_types] ([id], [row_label], [col_single], [col_double]) VALUES (3, N'negative', -0.0001500000071246177, 0)
INSERT [dbo].[float_types] ([id], [row_label], [col_single], [col_double]) VALUES (4, N'NULL', NULL, NULL)
INSERT [dbo].[guid_types] ([id], [row_label], [col_guid]) VALUES (1, N'guid1', N'12345678-abcd-ef01-2345-6789abcdef01')
INSERT [dbo].[guid_types] ([id], [row_label], [col_guid]) VALUES (2, N'zero', N'00000000-0000-0000-0000-000000000000')
INSERT [dbo].[guid_types] ([id], [row_label], [col_guid]) VALUES (3, N'NULL', NULL)
INSERT [dbo].[integer_types] ([id], [row_label], [col_byte], [col_int], [col_long], [col_bigint]) VALUES (1, N'zero', 0, 0, 0, 0)
INSERT [dbo].[integer_types] ([id], [row_label], [col_byte], [col_int], [col_long], [col_bigint]) VALUES (2, N'positive typical', 128, 32767, 2147483647, 9223372036854775807)
INSERT [dbo].[integer_types] ([id], [row_label], [col_byte], [col_int], [col_long], [col_bigint]) VALUES (3, N'negative', NULL, -32768, -2147483648, -9223372036854775808)
INSERT [dbo].[integer_types] ([id], [row_label], [col_byte], [col_int], [col_long], [col_bigint]) VALUES (4, N'NULL', NULL, NULL, NULL, NULL)
INSERT [dbo].[text_types] ([id], [row_label], [col_text_50], [col_memo]) VALUES (1, N'empty', N'', N'')
INSERT [dbo].[text_types] ([id], [row_label], [col_text_50], [col_memo]) VALUES (2, N'hello', N'Hello World', N'Long memo text')
INSERT [dbo].[text_types] ([id], [row_label], [col_text_50], [col_memo]) VALUES (3, N'NULL', NULL, NULL)
USE [master]
GO
ALTER DATABASE [ms_ref_harness] SET  READ_WRITE 
GO
