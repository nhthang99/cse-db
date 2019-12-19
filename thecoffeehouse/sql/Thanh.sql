USE TheCoffeeHouse
GO

--Câu 1
--Procedure cho việc insert vào bảng pUser, kiểm tra xem username và password có đạt yêu cầu là tối thiểu 6 ký tự hay không
CREATE PROCEDURE Insert_pUser
@Ho NVARCHAR(50),
@Ten NVARCHAR(50),
@TenDuong NVARCHAR(200),
@SoNha VARCHAR(50),
@TinhTP NVARCHAR(100),
@GioiTinh NVARCHAR(50),
@UsenameU VARCHAR(50),
@PasswordU VARCHAR(50)
AS
BEGIN
	IF LEN(@UsenameU) < 6 or LEN(@PasswordU) < 6
	BEGIN
		RAISERROR(N'Username phải có độ dài tối thiểu là 6',18,1)
	END
	ELSE
	BEGIN
		INSERT pUser
		VALUES(
			@Ho,
			@Ten,
			@TenDuong,
			@SoNha,
			@TinhTP,
			@GioiTinh,
			@UsenameU,
			@PasswordU
		)
	END
END
GO

--Procedure cho việc hiển thị bảng pUser
---------------------PROCEDURE SHOW DATA pUser TABLE--------------------
CREATE PROCEDURE View_pUser
AS
BEGIN
	BEGIN
		SELECT * FROM pUser
	END
END
GO

--Câu 2
--Trigger after thông báo số lượng tài khoản bị xóa
CREATE TRIGGER delete_pUser
ON pUser
AFTER DELETE
AS
BEGIN
	DECLARE @amount INT = 0
	SELECT @amount = COUNT(*) FROM DELETED
	PRINT 'Đã xóa ' + CONVERT(NVARCHAR,@amount) + N' tài khoản'
END
GO

--Trigger for, tự động xóa tài khoản khi xóa nhân viên
CREATE TRIGGER delete_NhanVien
ON Nhanvien
FOR DELETE
AS
BEGIN
	DECLARE NhanVienCursor CURSOR FOR SELECT ID FROM deleted
	OPEN NhanVienCursor
	DECLARE @idNhanVien INT
	FETCH NEXT FROM NhanVienCursor INTO @idNhanVien
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @amount INT = 0
		SELECT @amount = COUNT(*) FROM pUser
		WHERE pUser.ID = @idNhanVien
		IF @amount = 1
			DELETE pUser WHERE pUser.ID = @idNhanVien
		FETCH NEXT FROM NhanVienCursor INTO @idNhanVien
	END
	CLOSE NhanVienCursor
	DEALLOCATE NhanVienCursor
END
GO

--Câu 3
--Truy xuất danh sách nhân viên và sắp xếp tăng dần theo tên
SELECT pUser.*,Nhanvien.CongViec FROM pUser,Nhanvien
WHERE pUser.ID = Nhanvien.ID
ORDER BY pUser.Ten ASC
GO

--Truy xuất thống kê số lượng các nhân viên làm công việc pha chế theo tỉnh, sắp xếp tăng dần theo tên tỉnh
SELECT pUser.TinhTP AS N'Tỉnh', COUNT(*) AS N'Số lượng nhân viên pha chế theo tỉnh' FROM pUser,Nhanvien
WHERE pUser.ID = Nhanvien.ID
GROUP BY pUser.TinhTP, Nhanvien.CongViec
HAVING Nhanvien.CongViec = N'Pha chế'
ORDER BY pUser.TinhTP
GO

--Truy xuất danh sách nhân viên nam theo công việc, sắp xếp theo số lượng giảm dần
SELECT Nhanvien.CongViec AS N'Công việc', COUNT(*) AS N'Số lượng nhân viên' FROM pUser,Nhanvien
WHERE pUser.ID = Nhanvien.ID
GROUP BY GioiTinh, Nhanvien.CongViec
HAVING GioiTinh = N'Nam'
ORDER BY COUNT(*) DESC
GO

--Câu 4
--Function nhận tham số đầu vào là ID của tài khoản, trả ra kết quả đó là loại tài khoản gì- khách hàng, nhân viên hay quản lý
CREATE FUNCTION kiemTraLoaiTaiKhoan(@ID INT)
RETURNS NVARCHAR(100)
AS
BEGIN
	IF @ID <= 0
		RETURN N'Lỗi! ID không được nhỏ hơn hoặc bằng 0'
	IF (SELECT COUNT(*) FROM Nhanvien WHERE Nhanvien.ID = @ID ) = 1
		RETURN N'Tài khoản nhân viên'
	ELSE IF (SELECT COUNT(*) FROM QuanLy WHERE QuanLy.ID = @ID ) = 1
		RETURN N'Tài khoản quản lý'
	ELSE IF (SELECT COUNT(*) FROM Khachhang WHERE Khachhang.ID = @ID ) = 1
		RETURN N'Tài khoản khách hàng'
	RETURN N'Default'
