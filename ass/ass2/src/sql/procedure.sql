USE TheCoffeeHouse
GO

CREATE PROCEDURE InsertNews (
    @Tieude NVARCHAR(200),
    @Loai NVARCHAR(100),
    @Thoigian DATE,
    @Noidung NVARCHAR(MAX),
    @IDNhanVien INT
)   
AS 
BEGIN
    IF (LEN(@Tieude) > 80)
    BEGIN
        RAISERROR('Your title very long. Please try again...', 18, 1)
        RETURN
    END

    IF (LEN(@Tieude) < 10)
    BEGIN
        RAISERROR('Your title very short. Please try again...', 18, 1)
        RETURN
    END

    IF @Thoigian < getdate()
        SET @Thoigian = getdate()

    INSERT INTO dbo.TinTuc VALUES(@Tieude, @Loai, @Thoigian, @Noidung, @IDNhanVien)
END
GO

-- ###########################################################################

DECLARE @RC int
DECLARE @Tieude varchar(200)
DECLARE @Loai nvarchar(100)
DECLARE @Thoigian date
DECLARE @Noidung nvarchar(max)
DECLARE @IDNhanVien int 

-- TODO: Set parameter values here.
SET @Tieude = 'dasddD'
SET @Loai = N'Kết nối'
SET @Thoigian = '2019-12-30'
SET @Noidung = N'Mọi quyết định và hành động ở The Coffee House đều bắt đầu từ sứ mệnh “Deliver Happiness” - Trao gửi hạnh phúc. Từ niềm vui cho nhân viên đến sự hài lòng của khách hàng, chúng tôi tin rằng tất cả mọi người đều có thể đóng góp thêm những việc làm tốt đẹp cho cộng đồng. Hạnh phúc được tạo ra và lan tỏa, với The Coffee House, mới là hạnh phúc trọn vẹn.'
SET @IDNhanVien = 1

EXECUTE @RC = [dbo].[InsertNews] 
   @Tieude
  ,@Loai
  ,@Thoigian
  ,@Noidung
  ,@IDNhanVien
GO

-- ###########################################################################

CREATE PROCEDURE ShowNews
AS
BEGIN
    SELECT * FROM dbo.Tintuc WHERE Thoigian <= getdate()
END
GO

DECLARE @RC int
EXECUTE @RC = [dbo].[ShowNews]
GO

-- ###########################################################################

CREATE PROCEDURE ShowNewsAndImages
AS
BEGIN
    SELECT TOP(SELECT COUNT(DISTINCT MaBV) FROM dbo.HinhAnhTinTuc) 
    TT.MaBV, TT.Tieude, TT.Loai, TT.Thoigian, TT.Noidung, HATT.HinhAnh
    FROM dbo.HinhAnhTintuc HATT JOIN dbo.Tintuc TT ON HATT.MaBV = TT.MaBV WHERE TT.Thoigian <= GETDATE()
END

DECLARE @RC int
EXECUTE @RC = [dbo].[ShowNewsAndImages]
GO

