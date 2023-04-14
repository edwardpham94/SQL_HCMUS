use QUANLYDETAI01

-- Câu a
create procedure HelloWorld
as
	print 'Hello World!!!'
exec HelloWorld

-- Câu b
create procedure Tong_2_print @So1 int, @So2 int
as
begin
	declare @Tong int
	set @Tong = @So1 + @So2
	print @Tong
end

exec Tong_2_print 8, 7

-- Câu c
create procedure Tong_2 @So1 int, @So2 int, @Tong int out
as
begin
	set @Tong = @So1 + @So2
end

declare @Sum int
exec Tong_2 1, -2, @Sum out
print @Sum

-- Câu d
create procedure Tong_3_int @So1 int, @So2 int,@So3 int
as
begin
	declare @Tong int
	exec Tong_2 @So1, @So2, @Tong out
	set @Tong = @Tong + @So3
	print @Tong
end
exec Tong_3_int 1, -2, 4

-- Câu e
create procedure Tong_MN @m int, @n int
as
	declare @Tong int
	declare @i int
	set @Tong = 0
	set @i = @m
	
	while (@i < @n)
	begin
		set @Tong = @Tong + @i
		set @i = @i + 1
	end
	print @Tong

exec Tong_MN 1,6

-- Câu f
create procedure check_NgTo @num int, @check bit out
as
	declare @bound float
	declare @i int
	set @check = 1
	set @i = 2
	set @bound = SQRT(@num)
	
	while (@i <= @bound)
	begin
		if (@num % @i = 0)
			begin
				set @check = 0
				break
			end
		set @i = @i + 1		
	end

declare @check bit
exec check_NgTo 18, @check out
if (@check = 1)
	begin
		print N'Là số nguyên tố'
	end
else
	begin
		print N'Không là số nguyên tố'
	end
	
-- Câu g		
create procedure tong_NgTo_MN @m int, @n int
as
	declare @Tong int
	declare @i int
	declare @check bit
	set @Tong = 0
	set @i = @m
	
	while (@i <= @n)
	begin
		exec check_NgTo @i, @check out
		if (@check = 1)
			begin
				set @Tong = @Tong + @i
			end
			
		set @i = @i + 1
	end
	
	print N'Tổng các số nguyên tố trong [' + cast(@m as varchar(10)) + N', ' + cast(@n as varchar(10)) + '] = ' + cast(@Tong as varchar(10))

exec tong_NgTo_MN 4, 25

-- Câu h
create procedure fUCLN @a int, @b int, @ret int out
as
begin
	set @a = ABS(@a)
	set @b = ABS(@b)
	
	if (@a = 0 OR @b = 0)  set @ret = @a + @b 
	else
		begin
			while (@a <> @b)
			begin
				if (@a > @b) set @a = @a - @b
				else set @b = @b - @a
			end
		end
	
	set @ret = @a
end

declare @UCLN int
exec fUCLN 10, 15, @UCLN out
print @UCLN

-- Câu i
create procedure fBCNN @a int, @b int, @ret int out
as
begin
	declare @temp int 
	exec fUCLN @a, @b, @temp out
	set @ret = ABS(@a * @b) / @temp
end
declare @BCNN int
exec fBCNN 4, 14, @BCNN out
print @BCNN

-- Câu j
create procedure DSGV
as
begin
	select * 
	from GIAOVIEN
end
exec DSGV

-- Câu k
create procedure SLDT @MaGV varchar(9)
as
begin
	declare @ret int
	set @ret = (select COUNT(distinct MADT) from THAMGIADT where MAGV = @MaGV group by MAGV)
	print N'Số lượng đề tài là  : ' + CasT(@ret as varchar(12))
end
exec SLDT '001'

