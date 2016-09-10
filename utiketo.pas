{ File	 : utiketo.pas 																		}
{ Editor : Fadhil Imam Kurnia / 16515183													}
{ Versi	 : 3.0 		(sudah gabungan)														}
{ Tanggal: 20 April 2016																	}
{ Deskrip: File unit untuk aplikasi TIKETO 													}
{ 		   Tubes Daspro 2016 																}


unit utiketo;
	{ Unit bagian dari program tiketo yang berisi 
		- deklarasi tipe tipe bentukan
		- konstanta letak database
		- fungsi dasar untuk mengolah data SplitData()
	}

interface
	uses crt, sysutils;
	{Konstanta letak database dan menu pada tiketo}
	const
		fileFilm		= 'data/data_film.txt';
		fileTanggal		= 'data/data_hari_ini.txt';
		fileKapasitas 	= 'data/data_kapasitas.txt';
		fileMember		= 'data/data_member.txt';
		filePemesanan	= 'data/data_transaksi.txt';
		fileTayang		= 'data/data_tayang.txt';
		fileSnack		= 'data/data_snack.txt';
		filePemesananSnack = 'data/data_transaksi_snack.txt';
		Menu			:  array [1..15] of string = (
							'nowplaying',
							'upcoming',
							'schedule',
							'genrefilter',
							'ratingfilter',
							'searchmovie',
							'showmovie',
							'shownextday',
							'selectmovie',
							'help',
							'buysnack',
							'paymember',
							'registermember',
							'paycreditcard',
							'about');
		jumlahMenu		= 15;

	{Tipe tipe yang digunakan dalam tiketo}
	type
		Film 	= record
					Judul:string;
					Genre:string;
					Rating:string;
					Durasi:string;
					Sinopsis:ansistring;
					HargaWeekdays:longint;
					HargaWeekend:longint;
				  end;
		Tayang	= record
					NamaFilm:string;
					JamTayang:string;
					Tanggal:integer;
					Bulan:integer;
					Tahun:integer;
					Lama:integer;
				  end;
		Kapasitas=record				  
					NamaFilm:string;
					Tanggal:integer;
					Bulan:integer;
					Tahun:integer;
					JamTayang:string;
					SisaKursi:integer;
				  end;
		Pemesanan=record
					No:integer;
					NamaFilm:string;
					Tanggal:integer;
					Bulan:integer;
					Tahun:integer;
					JamTayang:string;
					JumlahKursi:integer;
					Total:longint;
					JenisPembayaran:string;
				  end;
		Member	= record
					Username:string;
					Password:string;
					Saldo:longint;
				  end;
		Tanggal	= record
					Tanggal:integer;
					Bulan:integer;
					Tahun:integer;
				  end;
		Snack 	= record
					Nama:string;
					Harga:longint;
					Stok:longint;
				  end;
		PemesananSnack = record
							Id:integer;
							Nama:string;
							Jumlah:integer;
							Total:longint;
							Jenis:string;
						 end;
		Jam 	= record
					Hour:integer;	
					Minute:integer;
				  end;

		arrayFilm =array [1..1000] of Film;			// dataFilm berisi data film-film di bioskop
		arrayMember = array [1..1000] of Member;	// dataMember berisi data member-member hingga maksimal 1.000.000 orang member
		arrayTayang = array [1..1000] of Tayang;
		arrayKapasitas = array [1..1000] of Kapasitas;
		arrayPemesanan = array [1..1000] of Pemesanan;
		arrayData = array [1..20] of AnsiString;
		arraySnack = array [1..1000] of Snack;
		arrayPemesananSnack = array [1..1000] of PemesananSnack;

		tabSnack = record
					Data:arraySnack;
					Neff:longint;
				   end;

	function SplitData(s:ansistring):arrayData;
		{fungsi untuk memecah data teks yang ke dalam array, teks dipecah berdasar letak karakter ' | ' }
	function isMenu(s:string):Boolean;
		{isMenu menghasilkan true jika s adalah menu dalam tiketo, menghasilkan false jika s bukan
		 menu dalam tiketo}
	procedure showHeader();
		{ IS: sembarang
		  FS: tampil header aplikasi tiketo}
	procedure help();
		{ IS: sembarang
		  FS: tampil penjelasan menu pada tiketo}
	procedure about();
		{ IS: sembarang
		  FS: tampil penjelasan Aplikasi TIKETO}

	function countChar(c:char;s:ansistring):longint;
		{fungsi countChar(c,s) akan mengembalikan jumlah karakter c dalam string s}
	function IsKabisat(y:integer):boolean;
		{fungsi untuk mengecek apakah y merupakan tahun kabisat}
	function JumlahHari(yy:integer;mm:integer;dd:integer):LongInt;
		{fungsi untuk menghitung jumlah hari dari awal tahun masehi}
	procedure uang(nominal: longint);
		{Prosedur untuk mencetak nominal dengan format uang}
	function jumlahDigit(angka:longint):integer;		
		{fungsi untuk menghitung banyaknya digit dalam suatu angka}
	function JumlahJam(inputWaktu:Jam):integer;
		{fungsi untuk menjumlahkan jam dan menit ke dalam satuan menit}
	function konversiTanggal(s:string):Tanggal;
		{ IS: string sembarang dan diasumsikan valid
		  FS: input string diubah ke type bentukan tanggal}
	function konversiJam(s:string):Jam;
		{ IS: string sembarang dan diasumsikan valid
		  FS: input string diubah ke type bentukan Jam}
	function konversiDurasi(s:string):Jam;
		{ IS: string sembarang dan diasumsikan valid
		  FS: input string diubah ke type bentukan Jam}
	function SplitTanggal(s:ansistring):arrayData;
		{ IS: string sembarang dan diasumsikan valid
		  FS: input string dipecah setiap ditemukan character "-"}
	function SplitJam(s:ansistring):arrayData;
		{ IS: string sembarang dan diasumsikan valid
		  FS: input string dipecah setiap ditemukan character "."}
	function SplitDurasi(s:ansistring):arrayData;
		{ IS: string sembarang dan diasumsikan valid
		  FS: input string dipecah setiap ditemukan character " "}
	function IsJamValid(inputWaktu:Jam):boolean;
		{ IS: waktu input diasumsikan valid
		  FS: mencek apakah waktu tersebut rasional}
	function isDateValid (dd : integer; mm : integer; yy : integer):Boolean;
		{I.S : type input sudah sesuai
		 F.S : dihasilkan boolean hasil pengecekan}

