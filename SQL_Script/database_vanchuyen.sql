DROP DATABASE vanchuyen;
CREATE DATABASE vanchuyen;
USE vanchuyen;
CREATE TABLE nhanvien (
  CCCD CHAR(12) NOT NULL,
  hoten VARCHAR(45) NOT NULL,
  namsinh INT NOT NULL,
  email VARCHAR(45) NOT NULL UNIQUE,
  congty VARCHAR(45) NOT NULL DEFAULT 'Viet Tan Phat',
  mucluong INT NOT NULL,
  gioitinh VARCHAR(4) NOT NULL,
  sdt VARCHAR(10) NOT NULL UNIQUE,
  img_url VARCHAR(255) DEFAULT "public/img/user/default.jpg",
  PRIMARY KEY (CCCD)
);

CREATE TABLE taixe (
  ID CHAR(4) NOT NULL,
  CCCD CHAR(12) NOT NULL UNIQUE,
  PRIMARY KEY (ID),
  CONSTRAINT nhanvien_taixe
    FOREIGN KEY (CCCD)
    REFERENCES nhanvien (CCCD)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE loxe (
  ID CHAR(4) NOT NULL,
  CCCD CHAR(12) NOT NULL UNIQUE,
  PRIMARY KEY (ID),
  CONSTRAINT nhanvien_loxe
  FOREIGN KEY (CCCD)
    REFERENCES nhanvien (CCCD)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE quanli (
  ma_quanli CHAR(4) NOT NULL,
  CCCD CHAR(12) NOT NULL UNIQUE,
  PRIMARY KEY (ma_quanli),
  CONSTRAINT nhanvien_quanli
    FOREIGN KEY (CCCD)
    REFERENCES nhanvien (CCCD)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE nvbienban (
  ID CHAR(4) NOT NULL,
  CCCD CHAR(12) NOT NULL UNIQUE,
  PRIMARY KEY (ID),
  CONSTRAINT nhanvien_taobienban
    FOREIGN KEY (CCCD)
    REFERENCES nhanvien (CCCD)
    ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE phuongtien (
  ID CHAR(4) NOT NULL,
  cong_ty_truc_thuoc VARCHAR(45) NOT NULL,
  tuyen_duong_di VARCHAR(200) NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE laixe (
  ID_phuongtien CHAR(4) NOT NULL,
  ID_taixe CHAR(4) NOT NULL,
  PRIMARY KEY (ID_phuongtien, ID_taixe),
  CONSTRAINT laixe_taixe
    FOREIGN KEY (ID_taixe)
    REFERENCES taixe (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT laixe_phuongtien
    FOREIGN KEY (ID_phuongtien)
    REFERENCES phuongtien (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE cuocxe (
  ID INT NOT NULL,
  ID_phuongtien CHAR(4) NOT NULL UNIQUE,
  ID_taixe CHAR(4) NOT NULL UNIQUE,
  ID_loxe CHAR(4) NOT NULL UNIQUE,
  ngay_di DATE NOT NULL,
  ngay_den DATE NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT cuocxe_taixe
    FOREIGN KEY (ID_taixe)
    REFERENCES taixe (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT cuocxe_phuongtien
    FOREIGN KEY (ID_phuongtien)
    REFERENCES phuongtien (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT cuocxe_loxe
    FOREIGN KEY (ID_loxe)
    REFERENCES loxe (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE kienhang (
  ID INT NOT NULL,
  khoiluong DECIMAL(10,2) NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE hanghoa (
  ID_kienhang INT NOT NULL,
  Tenhang VARCHAR(100) NOT NULL,
  Loaihang VARCHAR(100) NOT NULL,
  Soluonghang INT NOT NULL,
  Khoiluong DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (ID_kienhang, Tenhang),
  CONSTRAINT hanghoa_kienhang
    FOREIGN KEY (ID_kienhang)
    REFERENCES kienhang (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE khohang (
  ID int NOT NULL,
  Tenkho VARCHAR(100) NOT NULL,
  Tinh_tructhuoc VARCHAR(45) NOT NULL,
  Diachi VARCHAR(200) NOT NULL,
  Dientich DECIMAL(10,2) DEFAULT NULL,
  Ma_quanli CHAR(4) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT khohang_quanli
 FOREIGN KEY (Ma_quanli) 
REFERENCES quanli (Ma_quanli) 
ON DELETE CASCADE 
ON UPDATE CASCADE
);

CREATE TABLE hangxuatkho (
  ID_kienhang INT NOT NULL,
  Tenhang VARCHAR(100) NOT NULL,
  Phuongtienxuat VARCHAR(45) NOT NULL,
  Ngayxuatkho DATE NOT NULL,
  Nguoixuatkho VARCHAR(45) NULL,
  ID_khohang INT NOT NULL,
  PRIMARY KEY (ID_kienhang, Tenhang),
  CONSTRAINT xuat_khohang
    FOREIGN KEY (ID_khohang)
    REFERENCES khohang (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT xuatkho_hanghoa
    FOREIGN KEY (ID_kienhang , Tenhang)
    REFERENCES hanghoa (ID_kienhang , Tenhang)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


CREATE TABLE hangnhapkho (
  ID_kienhang INT NOT NULL,
  Tenhang VARCHAR(45) NOT NULL,
  Phuongtiennhap VARCHAR(45) NOT NULL,
  Ngaynhapkho DATE NOT NULL,
  Nguoinhapkho VARCHAR(45) NULL,
  ID_khohang INT NOT NULL,
  PRIMARY KEY (ID_kienhang, Tenhang),
  CONSTRAINT nhap_khohang
    FOREIGN KEY (ID_khohang)
    REFERENCES khohang (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT nhapkho_hanghoa
    FOREIGN KEY (ID_kienhang , Tenhang)
    REFERENCES hanghoa (ID_kienhang , Tenhang)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
    
CREATE TABLE khachhang (
  ID INT NOT NULL,
  hoten VARCHAR(45) NOT NULL,
  namsinh INT NOT NULL,
  Diachi VARCHAR(100) NOT NULL,
  sdt VARCHAR(12) NOT NULL,
  email VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID)
);
  
CREATE TABLE khachnhan (
  ID_khachnhan INT NOT NULL,
  PRIMARY KEY (ID_khachnhan),
  CONSTRAINT idkhachnhan
    FOREIGN KEY (ID_khachnhan)
    REFERENCES khachhang (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE khachgui (
  ID_khachgui INT NOT NULL,
  PRIMARY KEY (ID_khachgui),
  CONSTRAINT idkhachgui
    FOREIGN KEY (ID_khachgui)
    REFERENCES khachhang (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE bienban (
  ID INT NOT NULL,
  ID_nhanvien CHAR(4) NOT NULL,
  qua_trinh_giao_hang VARCHAR(200) NOT NULL,
  Mucphi DECIMAL(10,2) NOT NULL,
  Thongtin_hang VARCHAR(200) NULL,
  Namgiaodich CHAR(4) NOT NULL,
  ID_khachgui INT NOT NULL,
  ID_khachnhan INT NOT NULL,
  PRIMARY KEY (ID),
CONSTRAINT ID_khachgui
  FOREIGN KEY (ID_khachgui)
  REFERENCES khachgui (ID_khachgui)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
CONSTRAINT ID_khachnhan
  FOREIGN KEY (ID_khachnhan)
  REFERENCES khachnhan (ID_khachnhan)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
CONSTRAINT ID_nhanvien
  FOREIGN KEY (ID_nhanvien)
  REFERENCES nvbienban (ID)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
);


CREATE TABLE thuoc (
  ID_cuocxe INT NULL,
  ID_bienban INT NOT NULL,
  ID_kienhang INT NOT NULL,
  PRIMARY KEY (ID_bienban, ID_kienhang),
  CONSTRAINT thuoc_cuocxe
    FOREIGN KEY (ID_cuocxe)
    REFERENCES cuocxe (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT thuoc_bienban
    FOREIGN KEY (ID_bienban)
    REFERENCES bienban (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT thuoc_kienhang
    FOREIGN KEY (ID_kienhang)
    REFERENCES kienhang (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE lichsugiaodich (
  ID INT NOT NULL,
  lichsu DATE NOT NULL,
  PRIMARY KEY (ID, lichsu),
  CONSTRAINT lsgd_khachhang
    FOREIGN KEY (ID)
    REFERENCES khachhang (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


CREATE TABLE bienban_gui (
  ID INT NOT NULL,
  Ngaygui DATE NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT bienbangui
    FOREIGN KEY (ID)
    REFERENCES bienban (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


CREATE TABLE bienban_nhan (
  ID INT NOT NULL,
  Ngaynhan DATE NOT NULL,
  Hinhthuc_nhanhang VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT bienbannhan
    FOREIGN KEY (ID)
    REFERENCES bienban (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE yeucau (
  Ma INT NOT NULL,
  ID_bienbangui INT NULL,
  ID_khachgui INT NULL,
  Thongtin_yeucau VARCHAR(200) NULL,
  Mucdo_uutien INT NULL,
  Trangthai VARCHAR(20) NULL,
  PRIMARY KEY (Ma),
  CONSTRAINT yeucau_bienban
    FOREIGN KEY (ID_bienbangui)
    REFERENCES bienban_gui (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT yeucau_khachgui
    FOREIGN KEY (ID_khachgui)
    REFERENCES khachgui (ID_khachgui)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE nhan (
  Ma_yeucau INT NOT NULL,
  ID_taixe CHAR(4) NOT NULL,
  PRIMARY KEY (Ma_yeucau, ID_taixe),
  CONSTRAINT nhan_yeucau
    FOREIGN KEY (Ma_yeucau)
    REFERENCES yeucau (Ma)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT nhan_taixe
    FOREIGN KEY (ID_taixe)
    REFERENCES taixe (ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
    
CREATE TABLE thoigianca (
  calamviec VARCHAR(6) NOT NULL,
  thoigianbatdauca TIME NOT NULL,
  thoigianketthucca TIME NOT NULL,
  PRIMARY KEY (calamviec)
);


CREATE TABLE calamviec (
  CCCD CHAR(12) NOT NULL,
  calamviec VARCHAR(6) NOT NULL,
  PRIMARY KEY (CCCD),
  CONSTRAINT calamviec_nhanvien
    FOREIGN KEY (CCCD)
    REFERENCES nhanvien (CCCD)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT calamviec_thoigianca
    FOREIGN KEY (calamviec)
    REFERENCES thoigianca (calamviec)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('062202001458', 'Le Hong An', '2000', 'an1506@gmail.com', 'Viet Tan Phat', '10500000','Nam','0915614819');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('075202008945', 'Nguyen Huu Dat', '1996', 'dat1608@gmail.com', 'Viet Tan Phat', '12000000','Nam','0915468445');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('083202001123', 'Nguyen Son Tin', '1995', 'tin2807@gmail.com', 'Viet Tan Phat', '14600000','Nam','0156884862');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('083202001546', 'Tran Vinh Phuc', '1995', 'phuc1605@gmail.com', 'Viet Tan Phat', '15700000','Nam','0915611549');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('062202001478', 'Le Hoang Phat', '1997', 'phat0511@gmail.com', 'Viet Tan Phat', '11300000','Nam','0911563314');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('062202000001', 'Tran Hoai Duy', '1996', 'duy2412@gmail.com', 'Viet Tan Phat', '14600000','Nam','0265684430');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('062202000002', 'Dang The Duy', '1998', 'duy1910@gmail.com', 'Viet Tan Phat', '13500000','Nam','0915235678');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('062202000003', 'Vo Truong Giang', '1999', 'giang1702@gmail.com', 'Viet Tan Phat', '11300000','Nam','0968552224');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('062202000004', 'Nguyen Ba Giang', '1997', 'giang1103@gmail.com', 'Viet Tan Phat', '12800000','Nam','0956844819');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('062202000005', 'Phan Thanh Hai', '1994', 'hai0301@gmail.com', 'Viet Tan Phat', '16100000','Nam','0114656819');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('083002000001', 'Tran Duc Hai', '1997', 'hai2204@gmail.com', 'Viet Tan Phat', '10800000','Nam','0911351819');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('083002000002', 'Pham Duc Hiep', '1997', 'hiep0609@gmail.com', 'Viet Tan Phat', '11000000','Nam','0166557819');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('083002000003', 'Vo Tuan Hiep', '1997', 'hiep1007@gmail.com', 'Viet Tan Phat', '12500000','Nam','0915655469');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('083002000004', 'Le Trung Hieu', '1996', 'hieu2511@gmail.com', 'Viet Tan Phat', '15500000','Nam','0165444219');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('083002000005', 'Nguyen Trung Hieu', '1997', 'hieu1303@gmail.com', 'Viet Tan Phat', '14700000','Nam','0177895819');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('063002000001', 'Nguyen Duy Tan', '1996', 'tan2604@gmail.com', 'Viet Tan Phat', '13200000','Nam','0145637896');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('063002000002', 'Hoang Duy Tan', '1996', 'tan0112@gmail.com', 'Viet Tan Phat', '14800000','Nam','0187889531');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('063002000003', 'Tran Minh Thach', '1998', 'thach0910@gmail.com', 'Viet Tan Phat', '12700000','Nam','0156355123');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('063002000004', 'Pham Thanh Thang', '19975', 'thang0506@gmail.com', 'Viet Tan Phat', '12600000','Nam','0955688819');
INSERT INTO nhanvien (CCCD, hoten, namsinh, email, congty, mucluong, gioitinh, sdt) VALUES ('063002000005', 'Nguyen Dinh Tuan', '1998', 'tuan0811@gmail.com', 'Viet Tan Phat', '11400000','Nam','0159993265');
INSERT INTO taixe (ID, CCCD) VALUES ('1006', '062202001458');
INSERT INTO taixe (ID, CCCD) VALUES ('1009', '062202001478');
INSERT INTO taixe (ID, CCCD) VALUES ('1011', '075202008945');
INSERT INTO taixe (ID, CCCD) VALUES ('1012', '083202001123');
INSERT INTO taixe (ID, CCCD) VALUES ('1013', '083202001546');
INSERT INTO nvbienban (ID, CCCD) VALUES ('3001', '063002000001');
INSERT INTO nvbienban (ID, CCCD) VALUES ('3002', '063002000002');
INSERT INTO nvbienban (ID, CCCD) VALUES ('3003', '063002000003');
INSERT INTO nvbienban (ID, CCCD) VALUES ('3004', '063002000004');
INSERT INTO nvbienban (ID, CCCD) VALUES ('3005', '063002000005');
INSERT INTO quanli (ma_quanli, CCCD) VALUES ('5012', '062202000001');
INSERT INTO quanli (ma_quanli, CCCD) VALUES ('5013', '062202000002');
INSERT INTO quanli (ma_quanli, CCCD) VALUES ('5014', '062202000003');
INSERT INTO quanli (ma_quanli, CCCD) VALUES ('5020', '062202000004');
INSERT INTO quanli (ma_quanli, CCCD) VALUES ('5009', '062202000005');
INSERT INTO loxe (ID, CCCD) VALUES ('2005', '083002000001');
INSERT INTO loxe (ID, CCCD) VALUES ('2006', '083002000002');
INSERT INTO loxe (ID, CCCD) VALUES ('2013', '083002000003');
INSERT INTO loxe (ID, CCCD) VALUES ('2014', '083002000004');
INSERT INTO loxe (ID, CCCD) VALUES ('2001', '083002000005');
INSERT INTO phuongtien (ID, cong_ty_truc_thuoc, tuyen_duong_di) VALUES ('5001', 'Viet Tan Phat', 'nha -> kho TPHCM');
INSERT INTO phuongtien (ID, cong_ty_truc_thuoc, tuyen_duong_di) VALUES ('5002', 'Viet Tan Phat', 'kho KonTum -> kho TPHCM');
INSERT INTO phuongtien (ID, cong_ty_truc_thuoc, tuyen_duong_di) VALUES ('5003', 'Viet Tan Phat', 'kho TPHCM -> kho Danang');
INSERT INTO phuongtien (ID, cong_ty_truc_thuoc, tuyen_duong_di) VALUES ('5004', 'Viet Tan Phat', 'kho TPHCM -> kho KonTum');
INSERT INTO phuongtien (ID, cong_ty_truc_thuoc, tuyen_duong_di) VALUES ('5005', 'Viet Tan Phat', 'kho KonTum1 -> nha');
INSERT INTO laixe (ID_phuongtien, ID_taixe) VALUES ('5001', '1006');
INSERT INTO laixe (ID_phuongtien, ID_taixe) VALUES ('5002', '1009');
INSERT INTO laixe (ID_phuongtien, ID_taixe) VALUES ('5003', '1013');
INSERT INTO laixe (ID_phuongtien, ID_taixe) VALUES ('5004', '1011');
INSERT INTO laixe (ID_phuongtien, ID_taixe) VALUES ('5005', '1012');
INSERT INTO cuocxe (ID, ID_phuongtien, ID_taixe, ID_loxe, ngay_di, ngay_den) VALUES ('100102', '5001', '1006', '2005', '2020-09-25', '2020-09-28');
INSERT INTO cuocxe (ID, ID_phuongtien, ID_taixe, ID_loxe, ngay_di, ngay_den) VALUES ('100103', '5002', '1009', '2006', '2021-11-25', '2021-11-28');
INSERT INTO cuocxe (ID, ID_phuongtien, ID_taixe, ID_loxe, ngay_di, ngay_den) VALUES ('100106', '5003', '1013', '2014', '2021-12-07', '2021-12-12');
INSERT INTO cuocxe (ID, ID_phuongtien, ID_taixe, ID_loxe, ngay_di, ngay_den) VALUES ('100107', '5004', '1011', '2001', '2022-06-04', '2022-06-10');
INSERT INTO cuocxe (ID, ID_phuongtien, ID_taixe, ID_loxe, ngay_di, ngay_den) VALUES ('100111', '5005', '1012', '2013', '2022-10-24', '2022-10-30');
INSERT INTO khohang (ID, Tenkho, Tinh_tructhuoc, Diachi, Dientich, Ma_quanli) VALUES ('200101', 'TPHCM1', 'TP Ho Chi Minh', '465 Tung Thien Vuong, Phuong 12, Quan 8, TP Ho Chi Minh', '1000', '5009');
INSERT INTO khohang (ID, Tenkho, Tinh_tructhuoc, Diachi, Dientich, Ma_quanli) VALUES ('200102', 'DaNang1', 'TP Da Nang', '98 Khuc Thua Du, Phuong Nai Hien Dong, Quan Son Tra,TP  Da Nang', '1200', '5012');
INSERT INTO khohang (ID, Tenkho, Tinh_tructhuoc, Diachi, Dientich, Ma_quanli) VALUES ('200103', 'TPHCM2', 'TP Ho Chi Minh', '174 Chu Van An, Phuong 12, Quan Binh Thanh, TP Ho Chi Minh', '1300', '5013');
INSERT INTO khohang (ID, Tenkho, Tinh_tructhuoc, Diachi, Dientich, Ma_quanli) VALUES ('200104', 'KonTum1', 'Kon Tum', '647 Nguyen Hue, Phuong Quyet Thang, TP Kon Tum, Tinh Kon Tum', '1100', '5014');
INSERT INTO khohang (ID, Tenkho, Tinh_tructhuoc, Diachi, Dientich, Ma_quanli) VALUES ('200105', 'DaNang2', 'Tp Da Nang', '15 Nguyen Kim, Phuong Hoa Xuan, Quan Cam Le ,TP Da Nang', '1200', '5020');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600501', '0.5');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600502', '2.4');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600503', '3.0');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600504', '1.6');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600505', '1.9');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600506', '1.4');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600507', '1.8');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600508', '0.2');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600509', '8.2');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600510', '3.0');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600511', '4.0');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600512', '1.10');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600513', '0.20');
INSERT INTO kienhang (ID, khoiluong) VALUES ('600514', '1.70');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600501', 'khau trang N95', 'khau trang', '100', '0.5');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600502', 'thuoc paradol', 'duoc pham y te', '1000', '2.4');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600503', 'ao thun', 'quan ao', '5', '3.0');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600504', 'sach he co so du lieu', 'sach', '50', '1.6');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600505', 'tai nghe', 'dien tu', '1', '1.9');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600506', 'quan kaki', 'quan ao', '3', '1.4');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600507', 'choi lau nha', 'do dung nha cua', '1', '1.8');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600508', 'chuot may tinh', 'dien tu', '1', '0.2');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600509', 'thuoc ho', 'duoc pham y te', '800', '8.2');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600510', 'sach kinh te hoc', 'sach', '70', '3.0');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600511', 'ao ba lo', 'quan ao', '10', '4.0');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600512', 'sach nhap mon AI', 'sach', '5', '1.10');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600513', 'tai nghe', 'dien tu', '2', '0.20');
INSERT INTO hanghoa (ID_kienhang, Tenhang, Loaihang, Soluonghang, Khoiluong) VALUES ('600514', 'choi lau nha', 'dung cu lau don', '1', '1.70');
INSERT INTO hangxuatkho (ID_kienhang, Tenhang, Phuongtienxuat, Ngayxuatkho, Nguoixuatkho, ID_khohang) VALUES ('600501', 'khau trang N95', '5002', '2020-09-25', 'Nguyen Dinh Tuan', '200104');
INSERT INTO hangxuatkho (ID_kienhang, Tenhang, Phuongtienxuat, Ngayxuatkho, Nguoixuatkho, ID_khohang) VALUES ('600502', 'thuoc paradol', '5002', '2021-11-25', 'Nguyen Dinh Tuan', '200104');
INSERT INTO hangxuatkho (ID_kienhang, Tenhang, Phuongtienxuat, Ngayxuatkho, Nguoixuatkho, ID_khohang) VALUES ('600503', 'ao thun', '5005', '2021-12-07', 'Nguyen Dinh Tuan', '200104');
INSERT INTO hangxuatkho (ID_kienhang, Tenhang, Phuongtienxuat, Ngayxuatkho, Nguoixuatkho, ID_khohang) VALUES ('600504', 'sach he co so du lieu', '5003', '2022-06-04', 'Phan Thanh Hai', '200101');
INSERT INTO hangxuatkho (ID_kienhang, Tenhang, Phuongtienxuat, Ngayxuatkho, Nguoixuatkho, ID_khohang) VALUES ('600505', 'tai nghe', '5003', '2022-10-24', 'Phan Thanh Hai', '200101');
INSERT INTO hangnhapkho (ID_kienhang, Tenhang, Phuongtiennhap, Ngaynhapkho, Nguoinhapkho, ID_khohang) VALUES ('600506', 'quan kaki', '5001', '2022-10-30', 'Tran Hoai Duy', '200102');
INSERT INTO hangnhapkho (ID_kienhang, Tenhang, Phuongtiennhap, Ngaynhapkho, Nguoinhapkho, ID_khohang) VALUES ('600507', 'choi lau nha', '5004', '2022-10-30', 'Tran Hoai Duy', '200102');
INSERT INTO hangnhapkho (ID_kienhang, Tenhang, Phuongtiennhap, Ngaynhapkho, Nguoinhapkho, ID_khohang) VALUES ('600508', 'chuot may tinh', '5004', '2022-10-30', 'Tran Hoai Duy', '200102');
INSERT INTO hangnhapkho (ID_kienhang, Tenhang, Phuongtiennhap, Ngaynhapkho, Nguoinhapkho, ID_khohang) VALUES ('600509', 'thuoc ho', '5004', '2022-10-30', 'Tran Hoai Duy', '200102');
INSERT INTO hangnhapkho (ID_kienhang, Tenhang, Phuongtiennhap, Ngaynhapkho, Nguoinhapkho, ID_khohang) VALUES ('600510', 'sach kinh te hoc', '5004', '2020-09-28', 'Tran Hoai Duy', '200102');
INSERT INTO hangnhapkho (ID_kienhang, Tenhang, Phuongtiennhap, Ngaynhapkho, Nguoinhapkho, ID_khohang) VALUES ('600511', 'ao ba lo', '5001', '2022-10-24', 'Tran Hoai Duy', '200102');
INSERT INTO hangnhapkho(ID_kienhang, Tenhang, Phuongtiennhap, Ngaynhapkho, Nguoinhapkho, ID_khohang) VALUES ('600512', 'sach nhap mon AI', '5001', '2022-10-24', 'Dang The Duy', '200103');
INSERT INTO hangnhapkho(ID_kienhang, Tenhang, Phuongtiennhap, Ngaynhapkho, Nguoinhapkho, ID_khohang) VALUES ('600513', 'tai nghe', '5001', '2022-10-24', 'Dang The Duy', '200103');
INSERT INTO hangnhapkho(ID_kienhang, Tenhang, Phuongtiennhap, Ngaynhapkho, Nguoinhapkho, ID_khohang) VALUES ('600514', 'choi lau nha', '5001', '2020-09-25', 'Tran Hoai Duy', '200102');
INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES ('800001', 'Le Minh Tuan', '2002', 'Duong Ta Quang Buu, khu pho 6, phuong Linh Trung, thanh pho Thu Duc, Thanh pho Ho Chi Minh','0936135483','tuan1211@gmail.com');
INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES ('800002', 'Tran Duc Tuan', '2001', '09 Nguyen Hue, Phuong Quyet Thang, TP Kon Tum, Tinh Kon Tum','0915687435','tuan0112@gmail.com');
INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES ('800003', 'Tran Duc Truong', '2003', '02 Tung Thien Vuong, Phuong 12, Quan 8, TP Ho Chi Minh','0156365422','truong0405@gmail.com');
INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES ('800004', 'Nguyen Van Truong', '2002', '35 Khuc Thua Du, Phuong Nai Hien Dong, Quan Son Tra,TP  Da Nang','0165822299','truong2806@gmail.com');
INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES ('800005', 'Nguyen Nhat Nguyen', '2002', '24 Chu Van An, Phuong 12, Quan Binh Thanh, TP Ho Chi Minh','0949719566','nguyen3004@gmail.com');
INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES ('800006', 'Tran Tuan Anh', '2003', '135 Nguyen Hue, Phuong Quyet Thang, TP Kon Tum, Tinh Kon Tum','0144443568','anh2407@gmail.com');
INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES ('800007', 'Nguyen Huu Danh', '2001', '98 Tung Thien Vuong, Phuong 12, Quan 8, TP Ho Chi Minh','0923253331','danh1001@gmail.com');
INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES ('800008', 'Pham Hai Dang', '2003', '15 Nguyen Kim, Phuong Hoa Xuan, Quan Cam Le ,TP Da Nang','0923448666','dang2002@gmail.com');
INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES ('800009', 'Nguyen Duy Lam', '2003', '51 Khuc Thua Du, Phuong Nai Hien Dong, Quan Son Tra,TP  Da Nang','0987123654','lam2110@gmail.com');
INSERT INTO khachhang (ID, hoten, namsinh, Diachi,sdt,email) VALUES ('800010', 'Vo Cong Danh', '2003', '102 Chu Van An, Phuong 12, Quan Binh Thanh, TP Ho Chi Minh','0977453453','danh1508@gmail.com');
INSERT INTO khachnhan (ID_khachnhan) VALUES ('800002');
INSERT INTO khachnhan (ID_khachnhan) VALUES ('800007');
INSERT INTO khachnhan (ID_khachnhan) VALUES ('800008');
INSERT INTO khachnhan (ID_khachnhan) VALUES ('800009');
INSERT INTO khachnhan (ID_khachnhan) VALUES ('800010');
INSERT INTO khachgui (ID_khachgui) VALUES ('800001');
INSERT INTO khachgui (ID_khachgui) VALUES ('800003');
INSERT INTO khachgui (ID_khachgui) VALUES ('800004');
INSERT INTO khachgui (ID_khachgui) VALUES ('800005');
INSERT INTO khachgui (ID_khachgui) VALUES ('800006');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700301', '3001', 'Kho KonTum1 -> Kho TPHCM2', '110000', 'khoi luong: 0.50', '2020', '800006', '800007');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700302', '3001', 'Kho KonTum1 -> Kho TPHCM2', '120000', 'khoi luong: 2.40', '2021', '800006', '800010');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700303', '3002', 'So 7, Dan Chu, thanh pho Thu Duc -> Kho TPHCM1-> Kho KonTum1 -> 09 Nguyen Hue, phuong Quyet Thang, TP Kon Tum', '100000', 'khoi luong: 3.00', '2021', '800005', '800002');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700304', '3002', 'Kho TPHCM2 -> Kho DaNang1', '140000', 'khoi luong: 1.60', '2022', '800004', '800007');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700305', '3002', 'Kho TPHCM2 -> Kho DaNang1', '190000', 'khoi luong: 1.90', '2022', '800004', '800010');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700306', '3003', 'Kho TPHCM1-> Kho DaNang2->15 Nguyen Kim, Phuong Hoa Xuan, Quan Cam Le ,TP Da Nang', '30000', 'khoi luong: 1.40', '2020', '800001', '800008');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700307', '3004', 'So 100, Pham Van Dong, thanh pho Thu Duc -> Kho TPHCM1 -> Kho KonTum1 -> 23 Bach Dang, phuong Thong Nhat, TP KonTum', '0', 'khoi luong: 1.80', '2021', '800003', '800002');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700308', '3004', 'So 20, Ta Quang Buu, thanh pho Thu Duc -> Kho TPHCM2 -> Kho KonTum1', '0', 'khoi luong: 0.20', '2022', '800005', '800002');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700309', '3005', 'Kho TPHCM1 -> Kho KonTum1 -> 120 Dao Duy Tu, phuong Thong Nhat, TP KonTum', '0', 'khoi luong: 8.20', '2020', '800003', '800002');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700310', '3005', 'Kho TPHCM1 -> Kho KonTum1', '0', 'khoi luong: 3.00', '2022', '800005', '800002');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700311', '3003', 'So 1, Vo Van Ngan, thanh pho Thu Duc -> Kho TPHCM1 -> Kho TPHCM1 -> Kho TPHCM1 -> Kho DaNang1 -> 12 Khuc Thua Du, Phuong Nai Hien Dong, Quan Son Tra,TP  Da Nang ', '85000', 'khoi luong: 4.00', '2021', '800005', '800008');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700312', '3001', 'So 126, Vo Van Ngan, thanh pho Thu Duc -> Kho TPHCM2 -> Kho KonTum1', '160000', 'khoi luong: 1.10', '2022', '800003', '800002');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700313', '3001', 'So 145, Dan Chu, thanh pho Thu Duc -> Kho TPHCM2 -> Kho KonTum1', '45000', 'khoi luong: 0.20', '2021', '800003', '800002');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700314', '3002', '02 Tung Thien Vuong, Phuong 12, Quan 8, TP Ho Chi Minh -> Kho TPHCM2 -> Kho DaNang1', '125000', 'khoi luong: 1.70', '2022', '800004', '800007');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700315', '3001', 'Kho KonTum1 -> Kho TPHCM2', '0', 'khoi luong: 0.50', '2020', '800006', '800007');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700316', '3001', 'Kho KonTum1 -> Kho TPHCM2 -> 102 Chu Van An, Phuong 12, Quan Binh Thanh, TP Ho Chi Minh', '40000', 'khoi luong: 2.40', '2021', '800006', '800010');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700317', '3002', 'So 7, Dan Chu, thanh pho Thu Duc -> Kho TPHCM1-> Kho KonTum1 -> 09 Nguyen Hue, phuong Quyet Thang, TP Kon Tum', '45000', 'khoi luong: 3.00', '2021', '800005', '800002');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700318', '3002', 'Kho TPHCM2 -> Kho DaNang1', '0', 'khoi luong: 1.60', '2022', '800004', '800007');
INSERT INTO bienban (ID, ID_nhanvien, qua_trinh_giao_hang, Mucphi, Thongtin_hang, Namgiaodich, ID_khachgui, ID_khachnhan) VALUES ('700319', '3002', 'Kho TPHCM2 -> Kho DaNang1 ->  Nguyen Kim, Phuong Hoa Xuan, Quan Cam Le ,TP Da Nang', '35000', 'khoi luong: 1.90', '2022', '800004', '800010');
INSERT INTO bienban_gui (ID, Ngaygui) VALUES ('700301', '2020-09-25');
INSERT INTO bienban_gui (ID, Ngaygui) VALUES ('700302', '2021-11-25');
INSERT INTO bienban_gui (ID, Ngaygui) VALUES ('700303', '2021-12-07');
INSERT INTO bienban_gui (ID, Ngaygui) VALUES ('700304', '2022-06-04');
INSERT INTO bienban_gui (ID, Ngaygui) VALUES ('700305', '2022-10-24');
INSERT INTO bienban_gui (ID, Ngaygui) VALUES ('700311', '2022-10-24');
INSERT INTO bienban_gui (ID, Ngaygui) VALUES ('700312', '2022-10-24');
INSERT INTO bienban_gui (ID, Ngaygui) VALUES ('700313', '2022-10-24');
INSERT INTO bienban_gui (ID, Ngaygui) VALUES ('700314', '2020-09-25');
INSERT INTO bienban_nhan (ID, Ngaynhan, Hinhthuc_nhanhang) VALUES ('700306', '2022-10-30', 'Nhan tai nha');
INSERT INTO bienban_nhan (ID, Ngaynhan, Hinhthuc_nhanhang) VALUES ('700307', '2022-10-30', 'Nhan tai kho');
INSERT INTO bienban_nhan (ID, Ngaynhan, Hinhthuc_nhanhang) VALUES ('700308', '2022-10-30', 'Nhan tai kho');
INSERT INTO bienban_nhan (ID, Ngaynhan, Hinhthuc_nhanhang) VALUES ('700309', '2022-10-30', 'Nhan tai kho');
INSERT INTO bienban_nhan (ID, Ngaynhan, Hinhthuc_nhanhang) VALUES ('700310', '2020-09-28', 'Nhan tai kho');
INSERT INTO bienban_nhan (ID, Ngaynhan, Hinhthuc_nhanhang) VALUES ('700315', '2020-09-28', 'Nhan tai kho');
INSERT INTO bienban_nhan (ID, Ngaynhan, Hinhthuc_nhanhang) VALUES ('700316', '2021-11-28', 'Nhan tai nha');
INSERT INTO bienban_nhan (ID, Ngaynhan, Hinhthuc_nhanhang) VALUES ('700317', '2021-12-12', 'Nhan tai nha');
INSERT INTO bienban_nhan (ID, Ngaynhan, Hinhthuc_nhanhang) VALUES ('700318', '2022-06-10', 'Nhan tai kho');
INSERT INTO bienban_nhan (ID, Ngaynhan, Hinhthuc_nhanhang) VALUES ('700319', '2022-10-30', 'Nhan tai nha');
INSERT INTO thoigianca (calamviec, thoigianbatdauca, thoigianketthucca) VALUES ('ca 1', '07:00:00', '11:00:00');
INSERT INTO thoigianca (calamviec, thoigianbatdauca, thoigianketthucca) VALUES ('ca 2', '12:00:00', '17:00:00');
INSERT INTO thoigianca (calamviec, thoigianbatdauca, thoigianketthucca) VALUES ('ca 3', '18:00:00', '22:00:00');
INSERT INTO thoigianca (calamviec, thoigianbatdauca, thoigianketthucca) VALUES ('ca 4', '22:00:00', '06:00:00');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('062202000001', 'ca 1');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('062202000002', 'ca 2');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('062202000003', 'ca 2');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('062202000004', 'ca 3');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('062202000005', 'ca 3');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('062202001458', 'ca 1');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('062202001478', 'ca 2');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('063002000001', 'ca 1');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('063002000002', 'ca 1');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('063002000003', 'ca 2');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('063002000004', 'ca 2');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('063002000005', 'ca 3');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('075202008945', 'ca 2');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('083002000001', 'ca 1');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('083002000002', 'ca 1');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('083002000003', 'ca 2');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('083002000004', 'ca 2');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('083002000005', 'ca 3');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('083202001123', 'ca 3');
INSERT INTO calamviec (CCCD, calamviec) VALUES ('083202001546', 'ca 4');
INSERT INTO yeucau (Ma, ID_bienbangui, ID_khachgui, Thongtin_yeucau, Mucdo_uutien, Trangthai) VALUES ('900003', '700303', '800005','Ten hang: ao thun, so luong hang: 10, khoi luong: 4.0kg', '1', 'da xu ly');
INSERT INTO yeucau (Ma, ID_bienbangui, ID_khachgui, Thongtin_yeucau, Mucdo_uutien, Trangthai) VALUES ('900001', '700311', '800001','Ten hang: ao ba lo, so luong hang: 10,khoi luong: 4.0kg', '1', 'da xu ly');
INSERT INTO yeucau (Ma, ID_bienbangui, ID_khachgui, Thongtin_yeucau, Mucdo_uutien, Trangthai) VALUES ('900002', '700312', '800003','Ten hang: sach nhap mon AI, so luong hang: 5, khoi luong: 1.1kg', '2', 'dang xu ly');
INSERT INTO yeucau (Ma, ID_bienbangui, ID_khachgui, Thongtin_yeucau, Mucdo_uutien, Trangthai) VALUES ('900004', '700313', '800003','Ten hang: tai nghe, so luong hang: 2, khoi luong: 0.2kg', '2', 'dang xu ly');
INSERT INTO yeucau (Ma, ID_bienbangui, ID_khachgui, Thongtin_yeucau, Mucdo_uutien, Trangthai) VALUES ('900005', '700314', '800004','Ten hang: choi lau nha, so luong hang: 1, khoi luong: 1.7kg', '2', 'dang xu ly');
INSERT INTO nhan (Ma_yeucau, ID_taixe) VALUES ('900001', '1006');
INSERT INTO nhan (Ma_yeucau, ID_taixe) VALUES ('900002', '1006');
INSERT INTO nhan (Ma_yeucau, ID_taixe) VALUES ('900003', '1006');
INSERT INTO nhan (Ma_yeucau, ID_taixe) VALUES ('900004', '1006');
INSERT INTO nhan (Ma_yeucau, ID_taixe) VALUES ('900005', '1006');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100102', '700301', '600501');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100103', '700302', '600502');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100106', '700303', '600503');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100107', '700304', '600504');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100111', '700305', '600505');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100102', '700315', '600501');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100103', '700316', '600502');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100106', '700317', '600503');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100107', '700318', '600504');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100111', '700319', '600505');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100111', '700306', '600506');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100111', '700307', '600507');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100111', '700308', '600508');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100102', '700309', '600509');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100111', '700310', '600510');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100111', '700311', '600511');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100111', '700312', '600512');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100111', '700313', '600513');
INSERT INTO thuoc (ID_cuocxe, ID_bienban, ID_kienhang) VALUES ('100102', '700314', '600514');
INSERT INTO lichsugiaodich (ID, lichsu) VALUES ('800001', '2020-11-26');
INSERT INTO lichsugiaodich (ID, lichsu) VALUES ('800003', '2022-09-11');
INSERT INTO lichsugiaodich (ID, lichsu) VALUES ('800003', '2021-02-24');
INSERT INTO lichsugiaodich (ID, lichsu) VALUES ('800004', '2022-04-04');
INSERT INTO lichsugiaodich (ID, lichsu) VALUES ('800004', '2021-06-04');
INSERT INTO lichsugiaodich (ID, lichsu) VALUES ('800004', '2021-10-24');
INSERT INTO lichsugiaodich (ID, lichsu) VALUES ('800005', '2021-11-27');
INSERT INTO lichsugiaodich (ID, lichsu) VALUES ('800005', '2021-12-07');
INSERT INTO lichsugiaodich (ID, lichsu) VALUES ('800006', '2021-11-25');
INSERT INTO lichsugiaodich (ID, lichsu) VALUES ('800006', '2020-09-25');
