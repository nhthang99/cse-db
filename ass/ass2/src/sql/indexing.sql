USE TheCoffeeHouse
GO

CREATE INDEX indexOfpUser on pUser(ID)

CREATE INDEX indexOfMon on Mon(TenMon)

CREATE INDEX indexOfMaDH on DonHang(MaDH)

CREATE INDEX index_news ON dbo.Tintuc(MaBV, Tieude)

CREATE INDEX index_discount ON dbo.Khuyenmai(Ngaybatdau, Ngayketthuc)