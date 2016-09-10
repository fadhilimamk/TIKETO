{ File	 : uload.pas 																		}
{ Editor : Fadhil Imam Kurnia / 16515183													}
{ Versi	 : 3.0 (structirized)																}
{ Tanggal: 20 April 2016																	}
{ Deskrip: File unit untuk aplikasi TIKETO 													}
{ 		   Tubes Daspro 2016 																}

unit uload;
	{unit untuk fitur F1-Load, mengambil data dari file eksternal}
	{$mode objfpc}

interface
	uses utiketo, sysutils;
	
	procedure getFilm(var dataFilm:arrayFilm);
		{ Mendapatkan data Film dari database yang berisi :
		  		Judul | Genre | Rating | Durasi | Sinopsis | HargaWeekdays | HargaWeekend
			Data film tersebut dimasukkan dalam arrayFilm yang berisi film-film.
			IS : variabel dataFilm sembarang
			FS : variabel dataFilm terisi data dari database
				 tiap elemen ke i dari dataFilm berisi Film yang terdiri atas
					- dataFilm[i].Judul		(string)	= judul Film
					- dataFilm[i].Genre 	(string)	= genre Film ex: Drama, Komedi, dsb
					- dataFilm[i].Rating	(string)	= rating penonton yang cocok ex: Remaja, Semua Umur, Dewasa, dsb
					- dataFilm[i].Durasi	(string)	= lama Film dalam menit
					- dataFilm[i].Sinopsis	(string)	= cerita singkat tentang film
					- dataFilm[i].HargaWeekdays	(integer)	= harga tiket Film hari biasa
					- dataFilm[i].HargaWeekend	(integer)	= harga tiket Film harga liburan
		}
	function jumlahFilm():integer;
		{ Mengembalikan banyaknya Film yang terdapat dalam database }


	procedure getTayang(var dataTayang:arrayTayang);
		{ Mendapatkan data Tayang dari database yang berisi :
		 		NamaFilm | JamTayang | TanggalMulaiTayang | BulanMulaiTayang | TahunMulaiTayang | LamaHariTayang 
			IS : variabel dataTayang sembarang
			FS : variabel dataTayang sudah terisi dengan data Tayang (data penayangan film) dari database
				 Data tayang tersebut dimasukkan dalam dataTayang yang berisi variabel-variabel bertipe Tayang
				 dengan rincian pada elemen ke-i sebagai berikut
					- dataTayang[i].NamaFilm 	(string)	= judul Film yang akan tayang
					- dataTayang[i].JamTayang 	(string)	= waktu penayangan Film
					- dataTayang[i].Tanggal 	(integer)	= tanggal penayangan Film
					- dataTayang[i].Bulan 		(integer)	= bulan penayangan Film
					- dataTayang[i].Tahun 		(integer)	= tahun penayangan Film
					- dataTayang[i].Lama 		(integer)	= lama penayangan Film
		}
	function jumlahTayang():integer;
		{ Mengembalikan banyaknya data penayangan Film yang terdapat dalam database }


	procedure getKapasitas(var dataKapasitas:arrayKapasitas);
		{ Mendapatkan data Kapasitas dari database yang berisi :
				NamaFilm | Tanggal | Bulan | Tahun | Jam | SisaKursi 
			IS : variabel dataKapasitas sembarang
			FS : variabel dataKapasitas sudah terisi dengan data Kapasitas untuk menonton Film dari database 
				Data kapasitas tersebut dimasukkan dalam dataKapasitas yang berisi variabel-variabel bertipe Kapasitas.
				Tiap elemen ke-i dalam dataKapasitas berisi
					- dataKapasita s[i].NamaFilm	 (string)	= judulFilm
					- dataKapasitas[i].Tanggal	 (integer)	= tanggal untuk kapasitas
					- dataKapasitas[i].Bulan	 (integer)	= bulan untuk kapasitas
					- dataKapasitas[i].Tahun	 (integer)	= tahun untuk kapasitas
					- dataKapasitas[i].Jam		 (string)	= jam untuk kapasitas ex:"08.00"
					- dataKapasitas[i].SisaKursi (integer)	= sisa kursi yang tersedia pada Film tertentu
		}
	function jumlahKapasitas():integer;
		{ Mengembalikan banyaknya data kapasitas Film yang terdapat dalam database }


	procedure getPemesanan(var dataPemesanan:arrayPemesanan);
		{ Mendapatkan data Pemesanan / transaksi dari database yang berisi : 
				NomorPesanan | NamaFilm | TanggalTayang | BulanTayang | TahunTayang | JamTayang | Total | JenisPembayaran 
			IS : variabel dataPemesanan sembarang
			FS : variabel dataPemesanan terisi data transaksi yang berada dalam file database
				Data transaksi tersebut dimasukkan dalam dataPemesanan yang berisi variabel-variabel bertipe Pemesanan.
				Elemen ke-i dalam dataPemesaanan adalah sebagai berikut
					- dataPemesanan[i].NomorPemesanan 	(integer)	= urutan nomor pemesanan untuk data transaksi
					- dataPemesanan[i].NamaFilm 		(string) 	= judul Film yang dipesan 
					- dataPemesanan[i].Tanggal			(integer) 	= tanggal dilakukan pembelian tiket Film
					- dataPemesanan[i].Bulan			(integer) 	= bulan dilakukan pembelian tiket Film
					- dataPemesanan[i].Tahun			(integer) 	= tahun dilakukan pembelian tiket Film
					- dataPemesanan[i].Jamtayang		(string) 	= jam pemutaran Film yang telah dibeli
					- dataPemesanan[i].JumlahKursi		(integer) 	= jumlah kursi yang dipesan untuk Film tersebut
					- dataPemesanan[i].Total			(integer) 	= total harga tiket untuk transaksi ini
					- dataPemesanan[i].JenisPembayaran	(string) 	= jenis pembayaran pada transaksi tersebut ex: "Bayar","Belum Dibayar"
		}
	function jumlahPemesanan():integer;
		{ Mengembalikan banyaknya data transaksi pembelian tiket Film dari database }

	
	procedure getMember(var dataMember:arrayMember);
		{ Mendapatkan data member aplikasi Tiketo dari database yang berisi : 
				Username | Password | Saldo
		 	IS : variabel dataMember sembarang
		 	FS : variabel dataMember sudah terisi data member-member dari file database 
		 		 Data member tersebut dimasukkan dalam dataMember yang berisi variabel-variabel bertipe Member. 
		 		 Elemen ke-i dalam dataMember berisi data sebagai berikut
		 		 	- dataMember[i].Username 	(string)	= username member
		 		 	- dataMember[i].Password 	(string)	= password member yang telah dihash menggunakan md5
		 		 	- dataMember[i].Saldo 		(integer)	= saldo yang dimiliki oleh member
		}
	function jumlahMember():integer;
		{ Mengembalikan banyaknya data member dari database }	

	function getTanggal():Tanggal;
		{ Fungsi untuk mendapatkan hari ini (dari file database) }
	procedure setTanggalNow();
		{	IS : sembarang
			FS : data tanggal hari ini pada databse terganti sesuai tanggal sistem yang sesungguhnya
		}

	procedure load(var dataFilm:arrayFilm; var dataTayang:arrayTayang;  var dataKapasitas:arrayKapasitas; var dataPemesanan:arrayPemesanan; var neffPemesanan:integer; var dataMember:arrayMember; var neffMember:integer; var today:Tanggal);
		{	IS : sembarang 
			FS : semua data yang diinput dalam variabel ini terisi dengan data dari database,
				 tanggal pada database sesuai dengan tanggal saat prosedur load dipanggil
		}

	procedure exit(var dataFilm:arrayFilm; var dataTayang:arrayTayang; var dataKapasitas:arrayKapasitas; var dataPemesanan:arrayPemesanan; var neffPemesanan:integer; var dataMember:arrayMember; var neffMember:integer);
		{	IS : sembarang 
			FS : semua data yang diinput dalam variabel ini tersimpan ke database,
				 tanggal pada database diubah menjadi tanggal prosedur exit dilakukan
		}

