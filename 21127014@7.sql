use QUANLYDETAI

-- Q58 --
-- EXCEPT
select gv.MAGV
from GIAOVIEN gv
where not exists( 
				select cd.MACD
				from CHUDE cd
				except
				select dt.MACD
				from (GIAOVIEN gv1 join THAMGIADT tgdt on (tgdt.MAGV = gv1.MAGV)) join DETAI dt on (dt.MADT = tgdt.MADT)
				where gv.MAGV = gv1.MAGV 
				)

-- NOT EXIST
select gv.MAGV
from GIAOVIEN gv
where not exists (
			select *
			from CHUDE cd
			where not exists (
							select *
							from (THAMGIADT tgdt join DETAI dt on (tgdt.MADT = dt.MADT)) 
							where  tgdt.MAGV = gv.MAGV and cd.MACD = dt.MACD
							))

-- COUNT
select gv.MAGV, COUNT(distinct MACD)
from (GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)) join DETAI dt on (tgdt.MADT = dt.MADT)
where dt.MACD in (	select cd.MACD
					from CHUDE cd)
group by gv.MAGV
having COUNT(distinct MACD) = (	select COUNT(cd.MACD)
								from CHUDE cd)

-- Q59 --
-- EXCEPT
select dt.TENDT
from DETAI dt
where not exists (
				select gv.MAGV
				from GIAOVIEN gv 
				where gv.MABM = 'HTTT'
				except 
				select gv.MAGV
				from GIAOVIEN gv join THAMGIADT tgdt on (tgdt.MAGV = gv.MAGV and gv.MABM = 'HTTT')
				where tgdt.MADT = dt.MADT)

-- NOT EXISTS
select dt.TENDT
from DETAI dt
where not exists (
				select *
				from GIAOVIEN gv 
				where gv.MABM = 'HTTT' and  not exists (
								select *
								from GIAOVIEN gv1 join THAMGIADT tgdt on (gv1.MAGV =tgdt.MAGV)
								where dt.MADT = tgdt. MADT and gv1.MAGV = gv.MAGV ))

-- COUNT
select dt.MADT, dt.TENDT
from DETAI dt join THAMGIADT tgdt on (dt.MADT = tgdt.MADT)
where tgdt.MAGV in (	
						select MAGV
						from GIAOVIEN
						where MABM = 'HTTT')
group by dt.MADT, dt.TENDT
having COUNT(distinct tgdt.MAGV) = (
							select COUNT(*)
							from GIAOVIEN gv
							where MABM = 'HTTT')
							

------------------------------------------------------------------------ Q60 -------------------------------------------------------------------------------
select dt.TENDT
from DETAI dt
where not exists ( 
					select gv.MAGV
					from GIAOVIEN gv join BOMON bm on (bm.MABM = gv.MABM  and bm.TENBM = N'Hệ thống thông tin')
					except
					select gv.MAGV
					from (GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)  ) join BOMON bm on (bm.MABM = gv.MABM and bm.TENBM = N'Hệ thống thông tin')
					where dt.MADT = tgdt.MADT
					)

select dt.TENDT
from DETAI dt
where not exists (
					select *
					from GIAOVIEN gv join BOMON bm on (bm.MABM = gv.MABM  and bm.TENBM = N'Hệ thống thông tin')
					where not exists (
										select * 
										from (GIAOVIEN gv1 join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)  ) join BOMON bm on (bm.MABM = gv.MABM and bm.TENBM = N'Hệ thống thông tin')
										where dt.MADT = tgdt.MADT and gv1.MAGV = gv.MAGV
										)
					)

select dt.MADT, dt.TENDT
from DETAI dt join THAMGIADT tgdt on (dt.MADT = tgdt.MADT)
where tgdt.MAGV in (	
						select MAGV
						from GIAOVIEN gv join BOMON bm on (bm.MABM= gv.MABM and bm.TENBM = N'Hệ thống thông tin')
						)
