/*-------------- Trigger kiểm tra nhân viên phải sinh sau năm 1950 -----------*/
DELIMITER $$
USE vanchuyen$$
DROP TRIGGER IF EXISTS nhanvien_AFTER_INSERT$$
CREATE DEFINER = CURRENT_USER TRIGGER nhanvien_AFTER_INSERT AFTER INSERT ON nhanvien FOR EACH ROW
BEGIN
	if new.namsinh<1950 then
    begin
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'nhan vien qua do tuoi lao dong';
	end;
    end if;
END$$
DELIMITER ;
-- INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong,gioitinh,sdt) VALUES ('063002000006', 'Nguyen Dinh Tuan', '1949', 'tuan011@gmail.com', 'Viet Tan Phat', '31000000','Nam','0159193265');



/*-------------- Trigger dùng để khống chế lương nhân viên (lương nhân viên phải lớn hơn 0) -----------*/
DELIMITER $$
USE vanchuyen$$
DROP TRIGGER IF EXISTS nhanvien_AFTER_UPDATE$$
CREATE DEFINER = CURRENT_USER TRIGGER nhanvien_AFTER_UPDATE AFTER UPDATE ON nhanvien FOR EACH ROW
BEGIN
	if new.mucluong<0 then
    begin
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'muc luong khong duoc be hon 0';
	end;
    end if;
END$$
DELIMITER ;
-- UPDATE nhanvien SET mucluong=-10000 Where CCCD='063002000005'


/*-------------- Trigger dùng để khống chế số điện thoại phải có 10 số -----------*/
DELIMITER $$
USE vanchuyen$$
DROP TRIGGER IF EXISTS khachhang_AFTER_INSERT$$
CREATE DEFINER = CURRENT_USER TRIGGER khachhang_AFTER_INSERT AFTER INSERT ON khachhang FOR EACH ROW
BEGIN
	if char_length(new.sdt)!=10 then
    begin
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'so dien thoai phai co 10 so';
	end;
    end if;
END$$
DELIMITER ;
-- INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES ('800011', 'Vo Cong Danh', '2003', '102 Chu Van An, Phuong 12, Quan Binh Thanh, TP Ho Chi Minh','077453453','danh1508@gmail.com');



/*-------------- Trigger dùng để cập nhật lại mức phí của bảng biên bản khi cập nhật Tên mới cho khách hàng -----------*/
/*-------------- và biên bản tạo bởi nhân viên biên bản có ID ‘3003’,khách hàng này phải là khách gửi. -----------*/
DELIMITER $$
USE vanchuyen$$
DROP TRIGGER IF EXISTS khachhang_AFTER_UPDATE$$
CREATE DEFINER = CURRENT_USER TRIGGER khachhang_AFTER_UPDATE AFTER UPDATE ON khachhang FOR EACH ROW
BEGIN
       declare a INT;
       select bienban.ID into a from bienban join khachgui join khachhang where khachhang.hoten=new.hoten and khachgui.ID_khachgui=khachhang.ID and bienban.ID_khachgui=khachgui.ID_khachgui and bienban.ID_nhanvien='3003';
		UPDATE bienban
		SET Mucphi=Mucphi*0.9
		WHERE ID IN (a) ;
END$$
DELIMITER ;
-- UPDATE khachhang set hoten = 'Tran Duc Nguyen' where ID=800001


/*----------------- Trigger khống chế khối lượng hàng phải lớn hơn 0 -----------*/
DELIMITER $$
USE vanchuyen$$
DROP TRIGGER IF EXISTS hanghoa_AFTER_UPDATE$$
CREATE DEFINER = CURRENT_USER TRIGGER hanghoa_AFTER_UPDATE AFTER UPDATE ON hanghoa FOR EACH ROW
BEGIN
	if new.Khoiluong<0 then
    begin
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'khoi luong hang khong duoc be hon 0';
	end;
    end if;
END$$
DELIMITER ;
-- UPDATE hanghoa set khoiluong = -1.70 where ID_kienhang=600514



/*--------------- Trigger giúp thêm thông tin vào bảng kiện hàng khi thêm thông tin vào bảng hàng hóa -----------*/
DELIMITER $$
USE vanchuyen$$
DROP TRIGGER IF EXISTS hanghoa_BEFORE_INSERT$$
CREATE DEFINER = CURRENT_USER TRIGGER hanghoa_BEFORE_INSERT BEFORE INSERT ON hanghoa FOR EACH ROW
BEGIN
	if not exists (select ID from kienhang where ID = new.ID_kienhang) then
		INSERT into kienhang (ID, khoiluong) VALUES (new.ID_kienhang, new.Khoiluong);
    end if;
END$$
DELIMITER ;
-- INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600515', 'choi lau nha', 'dung cu lau don', '1', '1.70');



/*--------------- Trigger khống chế bảng yêu cầu nếu Trạng thái là ‘da xu ly’ thì Mức độ ưu tiên của yêu cầu đó là ‘0’ -----------*/
DELIMITER $$
USE vanchuyen$$
DROP TRIGGER IF EXISTS yeucau_BEFORE_UPDATE$$
CREATE DEFINER = CURRENT_USER TRIGGER yeucau_BEFORE_UPDATE BEFORE UPDATE ON yeucau FOR EACH ROW
BEGIN
	if new.Trangthai='da xu ly' then
        set new.Mucdo_uutien='0';
	end if;
END$$
DELIMITER ;
-- UPDATE yeucau set Trangthai = 'da xu ly' where Ma='900002'



/*--------------- Trigger khống chế Thông tin yêu cầu trong bảng yeucau phải bắt đầu từ ‘Ten hang’ -----------*/
DELIMITER $$
USE vanchuyen$$
DROP TRIGGER IF EXISTS yeucau_AFTER_INSERT$$
CREATE DEFINER = CURRENT_USER TRIGGER yeucau_AFTER_INSERT AFTER INSERT ON yeucau FOR EACH ROW
BEGIN
	declare a VARCHAR(8);
    SET a=substring(new.Thongtin_yeucau,1,8);
    if a != 'Ten hang' then
	begin
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Thong tin yeu cau phai co ten hang!';
	end;
    end if;
END$$
DELIMITER ;
-- INSERT INTO yeucau (Ma, ID_bienbangui, ID_khachgui, Thongtin_yeucau, Mucdo_uutien, Trangthai) VALUES ('900006', '700314', '800004','so luong hang: 1, khoi luong: 1.7kg', '2', 'dang xu ly');