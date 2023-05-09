USE vanchuyen;

/*-------------- Tạo giá trị ID mới cho tài xế  -----------*/			 
DELIMITER $$
DROP FUNCTION IF EXISTS getnewID_taixe $$
CREATE FUNCTION getnewID_taixe()
RETURNS CHAR(4) DETERMINISTIC
BEGIN
	DECLARE temp INT;
	DECLARE newID CHAR(4);
	DECLARE maxID CHAR(4);
    SELECT CAST(MAX(ID) AS SIGNED) + 1 INTO temp FROM taixe;
    SET newID = CAST(temp AS CHAR(4));
    RETURN newID;
END;$$



/*-------------- Tạo giá trị ID mới cho lơ xe  -----------*/					 
DELIMITER $$
DROP FUNCTION IF EXISTS getnewID_loxe $$
CREATE FUNCTION getnewID_loxe()
RETURNS CHAR(4) DETERMINISTIC
BEGIN
	DECLARE temp INT;
	DECLARE newID CHAR(4);
	DECLARE maxID CHAR(4);
    SELECT CAST(MAX(ID) AS SIGNED) + 1 INTO temp FROM loxe;
    SET newID = CAST(temp AS CHAR(4));
    RETURN newID;
END;$$



/*-------------- Tạo giá trị ID mới cho nhân viên biên bản  -----------*/				 
DELIMITER $$
DROP FUNCTION IF EXISTS getnewID_nvbb $$
CREATE FUNCTION getnewID_nvbb()
RETURNS CHAR(4) DETERMINISTIC
BEGIN
	DECLARE temp INT;
	DECLARE newID CHAR(4);
	DECLARE maxID CHAR(4);
    SELECT CAST(MAX(ID) AS SIGNED) + 1 INTO temp FROM nvbienban;
    SET newID = CAST(temp AS CHAR(4));
    RETURN newID;
END;$$



/*-------------- Tạo giá trị mã mới cho quản lí  -----------*/				 
DELIMITER $$
DROP FUNCTION IF EXISTS getnewID_quanli $$
CREATE FUNCTION getnewID_quanli()
RETURNS CHAR(4) DETERMINISTIC
BEGIN
	DECLARE temp INT;
	DECLARE newID CHAR(4);
	DECLARE maxID CHAR(4);
    SELECT CAST(MAX(ma_quanli) AS SIGNED) + 1 INTO temp FROM quanli;
    SET newID = CAST(temp AS CHAR(4));
    RETURN newID;
END;$$



/*-------------- Tạo giá trị ID mới cho khách hàng -----------*/				 
DELIMITER $$
DROP FUNCTION IF EXISTS getnewID_kh $$
CREATE FUNCTION getnewID_kh()
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE temp INT;
	DECLARE newID INT;
	DECLARE maxID CHAR(4);
    SELECT CAST(MAX(ID) AS SIGNED) + 1 INTO newID FROM khachhang;
    RETURN newID;
END;$$



/*--------------- Tạo giá trị ID mới cho biên bản ------------*/			 
DELIMITER $$
DROP FUNCTION IF EXISTS getnewID_bb $$
CREATE FUNCTION getnewID_bb()
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE temp INT;
	DECLARE newID INT;
	DECLARE maxID CHAR(4);
    SELECT CAST(MAX(ID) AS SIGNED) + 1 INTO newID FROM bienban;
    RETURN newID;
END;$$



/*--------------- Tính tổng số yêu cầu đang xử lí ------------*/	
DELIMITER $$
DROP FUNCTION IF EXISTS tongyeucau_dangxuli$$
CREATE FUNCTION tongyeucau_dangxuli()
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE g INT DEFAULT 0;
	SELECT COUNT(*) INTO g FROM yeucau 
    GROUP BY Trangthai
    HAVING yeucau.Trangthai = 'dang xu ly';
    RETURN g;
END;$$
-- SELECT tongyeucau_dangxuli() AS tongyeucau_dangxuli



/*-------------- Tính tổng chi phí các biên bản gửi của mỗi khách hàng theo ID khách hàng  -----------*/	
DELIMITER $$
DROP FUNCTION IF EXISTS tongchiphi$$
CREATE FUNCTION tongchiphi(idCheck INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE g INT DEFAULT 0;
	IF EXISTS (SELECT ID_khachgui FROM khachgui WHERE ID_khachgui=idCheck) THEN
		SELECT SUM(bienban.mucphi) INTO g FROM bienban JOIN bienban_gui ON bienban_gui.ID = bienban.ID AND bienban.ID_khachgui = idCheck GROUP BY bienban.ID_khachgui;
	END IF;
    RETURN g;
END;$$
-- SELECT tongchiphi('800003')


/*-------------- Tính tổng khối lượng hàng hóa nhập kho theo input ID của kho  -----------*/	
DELIMITER $$
DROP FUNCTION IF EXISTS khoiluonghangnhapkho$$
CREATE FUNCTION khoiluonghangnhapkho(ID_kho INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	DECLARE a DECIMAL(10,2) DEFAULT 0;
	IF EXISTS (SELECT * FROM khohang WHERE khohang.ID=ID_kho) THEN
		SELECT SUM(hanghoa.Khoiluong) INTO a FROM hanghoa JOIN hangnhapkho ON hangnhapkho.ID_kienhang = hanghoa.ID_kienhang AND hangnhapkho.Tenhang = hanghoa.Tenhang
        JOIN khohang ON khohang.ID = hangnhapkho.ID_khohang AND khohang.ID=ID_kho
        GROUP BY khohang.ID;
	END IF;
    RETURN a;
END;$$
-- SELECT khoiluonghangnhapkho('200102')
