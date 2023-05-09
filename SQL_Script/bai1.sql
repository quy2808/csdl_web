USE vanchuyen;

	/*-------------- CÁC PROCEDURE CHO NHÂN VIÊN -----------*/	
    
/*-------------- Tạo ID tự động cho tài xế khi có CCCD của nhân viên -----------*/					 
DELIMITER $$
DROP PROCEDURE IF EXISTS foreign_taixe $$
CREATE PROCEDURE foreign_taixe
(
    IN CCCDVal VARCHAR(12)
)
BEGIN
	INSERT INTO taixe (ID, CCCD) VALUES (getnewID_taixe(), CCCDVal);
END;$$



/*-------------- Tạo ID tự động cho lơ xe khi có CCCD của nhân viên -----------*/			 
DELIMITER $$
DROP PROCEDURE IF EXISTS foreign_loxe $$
CREATE PROCEDURE foreign_loxe
(
    IN CCCDVal VARCHAR(12)
)
BEGIN
	INSERT INTO loxe (ID, CCCD) VALUES (getnewID_loxe(), CCCDVal);
END;$$



/*-------------- Tạo ID tự động cho nhân viên biên bản khi có CCCD của nhân viên -----------*/			 
DELIMITER $$
DROP PROCEDURE IF EXISTS foreign_nvbb $$
CREATE PROCEDURE foreign_nvbb
(
    IN CCCDVal VARCHAR(12)
)
BEGIN
	INSERT INTO nvbienban (ID, CCCD) VALUES (getnewID_nvbb(), CCCDVal);
END;$$



/*-------------- Tạo mã mới cho quản lí khi có CCCD của quản lí -----------*/				
DELIMITER $$
DROP PROCEDURE IF EXISTS foreign_quanli $$
CREATE PROCEDURE foreign_quanli
(
    IN CCCDVal VARCHAR(12)
)
BEGIN
	INSERT INTO quanli (ma_quanli, CCCD) VALUES (getnewID_quanli(), CCCDVal);
END;$$



/*-------------- Nhập thông tin nhân viên theo form -----------*/		
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertNhanVien $$
CREATE PROCEDURE InsertNhanVien(
IN CCCD CHAR(12),
IN hoten VARCHAR(45),
IN namsinh INT,
IN email VARCHAR(45),
IN mucluong INT,
IN gioitinh VARCHAR(4),
IN sdt VARCHAR(10),
IN NVtype CHAR(1),
OUT result VARCHAR(255)
)
BEGIN
	DECLARE tuoi INT DEFAULT 0;
    DECLARE congty VARCHAR(45) DEFAULT 'Viet Tan Phat';
    SET result = '';
    SET tuoi = (YEAR(CURDATE()) - namsinh);
    IF(CCCD NOT REGEXP '[0-9]{12}') THEN
		SET result = 'CCCD không được chứa các kí tự khác chữ số';
	END IF;
	IF(LENGTH(CCCD)!=12) THEN
		SET result = 'CCCD phải có đủ 12 chữ số';
	ELSEIF(hoten REGEXP '[^a-zA-Z ]') THEN
		SET result = 'Họ tên chỉ có thể chứa chữ cái và khoảng cách';
	ELSEIF ( tuoi < 18) THEN
		SET result = 'Nhân viên phải trên 18 tuổi mới được tham gia công việc';
	ELSEIF (email NOT REGEXP '^[A-Z0-9._%-]{2,15}+@[A-Z0-9.-]+\.[A-Z]{2,4}$') THEN
		SET result = 'Địa chỉ email không hợp lệ';
	ELSEIF (mucluong <3000000 OR mucluong>30000000) THEN
		SET result = 'Mức lương không phù hợp với nhân viên';
	ELSEIF (sdt NOT LIKE ('0%')) THEN 
		SET result = 'Chữ số đầu tiên trong số điện thoại phải bằng 0';
	ELSEIF (sdt NOT REGEXP '[0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') THEN
		SET result = 'Không đủ số lượng (10 chữ số) hoặc chứa ký tự lạ';
	ELSEIF EXISTS (SELECT * FROM nhanvien WHERE nhanvien.email = email) THEN
		SET result = 'Địa chỉ email đã sử dụng, vui lòng nhập email khác';
	ELSEIF EXISTS (SELECT * FROM nhanvien WHERE nhanvien.sdt = sdt) THEN
		SET result = 'Số điện thoại đã được sử dụng, vui lòng nhập số điện thoại khác';
	END IF;
	IF (result = '') THEN
    INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES  (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt);
		IF (NVtype = '0') THEN CALL foreign_taixe(CCCD);
		ELSEIF (NVtype = '1') THEN CALL foreign_loxe(CCCD);
		ELSEIF (NVtype = '2') THEN CALL foreign_nvbb(CCCD);
		ELSEIF (NVtype = '3') THEN CALL foreign_quanli(CCCD);
		END IF;
    END IF;
