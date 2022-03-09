-- bai8
-- 37 cho biết danh sách các đề án (MADA) có nhân công với họ là Đinh, hoặc có ng trưởng phòng chủ trì đề án với họ là Đinh
select dean.tenda, phancong.mada
from dean inner join phancong on phancong.mada = dean.mada 
where phancong.manv in 
(select phancong.manv from nhanvien inner join phancong on nhanvien.manv=phancong.manv where nhanvien.honv like 'Đinh');
-- 38 danh sách những nhân viên có trên 2 thân nhân
select nhanvien.honv, nhanvien.tenlot, nhanvien.tennv
from nhanvien where nhanvien.manv  in
(select nhanvien.manv from nhanvien inner join thannhan on nhanvien.manv = thannhan.manv group by thannhan.manv having count(thannhan.manv) > 2 );
-- 39 danh sách những nhân viên ko có thân nhân nào
select nhanvien.honv, nhanvien.tenlot, nhanvien.tennv
from nhanvien where nhanvien.manv not in
(select nhanvien.manv from nhanvien inner join thannhan on nhanvien.manv = thannhan.manv group by thannhan.manv having count(thannhan.manv) >= 1 );
-- 40 danh sách những nhân viên  có tối thiểu 1 thân nhân 
select nhanvien.honv, nhanvien.tenlot, nhanvien.tennv
from nhanvien inner join phongban on nhanvien.manv = phongban.trphg where nhanvien.manv  in
(select nhanvien.manv from nhanvien inner join thannhan on nhanvien.manv = thannhan.manv group by thannhan.manv having count(thannhan.manv) >= 1 );
-- 41 họ những trưởng phòng chưa có gia đình
select nhanvien.honv 
from nhanvien inner join phongban on nhanvien.manv = phongban.trphg where nhanvien.manv not in
(select nhanvien.manv from nhanvien inner join thannhan on nhanvien.manv = thannhan.manv group by thannhan.manv having count(thannhan.manv) >= 1 );
-- 42 cho biết họ tên nhân viên có mức lương trên mức lương trung bình của phòng "Nghiên cứu"
select nhanvien.honv, nhanvien.tenlot, nhanvien.tennv
from nhanvien where luong > (
select avg(nhanvien.luong)
from nhanvien inner join phongban on nhanvien.maphg = phongban.maphg where phongban.tenphg like 'Nghiên cứu');
-- 43 cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất
select phongban.tenphg, nhanvien.honv, nhanvien.tenlot, nhanvien.tennv
from phongban inner join nhanvien on phongban.trphg = nhanvien.manv where nhanvien.maphg in (
select nhanvien.maphg
from nhanvien group by nhanvien.maphg having count(nhanvien.maphg) >= all (select count(nhanvien.maphg) from nhanvien group by nhanvien.maphg));
-- 44 cho biết danh sách các mã đề án mà nhân viên có mã là 009 chưa làm
select dean.mada from dean where dean.mada not in
(select phancong.mada from phancong where phancong.manv = 009);
-- 45 cho biết ds các công việc (tên cv) trong đề án 'Sản phẩm X' mà nhân viên có mã 009 chưa làm
select congviec.ten_cong_viec, phancong.stt
from phancong inner join congviec on (phancong.mada , phancong.stt) = (congviec.mada , congviec.stt) 
where phancong.manv not like '009' and phancong.mada in 
(select dean.mada from dean where dean.tenda like 'Sản phẩm X' ) ;


-- 46 tìm họ tên nhân viên và địa chỉ của những nhân viên làm việc cho 1 đề án ở tphcm nhưng phòng ban lại ko tọa lạc ở tphcm
select nhanvien.honv, nhanvien.tenlot, nhanvien.tennv, nhanvien.dchi
from nhanvien inner join phancong on nhanvien.manv = phancong.manv where phancong.mada in 
(select phancong.mada from phancong inner join dean on phancong.mada = dean.mada where dean.ddiem_da like 'TP HCM') and 
nhanvien.maphg in 
(select nhanvien.maphg from nhanvien inner join diadiem_phg on diadiem_phg.maphg = nhanvien.maphg where diadiem_phg.diadiem not like 'TP HCM' );
-- 47 tổng quát câu 16 tìm họ tên nhân viên và địa chỉ của những nhân viên làm việc cho 1 đề án ở tp nhưng phòng ban họ trực thuộc lại ko tọa lạc ở tp đó
select phancong.manv, nhanvien.honv, nhanvien.tenlot, nhanvien.tennv, nhanvien.DCHI, phancong.mada, dean.ddiem_da, nhanvien.maphg
from phancong left join nhanvien on nhanvien.manv = phancong.manv
left join dean on dean.mada = phancong.mada
where not exists (select maphg, diadiem from diadiem_phg where maphg = nhanvien.maphg and dean.ddiem_da like diadiem);




