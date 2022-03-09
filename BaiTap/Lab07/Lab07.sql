-- lab07
-- bai1
use qlda_lab6;
-- 10 với mỗi phòng ban cho biết tên phòng ban và địa điểm phòng
select pb.maphg, pb.tenphg,  dd.diadiem 
from phongban as pb inner join diadiem_phg as dd on pb.maphg = dd.maphg;
-- 11 tìm tên những người trưởng phòng của từng phòng ban
select pb.maphg, nv.tennv
from phongban as pb inner join nhanvien as nv on pb.trphg = nv.manv;
-- 12 tìm tên và địa chỉ của tất cả nhân viên phòng 'Nghiên cứu'
select nv.tennv, nv.dchi
from nhanvien as nv inner join phongban as pb on nv.maphg = pb.maphg and pb.maphg = 5;
-- 13 với mỗi đề án ở HN, cho biết tên đề án, tên phòng ban họ tên và ngày nhận chức của trưởng phòng của phòng ban chu trì đề án đó
select da.tenda, da.ddiem_da, nv.tennv, pb.ngnc, pb.tenphg
from phongban as pb inner join dean as da on da.maphg = pb.maphg and da.ddiem_da like 'Hà Nội'
inner join nhanvien as nv on pb.maphg = nv.maphg;
-- 14 tìm tên những nữ nhân viên và tên người thân của họ 
select nv.tennv, tn.tentn
from nhanvien as nv inner join thannhan as tn on nv.manv = tn.manv and nv.phai = 'Nữ';
-- 15 với mỗi nhân viên cho biết họ tên nhân viên và họ tên người quản lý trực tiếp của nhân viên đó 
select concat(m.honv, m.tenlot, m.tennv) as nhanvien, concat(nv.honv, nv.tenlot,nv.tennv) as nguoiquanly
from nhanvien as nv inner join  nhanvien as m on nv.manv = m.ma_nql;
-- 16 với mỗi nhân viên cho biết họ tên nhân viên đó , họ tên ng trưởng phòng, họ tên ng quản lý trực tiếp của nhân viên đó
select nv.tennv, ql.tennv as 'người quản lý',pb.trphg, tp.tennv as  'trưởng phòng'
from nhanvien as nv, nhanvien as ql, nhanvien as tp, phongban as pb
where nv.ma_nql = ql.manv and tp.manv = pb.trphg and pb.maphg = nv.maphg;
-- 17 tên nhân viên ở phòng 5 có tham gia đề án 'Sản phẩm X' và nhân viên này do 'Nguyễn Thanh Tùng' quản lý trực tiếp
select nhanvien.tennv from nhanvien where maphg = 5 and nhanvien.manv in (select nhanvien.manv from nhanvien
inner join phancong on nhanvien.manv = phancong.manv where phancong.mada in (select phancong.mada from phancong inner join dean on phancong.mada = dean.mada where dean.tenda like 'Sản phẩm X') );
-- 18 cho biết tên các đề án mà nhân viên 'Đinh Bá Tiên' đã tham gia
select phancong.manv,  dean.tenda
from phancong inner join dean on phancong.mada = dean.mada where phancong.manv in
 (select phancong.manv from phancong inner join nhanvien on nhanvien.manv = phancong.manv  where concat(nhanvien.honv, nhanvien.tenlot, nhanvien.tennv) like 'ĐinhBáTiên' );
