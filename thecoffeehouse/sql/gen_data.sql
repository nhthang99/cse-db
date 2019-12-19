USE TheCoffeeHouse
GO

INSERT pUser VALUES
    (N'Lê Nhật', N'Thành', N'Trần Phú', '47', N'Quảng Trị', N'Nam', 'thanh123', '123456'),
    (N'Võ Trung', N'Quân', N'Nguyễn Trãi', '15', N'Đắk Lắk', N'Nam', 'quan123', '123456'),
    (N'Trần Chương', N'Trình', N'Ngô Quyền', '33', N'Lâm Đồng', N'Nam', 'trinh123', '123456'),
    (N'Nguyễn Thị', N'Hồng', N'Nguyễn Du', '22', N'Lâm Đồng', N'Nữ', 'hong123', '123456'),
    (N'Nguyễn Hữu', N'Thắng', N'Trần Hưng Đạo', '33', N'Đắk Lắk', N'Nam', 'thang123', '123456'),
    (N'Bùi Thị', N'Hoa', N'Trần Phú', '27', N'TP HCM', N'Nữ', 'hoa123', '123456'),
    (N'Phan Minh', N'Thư', N'Lý Thường Kiệt', '354', N'TP HCM', N'Nữ', 'thu123', '123456')
GO


INSERT emailUser VALUES
    ('thanh@gmail.com', 1),
    ('quan@gmail.com', 1),
    ('trinh@gmail.com', 1),
    ('thanh@gmail.com', 2),
    ('quan@gmail.com', 2),
    ('trinh@gmail.com', 2),
    ('thanh@gmail.com', 3),
    ('quan@gmail.com', 3),
    ('trinh@gmail.com', 3)
GO

INSERT SDTUser VALUES
    ('01694751795', 1),
    ('01694751793', 1),
    ('0972806346', 1),
    ('01694751795', 2),
    ('01694751793', 2),
    ('0972806346', 2),
    ('01694751795', 3),
    ('01694751793', 3),
    ('0972806346', 3)
GO

INSERT Nhanvien VALUES
    (1, N'Pha chế'),
    (2, N'Phục vụ'),
    (3, N'Bảo vệ')
GO

INSERT Khachhang VALUES
    (1000, 4),
    (2000, 5),
    (2500, 6)
GO

INSERT QuanLy VALUES(7)
GO

INSERT Tintuc VALUES
    (N'Giảm giá cực sốc Trà Xanh Machiato', N'Khuyến Mãi', GETDATE(), N'Trà xanh Machiato giàm giá chỉ còn 35.000 1 ly tại chi nhánh 63 Nguyễn Du', 1),
    (N'LỄ HỘI MACCHIATO - THÊM CẢM HỨNG, THÊM VUI!', N'Khuyến Mãi', GETDATE(), N'Hãy sẵn sàng xóa tan cơn nắng mưa thất thường, để hòa mình vào Lễ Hội Macchiato đầy sắc màu với bộ ba món mới từ The Coffee House', 1),
    (N'Giảm giá Trà Xanh Machiato', N'Khuyến Mãi', GETDATE(), N'Trà xanh Machiato giàm giá chỉ còn 35.000 1 ly tại chi nhánh 63 Nguyễn Du', 2),
    (N'LỄ HỘI MACCHIATO - THÊM CẢM HỨNG', N'Khuyến Mãi', GETDATE(), N'Đến hẹn lại lên, Mùa Lễ Hội Macchiato đã quay trở lại! ', 2),
    (N'HƯƠNG VỊ MÙA YÊU THƯƠNG, BẠN ĐÃ THƯỞNG THỨC CHƯA?', N'Quảng cáo', GETDATE(), N'Câu chuyện cuối năm đâu chỉ có bộn bề. Mà còn ấm áp bởi những cuộc gặp gỡ đầy yêu thương. Và hãy để những hương vị “ấm áp - ngọt ngào - nhẹ nhàng” của Nhà, góp phần cho câu chuyện của bạn thêm đầy, thêm ấm hơn nhé!', 1),
    (N'THE COFFEE HOUSE GO GREEN - CHUỖI HOẠT ĐỘNG VÌ TRƯỜNG', N'Quảng cáo', GETDATE() - 1, N'Một trong những giá trị cốt lõi của The Coffee House từ ngày đầu tiên đó chính là giá trị quan tâm cộng đồng và có trách nhiệm làm cho môi trường sống được tốt đẹp, khỏe mạnh hơn.', 1),
    (N'Những câu hỏi thường gặp tại The Coffee House', N'Thắc mắc', GETDATE(), N'Sản phẩm ống hút sinh học sau khi thu gom và xử lý chôn lấp tại bãi rác thải công nghiệp sẽ phân hủy hoàn toàn trong vòng từ 12 - 24 tháng.', 2),
    (N'Khám phá không gian ảnh Sài Gòn Vẫn Thế tại The Coffee House Signature', N'Quảng cáo', GETDATE() + 3, N'Tử tế - Đâu chỉ là một tính từ, đó còn là văn hoá, là giá trị đặc biệt mà The Coffee House luôn theo đuổi trong suốt hành trình của mình. Mỗi ngày tại nơi đây chúng tôi đều luôn cố gắng làm việc và phục vụ khách hàng một cách tử tế, mang đến những tách cà phê trọn vị tử tế, lan toả những câu chuyện tử tế quanh bàn cà phê.', 2)
