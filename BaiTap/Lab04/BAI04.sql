CREATE DATABASE NHATRO;
USE NHATRO;
CREATE TABLE NHA (
SONHA VARCHAR(50) NOT NULL,
SOTANG VARCHAR (25) NOT NULL,
NGUOIQUANLY VARCHAR(255),
PRIMARY KEY (SONHA)
);
CREATE TABLE PHONG (
MAPHONG VARCHAR(50) NOT NULL,
TENPHONG VARCHAR(255),
SONHA VARCHAR(50)  NOT NULL,
MASV VARCHAR (50) NOT NULL,
PRIMARY KEY (MAPHONG),

CONSTRAINT FK_NHAPHONG FOREIGN KEY (SONHA)
REFERENCES NHA(SONHA)
);
ALTER TABLE PHONG 
ADD CONSTRAINT FK_SINHVIENPHONG FOREIGN KEY (MASV)
REFERENCES SINHVIEN(MASV);
CREATE TABLE SINHVIEN (
MASV VARCHAR (50) NOT NULL,
TENSV VARCHAR (255) NOT NULL,
GIOITINH VARCHAR(25),
DOITUONG VARCHAR(255),
TENLOP VARCHAR(50),
MAPHONG VARCHAR(50) NOT NULL,
PRIMARY KEY (MASV),
CONSTRAINT FK_PHONGSINHVIEN FOREIGN KEY (MAPHONG)
REFERENCES PHONG(MAPHONG)
);


--BAI2--
CREATE DATABASE CONGTY;
USE CONGTY;
CREATE TABLE NHANVIEN(
MANV VARCHAR(50) NOT NULL,
HOTEN VARCHAR(255) NOT NULL,
NGAYSINH DATE,
GIOITINH VARCHAR(50),
HSL INT NOT NULL,
DIACHI VARCHAR(255),
LUONG INT NOT NULL,
PRIMARY KEY (MANV)
);
ALTER TABLE NHANVIEN 
ADD column MADV VARCHAR(50) NOT NULL,
ADD CONSTRAINT FK_DONVINHANVIEN FOREIGN KEY (MADV)
REFERENCES DONVI(MADV);
CREATE TABLE DUAN (
MADA VARCHAR(50) NOT NULL,
TENDA VARCHAR(255) NOT NULL,
DIADIEM VARCHAR(255),
THOIGIANBATDAU DATETIME,
PRIMARY KEY (MADA)
);
CREATE TABLE DONVI (
MADV VARCHAR(50) NOT NULL,
TENDV VARCHAR(255) NOT NULL,
MANV VARCHAR(50) NOT NULL,
NGAYBATDAU DATE,
MADA VARCHAR(50) NOT NULL,
PRIMARY KEY (MADV),
CONSTRAINT FK_DUANDONVI FOREIGN KEY (MADA)
REFERENCES DUAN(MADA)
);
CREATE TABLE NGOAINGU (
MANV VARCHAR(50) NOT NULL,
NGOAINGU VARCHAR (255),
PRIMARY KEY (MANV, NGOAINGU),
CONSTRAINT FK_NHANVIENNGOAINGU FOREIGN KEY (MANV)
REFERENCES NHANVIEN(MANV)
);
CREATE TABLE THANNHAN (
MANV VARCHAR(50) NOT NULL,
TENTHANNHAN VARCHAR (255) NOT NULL,
NGAYSINH DATE,
GIOITINH VARCHAR(50),
QUANHE VARCHAR(50),
PRIMARY KEY (MANV, TENTHANNHAN),
CONSTRAINT FK_NHANVIENTHANNHAN FOREIGN KEY (MANV)
REFERENCES NHANVIEN(MANV)
);
CREATE TABLE DIADIEM(
MADV VARCHAR(50) NOT NULL,
DIADIEM VARCHAR(255) NOT NULL,
PRIMARY KEY (MADV, DIADIEM),
constraint FK_DONVIDIADIEM FOREIGN KEY (MADV)
references DONVI(MADV)
);
CREATE TABLE LAMVIEC(
MADV VARCHAR(50) NOT NULL,
MANV VARCHAR(50) NOT NULL,
SOGIO INT NOT NULL,
PRIMARY KEY (MADV, MANV),
CONSTRAINT FK_DONVILAMVIEC FOREIGN KEY (MADV)
REFERENCES DONVI(MADV),
CONSTRAINT FK_NHANVIENLAMVIEC FOREIGN KEY (MANV)
REFERENCES NHANVIEN(MANV)

);