END;$$
-- CALL InsertNhanVien('123456711111','A','2002','anh1510@gmil.com', '11111111', 'Nam', '0111171275','0', @result);
-- SELECT * FROM nhanvien

/*-------------- Cập nhật thông tin nhân viên (không thay đổi vai trò công việc)-----------*/			
DELIMITER $$
DROP PROCEDURE IF EXISTS UpdateNV_coban $$
CREATE PROCEDURE UpdateNV_coban(
IN CCCD CHAR(12),
IN hoten VARCHAR(45),
IN namsinh INT,
IN email VARCHAR(45),
IN mucluong INT,
IN gioitinh VARCHAR(4),
IN sdt VARCHAR(10),
OUT result VARCHAR(255)
)
BEGIN
	UPDATE nhanvien
	SET nhanvien.hoten = hoten, 
		nhanvien.namsinh = namsinh, 
		nhanvien.email = email, 
		nhanvien.mucluong = mucluong, 
		nhanvien.gioitinh = gioitinh, 
		nhanvien.sdt = sdt
	WHERE nhanvien.CCCD = CCCD;
END;$$
-- CALL UpdateNV_coban('062202001458','Nguyen Van B','2002','anh1111118@gmail.com', '11111111', 'Nam', '0158991235', @result);
-- SELECT * FROM nhanvien

