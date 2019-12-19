-- USE master
-- DROP DATABASE TheCoffeeHouse


CREATE DATABASE TheCoffeeHouse
GO

USE TheCoffeeHouse
GO


CREATE TABLE dbo.pUser
(
    ID INT PRIMARY KEY IDENTITY, -- primary key column
    Ho NVARCHAR(50) NOT NULL,
    Ten NVARCHAR(50) NOT NULL,
    TenDuong NVARCHAR(200) NOT NULL,
    SoNha VARCHAR(50) NOT NULL,
    TinhTP NVARCHAR(100) NOT NULL,
    GioiTinh NVARCHAR(50) NOT NULL CHECK (GioiTinh = 'Nam' or GioiTinh = N'Nữ' or GioiTinh = N'Khác'),
    UsenameU VARCHAR(50) NOT NULL UNIQUE,
    PasswordU VARCHAR(50) NOT NULL,
);
GO

CREATE TABLE dbo.emailUser
(
    Email VARCHAR(100), -- primary key column
    ID INT NOT NULL
	PRIMARY KEY (Email,ID)
);
ALTER TABLE dbo.emailUser
ADD CONSTRAINT fk_user_email_id FOREIGN KEY (ID) 
                            REFERENCES dbo.pUser(ID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE;
GO

CREATE TABLE dbo.SDTUser
(
    SDT VARCHAR(50), -- primary key column
    ID INT NOT NULL
	PRIMARY KEY (SDT,ID)
);
ALTER TABLE dbo.SDTUser
ADD CONSTRAINT fk_user_sdt_id FOREIGN KEY (ID) 
                            REFERENCES dbo.pUser(ID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE;
GO

CREATE TABLE dbo.Nhanvien
(
    ID INT NOT NULL,
	CongViec NVARCHAR(50)
	PRIMARY KEY (ID)
);
ALTER TABLE dbo.Nhanvien
ADD CONSTRAINT fk_user_staff_id FOREIGN KEY (ID) 
                            REFERENCES dbo.pUser(ID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE;
GO

CREATE TABLE dbo.Khachhang
(
    Diem INT,
    ID INT NOT NULL PRIMARY KEY
);
ALTER TABLE dbo.Khachhang
ADD CONSTRAINT fk_user_customer_id FOREIGN KEY (ID) 
                            REFERENCES dbo.pUser(ID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE;
GO

CREATE TABLE dbo.QuanLy
(
    ID INT NOT NULL PRIMARY KEY
);
ALTER TABLE dbo.QuanLy
ADD CONSTRAINT fk_user_manager_id FOREIGN KEY (ID) 
                            REFERENCES dbo.pUser(ID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE;
GO


CREATE TABLE dbo.Tintuc
(
    MaBV INT PRIMARY KEY IDENTITY, -- primary key column
    Tieude NVARCHAR(200),
    Loai NVARCHAR(100),
    Thoigian Date,
    Noidung NVARCHAR(MAX),
    IDNhanVien INT NOT NULL,
);
ALTER TABLE dbo.Tintuc
ADD CONSTRAINT fk_news_id FOREIGN KEY (IDNhanVien) 
                            REFERENCES dbo.Nhanvien(ID)
                            ON DELETE NO ACTION
                            ON UPDATE CASCADE;
GO

CREATE TABLE dbo.HinhAnhTintuc
(
    MaBV INT NOT NULL, -- primary key column
    HinhAnh VARCHAR(500),
	PRIMARY KEY (MaBV,HinhAnh),
);
ALTER TABLE dbo.HinhAnhTintuc
ADD CONSTRAINT fk_news_images_id FOREIGN KEY (MaBV) 
                            REFERENCES dbo.Tintuc(MaBV)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE;
GO

CREATE TABLE dbo.Mon
(
    TenMon NVARCHAR(200) PRIMARY KEY, -- primary key column
    Soluongban INT NOT NULL,
    Loai NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE dbo.HinhAnhMon
(
    TenMon NVARCHAR(200), -- primary key column
    HinhAnh VARCHAR(500)
	PRIMARY KEY (TenMon,HinhAnh)
);
ALTER TABLE dbo.HinhAnhMon
ADD CONSTRAINT fk_menu_images_id FOREIGN KEY (TenMon) 
                            REFERENCES dbo.Mon(TenMon)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE;
GO

CREATE TABLE dbo.NhanvienLamMon
(
    IDNhanVien INT NOT NULL,
    TenMon NVARCHAR(200) NOT NULL
	PRIMARY KEY (IDNhanVien,TenMon)
);
ALTER TABLE dbo.NhanvienLamMon
ADD CONSTRAINT fk_staff_do_drinks_id FOREIGN KEY (IDNhanVien) 
                            REFERENCES dbo.NhanVien(ID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE;

ALTER TABLE dbo.NhanvienLamMon
ADD CONSTRAINT fk_name_drinks FOREIGN KEY (TenMon) 
                            REFERENCES dbo.Mon(TenMon)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE;
GO

CREATE TABLE dbo.KhuyenMai
(
    MaKM INT IDENTITY PRIMARY KEY,
    ID INT NOT NULL,
    Giamtoida INT,
    Ngaybatdau DATE,
    Ngayketthuc DATE,
    Phantram INT CHECK(Phantram >= 5 AND Phantram <= 50),
    Ten NVARCHAR(1000),
    Giatri INT
);
ALTER TABLE dbo.KhuyenMai
ADD CONSTRAINT fk_manager_discount_id FOREIGN KEY (ID) 
                            REFERENCES dbo.QuanLy(ID)
                            ON DELETE NO ACTION
                            ON UPDATE CASCADE;
GO

CREATE TABLE dbo.DoituongKM
(
    DoiTuong NVARCHAR(100) NOT NULL CHECK (DoiTuong = N'Kim Cương' or DoiTuong = N'Vàng' or DoiTuong = N'Bạc' or DoiTuong = N'Đồng'), -- primary key column
    MaKM INT NOT NULL
	PRIMARY KEY (DoiTuong,MaKM)
);
ALTER TABLE dbo.DoituongKM
ADD CONSTRAINT fk_doituong_id FOREIGN KEY(MaKM)
    REFERENCES dbo.KhuyenMai(MaKM)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
GO

CREATE TABLE dbo.TintucNhacKM
(
    MaBV INT NOT NULL,
    MaKM INT NOT NULL
	PRIMARY KEY (MaBV,MaKM)
);
ALTER TABLE dbo.TintucNhacKM
ADD CONSTRAINT fk_news_post_id FOREIGN KEY(MaBV)
    REFERENCES dbo.Tintuc(MaBV)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE dbo.TintucNhacKM
ADD CONSTRAINT fk_news_mention_discount_id FOREIGN KEY(MaKM)
    REFERENCES dbo.KhuyenMai(MaKM)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
GO

CREATE TABLE dbo.pOption
(
    Size NVARCHAR(50) CHECK (Size = 'S' or Size = 'M' or Size = 'L'), -- primary key column
    TenMon NVARCHAR(200) NOT NULL,
    Gia INT,
    Nguyenlieu NVARCHAR(1000)
	PRIMARY KEY (Size,TenMon)
);
ALTER TABLE dbo.pOption
ADD CONSTRAINT fk_option_name_drinks FOREIGN KEY(TenMon)
    REFERENCES dbo.Mon(TenMon)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
GO

CREATE TABLE dbo.ChiNhanh
(
	IDChiNhanh INT PRIMARY KEY IDENTITY,
    Sonha NVARCHAR(50),
    Tenduong NVARCHAR(200) NOT NULL,
    TinhTP NVARCHAR(100) NOT NULL,
    QuanHuyen NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    SDT NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE dbo.QuanliChinhanh
(
    IDQuanLy INT NOT NULL,
	IDChiNhanh INT NOT NULL
	PRIMARY KEY (IDQuanLy,IDChiNhanh)
);
ALTER TABLE dbo.QuanliChinhanh
ADD CONSTRAINT fk_branch_id FOREIGN KEY(IDChiNhanh)
    REFERENCES dbo.ChiNhanh(IDChiNhanh)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE dbo.QuanliChinhanh
ADD CONSTRAINT fk_branch_manager_id FOREIGN KEY(IDQuanLy)
    REFERENCES dbo.QuanLy(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
GO

CREATE TABLE dbo.Kho
(
	IDKho INT PRIMARY KEY,
    Soluong INT,
    NhapXuat NVARCHAR(50) CHECK(NhapXuat = N'Nhập' or NhapXuat = N'Xuất'),
    Ngay DATE
);
ALTER TABLE dbo.Kho
ADD CONSTRAINT fk_stotage_id FOREIGN KEY(IDKho)
    REFERENCES dbo.ChiNhanh(IDChiNhanh)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
GO

CREATE TABLE dbo.Donhang
(
    MaDH INT IDENTITY PRIMARY KEY, -- primary key column
    Thoigiandathang DATE,
    TinhTP NVARCHAR(100) NOT NULL,
    Sonha NVARCHAR(50) NOT NULL,
    TenDuong NVARCHAR(200) NOT NULL,
    QuanHuyen NVARCHAR(200) NOT NULL,
    PhiVC INT,
    IDKhachHang INT NOT NULL,
    MaKM INT NOT NULL,
    SDT NVARCHAR(50) NOT NULL
);
ALTER TABLE dbo.Donhang
ADD CONSTRAINT fk_discount_in_cart_id FOREIGN KEY(MaKM)
    REFERENCES dbo.KhuyenMai(MaKM)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE dbo.Donhang
ADD CONSTRAINT fk_user_customer_in_cart_id FOREIGN KEY(IDKhachHang)
    REFERENCES dbo.KhachHang(ID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
GO

CREATE TABLE dbo.DonHangGom
(
    MaDH INT NOT NULL,
    TenMon NVARCHAR(200) NOT NULL,
    SoLuong INT,
    Gia INT
	PRIMARY KEY (MaDH,TenMon)
);
ALTER TABLE dbo.DonHangGom
ADD CONSTRAINT fk_cart_contain_name_drinks FOREIGN KEY(TenMon)
    REFERENCES dbo.Mon(TenMon)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE dbo.DonHangGom
ADD CONSTRAINT fk_cart_customer_id FOREIGN KEY(MaDH)
    REFERENCES dbo.Donhang(MaDH)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
GO

CREATE TABLE dbo.PhanHoi
(
    MaPH INT IDENTITY PRIMARY KEY, -- primary key column
    IDKhachHang INT NOT NULL,
    Thoigian DATE,
    Noidung NVARCHAR(MAX),
    Rating FLOAT NOT NULL CHECK (Rating >=1 AND Rating <=5)
);

ALTER TABLE dbo.PhanHoi
ADD CONSTRAINT fk_feadback_customer_id FOREIGN KEY(IDKhachHang)
    REFERENCES dbo.KhachHang(ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
GO