implementation	

	procedure getFilm(var dataFilm:arrayFilm);
		var
			f:text;
			s:ansistring;
			tempf:Film;
			tempd:arrayData;
			i:integer;
		begin
			assign(f, fileFilm);
			reset(f);i:=1;
			while not eof(f) do begin
				readln(f,s);
				if (countChar('|',s)=6) then begin
					tempd:=SplitData(s);
					{mengisi film}
						tempf.Judul:=tempd[1];
						tempf.Genre:=tempd[2];
						tempf.Rating:=tempd[3];
						if ((Copy (tempd[4],(length(tempd[4])-4),length(tempd[4])))<>'menit') then begin
							Writeln ('ERROR: Kesalahan data di "',fileFilm,'" pada baris ke-',i,' kolom ke-4.');
							Writeln ('Data seharusnya berisi waktu dalam menit!')
						end else begin
							Try
								StrToInt(Copy (tempd[4],1,(length(tempd[4])-6)));
								tempf.Durasi:=tempd[4];
							except
						    	On E : EConvertError do begin
						    		Writeln ('ERROR: Kesalahan data di "',fileFilm,'" pada baris ke-',i,' kolom ke-4.');
						    		Writeln ('Data waktu tidak tepat!');
						    	end;
							end; 
						end;
						tempf.Sinopsis:=tempd[5];
						Try
							tempf.HargaWeekdays:=StrToInt(tempd[6]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',fileFilm,'" pada baris ke-',i,' kolom ke-6.');
						    	Writeln ('Data seharusnya berisi angka!');
						    end;
						end;						
						Try
							tempf.HargaWeekend:=StrToInt(tempd[7]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',fileFilm,'" pada baris ke-',i,' kolom ke-7.');
						    	Writeln ('Data seharusnya berisi angka!');
						    end;
						end;
					dataFilm[i]:=tempf;
				end else begin
					writeln('ERROR: Terjadi kesalahan saat mengakses "',fileFilm,'" pada baris ke-',i);
					break;
				end;
				i:=i+1;
			end;
			close(f);
		end;

	function jumlahFilm():integer;
		var
			f:text;
			s:ansistring;
			i:integer;
		begin
			assign(f, fileFilm);
			reset(f);i:=0;
			while not eof(f) do begin
				i:=i+1;
				readln(f,s);
			end;
			jumlahFilm:=i;
			close(f);
		end;
	
	procedure getTayang(var dataTayang:arrayTayang);
		var
			f:text;
			s:ansistring;
			tempt:Tayang;
			tempd:arrayData;
			i:integer;
		begin
			assign(f, fileTayang);
			reset(f);i:=1;
			while not eof(f) do begin
				readln(f,s);
				if (countChar('|',s)=5) then begin
					tempd:=SplitData(s);
					{mengisi tayang}
						tempt.NamaFilm:=tempd[1];
						tempt.JamTayang:=tempd[2];
						Try
							tempt.Tanggal:=StrToInt(tempd[3]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',fileTayang,'" pada baris ke-',i,' kolom ke-3.');
						    	Writeln ('Data tanggal seharusnya berisi angka!');
						    end;
						end;
						Try
							tempt.Bulan:=StrToInt(tempd[4]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',fileTayang,'" pada baris ke-',i,' kolom ke-4.');
						    	Writeln ('Data bulan seharusnya berisi angka!');
						    end;
						end;						
						Try
							tempt.Tahun:=StrToInt(tempd[5]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',fileTayang,'" pada baris ke-',i,' kolom ke-5.');
						    	Writeln ('Data tahun seharusnya berisi angka!');
						    end;
						end;			
						Try
							tempt.Lama:=StrToInt(tempd[6]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',fileTayang,'" pada baris ke-',i,' kolom ke-6.');
						    	Writeln ('Data lama tayang seharusnya berisi angka!');
						    end;
						end;	
					dataTayang[i]:=tempt;
				end else begin
					writeln('ERROR: Terjadi  kesalahan saat mengakses "',fileTayang,'" pada baris ke-',i);
					break;
				end;
				i:=i+1;
			end;
			close(f);
		end;		
	
	function jumlahTayang():integer;
	var
		f:text;
		s:ansistring;
		i:integer;
	begin
		assign(f, fileTayang);
		reset(f);i:=0;
		while not eof(f) do begin
			readln(f,s);
			i:=i+1;
		end;
		close(f);
		jumlahTayang:=i;
	end;

	procedure getKapasitas(var dataKapasitas:arrayKapasitas);
		var
			f:text;
			s:ansistring;
			tempk:Kapasitas;
			tempd:arrayData;
			i:integer;
		begin
			assign(f, fileKapasitas);
			reset(f);i:=1;
			while not eof(f) do begin
				readln(f,s);
				if (countChar('|',s)=5) then begin
					tempd:=SplitData(s);
					{mengisi kapasitas}
						tempk.NamaFilm:=tempd[1];
						Try
							tempk.Tanggal:=StrToInt(tempd[2]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',fileKapasitas,'" pada baris ke-',i,' kolom ke-2.');
						    	Writeln ('Data tanggal seharusnya berisi angka!');
						    end;
						end;
						Try
							tempk.Bulan:=StrToInt(tempd[3]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',fileKapasitas,'" pada baris ke-',i,' kolom ke-3.');
						    	Writeln ('Data bulan seharusnya berisi angka!');
						    end;
						end;						
						Try
							tempk.Tahun:=StrToInt(tempd[4]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',fileKapasitas,'" pada baris ke-',i,' kolom ke-4.');
						    	Writeln ('Data tahun seharusnya berisi angka!');
						    end;
						end;	
						tempk.JamTayang:=tempd[5];
						Try
							tempk.SisaKursi:=StrToInt(tempd[6]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',fileKapasitas,'" pada baris ke-',i,' kolom ke-6.');
						    	Writeln ('Data sisa kursi seharusnya berisi angka!');
						    end;
						end;							
					dataKapasitas[i]:=tempk;
				end else begin
					writeln('ERROR: Terjadi  kesalahan saat mengakses "',fileKapasitas,'" pada baris ke-',i);
					break;					
				end;
				i:=i+1;
			end;
			close(f);
		end;	
	
	function jumlahKapasitas():integer;
		var
			f:text;
			i:integer;
			s:ansistring;
		begin
			assign(f, fileKapasitas);
			reset(f); i:=0;
			while not eof(f) do begin
				readln(f,s);
				i:=i+1;
			end;
			close(f);
			jumlahKapasitas:=i;
		end;
	
	procedure getPemesanan(var dataPemesanan:arrayPemesanan);
		var
			f:text;
			s:ansistring;
			tempp:Pemesanan;
			tempd:arrayData;
			i:integer;
		begin
			assign(f, filePemesanan);
			reset(f);i:=1;
			while not eof(f) do begin
				readln(f,s);
				if (countChar('|',s)=8) then begin
					tempd:=SplitData(s);
					{mengisi pemesanan}
						Try
							tempp.No:=StrToInt(tempd[1]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',filePemesanan,'" pada baris ke-',i,' kolom ke-1.');
						    	Writeln ('Data nomor pemesanan seharusnya berisi angka!');
						    end;
						end;						
						tempp.NamaFilm:=tempd[2];
						Try
							tempp.Tanggal:=StrToInt(tempd[3]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',filePemesanan,'" pada baris ke-',i,' kolom ke-3.');
						    	Writeln ('Data tanggal seharusnya berisi angka!');
						    end;
						end;
						Try
							tempp.Bulan:=StrToInt(tempd[4]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',filePemesanan,'" pada baris ke-',i,' kolom ke-4.');
						    	Writeln ('Data bulan seharusnya berisi angka!');
						    end;
						end;						
						Try
							tempp.Tahun:=StrToInt(tempd[5]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',filePemesanan,'" pada baris ke-',i,' kolom ke-5.');
						    	Writeln ('Data tahun seharusnya berisi angka!');
						    end;
						end;							
						tempp.JamTayang:=tempd[6];
						Try
							tempp.JumlahKursi:=StrToInt(tempd[7]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',filePemesanan,'" pada baris ke-',i,' kolom ke-7.');
						    	Writeln ('Data jumlah kursi seharusnya berisi angka!');
						    end;
						end;	
						Try
							tempp.Total:=StrToInt(tempd[8]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',filePemesanan,'" pada baris ke-',i,' kolom ke-8.');
						    	Writeln ('Data total seharusnya berisi angka!');
						    end;
						end;								
						tempp.JenisPembayaran:=tempd[9];
					dataPemesanan[i]:=tempp;
				end else begin
					writeln('ERROR: Terjadi  kesalahan saat mengakses "',filePemesanan,'" pada baris ke-',i);
					break;							
				end;
				i:=i+1;
			end;
			close(f);
		end;		
	
	function jumlahPemesanan():integer;
		var
			f:text;
			i:integer;
			s:string;
		begin
			assign(f,filePemesanan);
			reset(f);i:=0;
			while not eof(f) do begin
				readln(f,s);
				i:=i+1;			
			end;
			close(f);
			jumlahPemesanan:=i;
		end;
	
	procedure getMember(var dataMember:arrayMember);
		var
			f:text;
			s:ansistring;
			tempm:Member;
			tempd:arrayData;
			i:integer;
		begin
			assign(f, fileMember);
			reset(f);i:=1;
			while not eof(f) do begin
				readln(f,s);
				if (countChar('|',s)=2) then begin
					tempd:=SplitData(s);
						tempm.Username:=tempd[1];
						tempm.Password:=tempd[2];
						Try
							tempm.Saldo:=StrToInt(tempd[3]);
						except
						    On E : EConvertError do begin
						    	Writeln ('ERROR: Kesalahan data di "',fileMember,'" pada baris ke-',i,' kolom ke-3.');
						    	Writeln ('Data saldo member seharusnya berisi angka!');
						    end;
						end;		
					dataMember[i]:=tempm;
				end else begin
					writeln('ERROR: Terjadi  kesalahan saat mengakses "',fileMember,'" pada baris ke-',i);
					break;			
				end;
				i:=i+1;
			end;
			close(f);
		end;
	
	function jumlahMember():integer;
		var
			f:text;
			i:integer;
			s:ansistring;
		begin
			assign(f, fileMember);
			reset(f);i:=0;
			while not eof(f) do begin
				readln(f,s);
				i:=i+1;
			end;
			jumlahMember:=i;
			close(f);
		end;
	

	function getTanggal():Tanggal;
		var
			f:text;
			t:Tanggal;
			s:ansistring;
			tempd:arrayData;
		begin
			assign(f, fileTanggal);
			reset(f);
			readln(f,s);
			if (countChar('|',s)=3) then begin
				tempd:=SplitData(s);
					t.Tanggal:=StrToInt(tempd[1]);
					t.Bulan:=StrToInt(tempd[2]);
					t.Tahun:=StrToInt(tempd[3]);
				getTanggal:=t;
			end else begin
				writeln('ERROR: Terjadi  kesalahan saat mengakses "',fileTanggal,'" pada baris pertama');
			end;
			close(f);
		end;

	procedure setTanggalNow();
		var
			day,data,s:string;
			i:integer;
			f:text;
			NamaHari: array [1..7] of string;
		begin
			assign(f,fileTanggal);
			rewrite(f);
			s:=FormatDateTime('DD MM YYYY',Now);data:='';
			for i:=1 to length(s) do begin
				if (s[i]<>' ') then
					data:=data+s[i]
				else
					data:=data+' | ';
			end;
			NamaHari[1]:='Minggu';
			NamaHari[2]:='Senin';
			NamaHari[3]:='Selasa';
			NamaHari[4]:='Rabu';
			NamaHari[5]:='Kamis';
			NamaHari[6]:='Jumat';
			NamaHari[7]:='Sabtu';
			day:=NamaHari[DayOfWeek(Date)];
			data:=data+' | '+day;
			writeln(f,data);
			close(f);
		end;

	procedure load(var dataFilm:arrayFilm; var dataTayang:arrayTayang;  var dataKapasitas:arrayKapasitas; var dataPemesanan:arrayPemesanan; var neffPemesanan:integer; var dataMember:arrayMember; var neffMember:integer; var today:Tanggal);
		begin
			getFilm(dataFilm);
			getTayang(dataTayang);
			getKapasitas(dataKapasitas);
			getPemesanan(dataPemesanan);
			neffPemesanan := jumlahPemesanan;
			getMember(dataMember);
			neffMember := jumlahMember;
			today:=getTanggal();
			setTanggalNow();
		end;	

	procedure exit(var dataFilm:arrayFilm; var dataTayang:arrayTayang; var dataKapasitas:arrayKapasitas; var dataPemesanan:arrayPemesanan; var neffPemesanan:integer; var dataMember:arrayMember; var neffMember:integer);
		var
			f:text;
			x,i:integer;
		begin
			// menyimpan Film
			x:=jumlahFilm();
			assign(f, fileFilm);
			rewrite(f);
			for i:=1 to x do begin
				writeln(f,(dataFilm[i].Judul+' | '+dataFilm[i].Genre+' | '+dataFilm[i].Rating+' | '+dataFilm[i].Durasi+' | '+dataFilm[i].Sinopsis+' | '+IntToStr(dataFilm[i].HargaWeekdays)+' | '+IntToStr(dataFilm[i].HargaWeekend)));
			end;
			close(f);
			// menyimpan data Tayang
			x:=jumlahTayang();
			assign(f, fileTayang);
			rewrite(f);
			for i:=1 to x do begin
				writeln(f,(dataTayang[i].NamaFilm+' | '+dataTayang[i].Jamtayang+' | '+IntToStr(dataTayang[i].Tanggal)+' | '+IntToStr(dataTayang[i].Bulan)+' | '+IntToStr(dataTayang[i].Tahun)+' | '+IntToStr(dataTayang[i].Lama)));
			end;
			close(f);
			// menyimpan data kapasitas
			x:=jumlahKapasitas();
			assign(f, fileKapasitas);
			rewrite(f);	
			for i:=1 to x do begin
				writeln(f, (dataKapasitas[i].NamaFilm+' | '+IntToStr(dataKapasitas[i].Tanggal)+' | '+IntToStr(dataKapasitas[i].Bulan)+' | '+IntToStr(dataKapasitas[i].Tahun)+' | '+dataKapasitas[i].JamTayang+' | '+IntToStr(dataKapasitas[i].SisaKursi) ) );
			end;
			close(f);	
			// menyimpan data Pemesanan
			assign(f, filePemesanan);
			rewrite(f);	
			for i:=1 to neffPemesanan do begin
				writeln(f,(IntToStr(dataPemesanan[i].No)+' | '+dataPemesanan[i].NamaFilm+' | '+IntToStr(dataPemesanan[i].Tanggal)+' | '+IntToStr(dataPemesanan[i].Bulan)+' | '+IntToStr(dataPemesanan[i].Tahun)+' | '+dataPemesanan[i].JamTayang+' | '+IntToStr(dataPemesanan[i].JumlahKursi)+' | '+IntToStr(dataPemesanan[i].Total)+' | '+dataPemesanan[i].JenisPembayaran));
			end;
			close(f);	
			// menyimpan data Member
			assign(f, fileMember);
			rewrite(f);	
			for i:=1 to neffMember do begin
				writeln(f,(dataMember[i].Username+' | '+dataMember[i].Password+' | '+IntToStr(dataMember[i].Saldo)));
			end;
			close(f);				
		end;


end.