/*-------------- Cập nhật thông tin nhân viên theo form -----------*/			
DELIMITER $$
DROP PROCEDURE IF EXISTS UpdateNV $$
CREATE PROCEDURE UpdateNV(
IN CCCD CHAR(12),
IN hoten VARCHAR(45),
IN namsinh INT,
IN email VARCHAR(45),
IN mucluong INT,
IN gioitinh VARCHAR(4),
IN sdt VARCHAR(10),
IN NVtype CHAR(1),
OUT result VARCHAR(255)
)
BEGIN
	DECLARE tuoi INT DEFAULT 0;
    DECLARE congty VARCHAR(45) DEFAULT 'Viet Tan Phat';
    SET result = '';
    SET tuoi = (YEAR(CURDATE()) - namsinh);
    IF(CCCD NOT REGEXP '[0-9]{12}') THEN
		SET result = 'CCCD không được chứa các kí tự khác chữ số';
	END IF;
	IF(LENGTH(CCCD)!=12) THEN
		SET result = 'CCCD phải có đủ 12 chữ số';
	ELSEIF(hoten REGEXP '[^a-zA-Z ]') THEN
		SET result = 'Họ tên chỉ có thể chứa chữ cái và khoảng cách';
	ELSEIF ( tuoi < 18) THEN
		SET result = 'Nhân viên phải trên 18 tuổi mới được tham gia công việc';
	ELSEIF (email NOT REGEXP '^[A-Z0-9._%-]{2,15}+@[A-Z0-9.-]+\.[A-Z]{2,4}$') THEN
		SET result = 'Địa chỉ email không hợp lệ';
	ELSEIF (mucluong < 3000000 OR mucluong > 30000000) THEN
		SET result = 'Mức lương không phù hợp với nhân viên';
	ELSEIF (sdt NOT LIKE ('0%')) THEN 
		SET result = 'Chữ số đầu tiên trong số điện thoại phải bằng 0';
	ELSEIF (sdt NOT REGEXP '[0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') THEN
		SET result = 'Không đủ số lượng (10 chữ số) hoặc chứa ký tự lạ';
	ELSEIF EXISTS (SELECT * FROM nhanvien WHERE nhanvien.email = email AND nhanvien.CCCD != CCCD) THEN
		SET result = 'Địa chỉ email đã sử dụng, vui lòng nhập email khác';
	ELSEIF EXISTS (SELECT * FROM nhanvien WHERE nhanvien.sdt = sdt AND nhanvien.CCCD != CCCD) THEN
		SET result = 'Số điện thoại đã được sử dụng, vui lòng nhập số điện thoại khác';
	END IF;
	IF (result = '') THEN
		UPDATE nhanvien
		SET nhanvien.hoten = hoten, 
			nhanvien.namsinh = namsinh, 
			nhanvien.email = email, 
			nhanvien.mucluong = mucluong, 
			nhanvien.gioitinh = gioitinh, 
			nhanvien.sdt = sdt
		WHERE nhanvien.CCCD = CCCD;
     IF EXISTS (SELECT taixe.CCCD FROM taixe WHERE taixe.CCCD = CCCD) THEN 
			DELETE FROM taixe WHERE taixe.CCCD = CCCD;
		ELSEIF EXISTS (SELECT loxe.CCCD FROM loxe WHERE loxe.CCCD = CCCD) THEN 
			DELETE FROM loxe WHERE loxe.CCCD = CCCD;
		ELSEIF EXISTS (SELECT nvbienban.CCCD FROM nvbienban WHERE nvbienban.CCCD = CCCD) THEN 
			DELETE FROM nvbienban WHERE nvbienban.CCCD = CCCD;
		ELSEIF EXISTS (SELECT quanli.CCCD FROM quanli WHERE quanli.CCCD = CCCD) THEN 
			DELETE FROM quanli WHERE quanli.CCCD = CCCD;
		END IF;
		IF (NVtype = '0') THEN CALL foreign_taixe(CCCD);
		ELSEIF (NVtype = '1') THEN CALL foreign_loxe(CCCD);
		ELSEIF (NVtype = '2') THEN CALL foreign_nvbb(CCCD);
		ELSEIF (NVtype = '3') THEN CALL foreign_quanli(CCCD);
		END IF;
    END IF;
END;$$
-- CALL UpdateNV('062202001458','Nguyen Van A','2002','anh1111118@gmail.com', '11111111', 'Nam', '0114656819','2', @result);
-- SELECT @result


/*-------------- Xóa thông tin nhân viên theo CCCD -----------*/				
DELIMITER $$
DROP PROCEDURE IF EXISTS DeletefromCCCD $$
CREATE PROCEDURE DeletefromCCCD
(
	IN CCCDCheck CHAR(12)
)
BEGIN
	DELETE FROM nhanvien where CCCD = CCCDCheck;
END;$$
-- CALL DeletefromCCCD('062202000003');
-- SELECT * FROM nhanvien

/*-------------- Kiểm tra đối tượng đó có tồn tại khi xóa thông tin nhân viên theo CCCD -----------*/				
DELIMITER $$
DROP PROCEDURE IF EXISTS DeleteNVfromCCCD $$
CREATE PROCEDURE DeleteNVfromCCCD
(
	IN CCCDCheck CHAR(12),
    OUT result VARCHAR(45)
)
BEGIN
	SET result = '';
	IF NOT EXISTS (SELECT * FROM nhanvien WHERE CCCD = CCCDCheck) THEN 
		SET result = 'Không tồn tại nhân viên có CCCD như trên';
    END IF; 
    IF (result = '') THEN 
		DELETE FROM nhanvien where CCCD = CCCDCheck;
    END IF;