implementation
	function SplitData(s:ansistring):arrayData;
		var
			i,j:integer;
			temp:ansistring;
		begin
			i:=1;j:=1;temp:='';
			while (i<=length(s)) do begin
				if (s[i]+s[i+1]+s[i+2]<>' | ') then begin
					temp:=temp+s[i];
				end else begin
					SplitData[j]:=temp;
					temp:='';
					j:=j+1;
					i:=i+2;
				end;
				if (i=length(s)) then SplitData[j]:=temp; // menambag data terakhir
				i:=i+1;
			end;
		end;


	procedure showHeader();
	var
		marginL:integer;
	begin
		clrscr;
		marginL:=1;
		TextBackground(Red);
	    gotoxy(marginL,1);write('                                                                                ');
	    gotoxy(marginL,2);write('          .::.     -:-   `::-                    `::-                           ');
	    gotoxy(marginL,3);write('          .hh+     yhy   .hhy    ```     ````    -hhy         `````             ');
	    gotoxy(marginL,4);write('          .hhyso   sys   .hhh `/sy+.  ./syyyyo/` -hhhso    `:ossssso-           ');
	    gotoxy(marginL,5);write('          .hh+s,   yhy   .hhh/yhs:   .yhy:  +hhs -hhys,   `yh/-  :-sh/          ');
	    gotoxy(marginL,6);write('          .hho     yhy   .hhhhhhs.   :hhyssssyyy`-hhs     /ho-     -hy          ');
	    gotoxy(marginL,7);write('          .hho.    yhy   .hhh.-yhy:  .hhy:       -hhy..   .yh:.  -.oh+          ');
	    gotoxy(marginL,8);write('          -yhhy+   yhy   .hhy  .shh+` -oyyyyyy+. `shhyy    .+yysosys:           ');
	    gotoxy(marginL,9);write('           ``..`   ```    ```   ````    `....`    ``..`      ``...`             ');
		TextBackground(Black);
	    gotoxy(marginL,10);write('================================================================================');
		{Login Panel }
	end;

	procedure help();
		begin
			TextBackground(Green);
			writeln('-----------------------------------   HELP   -----------------------------------');
			TextBackground(Black);
			writeln('perintah yang tersedia :');
			writeln('     nowPlaying     - Menampilkan Film-Film yang tersedia pada hari ini');
			writeln('     upcoming       - Menampilkan Film-Film yang akan ditampilkan');
			writeln('                      minggu depan');
			writeln('     schedule       - Menampilkan jam tayang suatu Film dengan masukkan');
			writeln('                      nama Film dan tanggal penayangan');
			writeln('     genreFilter    - Menampilkan film sesuai genre yang diinginkan');
			writeln('     ratingFilter   - menampilkan film sesuai dengan rating');
			writeln('                      penonton film tersebut');
			writeln('     searchMovie    - mencari film berdasarkan keyword. Keyword bisa diambil');
			writeln('                      dari judul, genre, dan sinopsis film');
			writeln('     showMovie      - menampilkan deskripsi film berdasarkan input nama film');
			writeln('     showNextDay    - menampilkan film apa saja yang ditayangkan pada ');
			writeln('                      hari berikutnya');
			writeln('     selectMovie    - memilih Film yang akan ditonton ');
			writeln('     payCreditCard  - membayar tiket menggunakan kartu kredit ');
			writeln('     payMember      - membayar tiket yang dibeli menggunakan saldo ');
			writeln('                      member, diperlukan login untuk membayar');
			writeln('     registerMember - mendaftarkan member baru');
			writeln('     buySnack       - menu untuk membeli snack yang tersedia');
			writeln('     help           - menampilkan info-info menu pada TIKETO');
			writeln('     about          - menampilkan informasi tentang Aplikasi TIKETO');
			writeln('--------------------------------------------------------------------------------');
		end;

	procedure about();
		begin
			TextBackground(Green);
			writeln('----------------------------------   ABOUT   -----------------------------------');
			TextBackground(Black);
			writeln('   Nama Aplikasi    : TIKETO ');
			writeln('   Versi            : 1.0.0 - April 2016 ');
			writeln('   Tanggal Rilis    : 24-04-2016 ');
			writeln('   Developer        : ');
			writeln('                             Kelompok 5 DASPRO K-01                             ');
			writeln('                                Ari Mukti Wibowo                                ');
			writeln('                               Fadhil Imam Kurnia                               ');
			writeln('                              Radiyya Dwi Saputra                               ');
			writeln('                                 Tri Fuad Aziz                                  ');
			writeln('                                Robby Syaifullah                                ');
			writeln;
			writeln('              - Aplikasi penjualan tiket bioskop yang interaktif -              ');
			writeln;
			writeln('--------------------------------------------------------------------------------');
		end;

	function isMenu(s:string):Boolean;
		var
			i:integer;
		begin
			isMenu:=false;
			for i:=1 to jumlahMenu do begin
				if (Menu[i]=lowerCase(s)) then begin
					isMenu:=true;
					break;
				end;
			end;

		end;

	function countChar(c:char;s:ansistring):longint;
		var
			i:longint;
			count:integer;
		begin
			count:=0;
			for i:=1 to length(s) do begin
				if (c=s[i]) then begin
					count:=count+1;
				end;
			end;
			countChar:=count;
		end;

	function IsKabisat (y : integer):boolean;
		begin
			if (y mod 100=0) then 	{tahun abad}
			begin
				if (y mod 400 =0) then IsKabisat:=true else IsKabisat:=false;
			end else
				if (y mod 4= 0) then IsKabisat:=true else IsKabisat:= false;
		end;

	function JumlahHari(yy:integer;mm:integer;dd:integer):LongInt;
		var
			i:integer;
		begin
			yy:=yy-1;
			jumlahHari:=0;
			for i:= yy downto 1 do begin
				if IsKabisat(yy) then 
					JumlahHari:=JumlahHari+366
				else 
					JumlahHari:=JumlahHari+365;
			end;
			for i:= mm-1 downto 1 do begin
				case i of
					1,3,5,7,8,10,12 : begin JumlahHari:=JumlahHari+31; end;
					4,6,9,11 		: begin JumlahHari:=JumlahHari+30; end;
					2 				: begin
										if IsKabisat(yy+1) then JumlahHari:=JumlahHari+29
										else JumlahHari:=JumlahHari+28;
									  end;
				end;
			end;
			JumlahHari:=JumlahHari+dd;
		end;



	procedure uang(nominal: longint);
		var
			x:longint;
			i:integer;
		begin
			x:=1;

			for i:=1 to (jumlahDigit(nominal)-1) do
				x:=x*10;
			write('Rp ');
			if (jumlahDigit(nominal)>1) then begin
				for i:=1 to jumlahDigit(nominal) do begin
					write((nominal div x)mod 10);
					x:=x div 10;
					if ((jumlahDigit(nominal)-i) mod 3 = 0)and((jumlahDigit(nominal)-i)<>0) then
						write('.');
				end;
			end else
				write(nominal);
			write(',-');

		end;

	function jumlahDigit(angka:longint):integer;
		var
			i:integer;
			x:longint;
		begin
			if (angka>0) then begin
				x:=10;i:=0; 
				while (angka>0) do begin
					angka:=angka div x;
					i:=i+1;
				end;
				jumlahDigit:=i;
			end else
				jumlahDigit:=0;
		end;


	function JumlahJam(inputWaktu:Jam):integer;
		begin
			JumlahJam:=inputWaktu.Hour*60+inputWaktu.Minute;
		end;

	function konversiTanggal(s:string):Tanggal;
		var
			tempd:arrayData;
			t:Tanggal;
		begin
				tempd:=splitTanggal(s);
				t.Tanggal:=StrToInt(tempd[1]);
				t.Bulan:=StrToInt(tempd[2]);
				t.Tahun:=StrToInt(tempd[3]);
			konversiTanggal:=t;
		end;
		
	function konversiJam(s:string):Jam;
		var
			tempd:arrayData;
			t:Jam;
		begin
			tempd:=SplitJam(s);
				t.Hour:=StrToInt(tempd[1]);
				t.Minute:=StrToInt(tempd[2]);
			konversiJam:=t;
		end;
		
	function konversiDurasi(s:string):Jam;
		var
			tempd:arrayData;
			t:Jam;
		begin
			tempd:=SplitDurasi(s);
				t.Minute:=StrToInt(tempd[1]);
			konversiDurasi:=t;
		end;
		
	function SplitTanggal(s:ansistring):arrayData;
		var
			i,j:integer;
			temp:ansistring;
		begin
			i:=1;j:=1;temp:='';
			while (i<=length(s)) do begin
				if (s[i]<>'-') then begin
					temp:=temp+s[i];
				end else begin
					SplitTanggal[j]:=temp;
					temp:='';
					j:=j+1;
				end;
				if (i=length(s)) then SplitTanggal[j]:=temp; // menambag data terakhir
				i:=i+1;
			end;
		end;	

	function SplitJam(s:ansistring):arrayData;
		var
			i,j:integer;
			temp:ansistring;
		begin
			i:=1;j:=1;temp:='';
			while (i<=length(s)) do begin
				if (s[i]<>'.') then begin
					temp:=temp+s[i];
				end else begin
					SplitJam[j]:=temp;
					temp:='';
					j:=j+1;
				end;
				if (i=length(s)) then SplitJam[j]:=temp; // menambag data terakhir
				i:=i+1;
			end;
		end;	
		
	function SplitDurasi(s:ansistring):arrayData;
		var
			i,j:integer;
			temp:ansistring;
		begin
			i:=1;j:=1;temp:='';
			while (i<=length(s)) do begin
				if (s[i]<>' ') then begin
					temp:=temp+s[i];
				end else begin
					SplitDurasi[j]:=temp;
					temp:='';
					j:=j+1;
				end;
				if (i=length(s)) then SplitDurasi[j]:=temp; // menambag data terakhir
				i:=i+1;
			end;
		end;
		

	function IsJamValid(inputWaktu:Jam):boolean;
		begin
			isJamValid:=(inputWaktu.Hour >=0) and (inputWaktu.Hour <=24) and (inputWaktu.Minute >=0) and (inputWaktu.Minute <=60);
		end;

	function isDateValid (dd:integer;mm:integer;yy:integer):Boolean;
		var
		a : boolean;
		
		begin
			a := True; {inisiasi awal}
			if (mm <= 12) then begin 
				case mm of {kasus untuk nilai bulan}
				1,3,5,7,8,10,12 :begin
									if (dd>0) and (dd <= 31) and (yy > 999) then a:=True
									else a:=False; {kasus untuk hari dan tahun}
								 end;
				4,6,9,11 		:begin
									if (dd>0) and (dd<=30) and (yy>999) then a:=True
									else a:=False;{kasus untuk hari dan tahun}
								 end;
				2 				:begin
									if (dd>0) and (dd<=29) and (IsKabisat (yy)) then a := True
									else if (dd>0) and (dd<=28) and (not IsKabisat (yy)) then a := True
										else a := False;{kasus untuk hari dan tahun}
								 end;
				end;	
			end else 
				a:= False; {mm>12}
			isDateValid := a; {penetapan nilai fungsi isDateValid}
		end;

end.