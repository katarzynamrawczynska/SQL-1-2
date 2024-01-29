USE [BS]
GO
/****** Object:  Table [dbo].[tblKategorie]    Script Date: 22.01.2024 09:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKategorie](
	[ID_Kategoria] [int] IDENTITY(1,1) NOT NULL,
	[NazwaKategorii] [nvarchar](20) NOT NULL,
 CONSTRAINT [tblKategorie$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID_Kategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblKlienci]    Script Date: 22.01.2024 09:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKlienci](
	[ID_Klient] [int] IDENTITY(1,1) NOT NULL,
	[KodKlienta] [nvarchar](5) NOT NULL,
	[NazwaFirmy] [nvarchar](40) NOT NULL,
	[NIP] [nvarchar](13) NOT NULL,
	[Telefon] [nvarchar](14) NULL,
	[TelefonKomorkowy] [nvarchar](10) NULL,
	[Ulica] [nvarchar](25) NOT NULL,
	[Kod] [nvarchar](6) NULL,
	[Miasto] [nvarchar](20) NOT NULL,
	[Aktywny] [bit] NOT NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [tblKlienci$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID_Klient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOpisSprzedazy]    Script Date: 22.01.2024 09:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOpisSprzedazy](
	[ID_OpisSprzedazy] [int] IDENTITY(1,1) NOT NULL,
	[Sprzedaz_ID] [int] NULL,
	[Towar_ID] [int] NULL,
	[Ilosc] [real] NOT NULL,
	[CenaSprzedazy] [money] NOT NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [tblOpisSprzedazy$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID_OpisSprzedazy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPracownicy]    Script Date: 22.01.2024 09:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPracownicy](
	[IDPracownika] [int] IDENTITY(1,1) NOT NULL,
	[Imie] [nvarchar](10) NOT NULL,
	[Nazwisko] [nvarchar](20) NOT NULL,
	[Stanowisko] [nvarchar](40) NULL,
	[Adres] [nvarchar](60) NOT NULL,
	[Miasto] [nvarchar](15) NOT NULL,
	[KodPocztowy] [nvarchar](6) NULL,
 CONSTRAINT [tblPracownicy$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[IDPracownika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSprzedaz]    Script Date: 22.01.2024 09:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSprzedaz](
	[ID_Sprzedaz] [int] IDENTITY(1,1) NOT NULL,
	[Klient_ID] [int] NOT NULL,
	[DataSprzedazy] [datetime2](0) NOT NULL,
	[Pracownik_ID] [int] NOT NULL,
 CONSTRAINT [tblSprzedaz$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID_Sprzedaz] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTowary]    Script Date: 22.01.2024 09:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTowary](
	[ID_Towar] [int] IDENTITY(1,1) NOT NULL,
	[Kategoria_ID] [int] NOT NULL,
	[NazwaTowaru] [nvarchar](30) NOT NULL,
	[Cena_Katalogowa] [money] NOT NULL,
 CONSTRAINT [tblTowary$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID_Towar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblKategorie] ON 
GO
INSERT [dbo].[tblKategorie] ([ID_Kategoria], [NazwaKategorii]) VALUES (1, N'Napoje')
GO
INSERT [dbo].[tblKategorie] ([ID_Kategoria], [NazwaKategorii]) VALUES (2, N'Alkohole')
GO
INSERT [dbo].[tblKategorie] ([ID_Kategoria], [NazwaKategorii]) VALUES (3, N'Piwo')
GO
INSERT [dbo].[tblKategorie] ([ID_Kategoria], [NazwaKategorii]) VALUES (4, N'Słodycze')
GO
INSERT [dbo].[tblKategorie] ([ID_Kategoria], [NazwaKategorii]) VALUES (5, N'Owoce')
GO
INSERT [dbo].[tblKategorie] ([ID_Kategoria], [NazwaKategorii]) VALUES (6, N'Mleczne przetwory')
GO
INSERT [dbo].[tblKategorie] ([ID_Kategoria], [NazwaKategorii]) VALUES (7, N'Zbożowe przetwory')
GO
INSERT [dbo].[tblKategorie] ([ID_Kategoria], [NazwaKategorii]) VALUES (8, N'Pieczywo')
GO
SET IDENTITY_INSERT [dbo].[tblKategorie] OFF
GO
SET IDENTITY_INSERT [dbo].[tblKlienci] ON 
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (1, N'AK', N'ALOJZY KOWALCZUK', N'458-859-68-64', N'445568907', N'0501987344', N'Obrońców 47/87', N'01-147', N'BIAŁYSTOK', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (2, N'AL', N'ALLADYN SP Z o.o.', N'789-596-99-62', N'228906754', N'0501666666', N'BAJKOWA 7', N'78-959', N'WARSZAWA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (3, N'BR', N'NATALEX -  IMPORT-EXPORT BOJAR ROBERT', N'789-658-35-63', N'123459056', N'0601222345', N'POWSTAŃCÓW 26', N'05-220', N'ZIELONKA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (4, N'CG', N'CHACIŃSKA GABRIELA', N'425-879-85-22', N'123469811', N'603343454', N'ZAKRĘT 115A', N'03-789', N'ZIELONKA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (5, N'CR', N'CHACIŃSKI RYSZARD', N'142-578-41-24', N'223335609', N'605332111', N'GROCHOWSKA 261 m10', N'05-285', N'WARSZAWA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (6, N'D', N'DAMIS', N'254-524-52-43', N'123456768', NULL, N'GROCHOWSKA 14', N'01-589', N'ZIELONKA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (7, N'DZ', N'ŻUK-POL', N'145-932-55-62', N'228696045', NULL, N'TARGOWA 12', N'03-731', N'WARSZAWA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (8, N'ELENA', N'ELENA-PRES', N'487-858-69-63', N'443434545', NULL, N'DZIENNIKARSKA 12/85', N'00-950', N'BIAŁYSTOK', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (9, N'IRA', N'IRLANDZKIE ROWERY AUTOMATYCZNE S.A', N'145-878-56-62', N'143333333', NULL, N'DYWERSYJNA 78', N'78-955', N'ZIELONKA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (10, N'KF', N'KRAK&FIK KANCELARIA PRAWNICZA', N'478-789-87-84', N'558-22-78', NULL, N' KANTU 78', N'78-959', N'WARSZAWA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (11, N'LAA', N'MIASTO ANIOŁÓW S.A.', N'789-685-96-62', N'228606045', NULL, N'Stępińska 36', N'78-965', N'WARSZAWA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (12, N'LF', N'LIF-TEX LIPIŃSKI FRANCISZEK', N'124-323-65-54', N'456678888', NULL, N'PL. HALLERA 4', N'08-450', N'BIAŁYSTOK', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (13, N'LLA', N'LEKSUX S.A.', N'112-787-99-54', N'45 777788', NULL, N'KAPUCYŃSKA 6/9', N'77-878', N'KATOWICE', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (14, N'LR', N'LIPIŃSKI ROBERT', N'789-855-55-54', N'222223309', NULL, N'MAJDAŃSKA 5/8', N'04-088', N'WARSZAWA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (15, N'MSZ', N'MSZCZONÓW', N'256-525-45-55', N'567890909', NULL, N'DWORCOWA 34', N'14-589', N'MSZCZONÓW', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (16, N'NINIW', N'NIRWANA - WYDAWNICTWO ODLOTOWE', N'789-568-95-44', N'99-99-66', NULL, N'MARYSI 666/666', N'78-785', N'WARSZAWA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (17, N'OPIO', N'Firma S.A', N'212-252-15-44', N'23 454545', NULL, N'Klonowa 47', N'47-855', N'CIECHOCINEK', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (18, N'PD', N'POLDEX', N'789-598-65-93', N'423344576', NULL, N'POGODNA 47', N'78-965', N'KATOWICE', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (19, N'R', N'ROBEX', N'789-698-62-74', N'424675868', NULL, N'JANA PADLINY 78/87', N'78-965', N'KATOWICE', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (20, N'RC', N'ROSA CELINA', N'215-452-14-53', N'223434343', NULL, N'MAKOWSKA 5 a', N'04-208', N'WARSZAWA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (21, N'SA', N'ŚWIDOWSKI ANDRZEJ', N'215-587-88-74', N'76 767667', NULL, N'ARMII KRAJOWEJ 91 m2', N'05-075', N'WESOŁA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (22, N'SOS', N'SOSNOWSKA', N'478-789-54-54', N'227890197', NULL, N'KONDRATOWICZA 14/41', N'05-789', N'WARSZAWA', 1)
GO
INSERT [dbo].[tblKlienci] ([ID_Klient], [KodKlienta], [NazwaFirmy], [NIP], [Telefon], [TelefonKomorkowy], [Ulica], [Kod], [Miasto], [Aktywny]) VALUES (23, N'SZ', N'SZWED ZENON', N'788-885-85-88', N'226333333', NULL, N'OSIEDLOWA', N'78-996', N'WARSZAWA', 1)
GO
SET IDENTITY_INSERT [dbo].[tblKlienci] OFF
GO
SET IDENTITY_INSERT [dbo].[tblOpisSprzedazy] ON 
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (1, 22, 16, 10, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (2, 58, 32, 10, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (3, 112, 13, 10, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (4, 54, 4, 10, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (5, 71, 23, 10, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (6, 139, 15, 1, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (7, 43, 6, 10, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (8, 42, 19, 2, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (9, 104, 3, 5, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (10, 11, 24, 1, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (11, 136, 3, 4, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (12, 141, 10, 1, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (13, 117, 19, 1, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (14, 26, 21, 4, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (15, 5, 17, 6, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (16, 138, 12, 10, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (17, 108, 18, 15, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (18, 30, 30, 6, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (19, 114, 27, 2, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (20, 49, 18, 4, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (21, 28, 35, 15, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (22, 131, 24, 3, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (23, 95, 9, 6, 8.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (24, 19, 1, 15, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (25, 24, 7, 14, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (26, 3, 19, 16, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (27, 37, 19, 20, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (28, 35, 33, 10, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (29, 121, 13, 20, 14.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (30, 65, 8, 10, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (31, 4, 24, 10, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (32, 74, 34, 40, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (33, 21, 7, 30, 14.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (34, 21, 6, 10, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (35, 67, 35, 2, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (36, 90, 29, 20, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (37, 19, 3, 14, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (38, 54, 33, 21, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (39, 48, 3, 2, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (40, 18, 16, 27, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (41, 57, 15, 10, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (42, 14, 28, 5, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (43, 57, 35, 46, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (44, 32, 16, 10, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (45, 106, 22, 20, 8.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (46, 29, 32, 6, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (47, 45, 34, 1, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (48, 100, 26, 78, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (49, 18, 15, 30, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (50, 64, 1, 7, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (51, 11, 21, 42, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (52, 60, 20, 12, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (53, 44, 5, 2, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (54, 52, 7, 1, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (55, 116, 29, 2, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (56, 104, 16, 5, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (57, 81, 21, 2, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (58, 114, 13, 9, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (59, 19, 1, 6, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (60, 8, 21, 2, 10.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (61, 103, 16, 2, 14.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (62, 120, 33, 2, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (63, 68, 21, 3, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (64, 2, 35, 8, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (65, 108, 14, 2, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (66, 13, 5, 2, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (67, 71, 4, 3, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (68, 37, 2, 1, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (69, 3, 34, 3, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (70, 15, 28, 4, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (71, 115, 10, 5, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (72, 144, 27, 2, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (73, 1, 26, 18, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (74, 93, 11, 6, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (75, 29, 19, 3, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (76, 122, 11, 6, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (77, 54, 31, 1, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (78, 76, 31, 4, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (79, 92, 5, 3, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (80, 88, 32, 9, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (81, 121, 31, 1, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (82, 45, 14, 1, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (83, 126, 16, 6, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (84, 102, 14, 5, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (85, 13, 10, 1, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (86, 122, 7, 2, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (87, 75, 33, 3, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (88, 42, 29, 2, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (89, 69, 7, 4, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (90, 65, 28, 5, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (91, 19, 14, 16, 14.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (92, 67, 25, 1, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (93, 124, 22, 5, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (94, 53, 5, 2, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (95, 144, 30, 2, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (96, 111, 2, 5, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (97, 49, 20, 3, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (98, 99, 21, 5, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (99, 16, 30, 2, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (100, 102, 21, 1, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (101, 12, 35, 1, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (102, 76, 27, 1, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (103, 137, 3, 5, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (104, 81, 8, 3, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (105, 101, 8, 30, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (106, 142, 25, 40, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (107, 42, 1, 1, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (108, 49, 2, 2, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (109, 7, 24, 1, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (110, 127, 11, 1, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (111, 26, 18, 3, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (112, 23, 20, 3, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (113, 135, 15, 16, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (114, 17, 6, 1, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (115, 18, 10, 5, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (116, 70, 4, 3, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (117, 100, 7, 3, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (118, 28, 32, 8, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (119, 73, 7, 3, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (120, 116, 9, 4, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (121, 63, 14, 1, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (122, 127, 5, 1, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (123, 19, 34, 3, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (124, 111, 30, 30, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (125, 42, 20, 1, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (126, 52, 34, 10, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (127, 93, 19, 15, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (128, 96, 11, 2, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (129, 70, 4, 8, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (130, 77, 22, 16, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (131, 20, 21, 18, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (132, 23, 18, 4, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (133, 82, 15, 6, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (134, 107, 27, 16, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (135, 133, 1, 2, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (136, 94, 2, 1, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (137, 45, 1, 7, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (138, 82, 35, 5, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (139, 43, 7, 2, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (140, 47, 24, 10, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (141, 78, 15, 2, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (142, 65, 11, 3, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (143, 113, 20, 1, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (144, 95, 15, 2, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (145, 43, 34, 2, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (146, 11, 9, 10, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (147, 136, 24, 12, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (148, 41, 19, 7, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (149, 140, 11, 2, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (150, 100, 21, 1, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (151, 102, 11, 2, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (152, 129, 10, 4, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (153, 17, 10, 17, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (154, 137, 22, 2, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (155, 72, 14, 3, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (156, 44, 16, 1, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (157, 5, 26, 2, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (158, 32, 6, 2, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (159, 134, 8, 7, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (160, 92, 21, 1, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (161, 23, 23, 4, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (162, 3, 34, 1, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (163, 60, 17, 3, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (164, 53, 11, 2, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (165, 61, 16, 2, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (166, 48, 16, 2, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (167, 111, 4, 2, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (168, 98, 35, 16, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (169, 14, 29, 12, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (170, 75, 28, 1, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (171, 109, 21, 20, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (172, 24, 15, 15, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (173, 75, 4, 14, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (174, 113, 19, 3, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (175, 97, 24, 2, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (176, 97, 25, 41, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (177, 131, 3, 18, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (178, 125, 24, 41, 10.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (179, 130, 30, 2, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (180, 123, 35, 2, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (181, 92, 3, 1, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (182, 118, 25, 8, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (183, 70, 24, 6, 8.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (184, 66, 28, 13, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (185, 88, 31, 8, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (186, 83, 2, 12, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (187, 98, 1, 7, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (188, 105, 22, 11, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (189, 101, 20, 3, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (190, 98, 35, 15, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (191, 45, 31, 9, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (192, 134, 15, 17, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (193, 8, 31, 50, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (194, 94, 31, 21, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (195, 42, 2, 13, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (196, 18, 8, 2, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (197, 92, 2, 13, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (198, 84, 23, 14, 8.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (199, 6, 8, 27, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (200, 67, 2, 6, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (201, 137, 17, 9, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (202, 84, 1, 8, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (203, 114, 25, 2, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (204, 131, 29, 6, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (205, 127, 20, 11, 10.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (206, 97, 12, 1, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (207, 19, 22, 7, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (208, 29, 22, 5, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (209, 118, 4, 1, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (210, 116, 29, 2, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (211, 43, 35, 1, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (212, 27, 1, 6, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (213, 8, 11, 14, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (214, 118, 19, 4, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (215, 100, 14, 15, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (216, 128, 16, 21, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (217, 2, 5, 4, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (218, 58, 28, 15, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (219, 53, 2, 3, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (220, 13, 12, 4, 8.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (221, 113, 35, 4, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (222, 17, 30, 15, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (223, 62, 19, 6, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (224, 5, 5, 7, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (225, 45, 25, 29, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (226, 55, 8, 5, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (227, 112, 20, 3, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (228, 128, 22, 3, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (229, 65, 2, 10, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (230, 33, 1, 23, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (231, 76, 1, 4, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (232, 31, 30, 5, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (233, 45, 19, 17, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (234, 90, 20, 11, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (235, 62, 32, 7, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (236, 24, 5, 1, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (237, 74, 20, 1, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (238, 57, 11, 4, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (239, 6, 22, 3, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (240, 1, 5, 1, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (241, 63, 14, 12, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (242, 104, 28, 1, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (243, 37, 29, 2, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (244, 127, 5, 3, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (245, 17, 17, 1, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (246, 45, 1, 3, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (247, 2, 27, 5, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (248, 127, 15, 15, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (249, 115, 35, 15, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (250, 114, 28, 15, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (251, 128, 3, 14, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (252, 39, 27, 15, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (253, 106, 32, 10, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (254, 11, 33, 20, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (255, 130, 16, 20, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (256, 1, 10, 10, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (257, 108, 12, 20, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (258, 28, 22, 28, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (259, 18, 17, 40, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (260, 105, 34, 27, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (261, 87, 20, 22, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (262, 30, 11, 7, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (263, 61, 21, 4, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (264, 15, 25, 16, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (265, 93, 13, 15, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (266, 41, 33, 14, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (267, 125, 17, 20, 8.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (268, 47, 1, 30, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (269, 102, 1, 158, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (270, 20, 17, 236, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (271, 55, 30, 163, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (272, 80, 4, 54, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (273, 107, 12, 160, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (274, 76, 32, 29, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (275, 138, 8, 28, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (276, 83, 33, 33, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (277, 53, 24, 90, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (278, 130, 13, 61, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (279, 135, 24, 50, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (280, 23, 32, 4, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (281, 116, 13, 4, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (282, 41, 6, 4, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (283, 116, 31, 4, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (284, 97, 19, 4, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (285, 70, 1, 5, 8.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (286, 47, 7, 2, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (287, 60, 33, 1, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (288, 144, 3, 4, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (289, 59, 3, 4, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (290, 99, 17, 3, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (291, 121, 14, 2, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (292, 25, 16, 2, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (293, 77, 11, 1, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (294, 142, 19, 6, 8.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (295, 95, 4, 2, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (296, 16, 13, 22, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (297, 97, 26, 3, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (298, 25, 23, 3, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (299, 6, 23, 30, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (300, 113, 19, 10, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (301, 30, 21, 4, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (302, 107, 27, 2, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (303, 9, 29, 33, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (304, 24, 20, 5, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (305, 128, 22, 4, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (306, 51, 5, 10, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (307, 97, 13, 4, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (308, 23, 13, 4, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (309, 73, 31, 18, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (310, 103, 27, 29, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (311, 74, 24, 6, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (312, 3, 18, 7, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (313, 15, 6, 7, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (314, 137, 4, 4, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (315, 143, 31, 3, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (316, 99, 12, 11, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (317, 59, 28, 2, 22.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (318, 10, 27, 2, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (319, 60, 6, 2, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (320, 125, 1, 1, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (321, 9, 8, 1, 8.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (322, 78, 32, 1, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (323, 134, 31, 5, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (324, 142, 7, 6, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (325, 98, 11, 4, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (326, 94, 25, 2, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (327, 27, 30, 4, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (328, 135, 34, 4, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (329, 113, 35, 44, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (330, 111, 33, 62, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (331, 86, 10, 33, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (332, 2, 25, 25, 10.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (333, 113, 9, 1, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (334, 87, 18, 8, 17.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (335, 87, 35, 9, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (336, 13, 27, 20, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (337, 8, 34, 10, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (338, 78, 19, 5, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (339, 11, 31, 3, 11.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (340, 34, 26, 3, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (341, 37, 13, 13, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (342, 111, 17, 4, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (343, 27, 16, 2, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (344, 55, 33, 16, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (345, 132, 21, 3, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (346, 17, 20, 4, 29.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (347, 131, 30, 14, 21.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (348, 91, 24, 4, 12.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (349, 7, 4, 4, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (350, 92, 11, 1, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (351, 132, 13, 5, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (352, 110, 11, 5, 50.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (353, 48, 1, 1, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (354, 43, 12, 1, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (355, 52, 18, 1, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (356, 107, 14, 5, 5.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (357, 55, 21, 4, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (358, 136, 12, 3, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (359, 22, 20, 10, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (360, 3, 27, 4, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (361, 131, 16, 3, 28.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (362, 31, 24, 2, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (363, 71, 31, 1, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (364, 68, 11, 1, 20.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (365, 77, 3, 2, 32.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (366, 94, 34, 1, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (367, 126, 35, 2, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (368, 123, 19, 1, 16.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (369, 105, 29, 5, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (370, 144, 5, 3, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (371, 67, 34, 5, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (372, 119, 20, 43, 14.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (373, 39, 34, 3, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (374, 81, 20, 3, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (375, 62, 23, 2, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (376, 132, 28, 3, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (377, 111, 35, 3, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (378, 143, 30, 8, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (379, 46, 30, 3, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (380, 41, 12, 5, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (381, 52, 21, 8, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (382, 143, 4, 1, 23.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (383, 125, 22, 4, 7.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (384, 72, 30, 4, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (385, 14, 17, 6, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (386, 85, 19, 30, 4.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (387, 18, 26, 13, 8.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (388, 55, 11, 5, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (389, 39, 9, 3, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (390, 96, 9, 25, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (391, 101, 19, 5, 41.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (392, 113, 2, 4, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (393, 44, 27, 4, 14.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (394, 83, 28, 4, 6.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (395, 23, 2, 5, 41.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (396, 123, 30, 5, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (397, 123, 31, 4, 36.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (398, 120, 6, 4, 3.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (399, 19, 32, 15, 25.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (400, 62, 12, 1, 15.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (401, 139, 22, 4, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (402, 57, 27, 5, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (403, 39, 18, 10, 30.0000)
GO
INSERT [dbo].[tblOpisSprzedazy] ([ID_OpisSprzedazy], [Sprzedaz_ID], [Towar_ID], [Ilosc], [CenaSprzedazy]) VALUES (404, 78, 13, 3, 54.0000)
GO
SET IDENTITY_INSERT [dbo].[tblOpisSprzedazy] OFF
GO
SET IDENTITY_INSERT [dbo].[tblPracownicy] ON 
GO
INSERT [dbo].[tblPracownicy] ([IDPracownika], [Imie], [Nazwisko], [Stanowisko], [Adres], [Miasto], [KodPocztowy]) VALUES (1, N'Joanna', N'Kowalska', N'Asystent handlowy', N'ul. Kwiatowa 17/96', N'Warszawa', N'78945')
GO
INSERT [dbo].[tblPracownicy] ([IDPracownika], [Imie], [Nazwisko], [Stanowisko], [Adres], [Miasto], [KodPocztowy]) VALUES (2, N'Andrzej', N'Fuller', N'Wiceprezes ds. sprzedaży', N'ul. Leśna 77/4', N'Sochaczew', N'98401')
GO
INSERT [dbo].[tblPracownicy] ([IDPracownika], [Imie], [Nazwisko], [Stanowisko], [Adres], [Miasto], [KodPocztowy]) VALUES (3, N'Joanna', N'Nowak', N'Przedstawiciel handlowy', N'ul.Floriańska 78', N'Warszawa', N'98033')
GO
INSERT [dbo].[tblPracownicy] ([IDPracownika], [Imie], [Nazwisko], [Stanowisko], [Adres], [Miasto], [KodPocztowy]) VALUES (4, N'Małgorzata', N'Pazura', N'Przedstawiciel handlowy', N'ul.Zacisze 7', N'Warszawa', N'98052')
GO
INSERT [dbo].[tblPracownicy] ([IDPracownika], [Imie], [Nazwisko], [Stanowisko], [Adres], [Miasto], [KodPocztowy]) VALUES (5, N'Stanisław', N'Buchanan', N'Dyrektor ds. sprzedaży', N'ul. Poziomkowa', N'Warszawa', N'98885')
GO
INSERT [dbo].[tblPracownicy] ([IDPracownika], [Imie], [Nazwisko], [Stanowisko], [Adres], [Miasto], [KodPocztowy]) VALUES (6, N'Michał', N'Sum', N'Przedstawiciel handlowy', N'Al. Pokoju 47/855', N'Warszawa', N'78965')
GO
INSERT [dbo].[tblPracownicy] ([IDPracownika], [Imie], [Nazwisko], [Stanowisko], [Adres], [Miasto], [KodPocztowy]) VALUES (7, N'Robert', N'King', N'Przedstawiciel handlowy', N'ul. Miodowa', N'Warszawa', N'78996')
GO
INSERT [dbo].[tblPracownicy] ([IDPracownika], [Imie], [Nazwisko], [Stanowisko], [Adres], [Miasto], [KodPocztowy]) VALUES (8, N'Laura', N'WIŚNIEWSKA', N'Koordynator sprzedaży wewnętrznej', N'ul. Zapole 47/899', N'Warszawa', N'98105')
GO
INSERT [dbo].[tblPracownicy] ([IDPracownika], [Imie], [Nazwisko], [Stanowisko], [Adres], [Miasto], [KodPocztowy]) VALUES (9, N'Anna', N'Donat', N'Przedstawiciel handlowy', N'ul. Wynalazaek 78-9/65', N'Warszawa', N'78991')
GO
INSERT [dbo].[tblPracownicy] ([IDPracownika], [Imie], [Nazwisko], [Stanowisko], [Adres], [Miasto], [KodPocztowy]) VALUES (10, N'Henryk', N'Piecuch', N'Przedstawiciel handlowy', N'ul. Ciepła 32/8', N'Warszawa', N'78999')
GO
SET IDENTITY_INSERT [dbo].[tblPracownicy] OFF
GO
SET IDENTITY_INSERT [dbo].[tblSprzedaz] ON 
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (1, 3, CAST(N'2015-09-15T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (2, 9, CAST(N'2013-12-10T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (3, 23, CAST(N'2016-10-28T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (4, 16, CAST(N'2014-06-16T00:00:00.0000000' AS DateTime2), 2)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (5, 12, CAST(N'2014-07-22T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (6, 17, CAST(N'2016-02-24T00:00:00.0000000' AS DateTime2), 2)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (7, 21, CAST(N'2014-01-03T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (8, 10, CAST(N'2013-05-08T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (9, 20, CAST(N'2014-09-01T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (10, 3, CAST(N'2017-01-15T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (11, 1, CAST(N'2012-02-01T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (12, 23, CAST(N'2013-11-16T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (13, 19, CAST(N'2015-03-04T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (14, 12, CAST(N'2012-05-06T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (15, 15, CAST(N'2014-09-16T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (16, 19, CAST(N'2017-03-06T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (17, 13, CAST(N'2014-09-07T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (18, 22, CAST(N'2012-10-10T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (19, 11, CAST(N'2012-02-08T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (20, 14, CAST(N'2013-07-15T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (21, 11, CAST(N'2013-08-14T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (22, 16, CAST(N'2013-09-27T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (23, 8, CAST(N'2014-04-06T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (24, 23, CAST(N'2012-11-22T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (25, 16, CAST(N'2016-04-24T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (26, 23, CAST(N'2015-08-01T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (27, 16, CAST(N'2015-01-20T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (28, 4, CAST(N'2016-10-11T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (29, 10, CAST(N'2014-07-21T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (30, 23, CAST(N'2012-01-15T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (31, 23, CAST(N'2016-06-22T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (32, 18, CAST(N'2014-02-11T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (33, 17, CAST(N'2014-05-19T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (34, 2, CAST(N'2012-12-09T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (35, 12, CAST(N'2014-06-13T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (36, 11, CAST(N'2012-02-05T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (37, 11, CAST(N'2013-02-09T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (38, 17, CAST(N'2012-09-30T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (39, 20, CAST(N'2012-02-02T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (40, 12, CAST(N'2016-05-23T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (41, 22, CAST(N'2014-05-07T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (42, 16, CAST(N'2013-10-16T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (43, 17, CAST(N'2013-09-25T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (44, 13, CAST(N'2012-05-11T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (45, 21, CAST(N'2016-06-27T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (46, 21, CAST(N'2013-05-01T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (47, 7, CAST(N'2017-03-19T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (48, 22, CAST(N'2014-11-15T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (49, 3, CAST(N'2012-11-08T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (50, 21, CAST(N'2016-02-26T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (51, 7, CAST(N'2017-07-15T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (52, 9, CAST(N'2017-05-01T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (53, 5, CAST(N'2017-01-30T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (54, 10, CAST(N'2016-03-22T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (55, 3, CAST(N'2016-11-11T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (56, 16, CAST(N'2012-12-21T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (57, 17, CAST(N'2016-08-14T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (58, 22, CAST(N'2014-09-27T00:00:00.0000000' AS DateTime2), 2)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (59, 23, CAST(N'2012-07-12T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (60, 8, CAST(N'2014-03-31T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (61, 20, CAST(N'2013-04-03T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (62, 18, CAST(N'2015-09-11T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (63, 9, CAST(N'2013-11-29T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (64, 23, CAST(N'2017-04-11T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (65, 5, CAST(N'2013-04-21T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (66, 23, CAST(N'2014-03-06T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (67, 1, CAST(N'2017-08-21T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (68, 1, CAST(N'2016-11-29T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (69, 17, CAST(N'2015-01-02T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (70, 5, CAST(N'2012-02-06T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (71, 1, CAST(N'2015-04-12T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (72, 17, CAST(N'2012-01-23T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (73, 7, CAST(N'2014-10-11T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (74, 8, CAST(N'2013-07-30T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (75, 15, CAST(N'2015-04-14T00:00:00.0000000' AS DateTime2), 2)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (76, 22, CAST(N'2012-09-13T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (77, 2, CAST(N'2016-08-15T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (78, 7, CAST(N'2016-04-21T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (79, 6, CAST(N'2012-11-22T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (80, 12, CAST(N'2013-04-10T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (81, 6, CAST(N'2014-05-02T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (82, 9, CAST(N'2016-07-03T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (83, 23, CAST(N'2013-08-25T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (84, 6, CAST(N'2016-12-14T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (85, 13, CAST(N'2016-02-16T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (86, 4, CAST(N'2015-11-09T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (87, 5, CAST(N'2017-08-27T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (88, 13, CAST(N'2015-01-27T00:00:00.0000000' AS DateTime2), 2)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (89, 2, CAST(N'2015-02-20T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (90, 16, CAST(N'2016-03-01T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (91, 4, CAST(N'2014-09-03T00:00:00.0000000' AS DateTime2), 2)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (92, 8, CAST(N'2012-06-26T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (93, 11, CAST(N'2013-11-24T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (94, 15, CAST(N'2017-02-03T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (95, 2, CAST(N'2015-05-20T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (96, 4, CAST(N'2015-01-04T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (97, 7, CAST(N'2015-03-31T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (98, 9, CAST(N'2017-06-04T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (99, 11, CAST(N'2015-01-10T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (100, 18, CAST(N'2012-06-04T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (101, 13, CAST(N'2015-12-20T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (102, 12, CAST(N'2016-02-15T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (103, 17, CAST(N'2015-07-08T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (104, 6, CAST(N'2017-04-21T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (105, 16, CAST(N'2014-08-20T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (106, 14, CAST(N'2017-09-02T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (107, 15, CAST(N'2017-09-04T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (108, 8, CAST(N'2013-09-02T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (109, 11, CAST(N'2012-03-12T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (110, 10, CAST(N'2017-04-19T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (111, 1, CAST(N'2016-06-23T00:00:00.0000000' AS DateTime2), 2)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (112, 20, CAST(N'2013-04-04T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (113, 17, CAST(N'2013-08-14T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (114, 17, CAST(N'2016-08-12T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (115, 20, CAST(N'2012-10-17T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (116, 3, CAST(N'2012-03-20T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (117, 18, CAST(N'2015-04-23T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (118, 10, CAST(N'2015-08-01T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (119, 9, CAST(N'2017-05-26T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (120, 22, CAST(N'2012-12-24T00:00:00.0000000' AS DateTime2), 8)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (121, 20, CAST(N'2013-09-04T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (122, 9, CAST(N'2013-10-30T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (123, 20, CAST(N'2016-11-13T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (124, 11, CAST(N'2016-07-20T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (125, 4, CAST(N'2013-04-19T00:00:00.0000000' AS DateTime2), 10)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (126, 6, CAST(N'2014-04-28T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (127, 8, CAST(N'2014-06-02T00:00:00.0000000' AS DateTime2), 2)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (128, 14, CAST(N'2012-10-25T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (129, 7, CAST(N'2013-03-11T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (130, 4, CAST(N'2014-11-17T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (131, 2, CAST(N'2014-12-19T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (132, 1, CAST(N'2014-03-04T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (133, 12, CAST(N'2012-02-25T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (134, 16, CAST(N'2014-03-23T00:00:00.0000000' AS DateTime2), 7)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (135, 18, CAST(N'2012-10-04T00:00:00.0000000' AS DateTime2), 2)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (136, 10, CAST(N'2012-07-14T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (137, 16, CAST(N'2014-05-12T00:00:00.0000000' AS DateTime2), 5)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (138, 13, CAST(N'2017-07-06T00:00:00.0000000' AS DateTime2), 6)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (139, 21, CAST(N'2013-05-31T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (140, 2, CAST(N'2012-12-14T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (141, 16, CAST(N'2013-05-30T00:00:00.0000000' AS DateTime2), 9)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (142, 18, CAST(N'2016-08-18T00:00:00.0000000' AS DateTime2), 4)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (143, 7, CAST(N'2012-07-31T00:00:00.0000000' AS DateTime2), 3)
GO
INSERT [dbo].[tblSprzedaz] ([ID_Sprzedaz], [Klient_ID], [DataSprzedazy], [Pracownik_ID]) VALUES (144, 18, CAST(N'2016-01-04T00:00:00.0000000' AS DateTime2), 4)
GO
SET IDENTITY_INSERT [dbo].[tblSprzedaz] OFF
GO
SET IDENTITY_INSERT [dbo].[tblTowary] ON 
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (1, 2, N'  Wódka "Polonez"', 29.9520)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (2, 2, N'Wódka "Wyborowa"', 36.0960)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (3, 6, N'Jogurt ananasowy', 5.7600)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (4, 6, N'Jogurt gruszkowy', 5.9520)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (5, 6, N'Kefir naturalny', 4.2240)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (6, 6, N'Mleko "Łaciate"', 7.2960)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (7, 6, N'Mleko "Sielska dolina"', 8.1664)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (8, 6, N'Bryndza', 15.9360)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (9, 6, N'Ser "Morski"', 17.0240)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (10, 1, N'7UP', 4.4800)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (11, 1, N'Fanta', 4.3520)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (12, 1, N'Oranżada', 2.8160)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (13, 1, N'Sok marchwiowy', 6.0160)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (14, 1, N'Sok pomarańczowy', 11.0720)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (15, 1, N'Sok pomidorowy', 11.9040)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (16, 1, N'Woda "Nałęczowianka"', 3.0080)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (17, 1, N'Woda "Zdrój"', 3.3280)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (18, 5, N'   Banany', 24.9600)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (19, 5, N'Cytryny', 28.6720)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (20, 5, N'Gruszki', 20.6080)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (21, 5, N'Jabłka', 22.1952)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (22, 5, N'Kiwi', 14.5280)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (23, 5, N'Nektarynki', 23.4240)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (24, 5, N'Winogrona', 28.5440)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (25, 3, N'  Bosman', 5.7600)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (26, 3, N'Warka', 5.9520)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (27, 3, N'Żywiec', 6.6560)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (28, 4, N'Cistka"Kokosanki"', 10.6880)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (29, 4, N'Ciastka "Sezamkowe"', 11.9040)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (30, 4, N'Czekolada "Fantazja"', 15.8720)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (31, 4, N'Czekolada "Juibleuszowa"', 21.1200)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (32, 7, N'Makaron nitki', 9.7920)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (33, 7, N'Płatki kukurydziane', 15.9360)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (34, 7, N'Płatki owsiane', 17.3440)
GO
INSERT [dbo].[tblTowary] ([ID_Towar], [Kategoria_ID], [NazwaTowaru], [Cena_Katalogowa]) VALUES (35, 7, N'Płatki ryżowe', 14.3360)
GO
SET IDENTITY_INSERT [dbo].[tblTowary] OFF
GO
ALTER TABLE [dbo].[tblKlienci] ADD  DEFAULT ('WARSZAWA') FOR [Miasto]
GO
ALTER TABLE [dbo].[tblKlienci] ADD  DEFAULT ((1)) FOR [Aktywny]
GO
ALTER TABLE [dbo].[tblSprzedaz] ADD  DEFAULT ((0)) FOR [Klient_ID]
GO
ALTER TABLE [dbo].[tblSprzedaz] ADD  DEFAULT ((0)) FOR [Pracownik_ID]
GO
ALTER TABLE [dbo].[tblOpisSprzedazy]  WITH NOCHECK ADD  CONSTRAINT [tblOpisSprzedazy$tblSprzedaztblOpisSprzedazy] FOREIGN KEY([Sprzedaz_ID])
REFERENCES [dbo].[tblSprzedaz] ([ID_Sprzedaz])
GO
ALTER TABLE [dbo].[tblOpisSprzedazy] CHECK CONSTRAINT [tblOpisSprzedazy$tblSprzedaztblOpisSprzedazy]
GO
ALTER TABLE [dbo].[tblOpisSprzedazy]  WITH NOCHECK ADD  CONSTRAINT [tblOpisSprzedazy$tblTowarytblOpisSprzedazy] FOREIGN KEY([Towar_ID])
REFERENCES [dbo].[tblTowary] ([ID_Towar])
GO
ALTER TABLE [dbo].[tblOpisSprzedazy] CHECK CONSTRAINT [tblOpisSprzedazy$tblTowarytblOpisSprzedazy]
GO
ALTER TABLE [dbo].[tblSprzedaz]  WITH NOCHECK ADD  CONSTRAINT [tblSprzedaz$tblKliencitblSprzedaz] FOREIGN KEY([Klient_ID])
REFERENCES [dbo].[tblKlienci] ([ID_Klient])
GO
ALTER TABLE [dbo].[tblSprzedaz] CHECK CONSTRAINT [tblSprzedaz$tblKliencitblSprzedaz]
GO
ALTER TABLE [dbo].[tblSprzedaz]  WITH NOCHECK ADD  CONSTRAINT [tblSprzedaz$tblPracownicytblSprzedaz] FOREIGN KEY([Pracownik_ID])
REFERENCES [dbo].[tblPracownicy] ([IDPracownika])
GO
ALTER TABLE [dbo].[tblSprzedaz] CHECK CONSTRAINT [tblSprzedaz$tblPracownicytblSprzedaz]
GO
ALTER TABLE [dbo].[tblTowary]  WITH NOCHECK ADD  CONSTRAINT [tblTowary$tblKategorietblTowary] FOREIGN KEY([Kategoria_ID])
REFERENCES [dbo].[tblKategorie] ([ID_Kategoria])
GO
ALTER TABLE [dbo].[tblTowary] CHECK CONSTRAINT [tblTowary$tblKategorietblTowary]
GO
ALTER TABLE [dbo].[tblKategorie]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblKategorie$NazwaKategorii$disallow_zero_length] CHECK  ((len([NazwaKategorii])>(0)))
GO
ALTER TABLE [dbo].[tblKategorie] CHECK CONSTRAINT [SSMA_CC$tblKategorie$NazwaKategorii$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblKlienci]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblKlienci$Kod$disallow_zero_length] CHECK  ((len([Kod])>(0)))
GO
ALTER TABLE [dbo].[tblKlienci] CHECK CONSTRAINT [SSMA_CC$tblKlienci$Kod$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblKlienci]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblKlienci$KodKlienta$disallow_zero_length] CHECK  ((len([KodKlienta])>(0)))
GO
ALTER TABLE [dbo].[tblKlienci] CHECK CONSTRAINT [SSMA_CC$tblKlienci$KodKlienta$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblKlienci]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblKlienci$Miasto$disallow_zero_length] CHECK  ((len([Miasto])>(0)))
GO
ALTER TABLE [dbo].[tblKlienci] CHECK CONSTRAINT [SSMA_CC$tblKlienci$Miasto$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblKlienci]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblKlienci$NazwaFirmy$disallow_zero_length] CHECK  ((len([NazwaFirmy])>(0)))
GO
ALTER TABLE [dbo].[tblKlienci] CHECK CONSTRAINT [SSMA_CC$tblKlienci$NazwaFirmy$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblKlienci]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblKlienci$NIP$disallow_zero_length] CHECK  ((len([NIP])>(0)))
GO
ALTER TABLE [dbo].[tblKlienci] CHECK CONSTRAINT [SSMA_CC$tblKlienci$NIP$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblKlienci]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblKlienci$Telefon$disallow_zero_length] CHECK  ((len([Telefon])>(0)))
GO
ALTER TABLE [dbo].[tblKlienci] CHECK CONSTRAINT [SSMA_CC$tblKlienci$Telefon$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblKlienci]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblKlienci$TelefonKomorkowy$disallow_zero_length] CHECK  ((len([TelefonKomorkowy])>(0)))
GO
ALTER TABLE [dbo].[tblKlienci] CHECK CONSTRAINT [SSMA_CC$tblKlienci$TelefonKomorkowy$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblKlienci]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblKlienci$Ulica$disallow_zero_length] CHECK  ((len([Ulica])>(0)))
GO
ALTER TABLE [dbo].[tblKlienci] CHECK CONSTRAINT [SSMA_CC$tblKlienci$Ulica$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblPracownicy]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblPracownicy$Adres$disallow_zero_length] CHECK  ((len([Adres])>(0)))
GO
ALTER TABLE [dbo].[tblPracownicy] CHECK CONSTRAINT [SSMA_CC$tblPracownicy$Adres$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblPracownicy]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblPracownicy$Imie$disallow_zero_length] CHECK  ((len([Imie])>(0)))
GO
ALTER TABLE [dbo].[tblPracownicy] CHECK CONSTRAINT [SSMA_CC$tblPracownicy$Imie$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblPracownicy]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblPracownicy$KodPocztowy$disallow_zero_length] CHECK  ((len([KodPocztowy])>(0)))
GO
ALTER TABLE [dbo].[tblPracownicy] CHECK CONSTRAINT [SSMA_CC$tblPracownicy$KodPocztowy$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblPracownicy]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblPracownicy$Miasto$disallow_zero_length] CHECK  ((len([Miasto])>(0)))
GO
ALTER TABLE [dbo].[tblPracownicy] CHECK CONSTRAINT [SSMA_CC$tblPracownicy$Miasto$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblPracownicy]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblPracownicy$Nazwisko$disallow_zero_length] CHECK  ((len([Nazwisko])>(0)))
GO
ALTER TABLE [dbo].[tblPracownicy] CHECK CONSTRAINT [SSMA_CC$tblPracownicy$Nazwisko$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblPracownicy]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblPracownicy$Stanowisko$disallow_zero_length] CHECK  ((len([Stanowisko])>(0)))
GO
ALTER TABLE [dbo].[tblPracownicy] CHECK CONSTRAINT [SSMA_CC$tblPracownicy$Stanowisko$disallow_zero_length]
GO
ALTER TABLE [dbo].[tblTowary]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$tblTowary$NazwaTowaru$disallow_zero_length] CHECK  ((len([NazwaTowaru])>(0)))
GO
ALTER TABLE [dbo].[tblTowary] CHECK CONSTRAINT [SSMA_CC$tblTowary$NazwaTowaru$disallow_zero_length]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKategorie].[ID_Kategoria]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKategorie', @level2type=N'COLUMN',@level2name=N'ID_Kategoria'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKategorie].[NazwaKategorii]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKategorie', @level2type=N'COLUMN',@level2name=N'NazwaKategorii'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKategorie].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKategorie', @level2type=N'CONSTRAINT',@level2name=N'tblKategorie$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKategorie]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKategorie'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci].[ID_Klient]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci', @level2type=N'COLUMN',@level2name=N'ID_Klient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci].[KodKlienta]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci', @level2type=N'COLUMN',@level2name=N'KodKlienta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci].[NazwaFirmy]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci', @level2type=N'COLUMN',@level2name=N'NazwaFirmy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci].[NIP]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci', @level2type=N'COLUMN',@level2name=N'NIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci].[Telefon]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci', @level2type=N'COLUMN',@level2name=N'Telefon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci].[TelefonKomorkowy]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci', @level2type=N'COLUMN',@level2name=N'TelefonKomorkowy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci].[Ulica]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci', @level2type=N'COLUMN',@level2name=N'Ulica'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci].[Kod]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci', @level2type=N'COLUMN',@level2name=N'Kod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci].[Miasto]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci', @level2type=N'COLUMN',@level2name=N'Miasto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci].[Aktywny]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci', @level2type=N'COLUMN',@level2name=N'Aktywny'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci', @level2type=N'CONSTRAINT',@level2name=N'tblKlienci$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblKlienci]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblKlienci'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblOpisSprzedazy].[ID_OpisSprzedazy]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblOpisSprzedazy', @level2type=N'COLUMN',@level2name=N'ID_OpisSprzedazy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblOpisSprzedazy].[Sprzedaz_ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblOpisSprzedazy', @level2type=N'COLUMN',@level2name=N'Sprzedaz_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblOpisSprzedazy].[Towar_ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblOpisSprzedazy', @level2type=N'COLUMN',@level2name=N'Towar_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblOpisSprzedazy].[Ilosc]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblOpisSprzedazy', @level2type=N'COLUMN',@level2name=N'Ilosc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblOpisSprzedazy].[CenaSprzedazy]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblOpisSprzedazy', @level2type=N'COLUMN',@level2name=N'CenaSprzedazy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblOpisSprzedazy].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblOpisSprzedazy', @level2type=N'CONSTRAINT',@level2name=N'tblOpisSprzedazy$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblOpisSprzedazy]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblOpisSprzedazy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblOpisSprzedazy].[tblSprzedaztblOpisSprzedazy]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblOpisSprzedazy', @level2type=N'CONSTRAINT',@level2name=N'tblOpisSprzedazy$tblSprzedaztblOpisSprzedazy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblOpisSprzedazy].[tblTowarytblOpisSprzedazy]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblOpisSprzedazy', @level2type=N'CONSTRAINT',@level2name=N'tblOpisSprzedazy$tblTowarytblOpisSprzedazy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblPracownicy].[IDPracownika]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblPracownicy', @level2type=N'COLUMN',@level2name=N'IDPracownika'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblPracownicy].[Imie]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblPracownicy', @level2type=N'COLUMN',@level2name=N'Imie'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblPracownicy].[Nazwisko]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblPracownicy', @level2type=N'COLUMN',@level2name=N'Nazwisko'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblPracownicy].[Stanowisko]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblPracownicy', @level2type=N'COLUMN',@level2name=N'Stanowisko'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblPracownicy].[Adres]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblPracownicy', @level2type=N'COLUMN',@level2name=N'Adres'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblPracownicy].[Miasto]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblPracownicy', @level2type=N'COLUMN',@level2name=N'Miasto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblPracownicy].[KodPocztowy]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblPracownicy', @level2type=N'COLUMN',@level2name=N'KodPocztowy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblPracownicy].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblPracownicy', @level2type=N'CONSTRAINT',@level2name=N'tblPracownicy$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblPracownicy]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblPracownicy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz].[ID_Sprzedaz]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'COLUMN',@level2name=N'ID_Sprzedaz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz].[Klient_ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'COLUMN',@level2name=N'Klient_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz].[DataSprzedazy]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'COLUMN',@level2name=N'DataSprzedazy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz].[Pracownik_ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'COLUMN',@level2name=N'Pracownik_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'CONSTRAINT',@level2name=N'tblSprzedaz$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz].[tblKliencitblSprzedaz]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'CONSTRAINT',@level2name=N'tblSprzedaz$tblKliencitblSprzedaz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblSprzedaz].[tblPracownicytblSprzedaz]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblSprzedaz', @level2type=N'CONSTRAINT',@level2name=N'tblSprzedaz$tblPracownicytblSprzedaz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblTowary].[ID_Towar]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTowary', @level2type=N'COLUMN',@level2name=N'ID_Towar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblTowary].[Kategoria_ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTowary', @level2type=N'COLUMN',@level2name=N'Kategoria_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblTowary].[NazwaTowaru]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTowary', @level2type=N'COLUMN',@level2name=N'NazwaTowaru'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblTowary].[Cena_Katalogowa]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTowary', @level2type=N'COLUMN',@level2name=N'Cena_Katalogowa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblTowary].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTowary', @level2type=N'CONSTRAINT',@level2name=N'tblTowary$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblTowary]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTowary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'Baza_Sprzedazv2.[tblTowary].[tblKategorietblTowary]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTowary', @level2type=N'CONSTRAINT',@level2name=N'tblTowary$tblKategorietblTowary'
GO