END;$$
-- SELECT * FROM nhanvien
-- SELECT @result


/*-------------- Xóa thông tin nhân viên theo Họ (firstname) -----------*/				 
DELIMITER $$
DROP PROCEDURE IF EXISTS DeletefromFirstName $$
CREATE PROCEDURE DeletefromFirstName
(
	IN FirstName VARCHAR(12)
)
BEGIN
	DELETE FROM nhanvien where hoten LIKE CONCAT(FirstName,' %');
END;$$
-- CALL DeletefromFirstName('Nguyen');
-- SELECT * FROM nhanvien


/*------------- Xóa thông tin nhân viên có mức lương dưới input đầu vào (firstname) ------------*/				 
DELIMITER $$
DROP PROCEDURE IF EXISTS DeletefromFirstName $$
CREATE PROCEDURE DeletefromFirstName
(
	IN mucluongVal INT
)
BEGIN
	DELETE FROM nhanvien where mucluong < mucluongVal;
END;$$
-- CALL DeletefromFirstName(15000000);
-- SELECT * FROM nhanvien


/*-------------- Tìm kiếm nhân viên theo CCCD -----------*/
DELIMITER $$
DROP PROCEDURE IF EXISTS SearchNVByCCCD $$
CREATE PROCEDURE SearchNVByCCCD
(
	CCCDcheck varchar (10)
)
BEGIN
	SELECT * FROM nhanvien WHERE CCCD LIKE CONCAT('%',CCCDcheck,'%');
END;$$
-- CALL SearchNVByCCCD('062202001')


/*-------------- Tìm kiếm nhân viên theo tên -----------*/
DELIMITER $$
DROP PROCEDURE IF EXISTS SearchNVByName $$
CREATE PROCEDURE SearchNVByName
(
	Namecheck varchar (10)
)
BEGIN
	SELECT * FROM nhanvien WHERE hoten LIKE CONCAT('%',Namecheck,'%');
END;$$
-- CALL SearchNVByName('Tan')


/*---------------- Tìm kiếm các thông tin nhân viên liên quan tới input đầu vào -------------*/					 
DELIMITER $$
DROP PROCEDURE IF EXISTS searchNV $$
CREATE PROCEDURE searchNV
(
    IN searchText VARCHAR(50)
)
BEGIN
	SELECT * FROM nhanvien 
    WHERE CCCD LIKE CONCAT('%',searchText,'%')
    OR hoten LIKE CONCAT('%',searchText,'%')
    OR namsinh LIKE CONCAT('%',searchText,'%')
    OR email LIKE CONCAT('%',searchText,'%')
    OR congty LIKE CONCAT('%',searchText,'%')
    OR mucluong LIKE CONCAT('%',searchText,'%')
    OR sdt LIKE CONCAT('%',searchText,'%')
    OR gioitinh LIKE CONCAT('%',searchText,'%');
END;$$
-- CALL searchNV('duy');


/*-------------- Cập nhật mức lương cho toàn bộ nhân viên -----------*/			 
DELIMITER $$
DROP PROCEDURE IF EXISTS UpdateSalary $$
CREATE PROCEDURE UpdateSalary()
BEGIN
	UPDATE nhanvien
    SET mucluong = mucluong*1.1;
END;$$
-- CALL UpdateSalary();
-- SELECT * FROM nhanvien


/*-------------- Cập nhật mức lương cho lơ xe -----------*/					 
DELIMITER $$
DROP PROCEDURE IF EXISTS UpdateSalary_loxe $$
CREATE PROCEDURE UpdateSalary_loxe()
BEGIN
	UPDATE nhanvien
    SET mucluong = mucluong*0.9
    WHERE CCCD IN (
    SELECT CCCD FROM loxe);
END;$$
-- CALL UpdateSalary_loxe();
-- SELECT * FROM nhanvien


