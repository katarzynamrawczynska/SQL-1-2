USE [HM]
GO
/****** Object:  Table [dbo].[tbFaktury]    Script Date: 15.01.2024 16:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbFaktury](
	[IDFaktury] [int] IDENTITY(1,1) NOT NULL,
	[KlientID] [int] NULL,
	[NrFaktury] [int] NOT NULL,
	[DataSprzed] [datetime2](7) NULL,
	[TerminPlat] [datetime2](7) NULL,
	[Uregulowana] [bit] NULL,
	[Uwagi] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDFaktury] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbKlienci]    Script Date: 15.01.2024 16:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbKlienci](
	[IDKlienta] [int] IDENTITY(1,1) NOT NULL,
	[nazwa] [nvarchar](30) NOT NULL,
	[miasto] [nvarchar](30) NULL,
	[kod] [nvarchar](6) NULL,
	[ulica] [nvarchar](30) NULL,
	[NIP] [nvarchar](13) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDKlienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbPozycjeFaktur]    Script Date: 15.01.2024 16:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbPozycjeFaktur](
	[FakturaID] [int] NOT NULL,
	[TowarID] [int] NOT NULL,
	[CenaSprz] [money] NULL,
	[Ilosc] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FakturaID] ASC,
	[TowarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbTowary]    Script Date: 15.01.2024 16:17:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbTowary](
	[IDTowaru] [int] IDENTITY(1,1) NOT NULL,
	[nosnik] [nvarchar](6) NULL,
	[wykonawca] [nvarchar](30) NULL,
	[tytul] [nvarchar](30) NULL,
	[rok_wydania] [int] NULL,
	[dystrybutor] [nvarchar](30) NULL,
	[cena] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDTowaru] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbFaktury] ON 
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (1, 3, 1, CAST(N'2004-10-29T00:00:00.0000000' AS DateTime2), CAST(N'2004-11-12T00:00:00.0000000' AS DateTime2), 1, N'Pierwsza faktura')
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (2, 1, 2, CAST(N'2004-10-29T00:00:00.0000000' AS DateTime2), CAST(N'2004-11-12T00:00:00.0000000' AS DateTime2), 1, N'Faktura 2')
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (3, 4, 3, CAST(N'2004-10-31T00:00:00.0000000' AS DateTime2), CAST(N'2004-11-14T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (4, 3, 4, CAST(N'2004-11-10T00:00:00.0000000' AS DateTime2), CAST(N'2004-11-24T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (5, 2, 5, CAST(N'2004-11-30T00:00:00.0000000' AS DateTime2), CAST(N'2004-12-13T00:00:00.0000000' AS DateTime2), 1, N'Faktura 5')
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (6, 2, 6, CAST(N'2004-11-30T00:00:00.0000000' AS DateTime2), CAST(N'2004-12-13T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (7, 3, 7, CAST(N'2004-12-31T00:00:00.0000000' AS DateTime2), CAST(N'2005-01-14T00:00:00.0000000' AS DateTime2), 1, N'ostatnia')
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (8, 3, 8, CAST(N'2005-02-10T00:00:00.0000000' AS DateTime2), CAST(N'2005-02-24T00:00:00.0000000' AS DateTime2), 0, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (9, 12, 9, CAST(N'2005-02-11T00:00:00.0000000' AS DateTime2), CAST(N'2005-02-25T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (10, 20, 10, CAST(N'2005-02-12T00:00:00.0000000' AS DateTime2), CAST(N'2005-02-26T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (11, 10, 11, CAST(N'2005-02-13T00:00:00.0000000' AS DateTime2), CAST(N'2005-02-27T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (12, 18, 12, CAST(N'2005-02-14T00:00:00.0000000' AS DateTime2), CAST(N'2005-02-28T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (13, 4, 13, CAST(N'2005-02-15T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-01T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (14, 3, 14, CAST(N'2005-02-16T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-02T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (15, 14, 15, CAST(N'2005-02-22T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-08T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (16, 6, 16, CAST(N'2005-02-23T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-09T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (17, 2, 17, CAST(N'2005-02-24T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-10T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (18, 4, 18, CAST(N'2005-02-25T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-11T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (19, 3, 19, CAST(N'2005-02-26T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-12T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (20, 17, 20, CAST(N'2005-02-27T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-13T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (21, 13, 21, CAST(N'2005-02-28T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-14T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (22, 4, 22, CAST(N'2005-03-03T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-17T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (23, 12, 23, CAST(N'2005-03-04T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-18T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (24, 16, 24, CAST(N'2005-03-05T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-19T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (25, 14, 25, CAST(N'2005-03-06T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-20T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (26, 5, 26, CAST(N'2005-03-07T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-21T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (27, 14, 27, CAST(N'2005-03-08T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-22T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (28, 15, 28, CAST(N'2005-03-15T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-29T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (29, 21, 29, CAST(N'2005-03-16T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-30T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (30, 17, 30, CAST(N'2005-03-17T00:00:00.0000000' AS DateTime2), CAST(N'2005-03-31T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (31, 1, 31, CAST(N'2005-03-18T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-01T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (32, 9, 32, CAST(N'2005-03-19T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-02T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (33, 19, 33, CAST(N'2005-03-30T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-13T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (34, 3, 34, CAST(N'2005-03-31T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-14T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (35, 15, 35, CAST(N'2005-04-01T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-15T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (36, 3, 36, CAST(N'2005-04-02T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-16T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (37, 10, 37, CAST(N'2005-04-03T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-17T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (38, 10, 38, CAST(N'2005-04-04T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-18T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (39, 16, 39, CAST(N'2005-04-05T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-19T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (40, 12, 40, CAST(N'2005-04-12T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-26T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (41, 9, 41, CAST(N'2005-04-13T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-27T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (42, 1, 42, CAST(N'2005-04-14T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-28T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (43, 3, 43, CAST(N'2005-04-15T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-29T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (44, 21, 44, CAST(N'2005-04-16T00:00:00.0000000' AS DateTime2), CAST(N'2005-04-30T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (45, 10, 45, CAST(N'2005-04-17T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-01T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (46, 19, 46, CAST(N'2005-04-18T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-02T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (47, 9, 47, CAST(N'2005-04-19T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-03T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (48, 6, 48, CAST(N'2005-04-20T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-04T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (49, 14, 49, CAST(N'2005-04-21T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-05T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (50, 6, 50, CAST(N'2005-04-22T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-06T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (51, 9, 51, CAST(N'2005-04-23T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-07T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (52, 9, 52, CAST(N'2005-04-24T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-08T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (53, 6, 53, CAST(N'2005-05-04T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-18T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (54, 19, 54, CAST(N'2005-05-05T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-19T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (55, 5, 55, CAST(N'2005-05-06T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-20T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (56, 3, 56, CAST(N'2005-05-07T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-21T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (57, 2, 57, CAST(N'2005-05-08T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-22T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (58, 9, 58, CAST(N'2005-05-09T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-23T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (59, 10, 59, CAST(N'2005-05-10T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-24T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (60, 6, 60, CAST(N'2005-05-11T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-25T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (61, 5, 61, CAST(N'2005-05-12T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-26T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (62, 15, 62, CAST(N'2005-05-13T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-27T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (63, 14, 63, CAST(N'2005-05-14T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-28T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (64, 14, 64, CAST(N'2005-05-15T00:00:00.0000000' AS DateTime2), CAST(N'2005-05-29T00:00:00.0000000' AS DateTime2), 0, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (65, 16, 65, CAST(N'2005-05-27T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-10T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (66, 6, 66, CAST(N'2005-05-28T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-11T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (67, 12, 67, CAST(N'2005-05-29T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-12T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (68, 18, 68, CAST(N'2005-05-30T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-13T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (69, 10, 69, CAST(N'2005-05-31T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-14T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (70, 2, 70, CAST(N'2005-06-05T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-19T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (71, 4, 71, CAST(N'2005-06-06T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-20T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (72, 21, 72, CAST(N'2005-06-07T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-21T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (73, 5, 73, CAST(N'2005-06-08T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-22T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (74, 16, 74, CAST(N'2005-06-09T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-23T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (75, 9, 75, CAST(N'2005-06-15T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-29T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (76, 19, 76, CAST(N'2005-06-16T00:00:00.0000000' AS DateTime2), CAST(N'2005-06-30T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (77, 12, 77, CAST(N'2005-06-17T00:00:00.0000000' AS DateTime2), CAST(N'2005-07-01T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (78, 13, 78, CAST(N'2005-06-18T00:00:00.0000000' AS DateTime2), CAST(N'2005-07-02T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (79, 5, 79, CAST(N'2005-06-19T00:00:00.0000000' AS DateTime2), CAST(N'2005-07-03T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (80, 10, 80, CAST(N'2005-06-25T00:00:00.0000000' AS DateTime2), CAST(N'2005-07-09T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (81, 18, 81, CAST(N'2005-06-26T00:00:00.0000000' AS DateTime2), CAST(N'2005-07-10T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (82, 10, 82, CAST(N'2005-06-27T00:00:00.0000000' AS DateTime2), CAST(N'2005-07-11T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (83, 21, 83, CAST(N'2005-06-28T00:00:00.0000000' AS DateTime2), CAST(N'2005-07-12T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (84, 2, 84, CAST(N'2005-06-29T00:00:00.0000000' AS DateTime2), CAST(N'2005-07-13T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (85, 16, 85, CAST(N'2005-08-03T00:00:00.0000000' AS DateTime2), CAST(N'2005-08-17T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (86, 9, 86, CAST(N'2005-08-04T00:00:00.0000000' AS DateTime2), CAST(N'2005-08-18T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (87, 1, 87, CAST(N'2005-08-05T00:00:00.0000000' AS DateTime2), CAST(N'2005-08-19T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (88, 1, 88, CAST(N'2005-08-06T00:00:00.0000000' AS DateTime2), CAST(N'2005-08-20T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (89, 18, 89, CAST(N'2005-08-07T00:00:00.0000000' AS DateTime2), CAST(N'2005-08-21T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (90, 2, 90, CAST(N'2005-08-08T00:00:00.0000000' AS DateTime2), CAST(N'2005-08-22T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (91, 18, 91, CAST(N'2005-09-01T00:00:00.0000000' AS DateTime2), CAST(N'2005-09-15T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (92, 6, 92, CAST(N'2005-09-02T00:00:00.0000000' AS DateTime2), CAST(N'2005-09-16T00:00:00.0000000' AS DateTime2), 0, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (93, 18, 93, CAST(N'2005-09-03T00:00:00.0000000' AS DateTime2), CAST(N'2005-09-17T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (94, 21, 94, CAST(N'2005-09-04T00:00:00.0000000' AS DateTime2), CAST(N'2005-09-18T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (95, 5, 95, CAST(N'2005-09-07T00:00:00.0000000' AS DateTime2), CAST(N'2005-09-21T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (96, 6, 96, CAST(N'2005-09-08T00:00:00.0000000' AS DateTime2), CAST(N'2005-09-22T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (97, 21, 97, CAST(N'2005-09-09T00:00:00.0000000' AS DateTime2), CAST(N'2005-09-23T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (98, 21, 98, CAST(N'2005-09-20T00:00:00.0000000' AS DateTime2), CAST(N'2005-10-04T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (99, 9, 99, CAST(N'2005-10-01T00:00:00.0000000' AS DateTime2), CAST(N'2005-10-15T00:00:00.0000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[tbFaktury] ([IDFaktury], [KlientID], [NrFaktury], [DataSprzed], [TerminPlat], [Uregulowana], [Uwagi]) VALUES (100, 23, 100, CAST(N'2013-05-15T00:00:00.0000000' AS DateTime2), CAST(N'2013-05-29T00:00:00.0000000' AS DateTime2), 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[tbFaktury] OFF
GO
SET IDENTITY_INSERT [dbo].[tbKlienci] ON 
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (1, N'EMPiK', N'Warszawa', N'46-788', N'Chmielna 23', N'455-888-32-41')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (2, N'Klient Ósmy', N'Kraków', N'99-111', N'Krakowska 1', N'777-777-77-77')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (3, N'Sklep Muzyczny Bogdan', N'Łódź', N'90-000', N'Rojna 19', N'728-120-12-00')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (4, N'Sklepy Muzyczne Blady Pank', N'Łódź', N'90-000', N'Plac Wolności 12', N'700-500-00-00')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (5, N'Teresyn Kowalski', N'Kowalewo', N'77-777', N'Kowalska 666', N'699-944-49-94')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (6, N'Dominik Garfild', N'Gniezno', N'00-989', N'Garffielda 145', N'906-868-66-68')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (9, N'Czernik Ryszard', N'Warszawa', N'00-714', N'Bachmacka 12', N'990-000-77-83')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (10, N'Henryk Paliwoda', N'Gdynia', N'90-456', N'Gdańska 55', N'992-992-88-34')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (12, N'Jon Bon Jovi', N'Warszawa', N'02745', N'Kwiatowa 17/96', N'444-444-44-44')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (13, N'Nicolas Cage', N'Sochaczew', N'98401', N'Leśna 77/4', N'555-555-55-55')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (14, N'Gillian Anderson', N'Warszawa', N'98033', N'Floriańska 78', N'666-666-66-66')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (15, N'Janet Jackson', N'Zielonka', N'98052', N'Zacisze 7', N'777-777-77-88')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (16, N'John Malkovich', N'Otwock', N'98885', N'Poziomkowa 2', N'353-534-53-45')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (17, N'Jet Li', N'Żyrardów', N'78965', N'Al. Pokoju 47/85', N'457-457-45-67')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (18, N'Tom Hanks', N'Warszawa', N'78996', N'Miodowa 37', N'679-679-87-69')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (19, N'Andie MacDowell', N'Warszawa', N'98105', N'Zapole 47/89', N'234-242-34-24')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (20, N'Melanie Griffith', N'Warszawa', N'78991', N'Wynalazaek 78/65', N'234-534-53-46')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (21, N'Mickey Mouse', N'Warszawa', N'00950', N'Plac Defilad 1', N'543-753-38-75')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (23, N'Najnowszy', N'Radom', N'00-999', N'Warszawska', N'990-099-90-99')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (24, N'Jan Kowalski', N'Kraków', N'22-222', N'Planty 22', N'222-222-22-22')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (28, N'"Księgarnia Meloman"', N'"Poznań"', N'"60321', N'"Dąbrowskiego 5"', N'"1234563218"')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (29, N'"Audiofilska Przystań"', N'"Warszawa"', N'"00001', N'"Marszałkowska 99"', N'"9876543210"')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (30, N'"Placówka Muzyczna Echo"', N'"Kraków"', N'"30011', N'"Floriańska 16"', N'"5643211122"')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (31, N'"Gramofonik"', N'"Katowice"', N'"40082', N'"3 Maja 22"', N'"2554125565"')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (32, N'"Muzyka dla Ciebie"', N'"Gdańsk"', N'"80842', N'"Długa 88"', N'"2143658799"')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (33, N'"Dźwiękolandia"', N'"Szczecin"', N'"70001', N'"Krzywoustego 100"', N'"7779995533"')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (34, N'"Fortepian Plus"', N'"Lublin"', N'"20102', N'"Lipowa 15"', N'"3014568912"')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (35, N'"Sklep Muzyczny Takt"', N'"Rzeszów"', N'"35064', N'"3 Maja 5"', N'"6062347890"')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (36, N'"Rytm i Melodia"', N'"Olsztyn"', N'"10513', N'"Pieniężnego 12"', N'"3126549877"')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (37, N'"Gitara i Ty"', N'"Białystok"', N'"15113', N'"Kolejowa 7"', N'"4125678945"')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (38, N'', N'', N'', N'', N'')
GO
INSERT [dbo].[tbKlienci] ([IDKlienta], [nazwa], [miasto], [kod], [ulica], [NIP]) VALUES (39, N'', N'', N'', N'', N'')
GO
SET IDENTITY_INSERT [dbo].[tbKlienci] OFF
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (1, 1, 666.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (1, 2, 29.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (1, 4, 37.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (1, 5, 39.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (1, 8, 9.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (1, 10, 50.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (1, 14, 13.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (1, 17, 16.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (1, 23, 29.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (1, 47, 36.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (2, 1, 13.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (2, 7, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (2, 8, 9.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (2, 15, 15.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (2, 19, 49.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (2, 23, 29.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (2, 27, 69.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (2, 37, 47.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (2, 41, 45.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (3, 1, 13.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (3, 3, 15.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (3, 7, 45.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (3, 22, 25.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (3, 43, 24.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (3, 46, 45.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (4, 1, 13.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (4, 4, 37.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (4, 7, 45.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (4, 9, 16.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (4, 33, 59.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (4, 34, 33.5000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (4, 47, 36.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (5, 6, 46.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (5, 7, 45.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (5, 11, 45.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (5, 13, 9.5000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (5, 15, 15.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (5, 16, 17.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (5, 23, 29.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (5, 33, 59.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (5, 43, 24.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (5, 46, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (6, 6, 46.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (6, 8, 9.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (6, 11, 45.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (6, 21, 39.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (6, 28, 56.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (6, 39, 54.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (7, 1, 12.5000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (7, 3, 15.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (7, 4, 37.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (7, 5, 39.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (7, 7, 45.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (7, 9, 16.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (7, 19, 49.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (7, 30, 44.5000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (8, 8, 9.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (8, 11, 45.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (8, 28, 56.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (8, 29, 33.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (8, 34, 33.5000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (8, 36, 27.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (8, 37, 47.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (8, 38, 36.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (8, 43, 24.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (9, 2, 29.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (9, 9, 16.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (9, 10, 50.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (9, 11, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (9, 14, 13.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (9, 16, 17.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (9, 22, 25.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (9, 36, 27.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (9, 39, 54.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (10, 10, 49.5000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (10, 31, 69.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (11, 2, 29.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (11, 23, 29.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (11, 26, 29.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (11, 42, 65.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (12, 2, 29.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (12, 8, 9.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (12, 10, 49.5000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (12, 12, 46.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (12, 21, 39.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (12, 30, 44.5000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (12, 45, 33.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (12, 47, 36.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (13, 3, 15.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (13, 32, 59.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (13, 40, 39.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (13, 46, 45.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (14, 12, 46.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (14, 13, 9.5000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (14, 14, 13.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (14, 24, 49.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (14, 26, 29.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (14, 28, 56.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (14, 32, 59.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (15, 30, 44.5000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (16, 12, 46.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (16, 26, 29.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (17, 7, 45.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (17, 10, 49.5000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (17, 13, 9.5000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (17, 21, 39.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (17, 25, 49.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (18, 15, 15.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (18, 19, 49.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (18, 45, 33.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (18, 46, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (19, 21, 39.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (19, 27, 69.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (20, 9, 16.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (20, 32, 59.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (20, 40, 39.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (21, 6, 46.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (21, 22, 25.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (21, 29, 33.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (21, 43, 24.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (22, 10, 49.5000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (23, 7, 45.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (23, 12, 46.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (24, 7, 45.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (24, 22, 25.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (24, 29, 33.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (25, 8, 9.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (25, 9, 16.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (25, 20, 25.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (25, 25, 49.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (25, 28, 56.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (25, 30, 44.5000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (25, 46, 45.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (26, 23, 29.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (26, 27, 69.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (26, 34, 33.5000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (26, 39, 54.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (27, 12, 46.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (27, 20, 25.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (27, 28, 56.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (27, 30, 44.5000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (27, 32, 59.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (27, 45, 33.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (28, 6, 46.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (28, 11, 45.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (28, 20, 25.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (28, 38, 36.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (28, 46, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (29, 2, 29.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (29, 3, 15.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (29, 4, 37.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (29, 11, 45.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (29, 13, 9.5000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (29, 15, 15.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (29, 17, 16.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (29, 27, 69.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (29, 33, 59.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (29, 36, 27.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (30, 15, 15.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (30, 18, 49.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (30, 30, 44.5000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (30, 32, 59.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (30, 38, 36.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (31, 6, 46.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (31, 8, 9.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (31, 12, 46.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (31, 30, 44.5000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (32, 2, 29.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (32, 15, 15.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (32, 33, 59.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (32, 41, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (32, 43, 24.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (33, 1, 12.5000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (33, 13, 9.5000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (33, 19, 49.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (33, 31, 69.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (33, 46, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (34, 14, 13.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (34, 24, 49.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (34, 38, 36.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (34, 46, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (35, 25, 49.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (35, 26, 29.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (35, 27, 69.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (36, 16, 17.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (36, 20, 25.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (36, 44, 42.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (37, 39, 54.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (37, 45, 33.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (37, 47, 36.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (38, 11, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (38, 19, 49.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (38, 22, 25.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (38, 36, 27.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (38, 42, 65.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (39, 3, 15.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (39, 6, 46.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (39, 19, 49.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (39, 20, 25.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (39, 31, 69.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (40, 9, 16.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (40, 27, 69.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (40, 30, 44.5000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (41, 5, 39.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (41, 19, 49.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (41, 32, 59.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (41, 37, 47.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (42, 15, 15.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (42, 19, 49.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (42, 23, 29.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (42, 33, 59.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (42, 45, 33.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (43, 3, 15.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (43, 14, 13.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (43, 16, 17.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (43, 21, 39.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (43, 25, 49.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (43, 29, 33.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (43, 32, 59.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (43, 47, 36.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (44, 14, 13.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (44, 25, 49.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (44, 31, 69.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (44, 34, 33.5000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (45, 13, 9.5000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (45, 25, 49.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (45, 39, 54.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (45, 40, 39.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (45, 42, 65.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (46, 8, 9.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (46, 11, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (46, 21, 39.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (46, 29, 33.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (46, 32, 59.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (46, 35, 55.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (46, 37, 47.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (46, 41, 45.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (47, 6, 46.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (47, 12, 46.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (47, 17, 16.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (47, 21, 39.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (47, 36, 27.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (48, 7, 45.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (48, 33, 59.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (48, 36, 27.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (49, 16, 17.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (49, 19, 49.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (49, 22, 25.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (49, 26, 29.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (49, 40, 39.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (49, 46, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (50, 13, 9.5000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (50, 18, 49.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (50, 28, 56.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (50, 30, 44.5000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (51, 7, 45.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (51, 9, 16.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (51, 16, 17.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (51, 41, 45.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (51, 42, 65.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (52, 28, 56.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (53, 3, 15.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (53, 12, 46.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (53, 18, 49.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (53, 26, 29.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (53, 37, 47.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (53, 39, 54.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (53, 40, 39.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (54, 13, 9.5000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (54, 16, 17.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (54, 31, 69.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (54, 33, 59.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (54, 35, 55.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (55, 1, 12.5000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (55, 4, 37.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (55, 9, 16.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (55, 13, 9.5000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (55, 15, 15.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (55, 19, 49.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (55, 21, 39.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (55, 23, 29.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (55, 39, 54.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (55, 42, 65.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (56, 9, 16.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (56, 14, 13.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (56, 24, 49.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (56, 25, 49.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (56, 32, 59.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (56, 42, 65.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (57, 1, 12.5000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (57, 13, 9.5000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (57, 31, 69.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (57, 47, 36.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (58, 12, 46.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (58, 17, 16.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (58, 18, 49.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (58, 23, 29.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (58, 32, 59.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (59, 2, 29.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (59, 23, 29.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (59, 31, 69.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (59, 37, 47.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (59, 38, 36.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (60, 7, 45.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (60, 9, 16.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (60, 37, 47.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (61, 2, 29.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (61, 23, 29.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (62, 20, 25.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (62, 25, 49.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (62, 28, 56.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (62, 31, 69.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (62, 32, 59.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (63, 2, 29.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (63, 6, 46.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (63, 9, 16.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (63, 23, 29.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (64, 4, 37.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (64, 16, 17.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (64, 39, 54.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (64, 47, 36.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (65, 2, 29.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (65, 12, 46.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (65, 15, 15.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (65, 16, 17.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (65, 17, 16.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (65, 25, 49.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (65, 28, 56.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (65, 31, 69.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (65, 40, 39.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (65, 46, 45.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (66, 3, 15.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (66, 27, 69.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (66, 29, 33.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (67, 3, 15.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (67, 23, 29.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (67, 32, 59.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (67, 36, 27.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (68, 38, 36.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (68, 44, 42.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (69, 3, 15.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (69, 12, 46.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (69, 29, 33.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (69, 37, 47.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (70, 9, 16.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (70, 13, 9.5000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (70, 26, 29.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (70, 34, 33.5000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (70, 37, 47.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (70, 44, 42.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (71, 4, 37.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (71, 6, 46.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (71, 12, 46.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (71, 44, 42.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (72, 10, 49.5000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (72, 19, 49.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (72, 37, 47.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (72, 42, 65.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (72, 43, 24.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (73, 7, 45.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (73, 19, 49.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (73, 21, 39.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (73, 24, 49.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (73, 30, 44.5000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (73, 34, 33.5000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (74, 16, 17.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (74, 17, 16.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (74, 30, 44.5000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (74, 43, 24.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (74, 44, 42.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (75, 22, 25.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (75, 25, 49.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (76, 7, 45.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (76, 19, 49.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (76, 21, 39.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (76, 31, 69.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (76, 37, 47.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (76, 41, 45.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (76, 42, 65.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (76, 47, 36.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (77, 15, 15.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (77, 19, 49.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (77, 25, 49.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (77, 39, 54.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (78, 26, 29.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (78, 30, 44.5000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (78, 36, 27.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (79, 3, 15.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (79, 9, 16.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (79, 34, 33.5000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (79, 39, 54.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (79, 44, 42.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (80, 11, 45.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (80, 29, 33.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (80, 31, 69.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (80, 37, 47.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (80, 38, 36.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (80, 47, 36.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (81, 3, 15.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (81, 6, 46.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (81, 27, 69.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (81, 29, 33.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (81, 36, 27.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (81, 42, 65.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (81, 45, 33.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (82, 16, 17.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (82, 26, 29.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (82, 31, 69.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (82, 46, 45.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (83, 5, 39.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (83, 13, 9.5000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (84, 17, 16.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (84, 18, 49.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (84, 26, 29.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (84, 29, 33.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (84, 34, 33.5000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (85, 4, 37.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (85, 5, 39.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (85, 6, 46.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (85, 25, 49.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (85, 27, 69.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (85, 30, 44.5000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (85, 40, 39.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (85, 42, 65.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (85, 44, 42.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (85, 46, 45.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (86, 9, 16.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (86, 21, 39.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (86, 30, 44.5000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (87, 14, 13.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (87, 20, 25.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (87, 44, 42.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (88, 10, 49.5000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (88, 12, 46.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (88, 15, 15.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (88, 22, 25.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (88, 26, 29.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (88, 31, 69.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (88, 44, 42.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (89, 14, 13.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (89, 15, 15.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (89, 25, 49.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (89, 39, 54.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (89, 42, 65.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (90, 11, 45.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (90, 14, 13.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (90, 18, 49.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (90, 28, 56.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (90, 39, 54.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (91, 4, 37.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (91, 17, 16.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (91, 24, 49.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (91, 27, 69.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (92, 12, 46.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (92, 17, 16.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (92, 28, 56.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (92, 43, 24.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (93, 7, 45.0000, 8)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (93, 8, 9.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (93, 18, 49.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (93, 35, 55.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (94, 5, 39.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (94, 8, 9.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (94, 21, 39.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (94, 36, 27.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (94, 40, 39.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (94, 41, 45.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (94, 43, 24.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (95, 35, 55.0000, 2)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (95, 36, 27.0000, 9)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (95, 37, 47.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (96, 11, 45.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (96, 19, 49.0000, 5)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (96, 27, 69.0000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (96, 33, 59.0000, 7)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (97, 10, 49.5000, 4)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (97, 29, 33.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (97, 41, 45.0000, 6)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (97, 47, 36.0000, 3)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (98, 31, 69.0000, 10)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (99, 46, 45.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (100, 26, 29.0000, 1)
GO
INSERT [dbo].[tbPozycjeFaktur] ([FakturaID], [TowarID], [CenaSprz], [Ilosc]) VALUES (100, 28, 56.0000, 1)
GO
SET IDENTITY_INSERT [dbo].[tbTowary] ON 
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (1, N'Analog', N'Czerwono - Czarni', N'Zima w mieście', 1978, N'Polskie Nagrania', 12.5000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (2, N'Analog', N'ELO', N'Time', 1983, N'Sony', 29.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (3, N'Analog', N'Kunicka', N'The Best', 1990, N'Polskie Nagrania', 15.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (4, N'CD', N'ELO', N'Time', 1983, N'Sony', 37.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (5, N'CD', N'Lyroy', N'Morda zbira', 1998, N'Polygram', 39.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (6, N'CD', N'Mike Oldfield', N'Voyager', 1999, N'Warner', 46.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (7, N'CD', N'Modern Talking', N'Back for Good', 1999, N'BMG', 45.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (8, N'MC', N'Kunicka', N'The Best', 1990, N'Polskie Nagrania', 9.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (9, N'MC', N'Mike Oldfield', N'Voyager', 1998, N'Warner', 16.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (10, N'VHS', N'Sting', N'Gold', 1998, N'Polygram', 49.5000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (11, N'CD', N'Sting', N'Gold', 1998, N'Polygram', 45.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (12, N'CD', N'Vangelis', N'1492', 1997, N'Warner', 46.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (13, N'MC', N'Czerwone Gitary', N'Biały Kruk na polu', 1996, N'Sony', 9.5000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (14, N'MC', N'ELO', N'Time', 1983, N'Sony', 13.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (15, N'MC', N'Modern Talking', N'Back for Good', 1999, N'BMG', 15.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (16, N'MC', N'Sting', N'Gold', 1998, N'Polygram', 17.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (17, N'MC', N'Vangelis', N'1492', 1997, N'Warner', 16.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (18, N'VHS', N'Modern Talking', N'Back for Good', 1999, N'BMG', 49.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (19, N'CD', N'Bryan Ferry', N'As Time Goes By', 1999, N'EMI', 49.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (20, N'CD', N'Łona', N'Koniec żartów', 2001, N'Sony', 25.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (21, N'VHS', N'Carreras Domingo Pavarotti', N'in concert Mehta', 1990, N'EMI', 39.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (22, N'DVD', N'PINK FLOYD', N'Live at Pompei', 1972, N'Polygram', 25.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (23, N'VHS', N'Sting', N'Ten Summoner''s Tales', 1998, N'Polygram', 29.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (24, N'CD', N'Carreras Domingo Pavarotti', N'in concert Mehta', 1990, N'EMI', 49.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (25, N'CD', N'Sting', N'Ten Summoner''s Tales', 1998, N'Polygram', 49.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (26, N'DVD', N'Doors', N'Doors', 1991, N'Warner', 29.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (27, N'DVD', N'David Bowie', N'best of bowie', 2002, N'EMI', 69.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (28, N'DVD', N'AC/DC', N'No Bull', 1996, N'Warner', 56.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (29, N'VHS', N'Simply Red', N'A Starry Night With', 1992, N'Warner', 33.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (30, N'DVD', N'Prince', N'Purple Rain', 1999, N'Warner', 44.5000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (31, N'DVD', N'U2', N'Rattle and Hum', 1988, N'Polygram', 69.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (32, N'CD', N'U2', N'Rattle and Hum', 1988, N'Polygram', 59.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (33, N'CD', N'U2', N'The Joshua Tree', 1987, N'Polygram', 59.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (34, N'CD', N'Prince', N'Purple Rain', 1999, N'Warner', 33.5000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (35, N'CD', N'Leonard Cohen', N'Dear Heather', 2004, N'BMG', 55.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (36, N'CD', N'Lech Janerka', N'Plagiaty', 2005, N'Sony', 27.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (37, N'CD', N'QUEEN', N'Innuendo', 1991, N'EMI', 47.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (38, N'CD', N'Led Zeppelin', N'I', 1994, N'Warner', 36.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (39, N'CD', N'Iron Maiden', N'I', 1998, N'EMI', 54.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (40, N'CD', N'Journey', N'Escape', 1981, N'Sony', 39.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (41, N'CD', N'Rolling Stones', N'Bridges to Babylon', 1997, N'EMI', 45.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (42, N'DVD', N'Rolling Stones', N'Bridges to Babylon', 1997, N'EMI', 65.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (43, N'CD', N'Reni Jusis', N'Zakręcona', 1998, N'EMI', 24.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (44, N'CD', N'The Pretenders', N'Greatest Hits', 2000, N'Warner', 42.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (45, N'CD', N'Alison Moyet', N'Singles', 1995, N'Sony', 33.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (46, N'CD', N'Jean Michel Jarre', N'Metamorphoses', 2000, N'Sony', 45.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (47, N'CD', N'Edyta Bartosiewicz', N'Dziś są moje urodziny', 1999, N'Polygram', 36.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (48, N'DVD', N'ABBA', N'The Definitive Collection', 2002, N'Polygram', 59.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (49, N'DVD', N'Kylie Minogue', N'Ultimate Kylie', 2004, N'Polygram', 65.0000)
GO
INSERT [dbo].[tbTowary] ([IDTowaru], [nosnik], [wykonawca], [tytul], [rok_wydania], [dystrybutor], [cena]) VALUES (50, N'DVD', N'George Michael', N'Twenty Five', 2006, N'Sony', 99.0000)
GO
SET IDENTITY_INSERT [dbo].[tbTowary] OFF
GO
ALTER TABLE [dbo].[tbFaktury] ADD  DEFAULT ((0)) FOR [KlientID]
GO
ALTER TABLE [dbo].[tbFaktury] ADD  DEFAULT (N'=Date()') FOR [DataSprzed]
GO
ALTER TABLE [dbo].[tbFaktury] ADD  DEFAULT (N'=Date()+14') FOR [TerminPlat]
GO
ALTER TABLE [dbo].[tbTowary] ADD  DEFAULT ((0)) FOR [rok_wydania]
GO
ALTER TABLE [dbo].[tbFaktury]  WITH CHECK ADD  CONSTRAINT [FK_tbFaktury_tbKlienci] FOREIGN KEY([KlientID])
REFERENCES [dbo].[tbKlienci] ([IDKlienta])
GO
ALTER TABLE [dbo].[tbFaktury] CHECK CONSTRAINT [FK_tbFaktury_tbKlienci]
GO
ALTER TABLE [dbo].[tbPozycjeFaktur]  WITH CHECK ADD  CONSTRAINT [FK_tbPozycjeFaktur_tbFaktury1] FOREIGN KEY([FakturaID])
REFERENCES [dbo].[tbFaktury] ([IDFaktury])
GO
ALTER TABLE [dbo].[tbPozycjeFaktur] CHECK CONSTRAINT [FK_tbPozycjeFaktur_tbFaktury1]
GO
ALTER TABLE [dbo].[tbPozycjeFaktur]  WITH CHECK ADD  CONSTRAINT [FK_tbPozycjeFaktur_tbTowary] FOREIGN KEY([TowarID])
REFERENCES [dbo].[tbTowary] ([IDTowaru])
GO
ALTER TABLE [dbo].[tbPozycjeFaktur] CHECK CONSTRAINT [FK_tbPozycjeFaktur_tbTowary]
GO
