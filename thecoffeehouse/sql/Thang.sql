USE TheCoffeeHouse
GO

CREATE TRIGGER delDiscountTrigger
ON dbo.KhuyenMai
AFTER DELETE
AS DECLARE  @numOfNews INT = 0,
            @numOfNewsMentionDiscount INT = 0

BEGIN

    SELECT @numOfNews = COUNT(*) FROM dbo.Tintuc
    SELECT @numOfNewsMentionDiscount = COUNT(DISTINCT MaBV) FROM dbo.TintucNhacKM

    IF @numOfNews > @numOfNewsMentionDiscount
    BEGIN
        DELETE FROM dbo.Tintuc WHERE MaBV NOT IN (SELECT MaBV FROM dbo.TintucNhacKM)
    END

END
GO

CREATE TRIGGER insertDiscountTrigger
ON dbo.KhuyenMai
FOR INSERT
AS DECLARE  @timeStart DATE,
            @timeEnd DATE

BEGIN

    SELECT @timeStart = inserted.Ngaybatdau FROM inserted
    SELECT @timeEnd = inserted.Ngayketthuc FROM inserted

    IF @timeStart < convert(DATE, getdate())
    BEGIN
        PRINT('The start time is in the past')
        ROLLBACK TRANSACTION
    END

    IF @timeEnd < @timeStart
    BEGIN
        PRINT('The end time is in the past of start time')
        ROLLBACK TRANSACTION
    END

END
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

CREATE PROCEDURE ShowNews
AS
BEGIN
    SELECT * FROM dbo.Tintuc WHERE Thoigian <= getdate()
END
GO

CREATE PROCEDURE ShowNewsAndImages
AS
BEGIN
    SELECT TOP(SELECT COUNT(DISTINCT MaBV) FROM dbo.HinhAnhTinTuc) 
    TT.MaBV, TT.Tieude, TT.Loai, TT.Thoigian, TT.Noidung, HATT.HinhAnh
    FROM dbo.HinhAnhTintuc HATT JOIN dbo.Tintuc TT ON HATT.MaBV = TT.MaBV WHERE TT.Thoigian <= GETDATE()
END
GO

USE TheCoffeeHouse
GO

CREATE FUNCTION isEnoughNumNewsOfDay
(@day DATE, @numOfNewsRequired INT)
RETURNS INT
AS
BEGIN

    SET @day = CONVERT(DATE, @day)
    DECLARE @numOfNewsOfDay INT = 0

    IF @day < CONVERT(DATE, GETDATE())
        RETURN -1
    
    SELECT @numOfNewsOfDay=COUNT(*) FROM dbo.Tintuc WHERE Thoigian = @day
    
    IF @numOfNewsOfDay < @numOfNewsRequired
        RETURN 1
    
    RETURN 0
END
GO

-- SELECT * FROM dbo.Tintuc
-- DECLARE @day DATE = GETDATE()
-- SELECT dbo.isEnoughNumNewsOfDay(@day, 10)
-- GO

CREATE FUNCTION searchTitleNews
(@string NVARCHAR(100), @startTime DATE, @endTime DATE)
RETURNS @result TABLE (
    Tieude NVARCHAR(200),
    Thoigian Date,
    Noidung NVARCHAR(MAX)
)
AS
BEGIN

    IF @startTime > @endTime
        RETURN;

    DECLARE @title NVARCHAR(200),
            @time DATE, 
            @content NVARCHAR(MAX), 
            @regex VARCHAR(100) = '%' + @string + '%'
    DECLARE TitleNewsCursor CURSOR FOR SELECT Tieude, Thoigian, Noidung FROM dbo.Tintuc WHERE @startTime <= Thoigian AND Thoigian <= @endTime

    OPEN TitleNewsCursor 

    FETCH NEXT FROM TitleNewsCursor     
    INTO @title, @time, @content

    WHILE @@FETCH_STATUS = 0    
    BEGIN
        IF @title LIKE @regex
            INSERT INTO @result VALUES (@title, @time, @content)

        FETCH NEXT FROM TitleNewsCursor INTO @title, @time, @content
    END

    CLOSE TitleNewsCursor;    
    DEALLOCATE TitleNewsCursor;
    RETURN;
END
GO

SELECT * FROM dbo.Tintuc
SELECT * FROM dbo.searchTitleNews(N'Gi', getdate()-1, getdate() + 5)