/*-------------- Cập nhật mức lương cho các nhân viên có mức lương dưới 16000000 -----------*/				 
DELIMITER $$
DROP PROCEDURE IF EXISTS UpdateSalary15 $$
CREATE PROCEDURE UpdateSalary15
()
BEGIN
	UPDATE nhanvien
    SET mucluong = mucluong*1.05
    WHERE mucluong < 16000000;
END;$$
-- CALL UpdateSalary15();
-- SELECT * FROM nhanvien




	/*-------------- CÁC PROCEDURE CHO KHÁCH HÀNG -----------*/	

/*-------------- Nhập thông tin khách hàng theo form ------------*/					
DELIMITER $$
DROP PROCEDURE IF EXISTS InsertKhachHang $$
CREATE PROCEDURE InsertKhachHang(
IN hoten VARCHAR(45),
IN namsinh INT ,
IN Diachi VARCHAR(100),
IN sdt VARCHAR(12),
IN email VARCHAR(45),
IN gui INT,
IN nhan INT,
OUT result VARCHAR(255)
)
BEGIN
	DECLARE ID_kh INT;
	DECLARE tuoi INT DEFAULT 0;
	SET result = '';
	SET tuoi = (YEAR(CURDATE()) - namsinh);
	IF(hoten REGEXP '[^a-zA-Z ]') THEN
		SET result = 'Họ tên chỉ có thể chứa chữ cái và khoảng cách';
	ELSEIF ( tuoi < 10 OR tuoi > 100) THEN
		SET result = 'Tuổi không hợp lệ'; 
	ELSEIF (sdt NOT LIKE ('0%')) THEN 
		SET result = 'Chữ số đầu tiên trong số điện thoại phải bằng 0';
	ELSEIF (sdt NOT REGEXP '[0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') THEN
		SET result = 'Không đủ số lượng (10 chữ số) hoặc chứa ký tự lạ';
	ELSEIF (email NOT REGEXP '^[A-Z0-9._%-]{2,15}+@[A-Z0-9.-]+\.[A-Z]{2,4}$') THEN
		SET result = 'Địa chỉ email không hợp lệ';
	ELSEIF EXISTS (SELECT * FROM khachhang WHERE khachhang.email = email) THEN
		SET result = 'Địa chỉ email đã sử dụng, vui lòng nhập email khác';
	ELSEIF EXISTS (SELECT * FROM khachhang WHERE khachhang.sdt = sdt) THEN
		SET result = 'Số điện thoại đã được sử dụng, vui lòng nhập số điện thoại khác';
	END IF;
    IF (result = '') THEN
    	SET ID_kh = getnewID_kh();
		INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES (ID_kh, hoten, namsinh, Diachi, sdt, email);
		IF (nhan = 1) THEN INSERT INTO khachnhan (ID_khachnhan) VALUES (ID_kh); END IF;
		IF (gui = 1) THEN INSERT INTO khachgui (ID_khachgui) VALUES (ID_kh); END IF;
	END IF;
END;$$
-- CALL InsertKhachHang('Vo Cong Anh', '2004', '102 Chu Van An, Phuong 12, Quan Binh Thanh, TP Ho Chi Minh','0977453403','anh8801@gmail.com','1','0', @result);
-- SELECT @result;


