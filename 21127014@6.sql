use QUANLYDETAI01

-- Q35 --
select MAX(LUONG) AS MaxLuong
from GIAOVIEN 

-- Q36 --
select *
from GIAOVIEN gv
where gv.LUONG >= all (	
		select LUONG
		from GIAOVIEN)

-- Q37 --
select MAX(gv.LUONG)
from GIAOVIEN gv
where gv.MABM in (	
		select bm.MABM
		from BOMON bm 
		where bm.MABM = 'HTTT')

-- Q38 --
select *
from GIAOVIEN gv
where DATEDIFF(YEAR, gv.NGAYSINH, GETDATE()) = ( 
		select MAX(DATEDIFF(YEAR, gv.NGAYSINH, GETDATE()))
		from GIAOVIEN gv  
		where gv.MABM in (	
				select BM.MABM
				from BOMON bm
				where bm.TENBM = N'Hệ thống thông tin') )

-- Q39 --
select *
from GIAOVIEN gv
where DATEDIFF(YEAR, gv.NGAYSINH, GETDATE()) = ( 
		select MIN(DATEDIFF(YEAR, gv.NGAYSINH, GETDATE()))
		from GIAOVIEN gv  
		where gv.MABM in (	
				select BM.MABM
				from BOMON bm , KHOA kh
				where bm.MAKHOA = kh.MAKHOA and kh.TENKHOA = N'Công nghệ thông tin') )
	
-- Q40 --
select gv.HOTEN, kh.TENKHOA, gv.LUONG
from (GIAOVIEN gv join BOMON bm ON (GV.MABM = bm.MABM)) join KHOA kh on (bm.MAKHOA = kh.MAKHOA)
where LUONG	>= all (	
		select LUONG
		from GIAOVIEN)

-- Q41 --
select *
from GIAOVIEN gv1
where gv1.LUONG >= all (	
		select LUONG
		from GIAOVIEN gv2
		where gv1.MABM = gv2.MABM)
order by gv1.MABM

-- Q42 --
select *
from DETAI dt
where dt.MADT not in  (	
		select tgdt.MADT 
		from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)
		where gv.HOTEN = N'Nguyễn Hoài An')

-- Q43 --
select dt.TENDT, gv.HOTEN
from DETAI dt join GIAOVIEN gv on (dt.GVCNDT = gv.MAGV)
where dt.MADT not in  (	
		select tgdt.MADT 
		from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)
		where gv.HOTEN = N'Nguyễn Hoài An')

-- Q44 --
select T1.MAGV, T1.HOTEN
from (	
			select *
			from GIAOVIEN gv
			where gv.MABM in (	
						select bm.MABM
						from BOMON bm join KHOA kh on (bm.MAKHOA = kh.MAKHOA and kh.TENKHOA = N'Công nghệ thông tin')) ) as T1
where T1.MAGV not in  (	
			select gv.MAGV
			from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MADT))

-- Q45 --
select *
from GIAOVIEN gv
where gv.MAGV not in (	
			select MAGV
			from THAMGIADT )

-- Q46 --
select *
from GIAOVIEN gv
where gv.LUONG > all (	
			select LUONG
			from GIAOVIEN gv 
			where gv.HOTEN = N'Nguyễn Hoài An')

-- Q47 --
select *
from GIAOVIEN
where MAGV in (
			select distinct gv.MAGV
			from (GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM)) join THAMGIADT tgdt on (tgdt.MAGV = gv.MAGV))



-- Q48 --
select *
from GIAOVIEN gv 
where gv.MAGV in (
			select gv1.MAGV 
			from GIAOVIEN gv1
			where gv.HOTEN = gv1.HOTEN and gv.PHAI = gv1.PHAI and gv.MAGV <> gv1.MAGV)


-- Q49 --
select *
from GIAOVIEN gv 
where gv.LUONG > (
			select distinct LUONG
			from GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM and bm.TENBM = N'Công nghệ phần mềm')
			where gv.LUONG <= all (
						select gv.LUONG
						from GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM and bm.TENBM = N'Công nghệ phần mềm')))

-- Q50 --
select *
from GIAOVIEN gv 
where gv.LUONG >= (
		select distinct LUONG
		from GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM and bm.TENBM = N'Hệ thống thông tin')
		where gv.LUONG >= all (
				select gv.LUONG
				from GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM and bm.TENBM = N'Hệ thống thông tin')))

-- Q51 --
select kh.TENKHOA
from  (GIAOVIEN gv join BOMON bm on (gv.MABM=bm.MABM)) join KHOA kh on (bm.MAKHOA=kh.MAKHOA) 
group by kh.TENKHOA   
having COUNT(*) >= all (
		select COUNT(*)
		from  (GIAOVIEN gv join BOMON bm on (gv.MABM=bm.MABM)) join KHOA kh on (bm.MAKHOA=kh.MAKHOA) 
		group by kh.MAKHOA )

-- Q52 --
select gv.MAGV
from GIAOVIEN gv join DETAI dt on (gv.MAGV = dt.GVCNDT)
group by gv.MAGV
having COUNT(*) >= all (
		select COUNT(*)
		from GIAOVIEN gv join DETAI dt on (gv.MAGV = dt.GVCNDT)
		group by gv.MAGV)

-- Q53 --
select bm.MABM
from BOMON bm join GIAOVIEN gv on (bm.MABM = gv.MABM)
group by bm.MABM
having COUNT(*) >= all (
		select COUNT(*)
		from BOMON bm join GIAOVIEN gv on (bm.MABM = gv.MABM)
		group by bm.MABM)

-- Q54 --
select gv.MAGV, gv.HOTEN, bm.TENBM
from (GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)) join BOMON bm on (gv.MABM = bm.MABM)
group by gv.MAGV, gv.HOTEN, bm.TENBM
having COUNT(*) >= all (
		select COUNT(*)
		from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)
		group by gv.MAGV, gv.HOTEN)

-- Q55 --
select gv.MAGV, gv.HOTEN, bm.TENBM
from (GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)) join BOMON bm on (gv.MABM = bm.MABM)
group by gv.MAGV, gv.HOTEN, bm.TENBM
having COUNT(*) >= all (
		select COUNT(*)
		from  (GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)) join BOMON bm on (gv.MABM = bm.MABM and bm.MABM='HTTT')
		group by gv.MAGV, gv.HOTEN)

-- Q56 --
select gv.MAGV, gv.HOTEN, bm.TENBM
from (GIAOVIEN gv join NGUOI_THAN nt on (gv.MAGV = nt.MAGV)) join BOMON bm on (gv.MABM = bm.MABM)
group by gv.MAGV, gv.HOTEN, bm.TENBM
having COUNT(*) >= all (
		select COUNT(*)
		from (GIAOVIEN gv join NGUOI_THAN nt on (gv.MAGV = nt.MAGV)) join BOMON bm on (gv.MABM = bm.MABM)
		group by gv.MAGV, gv.HOTEN, bm.TENBM)

-- Q57 --
select gv.HOTEN
from (GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM)) join DETAI dt on (dt.GVCNDT = gv.MAGV)
group by gv.HOTEN
having COUNT(*) >= all (
	select COUNT(*)
	from (GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM)) join DETAI dt on (dt.GVCNDT = gv.MAGV)
	group by gv.HOTEN)