group by dt.MADT, dt.TENDT
having COUNT(distinct tgdt.MAGV) = (
							select COUNT(*)
							from GIAOVIEN gv join BOMON bm on (bm.MABM= gv.MABM and bm.TENBM = N'Hệ thống thông tin')
							)
			


------------------------------------------------------------------------ Q61 -------------------------------------------------------------------------------
select *
from GIAOVIEN gv
where not exists (
					select dt.MADT
					from DETAI dt
					where dt.MACD = 'QLGD'
					except
					select dt.MADT
					from THAMGIADT tgdt join DETAI dt on (tgdt.MADT = dt.MADT and dt.MACD = 'QLGD')
					where tgdt.MAGV = gv.MAGV
				)

select *
from GIAOVIEN gv
where not exists (
					select * 
					from DETAI dt 
					where dt.MACD = 'QLGD' and not exists (
									   select *
									   from THAMGIADT tgdt join DETAI dt1 on (tgdt.MADT = dt1.MADT and dt1.MACD =  'QLGD')
									   where tgdt.MADT = dt.MADT and tgdt.MAGV = gv.MAGV))

select gv.MAGV, gv.HOTEN
from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)
where tgdt.MADT in (
					select dt.MADT
					from DETAI dt
					where dt.MACD = 'QLGD')
group by gv.MAGV, gv.HOTEN
having COUNT(distinct tgdt.MADT) = (
							select COUNT(*)
							from DETAI dt
							where dt.MACD =  'QLGD')

------------------------------------------------------------------------ Q62 -------------------------------------------------------------------------------
select gv2.HOTEN
from GIAOVIEN gv2
where gv2.HOTEN <>  N'Trần Trà Hương' and  not exists (
					select distinct tgdt.MADT
					from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV and gv.HOTEN = N'Trần Trà Hương')
					except 
					select distinct tgdt.MADT
					from GIAOVIEN gv1 join THAMGIADT tgdt on (gv1.MAGV = tgdt.MAGV)
					where gv2.MAGV = gv1.MAGV
					)

select *
from GIAOVIEN gv 
where gv.HOTEN <>  N'Trần Trà Hương' and not exists  (
					select tgdt.MADT
					from GIAOVIEN gv1 join THAMGIADT tgdt on (gv1.MAGV = tgdt.MAGV and gv1.HOTEN = N'Trần Trà Hương')
					where not exists (
										select *
										from GIAOVIEN gv2 join THAMGIADT tgdt1 on (gv2.MAGV = tgdt1.MAGV)
										where gv.MAGV= gv2.MAGV and tgdt.MADT = tgdt1.MADT
										))

select gv.MAGV, gv.HOTEN
from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)
where tgdt.MADT in (
						select tgdt1.MADT
						from GIAOVIEN gv1 join THAMGIADT tgdt1 on (gv1.MAGV = tgdt1.MAGV and gv1.HOTEN = N'Trần Trà Hương'))
group by gv.MAGV, gv.HOTEN
having COUNT(tgdt.MADT)  = (
								select COUNT(*)
								from GIAOVIEN gv1 join THAMGIADT tgdt1 on (gv1.MAGV = tgdt1.MAGV and gv1.HOTEN = N'Trần Trà Hương'))


------------------------------------------------------------------------ Q63 -------------------------------------------------------------------------------
select dt.TENDT
from DETAI dt
where not exists ( 
					select gv.MAGV
					from GIAOVIEN gv join BOMON bm on (bm.MABM = gv.MABM  and bm.TENBM = N'Hóa Hữu Cơ')
					except
					select gv.MAGV
					from (GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)  ) join BOMON bm on (bm.MABM = gv.MABM and bm.TENBM = N'Hóa Hữu Cơ')
					where dt.MADT = tgdt.MADT
					)