/*-------------- Cập nhật thông tin khách hàng theo form ------------*/				 
DELIMITER $$
DROP PROCEDURE IF EXISTS UpdateKH $$
CREATE PROCEDURE UpdateKH
(
IN ID INT,
IN hoten VARCHAR(45),
IN namsinh INT ,
IN Diachi VARCHAR(100),
IN sdt VARCHAR(12),
IN email VARCHAR(45),
IN gui INT,
IN nhan INT,
OUT result VARCHAR(255)
)
BEGIN
	DECLARE tuoi INT DEFAULT 0;
	SET result = '';
	SET tuoi = (YEAR(CURDATE()) - namsinh);
	IF(hoten REGEXP '[^a-zA-Z ]') THEN
		SET result = 'Họ tên chỉ có thể chứa chữ cái và khoảng cách';
	ELSEIF ( tuoi < 10 OR tuoi > 100) THEN
		SET result = 'Tuổi không hợp lệ'; 
	ELSEIF (sdt NOT LIKE ('0%')) THEN 
		SET result = 'Chữ số đầu tiên trong số điện thoại phải bằng 0';
	ELSEIF (sdt NOT REGEXP '[0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') THEN
		SET result = 'Không đủ số lượng (10 chữ số) hoặc chứa ký tự lạ';
	ELSEIF (email NOT REGEXP '^[A-Z0-9._%-]{2,15}+@[A-Z0-9.-]+\.[A-Z]{2,4}$') THEN
		SET result = 'Địa chỉ email không hợp lệ';
	ELSEIF EXISTS (SELECT * FROM khachhang WHERE khachhang.email = email AND khachhang.ID != ID) THEN
		SET result = 'Địa chỉ email đã sử dụng, vui lòng nhập email khác';
	ELSEIF EXISTS (SELECT * FROM khachhang WHERE khachhang.sdt = sdt AND khachhang.ID != ID) THEN
		SET result = 'Số điện thoại đã được sử dụng, vui lòng nhập số điện thoại khác';
	END IF;
	IF (result = '') THEN
		UPDATE khachhang
		SET khachhang.hoten = hoten, 
			khachhang.namsinh = namsinh,  
			khachhang.Diachi = Diachi, 
			khachhang.email = email,
			khachhang.sdt = sdt
		WHERE khachhang.ID = ID;
	IF EXISTS (SELECT * FROM khachgui WHERE khachgui.ID_khachgui = ID) THEN
		IF (gui = 0) THEN DELETE FROM khachgui WHERE khachgui.ID_khachgui = ID;
		END IF;
	END IF;
	IF NOT EXISTS (SELECT * FROM khachgui WHERE khachgui.ID_khachgui = ID) THEN
		IF (gui = 1) THEN INSERT INTO khachgui (ID_khachgui) VALUES (ID);
        END IF;
	END IF;
	IF EXISTS (SELECT * FROM khachnhan WHERE khachnhan.ID_khachnhan = ID) THEN
		IF (nhan = 0) THEN DELETE FROM khachnhan WHERE khachnhan.ID_khachnhan = ID;
		END IF;
	END IF;
	IF NOT EXISTS (SELECT * FROM khachnhan WHERE khachnhan.ID_khachnhan = ID) THEN
		IF (nhan = 1) THEN INSERT INTO khachnhan (ID_khachnhan) VALUES (ID);
        END IF;
	END IF;
    END IF;
END;$$
-- CALL UpdateKH('800010', 'Vo Cong Lao', '2003', '102 Chu Van An, Phuong 12, Quan Binhi Minh','0977453453','danh1508@gmail.com','0','1',@result);
-- SELECT * FROM khachhang



/*-------------- Tìm kiếm khách hàng theo tên -----------*/
DELIMITER $$
DROP PROCEDURE IF EXISTS SearchKHByName $$
CREATE PROCEDURE SearchKHByName
(
	Namecheck varchar (10)
)
BEGIN
	SELECT * FROM khachhang WHERE hoten LIKE CONCAT('%',Namecheck,'%');
END;$$
-- CALL SearchKHByName('Tuan')


/*---------------- Tìm kiếm các thông tin khách hàng liên quan tới input đầu vào -------------*/		
DELIMITER $$
DROP PROCEDURE IF EXISTS searchKH $$
CREATE PROCEDURE searchKH
(
    IN searchText VARCHAR(50)
)
BEGIN
	SELECT * FROM khachhang 
    WHERE hoten LIKE CONCAT('%',searchText,'%')
    OR namsinh LIKE CONCAT('%',searchText,'%')
    OR Diachi LIKE CONCAT('%',searchText,'%')
    OR sdt LIKE CONCAT('%',searchText,'%')
    OR email LIKE CONCAT('%',searchText,'%');
END;$$
-- CALL searchKH('duy');


