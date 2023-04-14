use QuanLyGiaoVien

-- Q1 --
Select GV.HOTEN, GV.LUONG
From GIAOVIEN GV
WHERE GV.PHAI = N'Nữ'

-- Q2 --
Select GV.HOTEN, GV.LUONG*1.1 AS LUONG
From GIAOVIEN GV

-- Q3 --
Select GV.MAGV
From GIAOVIEN GV
WHERE GV.LUONG > 2000 AND GV.HOTEN LIKE N'Nguyễn %'
Union
Select BM.TRUONGBM
From BOMON BM
Where  YEAR(bm.NGAYNHANCHUC) > 1995

-- Q4 --
Select gv.*
From (GIAOVIEN gv join BOMON bm on(gv.MABM = bm.MABM)) join KHOA kh on (bm.MAKHOA=kh.MAKHOA)
where kh.TENKHOA = N'Công nghệ thông tin'

-- Q5 --
Select *
From (GIAOVIEN GV JOIN BOMON BM ON (GV.MAGV = BM.TRUONGBM))

-- Q6 --
Select GV.HOTEN, BM.TENBM
From GIAOVIEN GV, BOMON BM
Where gv.MABM = BM.MABM

-- Q7 --
Select DT.TENDT, GV.HOTEN AS GVCNDT
From GIAOVIEN GV, DETAI DT
Where DT.GVCNDT = GV.MAGV

-- Q8 --
Select KH.TENKHOA, GV.*
From GIAOVIEN GV, KHOA KH
Where GV.MAGV = KH.TRUONGKHOA

-- Q9 --
Select GV.*
From GIAOVIEN gv, BOMON bm
Where gv.MABM = bm.MABM and bm.TENBM = 'Vi sinh'
Union
Select GV.*
From GIAOVIEN gv, THAMGIADT tgdt
Where tgdt.MAGV= gv.MAGV and tgdt.MADT = '006' 

-- Q10--
Select dt.MADT, dt.TENDT, dt.GVCNDT, gv.NGAYSINH, gv.DIACHI
From GIAOVIEN gv, DETAI dt
where dt.CAPQL = N'Trường' and gv.MAGV = dt.GVCNDT
-- yêu cầu query CAPQL = Thành phố nhưng ko có dữ liệu đó nên em thực hiện query với CAPQL = "Trường"

-- Q11--
Select gv.MAGV, gv.HOTEN, gv.GVQLCM AS MA_GVQLCM, gv2.HOTEN AS TEN_GVQLCM
From GIAOVIEN gv, GIAOVIEN gv2
where gv.GVQLCM = gv2.MAGV

-- Q12--
Select gv.MAGV, gv.HOTEN, gv.GVQLCM AS MA_GVQLCM, gv2.HOTEN AS TEN_GVQLCM
From GIAOVIEN gv, GIAOVIEN gv2
where gv.GVQLCM = gv2.MAGV and gv2.HOTEN = N'Nguyễn An Trung'  
-- đề yêu cầu tìm giáo viên có người QL trực tiếp là Nguyễn Thanh Tùng, nhưng người này không có trong DB nên em query tên khác


-- Q13 --
Select GV.*
From GIAOVIEN gv, BOMON bm
Where gv.MAGV = bm.TRUONGBM and bm.TENBM = 'Vi sinh'

-- Q14 --
Select GV.*
From  (GIAOVIEN gv join DETAI dt on (gv.MAGV = dt.GVCNDT)) join CHUDE cd on (dt.MACD = cd.MACD)
where cd.TENCD = N'Quản lý giáo dục' 

-- Q15 --
Select * 
From CONGVIEC cv, DETAI dt
Where dt.MADT = cv.MADT and dt.TENDT = N'HTTT quản lý giáo vụ cho một khoa' AND YEAR(cv.NGAYBD) > 2008  and MONTH(cv.NGAYBD) = 3


-- Q16 --
Select gv.MAGV, gv.HOTEN, gv.GVQLCM AS MA_GVQLCM, gv2.HOTEN AS TEN_GVQLCM
From GIAOVIEN gv, GIAOVIEN gv2
where gv.GVQLCM = gv2.MAGV

-- Q17 --
Select * 
From CONGVIEC cv
Where YEAR(cv.NGAYBD) = 2008 and MONTH(cv.NGAYBD) >= 1 AND  MONTH(cv.NGAYBD) <= 8

-- Q18 --
Select gv1.*
From  (GIAOVIEN gv join BOMON bm on (gv.HOTEN = N'Trần Trà Hương' and bm.MABM= gv.MABM)) join GIAOVIEN gv1 on (gv.MABM = gv1.MABM)

-- Q19 --
Select gv.* 
From GIAOVIEN gv, BOMON bm
where bm.TRUONGBM = gv.MAGV
INTERSECT
Select gv.* 
From GIAOVIEN gv, DETAI dt
where gv.MAGV = dt.GVCNDT

-- Q20 --
Select gv.* 
From GIAOVIEN gv, BOMON bm
where bm.TRUONGBM = gv.MAGV
INTERSECT
Select gv.* 
From GIAOVIEN gv, KHOA kh
where kh.TRUONGKHOA = gv.MAGV

-- Q21 --
Select gv.HOTEN 
From GIAOVIEN gv, BOMON bm
where bm.TRUONGBM = gv.MAGV
INTERSECT
Select gv.HOTEN
From GIAOVIEN gv, DETAI dt
where gv.MAGV = dt.GVCNDT

-- Q22 --
Select gv.MAGV
From GIAOVIEN gv, KHOA kh
where kh.TRUONGKHOA = gv.MAGV
Intersect
Select gv.MAGV
From GIAOVIEN gv, DETAI dt
where gv.MAGV = dt.GVCNDT

-- Q23 --
Select gv.*
From GIAOVIEN gv
where gv.MABM = 'HTTT' 
UNION
Select gv.*
From GIAOVIEN gv, THAMGIADT tgdt
where gv.MAGV= tgdt.MAGV  and tgdt.MADT = '001'

-- Q24 --
Select gv1.*
From (GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM and gv.MAGV= '002')) join GIAOVIEN gv1 on (gv.MABM = gv1.MABM)

-- Q25 --
Select gv.*
From GIAOVIEN gv, BOMON bm
where bm.TRUONGBM = gv.MAGV

-- Q26 --
Select gv.HOTEN, gv.LUONG
From GIAOVIEN gv