select dt.TENDT
from DETAI dt
where not exists (
					select *
					from GIAOVIEN gv join BOMON bm on (bm.MABM = gv.MABM  and bm.TENBM = N'Hóa Hữu Cơ')
					where not exists (
										select * 
										from (GIAOVIEN gv1 join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)  ) join BOMON bm on (bm.MABM = gv.MABM and bm.TENBM = N'Hóa Hữu Cơ')
										where dt.MADT = tgdt.MADT and gv1.MAGV = gv.MAGV
										)
					)

select dt.MADT, dt.TENDT
from DETAI dt join THAMGIADT tgdt on (dt.MADT = tgdt.MADT)
where tgdt.MAGV in (	
						select MAGV
						from GIAOVIEN gv join BOMON bm on (bm.MABM= gv.MABM and bm.TENBM = N'Hóa Hữu Cơ')
						)
group by dt.MADT, dt.TENDT
having COUNT(distinct tgdt.MAGV) = (
							select COUNT(*)
							from GIAOVIEN gv join BOMON bm on (bm.MABM= gv.MABM and bm.TENBM = N'Hóa Hữu Cơ')
							)


------------------------------------------------------------------------ Q64 -------------------------------------------------------------------------------
select *
from GIAOVIEN gv
where not exists  (	
					select cv.MADT, cv.STT
					from CONGVIEC cv
					where cv.MADT= '006'
					except
					select cv.MADT, cv.STT
					from (GIAOVIEN gv2 join THAMGIADT tgdt on (gv2.MAGV = tgdt.MAGV and tgdt.MADT = '006')) join CONGVIEC cv on (tgdt.MADT = cv.MADT)
					where gv.MAGV = gv2.MAGV
				)


select *
from GIAOVIEN gv
where not exists (
					select cv.MADT, cv.STT
					from CONGVIEC cv
					where cv.MADT= '006' and not exists (
															select *
															from (GIAOVIEN gv1 join THAMGIADT tgdt1 on (gv1.MAGV = tgdt1.MAGV and tgdt1.MADT = '006')) join CONGVIEC cv1 on (tgdt1.MADT = cv1.MADT)
															where gv.MAGV = gv1.MAGV and cv.MADT = cv1.MADT and cv.STT = cv1.STT
															))

select gv.HOTEN
from (GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV and tgdt.MADT = '006')) join CONGVIEC cv on (tgdt.MADT=cv.MADT)
group by gv.HOTEN
having COUNT(distinct cv.STT) = (
						select COUNT(*)
						from CONGVIEC cv
						where cv.MADT= '006')


------------------------------------------------------------------------ Q65 -------------------------------------------------------------------------------

select *
from GIAOVIEN gv
where not exists (
					select dt.MADT
					from DETAI dt join CHUDE cd on (dt.MACD = cd.MACD)
					where cd.TENCD = N'Ứng dụng công nghệ'
					except
					select dt.MADT
					from (THAMGIADT tgdt join DETAI dt on (tgdt.MADT = dt.MADT)) join CHUDE cd on (dt.MACD = cd.MACD and  cd.TENCD = N'Ứng dụng công nghệ')
					where tgdt.MAGV = gv.MAGV
				)

select *
from GIAOVIEN gv
where not exists (
					select * 
					from DETAI dt join CHUDE cd on (dt.MACD = cd.MACD)
					where cd.TENCD = N'Ứng dụng công nghệ' and not exists (
									   select *
									   from (THAMGIADT tgdt join DETAI dt1 on (tgdt.MADT = dt1.MADT)) join CHUDE cd on (cd.MACD = dt1.MACD and cd.TENCD = N'Ứng dụng công nghệ')
									   where tgdt.MADT = dt.MADT and tgdt.MAGV = gv.MAGV))

select gv.MAGV, gv.HOTEN
from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)
where tgdt.MADT in (
					select dt.MADT
					from DETAI dt join CHUDE cd on (dt.MACD = cd.MACD)
					where cd.TENCD = N'Ứng dụng công nghệ')