END
GO

-- SELECT dbo.kiemTraLoaiTaiKhoan(0) AS N'Loại tài khoản'
-- SELECT dbo.kiemTraLoaiTaiKhoan(1) AS N'Loại tài khoản'
-- SELECT dbo.kiemTraLoaiTaiKhoan(15) AS N'Loại tài khoản'
-- SELECT dbo.kiemTraLoaiTaiKhoan(16) AS N'Loại tài khoản'
-- GO

--Function nhận tham số đầu vào là giới tính, trả ra bảng danh sách nhân viên với giới tính tương ứng
CREATE FUNCTION DSNhanVienTheoGioiTinh(@GioiTinh NVARCHAR(50))
RETURNS INT
AS
BEGIN
	IF @GioiTinh != N'Nam' AND @GioiTinh != N'Nữ' AND @GioiTinh != N'Khác'
		RETURN -1
	DECLARE @amount INT = 0
	SELECT @amount = COUNT(*) FROM pUser,Nhanvien WHERE pUser.GioiTinh = @GioiTinh AND pUser.ID = Nhanvien.ID
	RETURN @amount
END
GO

-- SELECT dbo.DSNhanVienTheoGioiTinh(N'Test error')
-- SELECT dbo.DSNhanVienTheoGioiTinh(N'Nam') AS N'Số lượng nhân viên có giới tính nam'
-- SELECT dbo.DSNhanVienTheoGioiTinh(N'Nữ') AS N'Số lượng nhân viên có giới tính nữ'
-- SELECT dbo.DSNhanVienTheoGioiTinh(N'Khác') AS N'Số lượng nhân viên có giới tính khác'


--Test thử
-- USE TheCoffeeHouse
-- SELECT * FROM pUser
-- SELECT * FROM Nhanvien
-- SELECT * FROM Khachhang
-- SELECT * FROM QuanLy
-- EXEC Insert_pUser N'Lê Nhật', N'Thành', N'Trần Phú', N'47', N'Quảng Trị', N'Nam', 'thanh123', '123456'
-- GO
-- EXEC Insert_pUser N'Võ Trung', N'Quân', N'Nguyễn Trãi', N'15', N'Đắk Lắk', N'Nam', 'quan123', '123456'
-- GO
-- EXEC Insert_pUser N'Lê Thành', N'Nhật', N'Lê Lợi', N'20', N'Quảng Trị', N'Nam', 'nhat123', '123456'
-- GO
-- EXEC Insert_pUser N'Trần Chương', N'Trình', N'Ngô Quyền', N'33', N'Lâm Đồng', N'Nam', 'trinh123', '123456'
-- GO
-- EXEC Insert_pUser N'Nguyễn Thị', N'Hồng', N'Nguyễn Du', N'22', N'Lâm Đồng', N'Nữ', 'hong123', '123456'
-- GO
-- EXEC Insert_pUser N'Nguyễn Hữu', N'Thắng', N'Trần Hưng Đạo', N'33', N'Đắk Lắk', N'Nam', 'thang123', '123456'
-- GO
-- EXEC Insert_pUser N'Bùi Thị', N'Hoa', N'Trần Phú', N'27', N'TP HCM', N'Nữ', 'hoa123', '123456'
-- GO
-- EXEC Insert_pUser N'Phan Minh', N'Thư', N'Lý Thường Kiệt', N'354', N'TP HCM', N'Nữ', 'thu123', '123456'
-- GO
-- EXEC Insert_pUser N'Lê Khách', N'Hàng', N'Hoàng Sa', N'111', N'TP HCM', N'Nam', 'hang123', '123456'
-- GO
-- EXEC Insert_pUser N'Lê Quản', N'Lý', N'Trường Sa', N'1', N'TP HCM', N'Nữ', 'quanly123', '123456'
-- GO

-- DELETE pUser WHERE pUser.TinhTP = N'TP HCM'
-- GO

-- INSERT Nhanvien
-- VALUES (2,N'Pha chế')
-- INSERT Nhanvien
-- VALUES (3,N'Pha chế')
-- INSERT Nhanvien
-- VALUES (4,N'Lễ Tân')
-- INSERT Nhanvien
-- VALUES (5,N'Bồi bàn')
-- INSERT Nhanvien
-- VALUES (6,N'Pha chế')
-- INSERT Nhanvien
-- VALUES (7,N'Lễ Tân')

-- DELETE Nhanvien WHERE Nhanvien.ID = 1