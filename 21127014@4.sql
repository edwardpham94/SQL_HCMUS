USE QuanLyDeTai
-- Q27 --
Select COUNT(gv.MAGV) AS SoLuongGV, SUM(gv.LUONG) TongLuong
From GIAOVIEN gv

-- Q28 --
Select bm.MABM, COUNT(gv.MAGV) AS SoLuongGV, AVG(gv.LUONG) AS TrungBinhLuong
From (GIAOVIEN gv join BOMON bm on (gv.MABM = BM.MABM))
Group by bm.MABM

-- Q29 --
Select cd.TENCD, COUNT(dt.MADT) AS SoLuongDeTai
From DETAI dt join CHUDE cd on(dt.MACD= cd.MACD)
Group by cd.TENCD

-- Q30 --
Select gv.HOTEN, COUNT(tgdt.MADT) AS SoLuongDeTaiThamGia
From GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)
Group by gv.HOTEN

-- Q31 --
Select gv.HOTEN, COUNT(dt.TENDT) AS SoLuongCNDT
From GIAOVIEN gv join DETAI dt on (gv.MAGV = dt.GVCNDT)
Group by gv.HOTEN

-- Q32 --
Select  gv.HOTEN, COUNT(nt.TEN) AS SoLuongNguoiThan
From GIAOVIEN gv join NGUOI_THAN nt on (gv.MAGV = nt.MAGV)
Group by gv.HOTEN

-- Q33 --
Select  gv.MAGV, COUNT(tgdt.MADT) AS SoLuongDTTG
From GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)
Group by gv.MAGV
Having COUNT(tgdt.MADT) >= 3

-- Q34 --
Select dt.TENDT, COUNT(gv.MAGV) AS SoLuongGiaoVienTG 
From (GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)) join DETAI dt on (tgdt.MADT = dt.MADT)
where dt.TENDT = N'HTTT quản lý các trường đại học'  --N'Ứng dụng hóa học xanh'
Group by dt.TENDT
-- 'Ứng dụng hóa học xanh' khong có gv tham gia nên em thực hiện query trên 'HTTT quản lý các trường đại học'