/*-------------- Xóa thông tin khách hàng theo số điện thoại -----------*/				
DELIMITER $$
DROP PROCEDURE IF EXISTS DeleteKHfromsdt $$
CREATE PROCEDURE DeleteKHfromsdt
(
	IN SDTCheck CHAR(12)
)
BEGIN
	DELETE FROM khachhang where sdt = SDTCheck;
END;$$
-- CALL DeleteKHfromsdt('0949719566');
-- SELECT * FROM khachhang


/*-------------- Cập nhật thông tin khách hàng gửi và nhận -----------*/			
DELIMITER $$
DROP PROCEDURE IF EXISTS UpdateKHguinhan $$
CREATE PROCEDURE UpdateKHguinhan(
IN ID INT,
IN gui INT,
IN nhan INT,
OUT result VARCHAR(255)
)
BEGIN
	IF EXISTS (SELECT * FROM khachgui WHERE khachgui.ID_khachgui = ID) THEN
		IF (gui = 0) THEN DELETE FROM khachgui WHERE khachgui.ID_khachgui = ID;
		END IF;
	END IF;
	IF NOT EXISTS (SELECT * FROM khachgui WHERE khachgui.ID_khachgui = ID) THEN
		IF (gui = 1) THEN INSERT INTO khachgui (ID_khachgui) VALUES (ID);
        END IF;
	END IF;
	IF EXISTS (SELECT * FROM khachnhan WHERE khachnhan.ID_khachnhan = ID) THEN
		IF (nhan = 0) THEN DELETE FROM khachnhan WHERE khachnhan.ID_khachnhan = ID;
		END IF;
	END IF;
	IF NOT EXISTS (SELECT * FROM khachnhan WHERE khachnhan.ID_khachnhan = ID) THEN
		IF (nhan = 1) THEN INSERT INTO khachnhan (ID_khachnhan) VALUES (ID);
        END IF;
	END IF;
END;$$
-- CALL UpdateKHguinhan('800010','1','0',@result);
-- SELECT * FROM khachgui
-- UNION ALL
-- SELECT * FROM khachnhan




/*-------------- CÁC PROCEDURE CHO BIÊN BẢN -----------*/	

/*-------------- Tạo biên bản gửi ------------*/				
DELIMITER $$
DROP PROCEDURE IF EXISTS Insertbienbangui $$
CREATE PROCEDURE Insertbienbangui
(
  IN ID_nhanvien CHAR(4),
  IN qua_trinh_giao_hang VARCHAR(200),
  IN Mucphi DECIMAL(10,2),
  IN Thongtin_hang VARCHAR(200),
  IN Namgiaodich CHAR(4) ,
  IN ID_khachgui INT,
  IN ID_khachnhan INT,
  IN Ngaygui DATE,
  OUT result VARCHAR(255)
)
BEGIN
	DECLARE ID_bb INT;
    SET result = '';
    IF (Mucphi < 20000) THEN
		SET result = 'Mức phí đơn hàng quá nhỏ (<20000)';
	ELSEIF (Mucphi > 200000) THEN
		SET result = 'Mức phí đơn hàng quá lớn (>200000)';
    ELSEIF (Namgiaodich > YEAR(CURDATE())) THEN
		SET result = 'Năm giao dịch không hợp lệ';
	END IF;
    IF (result ='') THEN
		SET ID_bb = getnewID_bb();
		INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES (ID_bb, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan);
		INSERT INTO bienban_gui (ID, Ngaygui) VALUES (ID_bb, Ngaygui);
	END IF;
END;$$
-- CALL Insertbienbangui('3005', 'Kho TPHCM1 -> Kho KonTum1', '170000', 'ID:600510, khoi luong: 3.00', '2022', '800005', '800002', '2022-11-25', @result);
-- SELECT * FROM bienban