-- Câu l
create procedure TTGV @MaGV varchar(9)
as
begin
	declare @name nvarchar(30)
	set @name = (select HOTEN from GIAOVIEN where MAGV = @MaGV)
	print N'Họ tên: ' + @name
	
	declare @salary decimal(18,1)
	set @salary = (
					select LUONG 
					from GIAOVIEN
					where MAGV = @MaGV)
	print N'Lương: ' + CasT(@salary as varchar(12))
	
	declare @birthday date
	set @birthday = (
					select NGAYSINH 
					from GIAOVIEN 
					where MAGV = @MaGV)
	print N'Ngày sinh: ' + CasT(@birthday as varchar(12))
	
	declare @address nvarchar(50)
	set @address = (
					select DIACHI
					from GIAOVIEN 
					where MAGV = @MaGV)
	print N'Địa chỉ: ' + @address
	
	declare @SLDT int
	set @SLDT = (
					select COUNT(distinct MADT) 
					from THAMGIADT 
					where MAGV = @MaGV 
					group by MAGV)
	print N'SLDT: ' + CasT(@SLDT as varchar(12))
	
	declare @SLNT int
	set @SLNT = (
					select COUNT(*) 
					from NGUOI_THAN 
					where MAGV = @MaGV 
					group by MAGV)
	print N'SLNT: ' + CasT(@SLNT as varchar(12))
end
exec TTGV '004'

-- Câu m
create procedure CheckGVExist @MaGV varchar(9), @check bit out
as
	if (exists(select * from GIAOVIEN where MAGV = @MaGV))
		begin
			print N'MAGV = ' + @MaGV + N' -> tồn tại giáo viên.'
			set @check = 1
		end
	else
		begin
			print N'MAGV = ' + @MaGV + N' -> không tồn tại giáo viên!'
			set @check = 0
		end
		
declare @check bit
exec CheckGVExist '001', @check out

-- Câu n
create procedure checkRuleDT @MaGV varchar(9), @MaDT varchar(3), @check bit out
as
	declare @GVCNDT varchar(3)
	set @GVCNDT = (select GVCNDT from DETAI where MADT = @MaDT)
	
	if ((select MABM from GIAOVIEN where MAGV = @MaGV) = (select MABM from GIAOVIEN where MAGV = @GVCNDT))
		begin
			print 'True'
			set @check = 1
		end
	else
		begin
			print 'False'
			set @check = 0
		end

declare @flag bit
exec checkRuleDT '007', '003', @flag out

-- Câu o
create procedure PhanCongCV @MaGV varchar(3), @MaDT varchar(3), @Stt int, @PhuCap int, @Ketqua nvarchar(3)
as
	declare @check bit
	set @check = 1
	if (NOT exists(select * from GIAOVIEN where MAGV = @MaGV))
		begin
			print N'Lỗi! Mã GV không tồn tại!'
			set @check = 0
		end
	if (NOT exists(select * from CONGVIEC where MADT = @MaDT AND STT = @Stt))
		begin
			print N'Lỗi! Công việc không tồn tại!'
			set @check = 0
		end
exec PhanCongCV '001', '002', 3, 0, NULL

	
-- Câu n
	declare @GVCNDT varchar(3)
	set @GVCNDT = (select GVCNDT from DETAI where MADT = @MaDT)
	
	if (@check = 1 AND (select MABM from GIAOVIEN where MAGV = @MaGV) <> (select MABM from GIAOVIEN where MAGV = @GVCNDT))
		begin
			print N'Lỗi! Đề tài không do bộ môn của GV làm chủ nhiệm!'
			set @check = 0
		end
	
	-- Thêm phân công
	if (@check = 1)
		begin
			INSERT INTO THAMGIADT(MAGV, MADT, STT, PHUCAP, KETQUA)
			VALUES (@MaGV, @MaDT, @Stt, @PhuCap, @Ketqua)
			print N'Phân công thành công.'
		end