group by gv.MAGV, gv.HOTEN
having COUNT(distinct tgdt.MADT) = (
							select COUNT(*)
							from DETAI dt join CHUDE cd on (dt.MACD = cd.MACD)
							where cd.TENCD = N'Ứng dụng công nghệ')

------------------------------------------------------------------------ Q66 -------------------------------------------------------------------------------
select *
from GIAOVIEN gv
where not exists (
					select dt.MADT
					from DETAI dt join GIAOVIEN gv2 on (dt.GVCNDT = gv2.MAGV and gv2.HOTEN = N'Trần Trà Hương')
					except
					select tgdt2.MADT
					from GIAOVIEN gv2 join THAMGIADT tgdt2 on (gv2.MAGV = tgdt2.MAGV) 
					where tgdt2.MADT in (
											select dt.MADT
											from DETAI dt join GIAOVIEN gv2 on (dt.GVCNDT = gv2.MAGV and gv2.HOTEN = N'Trần Trà Hương')) and gv2.MAGV = gv.MAGV
					
					)

select *
from GIAOVIEN gv
where not exists  (
					select *
					from DETAI dt1 join GIAOVIEN gv1 on (dt1.GVCNDT = gv1.MAGV and gv1.HOTEN = N'Trần Trà Hương')
					where not exists (
										select *
										from GIAOVIEN gv2 join THAMGIADT tgdt2 on (gv2.MAGV = tgdt2.MAGV) 
										where gv2.MAGV = gv.MAGV and dt1.MADT = tgdt2.MADT)
				)

select gv.HOTEN
from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)
where tgdt.MADT in (
						select dt1.MADT
						from DETAI dt1 join GIAOVIEN gv1 on (dt1.GVCNDT = gv1.MAGV and gv1.HOTEN = N'Trần Trà Hương')
						)
group by gv.HOTEN
having COUNT(distinct TGDT.MADT) = (
							select COUNT(*)
							from DETAI dt1 join GIAOVIEN gv1 on (dt1.GVCNDT = gv1.MAGV and gv1.HOTEN = N'Trần Trà Hương')
							)

------------------------------------------------------------------------ Q67 -------------------------------------------------------------------------------
select *
from DETAI dt
where not exists (	
					select GV.MAGV	
					from GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM and bm.MAKHOA = 'CNTT')
					except
					select gv.MAGV
					from (GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM and bm.MAKHOA = 'CNTT')) join THAMGIADT tgdt on (tgdt.MAGV=gv.MAGV)
					where dt.MADT = tgdt.MADT
					)

select *
from DETAI dt
where not exists (
					select *
					from GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM and bm.MAKHOA = 'CNTT')
					where not exists (	
										select *
										from (GIAOVIEN gv1 join BOMON bm on (gv1.MABM = bm.MABM and bm.MAKHOA = 'CNTT')) join THAMGIADT tgdt on (tgdt.MAGV=gv1.MAGV)
										where dt.MADT = tgdt.MADT and gv.MAGV = gv1.MAGV
										)
				)


select dt.MADT
from (DETAI dt join THAMGIADT tgdt on (dt.MADT = tgdt.MADT)) join GIAOVIEN gv on (gv.MAGV = tgdt.MAGV)
where gv.MAGV in (
					select gv.MAGV
					from GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM and bm.MAKHOA = 'CNTT')
				)
group by dt.MADT
having COUNT(distinct gv.MAGV) = (
							select COUNT(*)
							from GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM and bm.MAKHOA = 'CNTT')
							)

