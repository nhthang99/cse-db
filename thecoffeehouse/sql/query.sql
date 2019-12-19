USE TheCoffeeHouse
GO

-- ####################################################################################
-- SELECT * FROM dbo.Tintuc
-- SELECT * FROM dbo.TintucNhacKM
-- SELECT * FROM dbo.KhuyenMai
DECLARE @currTime DATE
SET @currTime = GETDATE()

SELECT * FROM dbo.Tintuc WHERE MaBV IN
(
    SELECT MaBV FROM dbo.TintucNhacKM
        WHERE MaKM IN (SELECT MaKM FROM dbo.KhuyenMai WHERE Ngaybatdau <= @currTime AND Ngayketthuc >= @currTime)
)
ORDER BY Thoigian ASC
GO

-- ####################################################################################

DECLARE @startTime DATE = GETDATE(),
        @endTime DATE = GETDATE() + 5

SELECT ID, Ho, Ten, UsenameU, SoBaiViet FROM dbo.pUser JOIN 
(SELECT IDNhanVien, COUNT(*) SoBaiViet
FROM dbo.Tintuc WHERE Thoigian >= @startTime AND Thoigian <= @endTime
GROUP BY IDNhanVien HAVING COUNT(*) >= 1
) AS E ON dbo.pUser.ID = E.IDNhanVien ORDER BY Ten
GO

-- ####################################################################################

INSERT INTO dbo.DoituongKM 
    VALUES
        (N'Bạc', 1),
        (N'Đồng', 1),
        (N'Vàng', 2),
        (N'Bạc', 2),
        (N'Đồng', 2),
        (N'Vàng', 6),
        (N'Bạc', 6),
        (N'Đồng', 6),
        (N'Vàng', 3),
        (N'Bạc', 3),
        (N'Đồng', 3)

DECLARE @currTime DATE = GETDATE()
SELECT DoiTuong, COUNT(*) AS SoKhuyenMai FROM dbo.KhuyenMai 
JOIN dbo.DoituongKM ON dbo.KhuyenMai.MaKM = dbo.DoituongKM.MaKM
WHERE Ngaybatdau <= @currTime AND @currTime <= Ngayketthuc
GROUP BY DoiTuong HAVING COUNT(*) < 10
ORDER BY SoKhuyenMai
GO
