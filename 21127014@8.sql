use QUANLYDETAI01

-- Q75 --
select gv.HOTEN, BM.TENBM
from GIAOVIEN gv left join BOMON bm on (gv.MAGV = bm.TRUONGBM)

-- Q76 --
select bm.TENBM, gv.HOTEN GVCNBM
from BOMON bm left join GIAOVIEN gv on (bm.TRUONGBM = gv.MAGV)

-- Q77 --
select gv.HOTEN, dt.*
from GIAOVIEN gv left join DETAI dt on (gv.MAGV = dt.GVCNDT)

-- Q78 --
select gv.MAGV, gv.HOTEN, case
								when gv.LUONG < 1800 then N'Thấp'
								when gv.LUONG >= 1800 and gv.LUONG <=2200 then N'Trung bình'
								when gv.LUONG > 2200 then N'Cao'
							end MUCLUONGGV
from GIAOVIEN gv

-- Q79 --
SELECT GV.MAGV,GV.HOTEN,LUONG, (SELECT (COUNT(*)+1) 
						FROM GIAOVIEN GV1 
						WHERE GV1.LUONG>GV.LUONG) 'RANKING OF SALARY'
FROM GIAOVIEN GV



-- Q80 --
select gv.MAGV, gv.HOTEN, case 
							when gv.MAGV = kh.TRUONGKHOA then gv.LUONG + 600
							when gv.MAGV = bm.TRUONGBM and gv.MAGV <> kh.MAKHOA then gv.LUONG + 300
							when gv.MAGV <> bm.TRUONGBM and gv.MAGV <> kh.MAKHOA then gv.LUONG
							end THUNHAP
from (GIAOVIEN gv join BOMON bm on (gv.MABM= bm.MABM)) join KHOA kh on (bm.MAKHOA = kh.MAKHOA)

-- Q81 --
select gv.MAGV, gv.HOTEN, case
								when gv.PHAI = N'Nam' then YEAR(gv.NGAYSINH) + 60
								when gv.PHAI = N'Nữ' then YEAR(gv.NGAYSINH) + 55
							end NAMVEHUU
from GIAOVIEN gv

-- Q82 --
select gv1.MAGV, gv1.HOTEN, gv2.HOTEN GVQLCM
from GIAOVIEN gv1 left join GIAOVIEN gv2 on (gv1.GVQLCM = gv2.MAGV)

-- Q83 --
select bm.MABM, bm.TENBM, gv1.HOTEN as TRUONGBM , COUNT(gv.MAGV) SoLuongGV
from BOMON bm left join GIAOVIEN gv on (gv.MABM = bm.MABM) left join GIAOVIEN gv1 on (bm.TRUONGBM = gv1.MAGV)
group by bm.MABM, bm.TENBM, gv1.HOTEN

-- Q84 --
select gv.HOTEN, cv.TENCV
from GIAOVIEN gv left join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV) join CONGVIEC cv on (tgdt.MADT = cv.MADT and tgdt.STT = cv.STT)
where gv.PHAI = N'Nam'

-- Q85 --
select gv.HOTEN, cv.TENCV
from (GIAOVIEN gv right join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)) right join CONGVIEC cv on (tgdt.MADT = cv.MADT and tgdt.STT = cv.STT)
where tgdt.MADT = '001'

-- Q86 --
select gv.MAGV, gv.HOTEN
from GIAOVIEN gv
where 2014 =  (case 
		when gv.PHAI = N'Nam' then year(gv.NGAYSINH) + 60
		when gv.PHAI = N'Nữ' then year(gv.NGAYSINH) + 55
	end)

-- Q87 --
select gv.MAGV, (case 
		when gv.PHAI = N'Nam' then year(gv.NGAYSINH) + 60
		when gv.PHAI = N'Nữ' then year(gv.NGAYSINH) + 55
	end) NAMVELUU
from BOMON bm join GIAOVIEN gv on (bm.TRUONGBM = gv.MAGV)

-- Q88 --
create table DANHSACHTHIDUA (
	MAGV nvarchar(10),
	SODTDAT int,
	DANHHIEU nvarchar(30),
	primary key (MAGV)
)

-- a
insert into DANHSACHTHIDUA
select gv.MAGV, COUNT(tgdt.MADT), null
from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV= tgdt.MAGV)
group by gv.MAGV

-- b
update DANHSACHTHIDUA 
set DANHHIEU =  (case 
						when SODTDAT = 0 then N'Chưa hoàn thành nhiệm vụ'
						when SODTDAT > 0 and SODTDAT <= 2 then N'Hoàn thành nhiệm vụ'
						when SODTDAT >= 3 and SODTDAT <= 5 then N'Tiên tiến'
						when SODTDAT >= 6 then N'Lao động xuất sắc'
					end) 





