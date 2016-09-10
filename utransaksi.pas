{ File	 : utransaksi.pas 																		}
{ Editor : Robby / 16515400													}
{ Versi	 : 1.0 																				}
{ Tanggal: 24 April 2016																	}
{ Deskrip: File unit untuk aplikasi TIKETO 													}
{ 		   Tubes Daspro 2016 																}


unit utransaksi;
	{ Unit bagian dari program tiketo yang berisi fungsi dan prosedur yang
	  berkaitan dengan transaksi
	  - payCreditCard
	  - payMember
	}

interface
	uses utiketo, uload, umember,crt;
	procedure payMember(var dataMember:arrayMember;neffMember:integer;var dataPemesanan:arrayPemesanan; neffPemesanan:integer);
		{IS:menerima data berupa dataMember, neffMember, dataPemesanan, dan neffPemesanan}
		{FS:Akan dituliskan pada data pemesanan dibayarkan dengan member apabila memenuhi syarat tertentu. Syarat tersebut yaitu harus login terlebih dahulu, kemudian saldo harus mencukupi. Jika berhasil maka saldo akan dikurangi sesuai total}

	procedure paycreditcard(var dataPemesanan:arrayPemesanan;neffPemesanan:integer);
		{procedure patcreditcard akan menuliskan pada datatayang sesuai nomor pemesanan}

implementation

	procedure payMember(var dataMember:arrayMember;neffMember:integer;var dataPemesanan:arrayPemesanan; neffPemesanan:integer);
		var
			RequestNamaMember,pass:string;
			NomorPemesanan:integer;
			i,j:integer;
			found:boolean;

		begin
			i:=1;
			found:= false;
			write('> Nomor Pemesanan : '); readln(NomorPemesanan);
			while ( i <=  neffPemesanan ) and ( not found )do begin
				if(NomorPemesanan = dataPemesanan[i].no) and(dataPemesanan[i].JenisPembayaran <> 'Belum dibayar') then begin
					found:=true;
					writeln('> Pemesanan sudah dibayar');
				end else if (NomorPemesanan = dataPemesanan[i].no) and (dataPemesanan[i].JenisPembayaran = 'Belum dibayar') then begin
					found:=true;{Nomor pemesanan ditemukan dalam dataPemesanan}
					write('> Harga yang harus dibayar : ');uang(dataPemesanan[i].Total);
					readln;
					showLogin;
					doLogin(RequestNamaMember,pass);
					clrscr;
					showHeader;
					writeln('menu > payMember');
					writeln('> Nomor Pemesanan : ',NomorPemesanan);
					write('> Harga yang harus dibayar : ');uang(dataPemesanan[i].Total);writeln;
					if (authLogin(RequestNamaMember,pass,dataMember,neffMember)<>0) then begin
						j:=authLogin(RequestNamaMember,pass,dataMember,neffMember);
						if (dataMember[j].Saldo<dataPemesanan[i].Total) then begin
								write('> Saldo anda (',dataMember[j].Username,') tersisa ');uang(dataMember[j].Saldo);writeln;
								writeln('> Saldo tidak mencukupi untuk melakukan pembelian.');
								writeln('> Silakan menggunakan cara pembayaran lainnya');
						end else begin
								writeln('> Pembayaran Sukses!');
								dataPemesanan[i].JenisPembayaran:='Member';
								dataMember[j].Saldo:=dataMember[j].Saldo - round(dataPemesanan[i].Total*0.9);
								write('> Saldo anda (',dataMember[j].Username,') tersisa ');uang(dataMember[j].Saldo);writeln;
						end;
					end else 
						writeln('> Gagal Login');
				end;
				i:=i+1;
			end;
			if not found then
				writeln('> Nomor pemesanan salah');
		end;



	procedure paycreditcard(var dataPemesanan:arrayPemesanan;neffPemesanan:integer);
		var

			NomorPemesanan:integer;
			found:boolean;
			i:integer;
			hariKe:longint;
		begin
			i:= 1;
			found:= false;
			write('> Nomor Pemesanan : '); readln(NomorPemesanan);
			while ( i <=  neffPemesanan ) and ( not found )do begin
				if(NomorPemesanan = dataPemesanan[i].no) and(dataPemesanan[i].JenisPembayaran <> 'Belum dibayar') then begin
					found:=true;
					writeln('> Pemesanan sudah dibayar');
				end else if (NomorPemesanan = dataPemesanan[i].no) and (dataPemesanan[i].JenisPembayaran='Belum dibayar')then begin
					found:=true; {nomor pemesanan ditemuan}
					hariKe:= JumlahHari(dataPemesanan[i].Tahun,dataPemesanan[i].Bulan,dataPemesanan[i].Tanggal); {hari keberapakah tanggal tersebut dalam kalender masehi}
					if ( hariKe mod 7 = 1) or ( hariKe mod 7 = 2) then begin
						if (dataPemesanan[i].JumlahKursi>1) then begin
							writeln('> Selamat! Anda mendapatkan bonus discount 1 kursi!');
							write('> Harga yang harus dibayar : ');uang( round( (dataPemesanan[i].Total*(dataPemesanan[i].JumlahKursi-1))/dataPemesanan[i].JumlahKursi) );writeln;
						end else begin
							write('> Harga yang harus dibayar : '); uang(dataPemesanan[i].Total);writeln;
						end;
					end else begin
						write('> Harga yang harus dibayar : '); uang(dataPemesanan[i].Total);writeln;
					end;
					write('> Nomor kartu kredit : ');readln;
					writeln('> Pembayaran Sukses!');
					dataPemesanan[i].JenisPembayaran:='CreditCard';
				end;
				i:=i+1;
			end;
			if not found then
				writeln('> Nomor pemesanan yang Anda masukkan salah');
		end;	

end.
