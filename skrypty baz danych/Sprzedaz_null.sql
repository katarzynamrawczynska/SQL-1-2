USE [BS]
GO
/****** Object:  Table [dbo].[tblSprzedaz2]    Script Date: 29.01.2024 14:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblSprzedaz2](
	[ID_Sprzedaz] [int] IDENTITY(1,1) NOT NULL,
	[Klient_ID] [int] NOT NULL,
	[DataSprzedazy] [datetime2](0) NOT NULL,
	[Pracownik_ID] [int] , -- NOT NULL,
 CONSTRAINT [tblSprzedaz2$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID_Sprzedaz] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblSprzedaz2] ON 
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (1, 3, CAST(N'2015-09-15T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (2, 9, CAST(N'2013-12-10T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (3, 23, CAST(N'2016-10-28T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (4, 16, CAST(N'2014-06-16T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (5, 12, CAST(N'2014-07-22T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (6, 17, CAST(N'2016-02-24T00:00:00.0000000' AS DateTime2), NULL)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (7, 21, CAST(N'2014-01-03T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (8, 10, CAST(N'2013-05-08T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (9, 20, CAST(N'2014-09-01T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (10, 3, CAST(N'2017-01-15T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (11, 1, CAST(N'2012-02-01T00:00:00.0000000' AS DateTime2), NULL)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (12, 23, CAST(N'2013-11-16T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (13, 19, CAST(N'2015-03-04T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (14, 12, CAST(N'2012-05-06T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (15, 15, CAST(N'2014-09-16T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (16, 19, CAST(N'2017-03-06T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (17, 13, CAST(N'2014-09-07T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (18, 22, CAST(N'2012-10-10T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (19, 11, CAST(N'2012-02-08T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (20, 14, CAST(N'2013-07-15T00:00:00.0000000' AS DateTime2), NULL)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (21, 11, CAST(N'2013-08-14T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (22, 16, CAST(N'2013-09-27T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (23, 8, CAST(N'2014-04-06T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (24, 23, CAST(N'2012-11-22T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (25, 16, CAST(N'2016-04-24T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (26, 23, CAST(N'2015-08-01T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (27, 16, CAST(N'2015-01-20T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (28, 4, CAST(N'2016-10-11T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (29, 10, CAST(N'2014-07-21T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (30, 23, CAST(N'2012-01-15T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (31, 23, CAST(N'2016-06-22T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (32, 18, CAST(N'2014-02-11T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (33, 17, CAST(N'2014-05-19T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (34, 2, CAST(N'2012-12-09T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (35, 12, CAST(N'2014-06-13T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (36, 11, CAST(N'2012-02-05T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (37, 11, CAST(N'2013-02-09T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (38, 17, CAST(N'2012-09-30T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (39, 20, CAST(N'2012-02-02T00:00:00.0000000' AS DateTime2), NULL)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (40, 12, CAST(N'2016-05-23T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (41, 22, CAST(N'2014-05-07T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (42, 16, CAST(N'2013-10-16T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (43, 17, CAST(N'2013-09-25T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (44, 13, CAST(N'2012-05-11T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (45, 21, CAST(N'2016-06-27T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (46, 21, CAST(N'2013-05-01T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (47, 7, CAST(N'2017-03-19T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (48, 22, CAST(N'2014-11-15T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (49, 3, CAST(N'2012-11-08T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (50, 21, CAST(N'2016-02-26T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (51, 7, CAST(N'2017-07-15T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (52, 9, CAST(N'2017-05-01T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (53, 5, CAST(N'2017-01-30T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (54, 10, CAST(N'2016-03-22T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (55, 3, CAST(N'2016-11-11T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (56, 16, CAST(N'2012-12-21T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (57, 17, CAST(N'2016-08-14T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (58, 22, CAST(N'2014-09-27T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (59, 23, CAST(N'2012-07-12T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (60, 8, CAST(N'2014-03-31T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (61, 20, CAST(N'2013-04-03T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (62, 18, CAST(N'2015-09-11T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (63, 9, CAST(N'2013-11-29T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (64, 23, CAST(N'2017-04-11T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (65, 5, CAST(N'2013-04-21T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (66, 23, CAST(N'2014-03-06T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (67, 1, CAST(N'2017-08-21T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (68, 1, CAST(N'2016-11-29T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (69, 17, CAST(N'2015-01-02T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (70, 5, CAST(N'2012-02-06T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (71, 1, CAST(N'2015-04-12T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (72, 17, CAST(N'2012-01-23T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (73, 7, CAST(N'2014-10-11T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (74, 8, CAST(N'2013-07-30T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (75, 15, CAST(N'2015-04-14T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (76, 22, CAST(N'2012-09-13T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (77, 2, CAST(N'2016-08-15T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (78, 7, CAST(N'2016-04-21T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (79, 6, CAST(N'2012-11-22T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (80, 12, CAST(N'2013-04-10T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (81, 6, CAST(N'2014-05-02T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (82, 9, CAST(N'2016-07-03T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (83, 23, CAST(N'2013-08-25T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (84, 6, CAST(N'2016-12-14T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (85, 13, CAST(N'2016-02-16T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (86, 4, CAST(N'2015-11-09T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (87, 5, CAST(N'2017-08-27T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (88, 13, CAST(N'2015-01-27T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (89, 2, CAST(N'2015-02-20T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (90, 16, CAST(N'2016-03-01T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (91, 4, CAST(N'2014-09-03T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (92, 8, CAST(N'2012-06-26T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (93, 11, CAST(N'2013-11-24T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (94, 15, CAST(N'2017-02-03T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (95, 2, CAST(N'2015-05-20T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (96, 4, CAST(N'2015-01-04T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (97, 7, CAST(N'2015-03-31T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (98, 9, CAST(N'2017-06-04T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (99, 11, CAST(N'2015-01-10T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (100, 18, CAST(N'2012-06-04T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (101, 13, CAST(N'2015-12-20T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (102, 12, CAST(N'2016-02-15T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (103, 17, CAST(N'2015-07-08T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (104, 6, CAST(N'2017-04-21T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (105, 16, CAST(N'2014-08-20T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (106, 14, CAST(N'2017-09-02T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (107, 15, CAST(N'2017-09-04T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (108, 8, CAST(N'2013-09-02T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (109, 11, CAST(N'2012-03-12T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (110, 10, CAST(N'2017-04-19T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (111, 1, CAST(N'2016-06-23T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (112, 20, CAST(N'2013-04-04T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (113, 17, CAST(N'2013-08-14T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (114, 17, CAST(N'2016-08-12T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (115, 20, CAST(N'2012-10-17T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (116, 3, CAST(N'2012-03-20T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (117, 18, CAST(N'2015-04-23T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (118, 10, CAST(N'2015-08-01T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (119, 9, CAST(N'2017-05-26T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (120, 22, CAST(N'2012-12-24T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (121, 20, CAST(N'2013-09-04T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (122, 9, CAST(N'2013-10-30T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (123, 20, CAST(N'2016-11-13T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (124, 11, CAST(N'2016-07-20T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (125, 4, CAST(N'2013-04-19T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (126, 6, CAST(N'2014-04-28T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (127, 8, CAST(N'2014-06-02T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (128, 14, CAST(N'2012-10-25T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (129, 7, CAST(N'2013-03-11T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (130, 4, CAST(N'2014-11-17T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (131, 2, CAST(N'2014-12-19T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (132, 1, CAST(N'2014-03-04T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (133, 12, CAST(N'2012-02-25T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (134, 16, CAST(N'2014-03-23T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (135, 18, CAST(N'2012-10-04T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (136, 10, CAST(N'2012-07-14T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (137, 16, CAST(N'2014-05-12T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (138, 13, CAST(N'2017-07-06T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (139, 21, CAST(N'2013-05-31T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (140, 2, CAST(N'2012-12-14T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (141, 16, CAST(N'2013-05-30T00:00:00.0000000' AS DateTime2), NULL)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (142, 18, CAST(N'2016-08-18T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (143, 7, CAST(N'2012-07-31T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz2] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (144, 18, CAST(N'2016-01-04T00:00:00.0000000' AS DateTime2), 4)
GO
SET IDENTITY_INSERT [dbo].[tblSprzedaz2] OFF
GO
ALTER TABLE [dbo].[tblSprzedaz2] ADD  DEFAULT ((0)) FOR [Klient_ID]
GO
ALTER TABLE [dbo].[tblSprzedaz2] ADD  DEFAULT ((0)) FOR [Pracownik_ID]
GO
ALTER TABLE [dbo].[tblSprzedaz2]  WITH NOCHECK ADD  CONSTRAINT [tblSprzedaz$tblKliencitblSprzedaz] FOREIGN KEY([Klient_ID])
REFERENCES [dbo].[tblKlienci] ([ID_Klient])
GO
ALTER TABLE [dbo].[tblSprzedaz2] CHECK CONSTRAINT [tblSprzedaz$tblKliencitblSprzedaz]
GO
ALTER TABLE [dbo].[tblSprzedaz2]  WITH NOCHECK ADD  CONSTRAINT [tblSprzedaz$tblPracownicytblSprzedaz] FOREIGN KEY([Pracownik_ID])
REFERENCES [dbo].[tblPracownicy] ([IDPracownika])
GO
ALTER TABLE [dbo].[tblSprzedaz2] CHECK CONSTRAINT [tblSprzedaz$tblPracownicytblSprzedaz]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz2].[ID_Sprzedaz]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'COLUMN',@level2name=N'ID_Sprzedaz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz2].[Klient_ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'COLUMN',@level2name=N'Klient_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz2].[DataSprzedazy]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'COLUMN',@level2name=N'DataSprzedazy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz2].[Pracownik_ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'COLUMN',@level2name=N'Pracownik_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz2].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'CONSTRAINT',@level2name=N'tblSprzedaz$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz2]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz2].[tblKliencitblSprzedaz]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'CONSTRAINT',@level2name=N'tblSprzedaz$tblKliencitblSprzedaz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz2].[tblPracownicytblSprzedaz]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'CONSTRAINT',@level2name=N'tblSprzedaz$tblPracownicytblSprzedaz'
GO
