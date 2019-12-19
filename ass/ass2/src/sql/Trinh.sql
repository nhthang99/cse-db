-- Câu 1
CREATE PROCEDURE Insert_Mon
@TenMon NVARCHAR(200),
@Soluong INT,
@Loai NVARCHAR(200)
AS
BEGIN
    IF @Soluong < 0
        RAISERROR(N'Số lượng phải lớn hơn 0', 18, 1)
    ELSE
    BEGIN
        INSERT INTO dbo.Mon
        VALUES(
            @Tenmon,
            @Soluong,
            @Loai
        )
    END
END
GO


CREATE PROCEDURE view_Mon
AS
BEGIN
    SELECT * FROM dbo.Mon
END
GO

-- Trigger xoá Món khi xoá hết các option của Món
CREATE TRIGGER DeleteTriggerMenu
ON dbo.pOption
AFTER DELETE
AS
BEGIN
    DECLARE @Tenmon NVARCHAR(200),
            @Soluongoption INT

    SELECT @Tenmon = DELETED.TenMon FROM DELETED
    SELECT @Soluongoption = COUNT(*) FROM dbo.pOption WHERE @Tenmon = TenMon


    IF @Soluongoption = 0
    BEGIN
        DELETE FROM dbo.donhanggom WHERE @Tenmon = TenMon
        DELETE FROM dbo.nhanvienlammon WHERE @Tenmon = TenMon
        DELETE FROM dbo.hinhanhmon WHERE @Tenmon = TenMon
        DELETE FROM dbo.mon WHERE @Tenmon = TenMon
    END
END
GO


-- Trigger không cho phép thêm hình ảnh khi đã thêm vào quá nhiều
CREATE TRIGGER InsertTriggerImg
ON dbo.HinhAnhMon
FOR INSERT
AS
BEGIN
    DECLARE @Soluonganh INT,
			@Tenmon NVARCHAR(200)

    SELECT @Tenmon = INSERTED.TenMon FROM INSERTED 
    SELECT @Soluonganh = COUNT(*) FROM dbo.hinhanhmon WHERE @Tenmon = TenMon

    IF @Soluonganh > 3
        ROLLBACK TRANSACTION
END
GO

-- Câu 3
-- Truy vấn danh sách giá Món
SELECT * FROM dbo.mon, dbo.poption
WHERE mon.tenmon = poption.tenmon
ORDER BY poption.gia ASC

-- Truy vấn danh sách giá, loại có size S
SELECT Mon.Loai, pOption.Gia FROM dbo.mon, dbo.poption
WHERE mon.tenmon = poption.Tenmon 
GROUP BY Mon.Loai, pOption.Size, pOption.Gia
HAVING poption.Size = 'S'
ORDER BY Mon.Loai

-- Truy vấn danh sách Số lượng hình ảnh Món có loại là Trà
SELECT Mon.TenMon, COUNT(*) AS 'Soluonganh' FROM dbo.mon, dbo.HinhAnhMon
WHERE mon.tenmon = HinhAnhMon.TenMon 
GROUP BY Mon.TenMon, Mon.Loai
HAVING Mon.Loai = N'Trà & Macchiato'
ORDER BY Mon.TenMon
GO

-- Câu 4
-- Function nhận tham số đầu vào là tên món, trả ra loại của Món
CREATE FUNCTION kiemtraloai(@Tenmon NVARCHAR(200))
RETURNS NVARCHAR(50)
AS
BEGIN
    IF(EXISTS (SELECT * FROM dbo.Mon WHERE Mon.TenMon = @Tenmon))
        BEGIN
            DECLARE @Loai NVARCHAR(50)
            SELECT @Loai = Loai FROM dbo.Mon WHERE Mon.TenMon = @Tenmon
            RETURN @Loai
        END
    RETURN N'Không có Loại này!'
END
GO

-- Function nhận tham số đầu vào là tên món, trả ra số lượng hình ảnh của Món
CREATE FUNCTION kiemtrasoluonganh(@Tenmon NVARCHAR(200))
RETURNS INT
AS
BEGIN
    IF(EXISTS (SELECT * FROM dbo.HinhanhMon WHERE TenMon = @Tenmon))
     BEGIN
        DECLARE @Soluonganh INT
        SELECT @Soluonganh = COUNT(*) FROM dbo.HinhAnhMon WHERE TenMon = @Tenmon
        RETURN @Soluonganh
     END
     RETURN 0
END
GO

-- Insert dữ liệu

INSERT INTO dbo.Mon VALUES
            (N'Americano', 10, N'Cà Phê'),
            (N'Bạc Sỉu', 10, N'Cà Phê'),
            (N'Cà Phê Đen', 10, N'Cà Phê'),
            (N'Cà Phê Sữa', 10, N'Cà Phê'),
            (N'Cappucinno', 10, N'Cà Phê'),
            (N'Trà Cherry Macchiato', 10, N'Trà & Macchiato'),
            (N'Trà Đào Cam Sả', 10, N'Trà & Macchiato')

INSERT INTO dbo.HinhAnhMon VALUES
            (N'Americano', 'https://product.hstatic.net/1000075078/product/americano_large.jpg'),
            (N'Bạc Sỉu', 'https://product.hstatic.net/1000075078/product/white_vnese_coffee_9968c1184d7f4634a9bb9fce7b5ff313_large.jpg'),
            (N'Cà Phê Đen', 'https://product.hstatic.net/1000075078/product/vnese_coffee_large.jpg'),
            (N'Cà Phê Sữa', 'https://product.hstatic.net/1000075078/product/cfs_large.jpg'),
            (N'Cappucinno', 'https://product.hstatic.net/1000075078/product/cappuccino_large.jpg'),
            (N'Trà Cherry Macchiato', 'https://product.hstatic.net/1000075078/product/cherry_mac_6a3403fdb832464da88de8c6e6ddf662_large.jpg'),
            (N'Trà Đào Cam Sả', 'https://product.hstatic.net/1000075078/product/tra_dao_cam_sa_on_bg_large.jpg')

INSERT INTO dbo.pOption VALUES
            ('S', N'Americano', 12000, N'Cà Phê'),
            ('L', N'Americano', 12000, N'Cà Phê'),
            ('S', N'Bạc Sỉu', 10000, N'Cà Phê 2'),
            ('L', N'Bạc Sỉu', 10000, N'Cà Phê 2'),
            ('S', N'Cà Phê Đen', 10000, N'Cà Phê 3'),
            ('L', N'Cà Phê Đen', 10000, N'Cà Phê 3'),
            ('S', N'Cà Phê Sữa', 15000, N'Cà Phê 4'),
            ('L', N'Cà Phê Sữa', 15000, N'Cà Phê 4'),
            ('S', N'Cappucinno', 20000, N'Cà Phê 5'),
            ('L', N'Cappucinno', 20000, N'Cà Phê 5'),
            ('S', N'Trà Cherry Macchiato', 18000, N'Trà & Macchiato'),
            ('L', N'Trà Cherry Macchiato', 18000, N'Trà & Macchiato'),
            ('S', N'Trà Đào Cam Sả', 17000, N'Trà & Macchiato 2'),
            ('L', N'Trà Đào Cam Sả', 17000, N'Trà & Macchiato 2')