-- bai2
-- 19 cho biết số lượng đề án của cty
select  count(mada) as soluongdean from dean;
-- 20 số lượng đề án do phòng 'Nghiên cứu' chủ trì
select count(*) as soluongdeanphongnghiencuu 
from dean, phongban where phongban.maphg = dean.maphg and phongban.tenphg like 'Nghiên cứu' ; 
-- 21 lương trung bình của nhân viên nữ
select avg(luong) as luongtrungbinhnvnu from nhanvien where phai like 'Nữ';
-- 22 số thân nhân của nhân viên 'Đinh Bá Tiến'
select count(*) as sothannhan
from thannhan, nhanvien where thannhan.manv = nhanvien.manv and 
concat(nhanvien.honv, nhanvien.tenlot, nhanvien.tennv) like 'ĐinhBáTiên';
-- 23 với mỗi đề án liệt kê tên đề án và tổng số h làm việc 1 tuần của tất cả nhân viên tham dự đè án đó
select sum(phancong.thoigian) as tongsohlv, dean.tenda
from phancong, dean where phancong.mada=dean.mada group by phancong.mada; 
-- 24 với mỗi đề án cho biết có bao nhiêu nhân viên tham gia đề án đó
select count(phancong.manv) as tongsonv, dean.tenda
from phancong, dean where phancong.mada=dean.mada group by dean.tenda; 
-- 25 với mỗi nhân viên , cho biết họ tên nhân viên và số lượng thân nhân của nhân viên đó
select nhanvien.honv, nhanvien.tenlot, nhanvien.tennv, count(thannhan.manv) as sothannhan
from nhanvien left join thannhan  on  nhanvien.manv = thannhan.manv group by nhanvien.manv;
-- 26 với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đè án mà nhân viên đó đã tham gia
select nhanvien.honv, nhanvien.tenlot, nhanvien.tennv, count(phancong.mada) as soduanthamgia
from nhanvien, phancong where nhanvien.manv = phancong.manv group by nhanvien.manv;
-- 27 với mỗi nhân viên cho biết số lượng nhân viên mà nhân viên đó quản lý trực tiếp
select ql.ma_nql, count(nv.manv)
from nhanvien as nv left join nhanvien as ql on nv.manv = ql.manv group by ql.ma_nql;
-- 28  với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc tại phòng ban đó
select phongban.tenphg, avg(nhanvien.luong) as luongtrungbinh
from phongban, nhanvien where phongban.maphg = nhanvien.maphg group by phongban.tenphg;
-- 29 với các phòng ban có lương tb trên 30000, liệt kê tên phòng ban và số lượng nhân viên phòng ban đó
select phongban.tenphg, avg(nhanvien.luong), count(nhanvien.manv)
from phongban, nhanvien where phongban.maphg = nhanvien.maphg   group by phongban.tenphg having avg(nhanvien.luong) >30000;
-- 30 với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì 
select phongban.tenphg, count(dean.maphg) as soduan
from phongban, dean where phongban.maphg = dean.maphg group by phongban.tenphg;
-- 31 với mỗi phòng ban,  cho biết tên phòng ban , họ tên trường phòng và số lượng đề án mà phòng ban đó chủ trì
select pb.tenphg as 'Tên phòng', nv.honv , nv.tenlot , nv.tennv, count(da.mada) as 'Số lượng đề án' from dean da, phongban pb, nhanvien nv 
where da.maphg = pb.maphg and pb.trphg = nv.manv group by pb.tenphg, nv.honv, nv.tenlot, nv.tennv;
-- 32 với các phòng ban có lương tb trên 40000, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì 
select phongban.tenphg, avg(nhanvien.luong), count(dean.mada)
from phongban, nhanvien, dean where phongban.maphg = nhanvien.maphg and phongban.maphg = dean.maphg   
group by phongban.tenphg having avg(nhanvien.luong) >40000;
-- 33 cho biết số đề án diễn ra tại từng địa điểm 
select count(mada), ddiem_da from dean group by ddiem_da;
-- 34 với mỗi đề án cho biết tên đề án và số lượng công việc của đề án này 
select dean.tenda, count(congviec.ten_cong_viec) as socongviec
from dean, congviec where dean.mada = congviec.mada group by dean.tenda;
-- 35 với mỗi công việc trong đề án có mã đề án là 30 , cho biết số lượng nhân viên đc phân công
select congviec.ten_cong_viec, count(phancong.manv)
from congviec, phancong where congviec.mada = 30 and congviec.stt = phancong.stt group by congviec.ten_cong_viec;
-- 36 với mỗi công việc trong đề án có mã đề án là 'Dao Tao' , cho biết số lượng nhân viên đc phân công
select count(phancong.manv) as sonhanvien
from phancong inner join dean on phancong.mada = dean.mada where dean.tenda like 'Đào Tạo';