------------------------------------------------------------------------ Q68 -------------------------------------------------------------------------------
select gv.HOTEN
from GIAOVIEN gv
where not exists  (	
					select cv.MADT, cv.STT
					from CONGVIEC cv join DETAI dt on (dt.MADT = cv.MADT)
					where dt.TENDT = N'Nghiên cứu tế bào gốc'
					except
					select cv.MADT, cv.STT
					from ((GIAOVIEN gv2 join THAMGIADT tgdt on (gv2.MAGV = tgdt.MAGV)) join CONGVIEC cv on (tgdt.MADT = cv.MADT)) join DETAI dt on (dt.MADT = cv.MADT and dt.TENDT = N'Nghiên cứu tế bào gốc' )
					where gv.MAGV = gv2.MAGV
				)


select gv.HOTEN
from GIAOVIEN gv
where not exists (
					select cv.MADT, cv.STT
					from CONGVIEC cv join DETAI dt on (dt.MADT = cv.MADT)
					where dt.TENDT = N'Nghiên cứu tế bào gốc' and not exists (
															select *
															from ((GIAOVIEN gv1 join THAMGIADT tgdt1 on (gv1.MAGV = tgdt1.MAGV)) join CONGVIEC cv1 on (tgdt1.MADT = cv1.MADT)) join DETAI dt on (dt.MADT = cv1.MADT and dt.TENDT = N'Nghiên cứu tế bào gốc' )
															where gv.MAGV = gv1.MAGV and cv.MADT = cv1.MADT and cv.STT = cv1.STT
															))

select gv.HOTEN
from ((GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)) join CONGVIEC cv on (tgdt.MADT=cv.MADT)) join DETAI  dt on (dt.MADT = cv.MADT and dt.TENDT = N'Nghiên cứu tế bào gốc' )
group by gv.HOTEN
having COUNT(distinct cv.STT) = (
						select COUNT(*)
						from CONGVIEC cv join DETAI dt on (dt.MADT = cv.MADT)
					    where dt.TENDT = N'Nghiên cứu tế bào gốc')


------------------------------------------------------------------------ Q69 -----------------------------------------------------------------------------------------------
select *
from GIAOVIEN gv
where not exists  (
						select dt.MADT
						from DETAI dt 
						where dt.KINHPHI > 100
						except
						select tgdt.MADT
						from GIAOVIEN gv1 join THAMGIADT tgdt on (gv1.MAGV = tgdt.MAGV)
						where gv.MAGV = gv1.MAGV
				)

select *
from GIAOVIEN gv
where not exists (
					select *
					from DETAI dt 
					where dt.KINHPHI > 100 and not exists (
															select *
															from  GIAOVIEN gv1 join THAMGIADT tgdt on (gv1.MAGV = tgdt.MAGV)
															where gv.MAGV = gv1.MAGV and dt.MADT = tgdt.MADT
														)
				)


select  gv.MAGV, gv.HOTEN
from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)
where tgdt.MADT in (
					select dt.MADT
					from DETAI dt 
					where dt.KINHPHI > 100)
group by gv.MAGV, gv.HOTEN
having COUNT(distinct tgdt.MADT) = (
									select COUNT(*)
									from DETAI dt 
									where dt.KINHPHI > 100)

------------------------------------------------------------------------ Q70 -----------------------------------------------------------------------------------------------
select *
from DETAI dt 
where not exists (
					select gv.MAGV
					from (GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM)) join KHOA kh on (kh.MAKHOA = bm.MAKHOA and  kh.TENKHOA = N'Sinh Học')
					except 
					select gv.MAGV
					from ((GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)) join BOMON bm on (gv.MABM = bm.MABM)) join KHOA kh on (kh.MAKHOA = bm.MAKHOA and  kh.TENKHOA = N'Sinh Học')
					where tgdt.MADT = dt.MADT
				)


