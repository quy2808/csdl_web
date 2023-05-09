/*--------------- Lọc biên bản nhận hàng theo hình thức nhận hàng ------------*/	
DELIMITER $$
DROP PROCEDURE IF EXISTS bienban_nhanhang $$
CREATE PROCEDURE bienban_nhanhang
(
    IN selected VARCHAR(20)
)
BEGIN
	SELECT * FROM ( 
    SELECT bienban.ID, 
    nhanvien.hoten AS NV_taobienban,
    qua_trinh_giao_hang,
    Mucphi, 
    Thongtin_hang, 
    gui.hoten AS Nguoi_gui, 
    nhan.hoten AS Nguoi_nhan,
    Ngaynhan,
    Hinhthuc_nhanhang
    FROM bienban
    JOIN khachhang AS gui ON gui.ID = bienban.ID_khachgui
    JOIN khachhang AS nhan ON nhan.ID = bienban.ID_khachnhan
    JOIN bienban_nhan ON bienban_nhan.ID = bienban.ID AND bienban_nhan.Hinhthuc_nhanhang = selected
    JOIN nvbienban ON nvbienban.ID = bienban.ID_nhanvien
    JOIN nhanvien ON nvbienban.CCCD = nhanvien.CCCD) AS bbgui;
END;$$
-- CALL bienban_nhanhang('Nhan tai nha');



/*--------------- Lọc biên bản nhận hàng với mức phí lớn hơn giá trị input nhập vào ------------*/	
DELIMITER $$
DROP PROCEDURE IF EXISTS greaterFee $$
CREATE PROCEDURE greaterFee(IN check_mucphi DECIMAL(10,2)) DETERMINISTIC
BEGIN
	SELECT bienban.ID, 
    nhanvien.hoten AS NV_taobienban,
    qua_trinh_giao_hang,
    Mucphi, 
    Thongtin_hang, 
    gui.hoten AS Nguoi_gui, 
    nhan.hoten AS Nguoi_nhan,
    Ngaynhan,
    Hinhthuc_nhanhang
    FROM bienban
    JOIN khachhang AS gui ON gui.ID = bienban.ID_khachgui
    JOIN khachhang AS nhan ON nhan.ID = bienban.ID_khachnhan
    JOIN bienban_nhan ON bienban_nhan.ID = bienban.ID
    JOIN nvbienban ON nvbienban.ID = bienban.ID_nhanvien
    JOIN nhanvien ON nvbienban.CCCD = nhanvien.CCCD
    WHERE Mucphi > check_mucphi
    ORDER BY Mucphi, bienban.ID  DESC;
 END;$$
-- CALL greaterFee("30000");


/*--------------- Truy vấn biên bản gửi theo 1 năm cụ thể  ------------*/	
DELIMITER $$
DROP PROCEDURE IF EXISTS Bienbantrongnam $$
CREATE PROCEDURE Bienbantrongnam(
IN yearCheck CHAR(4)) DETERMINISTIC
BEGIN
	SELECT * FROM ( 
    SELECT bienban.ID, 
    nhanvien.hoten AS NV_taobienban,
    qua_trinh_giao_hang,
    Mucphi, 
    Thongtin_hang, 
    gui.hoten AS Nguoi_gui, 
    nhan.hoten AS Nguoi_nhan,
    Ngaygui
    FROM bienban
    JOIN khachhang AS gui ON gui.ID = bienban.ID_khachgui
    JOIN khachhang AS nhan ON nhan.ID = bienban.ID_khachnhan
    JOIN bienban_gui ON bienban_gui.ID = bienban.ID AND YEAR(bienban_gui.Ngaygui) = yearCheck
    JOIN nvbienban ON nvbienban.ID = bienban.ID_nhanvien
    JOIN nhanvien ON nvbienban.CCCD = nhanvien.CCCD)
    AS bbgui;
 END;$$
--  CALL Bienbantrongnam ('2022')


/*--------------- Truy vấn biên bản gửi để tính doanh thu ( tổng mức phí gửi ) trong 1 năm ------------*/	
DELIMITER $$
DROP PROCEDURE IF EXISTS Doanhthu1nam $$
CREATE PROCEDURE Doanhthu1nam(
IN yearCheck CHAR(4)) DETERMINISTIC
BEGIN
	SELECT SUM(Mucphi) AS DoanhThu FROM bienban
    JOIN bienban_gui ON bienban_gui.ID = bienban.ID
    WHERE YEAR(bienban_gui.Ngaygui) = yearCheck;
 END;$$
-- CALL Doanhthu1nam ('2022')


/*--------------- Truy vấn biên bản nhận và gửi sử dụng hàm gộp để tính doanh thu từng tháng qua các năm ------------*/	
DELIMITER $$
DROP PROCEDURE IF EXISTS Doanhthu $$
CREATE PROCEDURE Doanhthu() DETERMINISTIC
BEGIN
	SELECT gui_nhan.Thang, SUM(gui_nhan.phi) AS doanhthu_thang FROM (
	SELECT MONTH(bienban_nhan.Ngaynhan) AS Thang, SUM(Mucphi) AS phi FROM bienban
    JOIN bienban_nhan ON bienban_nhan.ID = bienban.ID
    GROUP BY Thang
    UNION
    SELECT MONTH(bienban_gui.Ngaygui) AS Thang, SUM(Mucphi) AS phi FROM bienban
    JOIN bienban_gui ON bienban_gui.ID = bienban.ID
    GROUP BY Thang
    ) gui_nhan
    GROUP BY Thang
    ORDER BY Thang;
 END;$$
--  CALL Doanhthu() 
 
 
 
