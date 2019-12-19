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

SELECT * FROM dbo.Tintuc
DECLARE @day DATE = GETDATE()
SELECT dbo.isEnoughNumNewsOfDay(@day, 10)
GO

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