select *
from DETAI dt
where not exists (
					select *
					from (GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM)) join KHOA kh on (kh.MAKHOA = bm.MAKHOA and  kh.TENKHOA = N'Sinh Học')
					where not exists (	
										select *
										from ((GIAOVIEN gv1 join BOMON bm on (gv1.MABM = bm.MABM)) join THAMGIADT tgdt on (tgdt.MAGV=gv1.MAGV)) join KHOA kh on (kh.MAKHOA = bm.MAKHOA and  kh.TENKHOA = N'Sinh Học')
										where dt.MADT = tgdt.MADT and gv.MAGV = gv1.MAGV
										)
				)


select dt.MADT, dt.TENDT
from (DETAI dt join THAMGIADT tgdt on (dt.MADT = tgdt.MADT)) join GIAOVIEN gv on (gv.MAGV = tgdt.MAGV)
where gv.MAGV in (
					select gv.MAGV
					from (GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM)) join KHOA kh on (kh.MAKHOA = bm.MAKHOA and  kh.TENKHOA = N'Sinh Học')
				)
group by dt.MADT, dt.TENDT
having COUNT(distinct gv.MAGV) = (
							select COUNT(*)
							from (GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM)) join KHOA kh on (kh.MAKHOA = bm.MAKHOA and  kh.TENKHOA = N'Sinh Học')
							)

------------------------------------------------------------------------ Q71 -----------------------------------------------------------------------------------------------

select gv.HOTEN
from GIAOVIEN gv
where not exists  (	
					select cv.MADT, cv.STT
					from CONGVIEC cv join DETAI dt on (dt.MADT = cv.MADT)
					where dt.TENDT = N'Ứng dụng xanh'
					except
					select cv.MADT, cv.STT
					from ((GIAOVIEN gv2 join THAMGIADT tgdt on (gv2.MAGV = tgdt.MAGV)) join CONGVIEC cv on (tgdt.MADT = cv.MADT)) join DETAI dt on (dt.MADT = cv.MADT and dt.TENDT = N'Nghiên cứu tế bào gốc' )
					where gv.MAGV = gv2.MAGV
				)


select gv.HOTEN
from GIAOVIEN gv
where not exists (
					select cv.MADT, cv.STT
					from CONGVIEC cv join DETAI dt on (dt.MADT = cv.MADT)
					where dt.TENDT = N'Ứng dụng xanh' and not exists (
															select *
															from ((GIAOVIEN gv1 join THAMGIADT tgdt1 on (gv1.MAGV = tgdt1.MAGV)) join CONGVIEC cv1 on (tgdt1.MADT = cv1.MADT)) join DETAI dt on (dt.MADT = cv1.MADT and dt.TENDT = N'Ứng dụng xanh' )
															where gv.MAGV = gv1.MAGV and cv.MADT = cv1.MADT and cv.STT = cv1.STT
															))

select gv.MAGV, gv.HOTEN, gv.NGAYSINH
from ((GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)) join CONGVIEC cv on (tgdt.MADT=cv.MADT)) join DETAI  dt on (dt.MADT = cv.MADT and dt.TENDT = N'Ứng dụng xanh' )
group by gv.MAGV, gv.HOTEN, gv.NGAYSINH
having COUNT(distinct cv.STT) = (
						select COUNT(*)
						from CONGVIEC cv join DETAI dt on (dt.MADT = cv.MADT)
					    where dt.TENDT = N'Ứng dụng xanh')

------------------------------------------------------------------------ Q72 -----------------------------------------------------------------------------------------------

select gv.MAGV, gv.HOTEN, gv.MABM, gv1.HOTEN
from GIAOVIEN gv join GIAOVIEN gv1 on (gv.GVQLCM= gv1.MAGV)
where not exists (
					select dt.MADT
					from DETAI dt join CHUDE cd on (dt.MACD = cd.MACD)
					where cd.TENCD = N'Nghiên cứu phát triển'
					except
					select dt.MADT
					from (THAMGIADT tgdt join DETAI dt on (tgdt.MADT = dt.MADT)) join CHUDE cd on (dt.MACD = cd.MACD and  cd.TENCD = N'Nghiên cứu phát triển')
					where tgdt.MAGV = gv.MAGV
				)

