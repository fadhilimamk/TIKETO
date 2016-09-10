{ File	 : usnack.pas 																		}
{ Editor : Fadhil Imam Kurnia / 16515183													}
{ Versi	 : 1.0 																				}
{ Tanggal: 24 April 2016																	}
{ Deskrip: File unit untuk aplikasi TIKETO 													}
{ 		   Tubes Daspro 2016 																}


unit usnack;
	{ Unit bagian dari program tiketo yang berisi fungsi dan prosedur yang
	  berkaitan dengan snack
	  - buySnack
	  - jumlahSnack
	  - getDataSnack
	  - simpanDataSnack
	}

	
interface
	uses utiketo, sysutils, umember;
	function jumlahSnack():longint;
		{fungsi untuk mendapatkan jumlah macam snack yang ada di database}
	procedure getDataSnack(var dataSnack:arraySnack; var neffSnack:longint; var dataPemesananSnack:arrayPemesananSnack; var neffPemesananSnack:longint);
		{getDataSnack merupakan prosedur untuk mengambil data Snack dan data Pemesanan Snack ke dalam variabel
			IS : dataSnack, neffSnack, dataPemesananSnack, neffPemesananSnack sembarang
			FS : dataSnack, neffSnack, dataPemesananSnack, neffPemesananSnack terisi data dari database
		}
	procedure buySnack(var dataSnack:arraySnack;neffSnack:longint; var dataPemesananSnack:arrayPemesananSnack;var neffPemesananSnack:longint; dataMember: arrayMember; neffMember: longint);
		{prosedur buySnack untuk menu buySnack dalam aplikasi TIKETO, untuk membeli snack yang tersedia
			IS : dataSnack, neffSnack, dataPemesananSnack, neffPemesananSnack, dataMember, neffMember sudah terisi data dari database
			FS : proses pembelian snack sudah berlangsung. variabel ataSnack, neffSnack, dataPemesananSnack, neffPemesananSnack, dataMember, neffMember terganti
				 dengan data pembelian baru
		}	
	procedure simpanDataSnack(dataSnack: arraySnack; neffSnack: longint; dataPemesananSnack: arrayPemesananSnack; neffPemesananSnack: longint);
	{ prosedur simpanDataSnack digunakan untuk menyimpan data dalam variabel ataSnack, neffSnack, dataPemesananSnack, neffPemesananSnack ke dalam
	  file eksternal
	  		IS : variabel ataSnack, neffSnack, dataPemesananSnack, neffPemesananSnack, dataMember, neffMember terisi data
	  		FS : variabel ataSnack, neffSnack, dataPemesananSnack, neffPemesananSnack, dataMember, neffMember sudah terisi ke dalam database
		
	}

