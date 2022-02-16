--PJ2---

CREATE DATABASE QLKS;
USE QLKS;
CREATE TABLE PHONG(
SoPhong varchar(25) NOT NULL,
LoaiPhong varchar(25),
GiaPhong float Not NULL,
PRIMARY KEY (SoPhong)
);
CREATE TABLE KHACHHANG(
CMND INT NOT NULL,
HoTen varchar(50) NOT NULL,
NgayBatDau datetime NOT NULL,
NgayDoiDi datetime NOT NULL,
PRIMARY KEY (CMND)
);
CREATE TABLE DAT(
SoPhong varchar(25) NOT NULL,
CMND int not null,
TongTienDatPhong float not null,
constraint FK_DatPhong FOREIGN KEY (SoPhong)
references Phong(SoPhong),
constraint FK_DatKhachHang FOREIGN KEY (CMND)
references KhachHang(CMND)
);
CREATE TABLE DICHVU(
MaDV varchar(25) not null,
LoaiDichVu varchar(50) not null,
Gia float,
PRIMARY KEY (MaDV) 
);
CREATE TABLE YEUCAU(
CMND int not null,
MaDV varchar(25) not null,
ThoiGianYeuCau datetime not null,
ChiPhiPhaiTra float not null,
constraint FK_YeuCauKhachHang FOREIGN KEY (CMND)
references KHACHHANG(CMND),
constraint FK_YeuCauDichVu FOREIGN KEY (MaDV)
references DICHVU(MaDV)
);

--PJ3--
CREATE DATABASE QLDS;
USE QLDS;
CREATE TABLE HOCVIEN(
MaHV varchar(50) not null,
HoTen varchar(125) not null,
NgayThangNamSinh date ,
GioiTinh varchar(50) not null,
NoiSinh varchar(125) not null,
QueQuan varchar(125) not null,
NamVaoHoc date not null,
NamTotNghiep date not null,
PRIMARY KEY (MaHV)
);
CREATE TABLE MONHOC(
MaMH varchar(50) not null,
TenMH varchar(125) not null,
DonViHocTrinh int not null,
PRIMARY KEY (MaMH)
);
CREATE TABLE HOC(
MaHV varchar(50) not null,
MaMH varchar(50) not null,
DiemSoCuoiKy int not null,
DiemQuaTrinh int not null,
constraint FK_HocHocVien FOREIGN KEY (MaHV)
references HOCVIEN(MaHV),
constraint FK_HocMonHoc FOREIGN KEY (MaMH)
references MONHOC(MaMH)
);