select  gv.MAGV, gv.HOTEN, gv.MABM, gv1.HOTEN
from GIAOVIEN gv join GIAOVIEN gv1 on (gv.GVQLCM= gv1.MAGV)
where not exists (
					select * 
					from DETAI dt join CHUDE cd on (dt.MACD = cd.MACD)
					where cd.TENCD =N'Nghiên cứu phát triển' and not exists (
									   select *
									   from (THAMGIADT tgdt join DETAI dt1 on (tgdt.MADT = dt1.MADT)) join CHUDE cd on (cd.MACD = dt1.MACD and cd.TENCD = N'Ứng dụng công nghệ')
									   where tgdt.MADT = dt.MADT and tgdt.MAGV = gv.MAGV))

select gv.MAGV, gv.HOTEN
from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)
where tgdt.MADT in (
					select dt.MADT
					from DETAI dt join CHUDE cd on (dt.MACD = cd.MACD)
					where cd.TENCD = N'Nghiên cứu phát triển')
group by gv.MAGV, gv.HOTEN
having COUNT(distinct tgdt.MADT) = (
							select COUNT(*)
							from DETAI dt join CHUDE cd on (dt.MACD = cd.MACD)
							where cd.TENCD = N'Nghiên cứu phát triển')


------------------------------------------------------------------------ Q73 -----------------------------------------------------------------------------------------------
select gv2.HOTEN, gv2.NGAYSINH, kh.TENKHOA
from (GIAOVIEN gv2 join BOMON bm on (gv2.MABM = bm.MABM)) join KHOA kh on (kh.MAKHOA = bm.MAKHOA)
where gv2.HOTEN <>  N'Nguyễn Hoài An' and  not exists (
					select distinct tgdt.MADT
					from GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV and gv.HOTEN = N'Nguyễn Hoài An')
					except 
					select distinct tgdt.MADT
					from GIAOVIEN gv1 join THAMGIADT tgdt on (gv1.MAGV = tgdt.MAGV)
					where gv2.MAGV = gv1.MAGV
					)

select gv.HOTEN, gv.NGAYSINH, kh.TENKHOA
from (GIAOVIEN gv join BOMON bm on (gv.MABM = bm.MABM)) join KHOA kh on (kh.MAKHOA = bm.MAKHOA)
where gv.HOTEN <> N'Nguyễn Hoài An' and not exists  (
					select tgdt.MADT
					from GIAOVIEN gv1 join THAMGIADT tgdt on (gv1.MAGV = tgdt.MAGV and gv1.HOTEN = N'Nguyễn Hoài An')
					where not exists (
										select *
										from GIAOVIEN gv2 join THAMGIADT tgdt1 on (gv2.MAGV = tgdt1.MAGV)
										where gv.MAGV= gv2.MAGV and tgdt.MADT = tgdt1.MADT
										))

select gv.MAGV, gv.HOTEN, gv.NGAYSINH, kh.TENKHOA
from ((GIAOVIEN gv join THAMGIADT tgdt on (gv.MAGV = tgdt.MAGV)) join BOMON bm on (gv.MABM = bm.MABM)) join KHOA kh on (kh.MAKHOA = bm.MAKHOA)
where tgdt.MADT in (
						select tgdt1.MADT
						from GIAOVIEN gv1 join THAMGIADT tgdt1 on (gv1.MAGV = tgdt1.MAGV and gv1.HOTEN = N'Nguyễn Hoài An'))
group by gv.MAGV, gv.HOTEN, gv.NGAYSINH, kh.TENKHOA
having COUNT(tgdt.MADT)  = (
								select COUNT(*)
								from GIAOVIEN gv1 join THAMGIADT tgdt1 on (gv1.MAGV = tgdt1.MAGV and gv1.HOTEN = N'Nguyễn Hoài An'))