implementation

	function jumlahSnack():longint;
		var
			f:text;
			s:string;
		begin
			assign(f,fileSnack);
			reset(f);jumlahSnack:=0;
			while not (eof(f)) do begin
				readln(f,s);
				jumlahSnack:=jumlahSnack+1;
			end;
			close(f);
		end;
	
	procedure getDataSnack(var dataSnack:arraySnack; var neffSnack:longint; var dataPemesananSnack:arrayPemesananSnack; var neffPemesananSnack:longint);
		var
			f:text;
			s:ansistring;
			temps:arrayData;
			i:longint;
		begin
			// mendapatkan data snack
			assign(f,fileSnack);
			reset(f);i:=0;neffSnack:=0;
			while not (eof(f)) do begin
				readln(f,s);i:=i+1;
				temps:=SplitData(s);
				dataSnack[i].Nama := temps[1];
				dataSnack[i].Harga:= StrToInt(temps[2]);
				dataSnack[i].Stok := StrToInt(temps[3]);
				neffSnack:=neffSnack+1;
			end;			
			close(f);
			// mendapatkan data pemesanansnack
			assign(f,filePemesananSnack);
			reset(f);i:=0;neffPemesananSnack:=0;
			while not (eof(f)) do begin
				readln(f,s);i:=i+1;
				temps:=SplitData(s);
				dataPemesananSnack[i].Id := StrToInt(temps[1]);
				dataPemesananSnack[i].Nama:= temps[2];
				dataPemesananSnack[i].Jumlah := StrToInt(temps[3]);
				dataPemesananSnack[i].Total := StrToInt(temps[4]);
				dataPemesananSnack[i].Jenis := temps[5];
				neffPemesananSnack:=neffPemesananSnack+1;
			end;			
			close(f);		
		end;

	procedure buySnack(var dataSnack:arraySnack;neffSnack:longint; var dataPemesananSnack:arrayPemesananSnack;var neffPemesananSnack:longint; dataMember: arrayMember; neffMember: longint);
		var
			kode,jumlah,i,x:longint;
			metode:char;
			usr,pass:string;
		begin
			//inisialisasi
			writeln('>  Menu snack yang tersedia :');
			if (neffSnack>0) then begin
				for i:=1 to neffSnack do
					writeln('>   [',i,']',dataSnack[i].Nama,' - Rp ',dataSnack[i].Harga,' tersedia ',dataSnack[i].Stok,' buah');
				write('>  Masukan kode snack: ');readln(kode);
				while (kode > neffSnack)or(kode<1) do begin
					writeln('>  Kode snack yang diinput salah. Masukkan kembali kode snack!');
					write('>  Masukan kode snack: ');readln(kode);
				end;			
				write('>  Masukan jumlah: ');readln(jumlah);
				while (jumlah > (dataSnack[kode].Stok))or(jumlah<1) do begin
					writeln('>  Jumlah harus kurang dari stok!, minimal pembelian adalah 1 item.');
					writeln('>  Masukkan kembali jumlah!');
					write('>  Masukan jumlah: ');readln(jumlah);
				end;
				write('>  Harga yang harus dibayar : ');uang(jumlah*dataSnack[kode].Harga);writeln;
				writeln('>  Metode pembayaran :');
				writeln('>     [1] Bayar di kasir');
				writeln('>     [2] Bayar dengan kartu kredit');
				writeln('>     [3] Bayar dengan kartu member');
				write('>  Masukan pilihan cara pembayaran : ');readln(metode);
				while (metode<>'1')and(metode<>'2')and(metode<>'3') do begin
					writeln(metode);
					writeln('>  pilihan cara pembayaran salah. Masukkan kembali pilihan cara pembayaran!');
					write('>  Masukan pilihan cara pembayaran : ');readln(metode);
				end;
				writeln('>  -- Kode pemesanan snack anda adalah ', (neffPemesananSnack+1),' --');
				neffPemesananSnack:=neffPemesananSnack+1;
				case metode of
					'1': begin
							writeln('>  Silahkan tunjukan nomor pemesanan snack anda ke kasir');
							dataPemesananSnack[neffPemesananSnack].Id := neffPemesananSnack;
							dataPemesananSnack[neffPemesananSnack].Nama := dataSnack[kode].Nama;
							dataPemesananSnack[neffPemesananSnack].Jumlah := jumlah;
							dataPemesananSnack[neffPemesananSnack].Total := jumlah*dataSnack[kode].Harga;
							dataPemesananSnack[neffPemesananSnack].Jenis := 'Kasir';
							dataSnack[kode].Stok:=dataSnack[kode].Stok-jumlah;
						 end;
					'2': begin
							write('>  Nomor kartu kredit : ');readln(x);
							writeln('>  Pembayaran Sukses !');
							dataPemesananSnack[neffPemesananSnack].Id := neffPemesananSnack;
							dataPemesananSnack[neffPemesananSnack].Nama := dataSnack[kode].Nama;
							dataPemesananSnack[neffPemesananSnack].Jumlah := jumlah;
							dataPemesananSnack[neffPemesananSnack].Total := jumlah*dataSnack[kode].Harga;
							dataPemesananSnack[neffPemesananSnack].Jenis := 'CreditCard';		
							dataSnack[kode].Stok:=dataSnack[kode].Stok-jumlah;				
						 end;
					'3': begin
							showLogin;
							doLogin(usr,pass);
							x := authLogin(usr,pass,dataMember,neffMember);
							if (authLogin(usr,pass,dataMember,neffMember)<>0) then begin		{berhasil login}
								dataSnack[kode].Stok:=dataSnack[kode].Stok-jumlah;
								dataPemesananSnack[neffPemesananSnack].Id := neffPemesananSnack;
								dataPemesananSnack[neffPemesananSnack].Nama := dataSnack[kode].Nama;
								dataPemesananSnack[neffPemesananSnack].Jumlah := jumlah;
								dataPemesananSnack[neffPemesananSnack].Total := jumlah*dataSnack[kode].Harga;
								if (dataMember[x].Saldo < (jumlah*dataSnack[kode].Harga)) then begin
									writeln('Saldo tidak mencukupi untuk melakukan pembelian. Silakan menggunakan cara pembayaran lainnya');
									dataPemesananSnack[neffPemesananSnack].Jenis := 'Belum dibayar';
								end else begin
									writeln('> Pembayaran Sukses!');
									dataMember[x].Saldo := dataMember[x].Saldo - (jumlah*dataSnack[kode].Harga);
									write('> Sisa saldo anda (',dataMember[x].Username,') :');uang(dataMember[x].Saldo);writeln;
									dataPemesananSnack[neffPemesananSnack].Jenis := 'Member';
								end;
							end else begin
								showHeader;
								writeln('>  Gagal Login');
							end;				
						 end;
				end;
			end else
				writeln('>  Tidak ada snack yang tersedia');
		end;

	procedure simpanDataSnack(dataSnack: arraySnack; neffSnack: longint; dataPemesananSnack: arrayPemesananSnack; neffPemesananSnack: longint);
		var
			i:longint;
			f:text;
		begin
			//simpan data snack
			assign(f, fileSnack);
			rewrite(f);
			for i:=1 to neffSnack do begin
				writeln(f, (dataSnack[i].Nama+' | '+IntToStr(dataSnack[i].Harga)+' | '+IntToStr(dataSnack[i].Stok)));
			end;
			close(f);
			//simpan data pemesanan snack
			assign(f, filePemesananSnack);
			rewrite(f);
			for i:=1 to neffPemesananSnack do begin
				writeln(f, (IntToStr(dataPemesananSnack[i].Id)+' | '+dataPemesananSnack[i].Nama+' | '+IntToStr(dataPemesananSnack[i].Jumlah)+' | '+IntToStr(dataPemesananSnack[i].Total)+' | '+dataPemesananSnack[i].Jenis));
			end;
			close(f);
		end;
end.