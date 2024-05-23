IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [DanhMucs] (
    [ID] uniqueidentifier NOT NULL,
    [Name] nvarchar(150) NOT NULL,
    CONSTRAINT [PK_DanhMucs] PRIMARY KEY ([ID])
);
GO

CREATE TABLE [ItemImages] (
    [ID] uniqueidentifier NOT NULL,
    [Img] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_ItemImages] PRIMARY KEY ([ID])
);
GO

CREATE TABLE [ThuocTinhChungs] (
    [ID] uniqueidentifier NOT NULL,
    [TenThuocTinh] nvarchar(50) NOT NULL,
    CONSTRAINT [PK_ThuocTinhChungs] PRIMARY KEY ([ID])
);
GO

CREATE TABLE [Users] (
    [ID] uniqueidentifier NOT NULL,
    [Name] nvarchar(256) NOT NULL,
    [UserName] nvarchar(50) NOT NULL,
    [Password] nvarchar(50) NOT NULL,
    [SDT] nvarchar(12) NOT NULL,
    [DiaChi] nvarchar(max) NOT NULL,
    [Email] nvarchar(50) NOT NULL,
    [NgaySinh] nvarchar(max) NOT NULL,
    [Role] int NOT NULL DEFAULT 0,
    [State] int NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY ([ID])
);
GO

CREATE TABLE [SanPhams] (
    [ID] uniqueidentifier NOT NULL,
    [Name] nvarchar(150) NOT NULL,
    [GiaGoc] int NOT NULL DEFAULT 0,
    [GiaGiamGia] int NOT NULL DEFAULT 0,
    [SoLuong] int NOT NULL DEFAULT 0,
    [TrangThai] int NOT NULL DEFAULT 2,
    [MoTa] nvarchar(max) NULL,
    CONSTRAINT [PK_SanPhams] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_IMG_SP] FOREIGN KEY ([ID]) REFERENCES [ItemImages] ([ID]) ON DELETE CASCADE
);
GO

CREATE TABLE [GiaTriThuocTinhs] (
    [ID] uniqueidentifier NOT NULL,
    [IDThuocTinh] uniqueidentifier NOT NULL,
    [GiaTri] nvarchar(50) NOT NULL,
    CONSTRAINT [PK_GiaTriThuocTinhs] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_TT_GTTT] FOREIGN KEY ([IDThuocTinh]) REFERENCES [ThuocTinhChungs] ([ID]) ON DELETE CASCADE
);
GO

CREATE TABLE [HoaDons] (
    [ID] uniqueidentifier NOT NULL,
    [UserID] uniqueidentifier NULL,
    [nameUser] nvarchar(max) NOT NULL,
    [NgayMua] datetime2 NOT NULL,
    [SDT] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    [DiaChi] nvarchar(max) NOT NULL,
    [ChuThich] nvarchar(max) NULL,
    [TrangThaiDonHang] int NOT NULL,
    CONSTRAINT [PK_HoaDons] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_HD_KH] FOREIGN KEY ([UserID]) REFERENCES [Users] ([ID])
);
GO

CREATE TABLE [DanhMucChiTiets] (
    [idDanhMuc] uniqueidentifier NOT NULL,
    [idSanPham] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_DanhMucChiTiets] PRIMARY KEY ([idDanhMuc], [idSanPham]),
    CONSTRAINT [FK_DMCT_DM] FOREIGN KEY ([idDanhMuc]) REFERENCES [DanhMucs] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_DMCT_SP] FOREIGN KEY ([idSanPham]) REFERENCES [SanPhams] ([ID]) ON DELETE CASCADE
);
GO

CREATE TABLE [GioHangChiTiets] (
    [ID] uniqueidentifier NOT NULL,
    [IDSanPham] uniqueidentifier NOT NULL,
    [UserID] uniqueidentifier NULL,
    [SoLuong] int NOT NULL DEFAULT 0,
    [ThuocTinh] nvarchar(max) NULL,
    CONSTRAINT [PK_GioHangChiTiets] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_GHCT_GH] FOREIGN KEY ([UserID]) REFERENCES [Users] ([ID]),
    CONSTRAINT [FK_GHCT_SP] FOREIGN KEY ([IDSanPham]) REFERENCES [SanPhams] ([ID]) ON DELETE CASCADE
);
GO