/*-------------- Tạo biên bản nhận ------------*/						
DELIMITER $$
DROP PROCEDURE IF EXISTS Insertbienbannhan $$
CREATE PROCEDURE Insertbienbannhan
(
  IN ID INT,
  IN ID_nhanvien CHAR(4),
  IN qua_trinh_giao_hang VARCHAR(200),
  IN Mucphi DECIMAL(10,2),
  IN Thongtin_hang VARCHAR(200),
  IN Namgiaodich CHAR(4),
  IN ID_khachgui INT,
  IN ID_khachnhan INT,
  IN Ngaynhan DATE,
  IN Hinhthuc_nhanhang VARCHAR(50),
  OUT result VARCHAR(255)
)
BEGIN
	DECLARE ID_bb INT;
    SET result = '';
    IF (Hinhthuc_nhanhang = 'Nhan tai kho') THEN
		SET Mucphi = 0;
	ELSEIF(Hinhthuc_nhanhang = 'Nhan tai nha') THEN
		IF (Mucphi <10000) THEN
			SET result = 'Mức phí đơn hàng quá nhỏ (<10000)';
		ELSEIF (Mucphi > 70000) THEN
			SET result = 'Mức phí đơn hàng quá lớn (>70000)';
		END IF;
    ELSEIF (Namgiaodich > YEAR(CURDATE())) THEN
		SET result = 'Năm giao dịch không hợp lệ';
	END IF;
    IF (result = '') THEN
		SET ID_bb = getnewID_bb();
		INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES (ID_bb, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan);
		INSERT INTO bienban_nhan (ID, Ngaynhan, Hinhthuc_nhanhang) VALUES (ID_bb, Ngaynhan, Hinhthuc_nhanhang);
	END IF;
END;$$


/*-------------- Tạo biên bản gửi với các thông tin cụ thể ------------*/				 
DELIMITER $$
DROP PROCEDURE IF EXISTS Getbienban_gui $$
CREATE PROCEDURE Getbienban_gui() DETERMINISTIC
BEGIN
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
    JOIN bienban_gui ON bienban_gui.ID = bienban.ID
    JOIN nvbienban ON nvbienban.ID = bienban.ID_nhanvien
    JOIN nhanvien ON nvbienban.CCCD = nhanvien.CCCD;
END;$$
-- CALL Getbienban_gui()



/*--------------- Tạo biên bản nhận với các thông tin cụ thể ------------*/					 
DELIMITER $$
DROP PROCEDURE IF EXISTS Getbienban_nhan $$
CREATE PROCEDURE Getbienban_nhan() DETERMINISTIC
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
    JOIN nhanvien ON nvbienban.CCCD = nhanvien.CCCD;
END;$$
-- CALL Getbienban_nhan();


/*---------------- Tìm kiếm các thông tin biên bản gửi liên quan tới input đầu vào -------------*/
DELIMITER $$
DROP PROCEDURE IF EXISTS searchBBGui $$
CREATE PROCEDURE searchBBGui
(
    IN searchText VARCHAR(50)
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
    Ngaygui
    FROM bienban
    JOIN khachhang AS gui ON gui.ID = bienban.ID_khachgui
    JOIN khachhang AS nhan ON nhan.ID = bienban.ID_khachnhan
    JOIN bienban_gui ON bienban_gui.ID = bienban.ID
    JOIN nvbienban ON nvbienban.ID = bienban.ID_nhanvien
    JOIN nhanvien ON nvbienban.CCCD = nhanvien.CCCD) AS bbgui
    WHERE bbgui.NV_taobienban LIKE CONCAT('%',searchText,'%')
    OR bbgui.qua_trinh_giao_hang LIKE CONCAT('%',searchText,'%')
    OR bbgui.Mucphi LIKE CONCAT('%',searchText,'%')
    OR bbgui.Thongtin_hang LIKE CONCAT('%',searchText,'%')
    OR bbgui.Nguoi_gui LIKE CONCAT('%',searchText,'%')
    OR bbgui.Ngaygui LIKE CONCAT('%',searchText,'%');
END;$$
-- CALL searchBBGui('Tu')




