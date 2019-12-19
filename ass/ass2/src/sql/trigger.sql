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

SELECT * FROM dbo.Tintuc
SELECT * FROM dbo.TintucNhacKM
SELECT * FROM dbo.KhuyenMai

DELETE FROM dbo.KhuyenMai WHERE MaKM = 1
SELECT * FROM dbo.Tintuc
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

INSERT INTO dbo.KhuyenMai VALUES(7, 40000, getdate(), getdate() + 3, 20, 'Noel', 20000)
INSERT INTO dbo.KhuyenMai VALUES(7, 40000, getdate() -3, getdate() + 3, 20, 'Noel', 20000)
INSERT INTO dbo.KhuyenMai VALUES(7, 40000, getdate(), getdate() - 1, 20, 'Noel', 20000)