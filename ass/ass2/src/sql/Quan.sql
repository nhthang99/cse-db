USE TheCoffeeHouse
GO

-- Q1 --
-- PROC Nếu SDT khác 10 kí tự thì Raise lỗi
CREATE PROCEDURE insertOrder(
    @Thoigiandathang DATE,
    @TinhTP NVARCHAR(100),
    @Sonha NVARCHAR(50),
    @TenDuong NVARCHAR(200),
    @QuanHuyen NVARCHAR(200),
    @PhiVC INT,
    @IDKhachHang INT,
    @MaKM INT,
    @SDT NVARCHAR(50)
)

AS
BEGIN
    IF LEN(@SDT) != 10
    BEGIN
        RAISERROR('Số điện thoại không tồn tại!', 18, 1)
        RETURN
    END
    INSERT dbo.Donhang VALUES(@Thoigiandathang, @TinhTP, @Sonha, @TenDuong, @QuanHuyen, @PhiVC, @IDKhachHang, @MaKM, @SDT)
END
GO

CREATE PROCEDURE View_Donhang
AS
BEGIN
    BEGIN
        SELECT * FROM Donhang
    END
END
GO

USE TheCoffeeHouse
GO
EXEC View_Donhang
GO  
-- Question2 --

-- Trigger After
-- Hiện kết quả xoá bao nhiêu đơn hàng
CREATE TRIGGER showResult_DeletedDonHang
ON dbo.Donhang
AFTER DELETE
AS
BEGIN
    DECLARE @countDEL INT = 0
    SELECT @countDEL = COUNT(*) FROM deleted
    PRINT N'Đã xoá ' + CONVERT(NVARCHAR(10),@countDEL) + N' Đơn hàng'
END
GO

SELECT * FROM Donhang

DELETE dbo.Donhang
WHERE MaDH = 1
GO
-- Trigger For
-- Xoá Đơn hàng Gồm, Sau đó check nếu mã ĐH ko có trong đơn hàng gồm thì xoá đơn hàng
GO
CREATE TRIGGER delete_Donhang_DonhangGom
ON dbo.DonHangGom
FOR DELETE
AS
BEGIN
    DECLARE @MaDH INT = 0
    SELECT @MaDH = MaDH FROM deleted
    DECLARE @Count INT = 0 
    SELECT @Count = COUNT(*) FROM dbo.DonHangGom WHERE DonHangGom.MaDH = @MaDH
    IF @Count = 0
    BEGIN
        PRINT '1'
        DELETE dbo.Donhang WHERE Donhang.MaDH = @MaDH
    END
END
GO

-- Question 3 --
USE TheCoffeeHouse
-- Sử dụng WHERE, ORDER BY
-- Mệnh đề truy xuất tất cả đơn hàng và đơn hàng gồm không trùng MaDH và Giá theo thứ tự từ nhỏ -> lớn
SELECT * FROM dbo.Donhang AS DH, dbo.DonHangGom AS DHG
WHERE DH.MaDH = DHG.MaDH
ORDER BY Gia ASC

-- Truy vấn có aggreate function, group by, having, where và order by

-- Truy vấn các món và số lượng của nó, Số lượng lớn hơn 2 và theo thứ tự từ ít đến nhiều
SELECT TenMon, COUNT(*) FROM dbo.Donhang AS DH, dbo.DonHangGom AS DHG
WHERE DH.MaDH = DHG.MaDH
GROUP BY TenMon
HAVING COUNT(*) > 1
ORDER BY COUNT(*) ASC

-- Truy vấn các món và Tổng bill của nó, xuất cái món có tổng giá lớn hơn 100000
SELECT TenMon, SUM(Gia) FROM dbo.Donhang AS DH, dbo.DonHangGom AS DHG
WHERE DH.MaDH = DHG.MaDH
GROUP BY TenMon
HAVING SUM(Gia) > 50000
ORDER BY SUM(Gia) ASC


-- Question 4 --
-- Function --
SELECT * FROM dbo.Donhang
SELECT * FROM dbo.DonHangGom
GO

-- Kiểm tra xem đơn hàng còn hạn hay không, nếu quá 5 ngày xem như hết hạn
CREATE FUNCTION show_outofDate(@Thoigian DATE, @MaDH INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    IF(@MaDH < 1) 
        RETURN N'Mã đơn hàng sai'

    DECLARE @Thoigiandathang DATE
    SELECT @Thoigiandathang = Thoigiandathang FROM dbo.Donhang
    WHERE dbo.Donhang.MaDH = @MaDH

    IF(DAY(@Thoigian) - DAY(@Thoigiandathang) > 5)
        RETURN N'Đã quá hạn'
    RETURN N'Còn hạn'
END
GO

SELECT dbo.show_outofDate(getDATE(),MaDH) FROM dbo.Donhang
GO

SELECT * FROM Donhang
GO

-- Tính giá của mỗi đon hàng
CREATE FUNCTION showbillMaDH(@MaDH INT)
RETURNS INT
AS
BEGIN
    IF(@MaDH < 1) 
        RETURN -1

    DECLARE @Tongbill INT = 0
    DECLARE DonhangCursor CURSOR FOR SELECT MaDH, SoLuong, Gia FROM dbo.DonHangGom

    OPEN DonhangCursor

    DECLARE @MaDonhang INT
    DECLARE @Soluong INT
    DECLARE @Gia INT

    FETCH NEXT FROM DonhangCursor INTO @MaDonhang, @Soluong, @Gia
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF(@MaDonhang = @MaDH)
            SET @Tongbill = @Tongbill + @Soluong*@Gia
        FETCH NEXT FROM DonhangCursor INTO @MaDonhang, @Soluong, @Gia
    END

    CLOSE DonhangCursor
    DEALLOCATE DonhangCursor

    RETURN @Tongbill
END
GO

SELECT dbo.showbillMaDH(1007)
GO