GO

INSERT HinhAnhTintuc VALUES
    (1, 'https://file.hstatic.net/1000075078/file/mango_macchiato_74e704a732a04775808da0eac901c75c_grande.jpg'),
    (2, 'https://file.hstatic.net/1000075078/file/cherry_macchiato_f338b0b65c5f4a559871a055f4251c2d_grande.jpg'),
    (3, 'https://file.hstatic.net/1000075078/file/img_0284_copy_72f56962804148e8be60e717b928f714_grande.jpg'),
    (4, 'https://file.hstatic.net/1000075078/file/img_1059_a299fa1781f242efa638c91957fd67eb_grande.jpg'),
    (5, 'https://file.hstatic.net/1000075078/file/img_6078_copy_copy_c1062e5768cd4628afe5e1a4ad9cc42d_grande.jpg'),
    (6, 'https://file.hstatic.net/1000075078/file/kv_tra_choco_1x1_4af0a1d225e541c7b2321f4137ae38ca_grande.jpg'),
    (7, 'https://file.hstatic.net/1000075078/file/kv_tra_oolong_1x1_373e6034896d4387b7a819c3ca9cba60_grande.jpg'),
    (8, 'https://file.hstatic.net/1000075078/file/kvmatcha_1x1_303ed02b088b4d3caec428b0e59b897d_grande.jpg')
GO

INSERT INTO dbo.Mon VALUES
            (N'Americano', 10, N'Cà Phê'),
            (N'Bạc Sỉu', 20, N'Cà Phê'),
            (N'Cà Phê Đen', 15, N'Cà Phê'),
            (N'Cà Phê Sữa', 30, N'Cà Phê'),
            (N'Cappucinno', 50, N'Cà Phê'),
            (N'Trà Cherry Macchiato', 100, N'Trà & Macchiato'),
            (N'Trà Đào Cam Sả', 80, N'Trà & Macchiato')
GO

INSERT INTO dbo.HinhAnhMon VALUES
            (N'Americano', 'https://product.hstatic.net/1000075078/product/americano_large.jpg'),
            (N'Bạc Sỉu', 'https://product.hstatic.net/1000075078/product/white_vnese_coffee_9968c1184d7f4634a9bb9fce7b5ff313_large.jpg'),
            (N'Cà Phê Đen', 'https://product.hstatic.net/1000075078/product/vnese_coffee_large.jpg'),
            (N'Cà Phê Sữa', 'https://product.hstatic.net/1000075078/product/cfs_large.jpg'),
            (N'Cappucinno', 'https://product.hstatic.net/1000075078/product/cappuccino_large.jpg'),
            (N'Trà Cherry Macchiato', 'https://product.hstatic.net/1000075078/product/cherry_mac_6a3403fdb832464da88de8c6e6ddf662_large.jpg'),
            (N'Trà Đào Cam Sả', 'https://product.hstatic.net/1000075078/product/tra_dao_cam_sa_on_bg_large.jpg')
GO