-- Câu p
create procedure deleteGiaoVien @MaGV varchar(9)
as
	declare @check bit
	set @check = 1
	if (exists(select * from GIAOVIEN where MAGV = @MaGV))
		begin
			if (exists(select * from NGUOI_THAN where MAGV = @MaGV))
				begin
					print N'Giáo viên tồn tại người thân! Lỗi!'
					set @check = 0
				end
				
			if (exists(select * from THAMGIADT where MAGV = @MaGV))
				begin
					print N'Giáo viên có tham gia đề tại! Lỗi!'
					set @check = 0
				end
				
			if (exists(select * from BOMON where TRUONGBM = @MaGV))
				begin
					print N'Giáo viên đang là trưởng bộ môn! Lỗi!'
					set @check = 0
				end
				
			if (exists(select * from KHOA where TRUONGKHOA = @MaGV))
				begin
					print N'Giáo viên đang là trưởng khoa! Lỗi!'
					set @check = 0
				end
				
			if (exists(select * from DETAI where GVCNDT = @MaGV))
				begin
					print N'Giáo viên đang chủ nhiệm đề tài! Lỗi!'
					set @check = 0
				end
				
			if (exists(select * from GV_DT where MAGV = @MaGV))
				begin
					print N'Giáo viên có tồn tại số điện thoại! Lỗi!'
					set @check = 0
				end
				
			if (@check = 1)
				begin
					DELETE from GIAOVIEN where MAGV = @MaGV
					print N'Xóa thành công.'
				end
		end
	else
		print N'Không tồn tại giáo viên có MAGV = ' + @MaGV
exec deleteGiaoVien '007'

-- Câu r
create procedure CheckRuleGV1 @MaGVA varchar(9), @MaGVB varchar(9)
as
	if ((select MABM from GIAOVIEN where MAGV = @MaGVA) = (select MABM from GIAOVIEN where MAGV = @MaGVB))
		if (exists(select * from BOMON where TRUONGBM = @MaGVA))
			if ((select LUONG from GIAOVIEN where MAGV = @MaGVA) < (select LUONG from GIAOVIEN where MAGV = @MaGVB))
				begin
					print 'FALSE'
				end
			else
				begin
					print 'TRUE'
				end
		else 
			if (exists(select * from BOMON where TRUONGBM = @MaGVB))
				if ((select LUONG from GIAOVIEN where MAGV = @MaGVA) > (select LUONG from GIAOVIEN where MAGV = @MaGVB))
					print 'FALSE'
				else
					print 'TRUE'
			else
				print 'TRUE'
	else
		print 'TRUE'

exec CheckRuleGV1 '003', '002'

-- Câu s
create procedure addGiaoVien @MaGV varchar(9), @HoTen nvarchar(30), @Luong int, @Phai nchar(3), @NgaySinh date, @DiaChi nvarchar(50), @GVQLCM varchar(3), @MaBM  nchar(4)
as
begin
	declare @check bit
	set @check = 1	if (exists(select * from GIAOVIEN where HOTEN = @HoTen))
		begin
			print N'Lỗi! Trùng họ tên GV khác'
			set @check = 0
		end
	if (YEAR(GetDate()) - YEAR(@NgaySinh) < 18)
		begin
			print N'Lỗi! Tuổi < 18'
			set @check = 0
		end
	if (@Luong <= 0)
		begin
			print N'Lỗi! Lương < 0'
			set @check = 0
		end
	if (@check = 1)
		begin
			insert into GIAOVIEN(MAGV, HOTEN, LUONG, PHAI, NGAYSINH, DIACHI, GVQLCM, MABM) values (@MaGV, @HoTen, @Luong, @Phai, @NgaySinh, @DiaChi, @GVQLCM, @MaBM)
			print N'Thêm thành công!'
		end
end
exec addGiaoVien '017', N'Phạm Bảo', 1000, N'Nam', '09/04/2003', N'Quảng Ngãi', '005', null

-- Câu t
create procedure checkMaGV @MaGV varchar(3) out
as
	declare @num int
	declare @temp varchar(3)
	set @num = 1
	
	WHILE (1=1)
	begin
		if (@num < 10) set @temp = '00' + CasT(@num as varchar(1)) 
		else if (@num < 100) set @temp = '0' + CasT(@num as varchar(2))
		else set @temp = CasT(@num as varchar(3))
		if (not exists(select * from GIAOVIEN where MAGV = @temp))
			begin
				set @MaGV = @temp
				break
			end
		set @num = @num + 1
	end

declare @MaGV varchar(3)
exec checkMaGV @MaGV out
print @MaGV