CREATE TABLE [ThuocTinhs] (
    [ID] uniqueidentifier NOT NULL,
    [IDSanPham] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_ThuocTinhs] PRIMARY KEY ([ID], [IDSanPham]),
    CONSTRAINT [FK_TTC_TT] FOREIGN KEY ([ID]) REFERENCES [ThuocTinhChungs] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_TT_SP] FOREIGN KEY ([IDSanPham]) REFERENCES [SanPhams] ([ID]) ON DELETE CASCADE
);
GO

CREATE TABLE [HoaDonChiTiets] (
    [ID] uniqueidentifier NOT NULL,
    [IDSanPham] uniqueidentifier NOT NULL,
    [IDSHoaDon] uniqueidentifier NOT NULL,
    [GiaSanPham] int NOT NULL,
    [SoLuong] int NOT NULL,
    [ThuocTinh] nvarchar(max) NULL,
    CONSTRAINT [PK_HoaDonChiTiets] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_HDCT] FOREIGN KEY ([IDSHoaDon]) REFERENCES [HoaDons] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_HDCT_SP] FOREIGN KEY ([IDSanPham]) REFERENCES [SanPhams] ([ID]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ID', N'DiaChi', N'Email', N'Name', N'NgaySinh', N'Password', N'SDT', N'State', N'UserName') AND [object_id] = OBJECT_ID(N'[Users]'))
    SET IDENTITY_INSERT [Users] ON;
INSERT INTO [Users] ([ID], [DiaChi], [Email], [Name], [NgaySinh], [Password], [SDT], [State], [UserName])
VALUES ('4722f2b1-f37e-483c-bf15-1523dc4179ec', N'Phúc Diễn, Bắc Từ Liêm, Hà Nội', N'nhatvu@gmail.com', N'Nguyễn Lê Nhất Vũ', N'2004-01-01', N'Admin19112004', N'0865805582', 0, N'shyke');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ID', N'DiaChi', N'Email', N'Name', N'NgaySinh', N'Password', N'SDT', N'State', N'UserName') AND [object_id] = OBJECT_ID(N'[Users]'))
    SET IDENTITY_INSERT [Users] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ID', N'DiaChi', N'Email', N'Name', N'NgaySinh', N'Password', N'Role', N'SDT', N'State', N'UserName') AND [object_id] = OBJECT_ID(N'[Users]'))
    SET IDENTITY_INSERT [Users] ON;
INSERT INTO [Users] ([ID], [DiaChi], [Email], [Name], [NgaySinh], [Password], [Role], [SDT], [State], [UserName])
VALUES ('c8d29bac-ab5a-4914-b957-0fac094f7857', N'Phúc Diễn, Bắc Từ Liêm, Hà Nội', N'nhatvu@gmail.com', N'Nguyễn Lê Nhất Vũ', N'2004-01-01', N'User19112004', 1, N'0865805582', 0, N'shykeuser');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ID', N'DiaChi', N'Email', N'Name', N'NgaySinh', N'Password', N'Role', N'SDT', N'State', N'UserName') AND [object_id] = OBJECT_ID(N'[Users]'))
    SET IDENTITY_INSERT [Users] OFF;
GO

CREATE INDEX [IX_DanhMucChiTiets_idSanPham] ON [DanhMucChiTiets] ([idSanPham]);
GO

CREATE INDEX [IX_GiaTriThuocTinhs_IDThuocTinh] ON [GiaTriThuocTinhs] ([IDThuocTinh]);
GO

CREATE INDEX [IX_GioHangChiTiets_IDSanPham] ON [GioHangChiTiets] ([IDSanPham]);
GO

CREATE INDEX [IX_GioHangChiTiets_UserID] ON [GioHangChiTiets] ([UserID]);
GO

CREATE INDEX [IX_HoaDonChiTiets_IDSanPham] ON [HoaDonChiTiets] ([IDSanPham]);
GO

CREATE INDEX [IX_HoaDonChiTiets_IDSHoaDon] ON [HoaDonChiTiets] ([IDSHoaDon]);
GO

CREATE INDEX [IX_HoaDons_UserID] ON [HoaDons] ([UserID]);
GO

CREATE UNIQUE INDEX [IX_ThuocTinhs_ID] ON [ThuocTinhs] ([ID]);
GO

CREATE INDEX [IX_ThuocTinhs_IDSanPham] ON [ThuocTinhs] ([IDSanPham]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240408212240_shyke', N'8.0.3');
GO

COMMIT;
GO