INSERT INTO dbo.pOption VALUES
            ('S', N'Americano', 12000, N'Cà Phê'),
            ('L', N'Americano', 12000, N'Cà Phê'),
            ('S', N'Bạc Sỉu', 10000, N'Cà Phê 2'),
            ('L', N'Bạc Sỉu', 10000, N'Cà Phê 2'),
            ('L', N'Cà Phê Đen', 10000, N'Cà Phê 3'),
            ('S', N'Cà Phê Sữa', 15000, N'Cà Phê 4'),
            ('L', N'Cà Phê Sữa', 15000, N'Cà Phê 4'),
            ('S', N'Cappucinno', 20000, N'Cà Phê 5'),
            ('L', N'Cappucinno', 20000, N'Cà Phê 5'),
            ('S', N'Trà Cherry Macchiato', 18000, N'Trà & Macchiato'),
            ('L', N'Trà Cherry Macchiato', 18000, N'Trà & Macchiato'),
            ('S', N'Trà Đào Cam Sả', 17000, N'Trà & Macchiato 2'),
            ('L', N'Trà Đào Cam Sả', 17000, N'Trà & Macchiato 2')
GO

INSERT INTO dbo.NhanvienLamMon VALUES
            (1, N'Americano'),
            (1, N'Bạc Sỉu'),
            (1, N'Cà Phê Đen'),
            (1, N'Cà Phê Sữa'),
            (1, N'Cappucinno'),
            (1, N'Trà Cherry Macchiato'),
            (1, N'Trà Đào Cam Sả')
GO

INSERT KhuyenMai VALUES
    (7, 40, GETDATE(), GETDATE() + 3, 30, N'Noel', 35000),
    (7, 30, GETDATE(), GETDATE() + 2, 30, N'Noel', 35000),
    (7, 40, GETDATE(), GETDATE() + 1, 30, N'Noel', 35000),
    (7, 30, GETDATE(), GETDATE() + 5, 30, N'Noel', 35000),
    (7, 30, GETDATE(), GETDATE() + 2, 30, N'Valentine', 35000),
    (7, 35, GETDATE(), GETDATE() + 3, 30, N'Valentine', 35000),
    (7, 40, GETDATE(), GETDATE() + 1, 30, N'Valentine', 35000)
GO

INSERT DoituongKM VALUES
    (N'Đồng', 4),
    (N'Bạc', 4),
    (N'Vàng', 4),
    (N'Kim Cương', 4),
    (N'Đồng', 2),
    (N'Bạc', 2),
    (N'Vàng', 2),
    (N'Kim Cương', 2),
    (N'Đồng', 3),
    (N'Bạc', 3),
    (N'Vàng', 3),
    (N'Kim Cương', 3)
GO

INSERT TintucNhacKM VALUES
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 5),
    (2, 6),
    (2, 7)
GO

INSERT ChiNhanh VALUES
    ('63', N'Thống Nhất', N'TP HCM', N'Quận 1', 'vtquan01010@gmail.com', '0972723745'),
    ('1A', N'Phan Châu Trinh', N'TP HCM', N'Quận 10', 'vtquan0101@gmail.com', '0972721235'),
    ('145', N'Phạm Văn Đồng', N'TP HCM', N'Quận 2', 'vtquan@gmail.com', '0923421235')
GO

INSERT QuanliChinhanh VALUES
    (7, 1),
    (7, 2),
    (7, 3)
GO

INSERT Kho VALUES
    (1, 1000, N'Nhập', GETDATE()),
    (2, 1400, N'Nhập', GETDATE()),
    (3, 2300, N'Nhập', GETDATE())
GO

INSERT Donhang VALUES
    (GETDATE(), N'TP HCM', '25', N'Đặng Văn Bi', N'Thủ Đức', 10000, 4, 2, '0905304999'),
    (GETDATE(), N'TP HCM', '25', N'Đặng Văn Bi', N'Thủ Đức', 10000, 5, 3, '0905304999')
GO

INSERT DonHangGom VALUES
    (2, N'Cappucinno', 1, 35000),
    (2, N'Trà Đào Cam Sả', 3, 35000)
GO

INSERT PhanHoi VALUES
    (5, GETDATE(), N'So Sweet', 4.5),
    (6, GETDATE(), N'So Sweet', 4.5)
GO