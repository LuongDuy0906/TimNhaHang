-- Giả sử tên bảng là 'restaurants'
INSERT INTO restaurants (name, address, category, price_range, closing, opening, rating, image_url) VALUES
('Phở 10 Lý Quốc Sư', '10 Lý Quốc Sư, Hoàn Kiếm, Hà Nội', 'Phở', 'Trung bình', '22:00', '06:00', 4.5, 'http://example.com/images/pho10.jpg'),
('Bún Chả Hương Liên (Obama)', '24 Lê Văn Hưu, Hai Bà Trưng, Hà Nội', 'Bún chả', 'Trung bình', '21:00', '10:00', 4.7, 'http://example.com/images/buncha_obama.jpg'),
('Cà phê Giảng', '39 Nguyễn Hữu Huân, Hoàn Kiếm, Hà Nội', 'Cà phê', 'Rẻ', '22:30', '07:00', 4.6, 'http://example.com/images/caphegiang.jpg'),
('Ốc Đào', '212B/C79 Nguyễn Trãi, Quận 1, TPHCM', 'Hải sản', 'Cao', '23:00', '16:00', 4.2, 'http://example.com/images/ocdao.jpg'),
('Mì Quảng Bà Mua', '19 Trần Bình Trọng, Hải Châu, Đà Nẵng', 'Mì Quảng', 'Rẻ', '21:00', '06:30', 4.3, 'http://example.com/images/miquangbamua.jpg'),
('Sen Tây Hồ', '614 Lạc Long Quân, Tây Hồ, Hà Nội', 'Buffet', 'Rất cao', '22:00', '18:00', 4.4, 'http://example.com/images/sentayho.jpg'),
('El Gaucho Steakhouse', '74 Hai Bà Trưng, Quận 1, TPHCM', 'Đồ Âu', 'Rất cao', '23:00', '11:00', 4.8, 'http://example.com/images/elgaucho.jpg'),
('Bánh Mì Huỳnh Hoa', '26 Lê Thị Riêng, Quận 1, TPHCM', 'Bánh mì', 'Trung bình', '22:00', '14:00', 4.9, 'http://example.com/images/banhmihuynhhoa.jpg'),
('Nhà hàng Chay Vị Lai', '4A Ngõ 67 Lý Thường Kiệt, Hoàn Kiếm, Hà Nội', 'Đồ chay', 'Cao', '22:00', '10:00', 4.6, 'http://example.com/images/chayvilai.jpg'),
('Pizza 4P''s', '8/15 Lê Thánh Tôn, Quận 1, TPHCM', 'Pizza', 'Cao', '22:00', '10:00', 4.7, 'http://example.com/images/pizza4ps.jpg'),
('Cơm Tấm Ba Ghiền', '84 Đặng Văn Ngữ, Phú Nhuận, TPHCM', 'Cơm tấm', 'Trung bình', '21:00', '07:00', 4.4, 'http://example.com/images/comtamba.jpg'),
('Hải Sản Bé Mặn', 'Võ Nguyên Giáp, Sơn Trà, Đà Nẵng', 'Hải sản', 'Cao', '23:00', '09:00', 4.5, 'http://example.com/images/beman.jpg'),
('Cộng Cà Phê', '127 Bùi Viện, Quận 1, TPHCM', 'Cà phê', 'Trung bình', '23:30', '07:30', 4.1, 'http://example.com/images/congcaphe.jpg'),
('Sushi Hokkaido Sachi', '139 Nguyễn Trãi, Quận 1, TPHCM', 'Đồ Nhật', 'Rất cao', '22:00', '11:00', 4.6, 'http://example.com/images/sushihokkaido.jpg'),
('Chè Thái Ý Phương', '382 Nguyễn Tri Phương, Quận 10, TPHCM', 'Tráng miệng', 'Rẻ', '23:00', '10:00', 4.0, 'http://example.com/images/chethai.jpg'),
('Bún Bò Huế Đông Ba', '110 Nguyễn Du, Quận 1, TPHCM', 'Bún bò Huế', 'Trung bình', '21:00', '06:00', 4.1, 'http://example.com/images/bunbohue.jpg'),
('Lẩu Phan', '7 Đào Duy Anh, Đống Đa, Hà Nội', 'Lẩu', 'Trung bình', '23:00', '11:00', 3.9, 'http://example.com/images/lauphan.jpg'),
('GoGi House', '189 Nguyễn Xí, Bình Thạnh, TPHCM', 'Đồ Hàn', 'Cao', '22:00', '10:00', 4.3, 'http://example.com/images/gogi.jpg'),
('Kem Tràng Tiền', '35 Tràng Tiền, Hoàn Kiếm, Hà Nội', 'Tráng miệng', 'Rẻ', '22:00', '08:00', 4.4, 'http://example.com/images/kemtrangtien.jpg'),
('Tadioto', '24 Tông Đản, Hoàn Kiếm, Hà Nội', 'Bar', 'Cao', '00:00', '18:00', 4.5, 'http://example.com/images/tadioto.jpg');

INSERT INTO booking (restaurant_id, user_id, created_at, booking_time)
VALUES
    (1, 'ggaoOglmbtSHRkaD3z6NrFbRJRx2', '2023-10-25 09:30:00', '2023-10-27 18:30:00'),
    (2, 'ggaoOglmbtSHRkaD3z6NrFbRJRx2', '2023-10-25 14:15:00', '2023-10-27 20:00:00'),
    (5, 'ggaoOglmbtSHRkaD3z6NrFbRJRx2', '2023-10-26 10:00:00', '2023-11-01 12:00:00'),
    (3, 'ggaoOglmbtSHRkaD3z6NrFbRJRx2', '2023-10-26 16:45:00', '2023-11-05 19:00:00'),
    (4, 'ggaoOglmbtSHRkaD3z6NrFbRJRx2', '2023-10-27 08:20:00', '2023-10-28 11:30:00');

INSERT INTO saves (user_id, restaurant_id, created_at) 
VALUES 
('ggaoOglmbtSHRkaD3z6NrFbRJRx2', 1, '2023-11-20 08:30:00'),
('ggaoOglmbtSHRkaD3z6NrFbRJRx2', 2, '2023-11-20 09:45:15'),
('ggaoOglmbtSHRkaD3z6NrFbRJRx2', 3, '2023-11-21 12:30:00'),
('ggaoOglmbtSHRkaD3z6NrFbRJRx2', 4, '2023-11-22 18:20:45');