{ File	 : umovie.pas 																		}
{ Editor : Fadhil Imam Kurnia / 16515183													}
{ Versi	 : 1.0 																				}
{ Tanggal: 20 April 2016																	}
{ Deskrip: File unit untuk aplikasi TIKETO 													}
{ 		   Tubes Daspro 2016 																}


unit umovie;
	{ Unit bagian dari program tiketo yang berisi fungsi dan prosedur yang
	  berkaitan dengan movie
	  - nowPlaying
	  - upcoming
	  - schedule
	  - genreFilter
	  - ratingFilter
	  - searchMovie
	  - showMovie
	  - showNextDay
	  - selectMovie
	}
interface
	uses utiketo,uload;
	function include(T1,T2:Tanggal;lama:integer;permintaan:string):boolean;
	{fungsi include mengecek apakah T1 berada di dalam batas waktu T2 dan lama. Apabila T2<=T1<=T2+lama maka akan dihasilkan nilai true}

	procedure nowPlaying(var dataTayang:arrayTayang;var neffTayang:LongInt;var today:Tanggal);
	procedure upcoming(var dataTayang:arrayTayang;var neffTayang:LongInt;var today:Tanggal);
	procedure schedule ( var tab2:arrayTayang );
		{berguna untuk menampilkan jam tayang suatu film berdasarkan nama film dan tanggal tayang
		*I.S  : tab2/arrayTayang terdefinisi, file eksternal data tayang sudah benar.
		*F.S  : ditampilkan jam tayang film yang sesuai}
	procedure genreFilter (var tab : arrayFilm );
		{berguna untuk menampilkan nama film yang sesuai dengan genre film yang diminta
		*I.S : tab/arrayFilm terdefinisi, file eksternal data film sudah benar
		*F.S : ditampilkan semua judul film yang sesuai dengan genre yang diminta}
	procedure ratingFilter (var tab : arrayFilm);
		{berguna untuk menampilkan nama film yang sesuai dengan rating film yang diminta
		*I.S : tab/arrayFilm terdefinisi, file eksternal data film sudah benar
		*F.S : ditampilkan semua judul film yang sesuai dengan rating film yang diminta }
	procedure selectMovie (dataFilm:arrayFilm;var tab : arrayKapasitas;var neffKapasitas:LongInt; var tab2 : arrayPemesanan ;var neffPemesanan:LongInt);
		//menampilkan ketersediaan kursi yang ingin dipesan

	procedure getJudulFilm(var dataFilm:arrayFilm;var neffFilm:LongInt);
		{ Menampilkan nama Film berdasarkan keyword yang bisa diambil dari judul, genre,dan sinopsis film }
	procedure showMovie(var tab:arrayFilm;neffFilm:LongInt);
		{ Menampilkan deskripsi Film secara berurutan berdasarkan input nama Film}
	procedure showNextDay(var dataTayang:arrayTayang;neffTayang:LongInt;var today:Tanggal);

implementation
	
	function include(T1,T2:tanggal;lama:integer;permintaan:string):boolean;
	{IF:Fungsi include akan menerima dua variabel tanggal yaitu T1 dan T2, variabel lama bertipe Integer, dan variabel permintaan bertipe string  }
	{FS: Akan dihasilkan apakah T1 berada diantara T2(hari pertama penayangan film) dan T2+lama-1 (hari terakhir penayangan film)}
		const
		next='shownextday';
		
		var
			L1,L2,L3:LongInt;
		
		begin
			if (lowerCase(permintaan)='nowplaying') then
				begin
					L1:=0+ JumlahHari(T1.Tahun,T1.Bulan,T1.Tanggal);
					L2:=JumlahHari(T2.Tahun,T2.Bulan,T2.Tanggal);
					L3:=L2+lama-1;
					if (L1>=L2) and (L1<=L3) then include:=true else include:=false;
				end else
			if (lowerCase(permintaan)=next) then
				begin
					L1:=1+ JumlahHari(T1.Tahun,T1.Bulan,T1.Tanggal);
					L2:=JumlahHari(T2.Tahun,T2.Bulan,T2.Tanggal);
					L3:=L2+lama-1;
					if (L1>=L2) and (L1<=L3) then include:=true else include:=false;
				end else
			if (lowerCase(permintaan)='upcoming') then
				begin
					L1:=7+ JumlahHari(T1.Tahun,T1.Bulan,T1.Tanggal);
					L2:=JumlahHari(T2.Tahun,T2.Bulan,T2.Tanggal);
					L3:=L2+lama-1;
					if (L1>=L2) and (L1<=L3) then include:=true else include:=false;
				end;
				
		end;

	procedure nowPlaying(var dataTayang:arrayTayang;var neffTayang:LongInt;var today:Tanggal);
		var
			i:integer;
			date:Tanggal;
			pilihan:string;
		begin
			pilihan:='nowplaying';
			for i:=1 to neffTayang do begin
				date.tanggal:=dataTayang[i].Tanggal;
				date.Bulan	:=dataTayang[i].Bulan;
				date.Tahun	:=dataTayang[i].Tahun;
				if include(today,date,dataTayang[i].Lama,pilihan) then 
					writeln('> ',dataTayang[i].NamaFilm);
			end;
		end;

	procedure upcoming(var dataTayang:arrayTayang;var neffTayang:LongInt;var today:Tanggal);
		var
			i:integer;
			date:Tanggal;
			pilihan:string;
		begin
			pilihan:='upcoming';
			for i:=1 to neffTayang do begin
				date.tanggal:=dataTayang[i].Tanggal;
				date.Bulan	:=dataTayang[i].Bulan;
				date.Tahun	:=dataTayang[i].Tahun;
				if include(today,date,dataTayang[i].Lama,pilihan) then 
					writeln('> ',dataTayang[i].NamaFilm);
			end;
		end;

	procedure schedule ( var tab2:arrayTayang);
	var
	i,dd,mm,yy : integer; {i sebagai index, (dd,mm,yy) untuk tanggal} 
	a : boolean;
	x, y : string; {varaibel untuk input nama film}
	
	begin
	write ('> Masukkan nama film : ');
	readln (x);
	{looping pembacaan tanggal tayang hingga valid/benar}
	repeat 
	write ('> Masukkan tanggal tayang film (dd-mm-yyyy) : ');
	readln (y);
	dd := konversiTanggal(y).Tanggal;
	mm := konversiTanggal(y).Bulan;
	yy := konversiTanggal(y).Tahun;
	if (isDateValid (dd,mm,yy) = False) then writeln ('> Input tanggal salah. Masukkan kembali'); 
	until isDateValid (dd,mm,yy) = True; {tanggal sudah valid}
	a := False; {inisiasi awal}
		{looping pengecekan nama film pada arrayTayang dan pengecekan tanggal input pada rentan tanggal tayang}
		for i:=1 to jumlahTayang do
		begin
		if (lowerCase (tab2[i].NamaFilm) = lowerCase (x)) and 
		(JumlahHari(tab2[i].Tahun,tab2[i].Bulan,tab2[i].Tanggal) <= JumlahHari (yy,mm,dd)) and
		(JumlahHari (yy,mm,dd) <= (JumlahHari (tab2[i].Tahun,tab2[i].Bulan,tab2[i].Tanggal) + tab2[i].Lama)) then 
		begin
		write ('> Jam tayang : '); 
		writeln (tab2[i].JamTayang);
		a := a or True; 
		end else a := a or False; {nama film tidak ada pada arrayTayang atau tanggal input tidak pada rentan tayang}
		end;
		if (not a) then writeln ('> Tidak ada penayangan film yang diminta pada tanggal tersebut');
	end;

	procedure genreFilter (var tab:arrayFilm);	
 	var
	i : integer; {index}
	a : boolean;
	x : string; {input genre film}
	
	begin
	write ('> Masukkan Genre Film : ');
	readln (x);
	a:=False; {inisiasi awal}
		{looping pengecekan genre pada arrayFilm}
		for i:=1 to jumlahFilm do
		begin
			if (lowerCase (tab[i].Genre) = lowerCase (x)) then 
			begin
			write ('> Nama Film : ');
			writeln (tab[i].Judul);
			a:= a or True;
			end else
			a := a or False; {tidak ada genre sesuai pada index i}
		end;
	if (not a) then writeln ('> Tidak ada penayangan film yang sesuai dengan genre yang diminta'); {tidak ada genre yang sesuai}
	end;


	procedure ratingFilter (var tab:arrayFilm);
		var
		i : integer;
		a : boolean;
		x : string;
	
		begin
		a:= False; {inisiasi awal}
		write ('> Masukkan Rating Film : ');
		readln (x);
			{looping pengecekan rating pada arrayFilm}
			for i:=1 to jumlahFilm do
			begin
				if (lowerCase (tab[i].Rating) = lowerCase (x)) then 
				begin
				writeln (tab[i].Judul);
				a := a or True;
				end else
				a := a or False; {tidak ada rating yang sesuai pada index i}
			end;
		if (not a) then writeln ('> Tidak ada penayangan film yang sesuai dengan rating yang diminta'); {tidak ada genre yang sesuai}
		end;


	
	procedure getJudulFilm(var dataFilm:arrayFilm;var neffFilm:LongInt);
		{ Menampilkan nama Film berdasarkan keyword yang bisa diambil dari judul, genre,dan sinopsis film }
		var
			i : integer;
			keyword:string;
		{ALGORITMA}
		begin
			write('> Masukkan Keyword Film: ');readln(keyword);
			for i:=1 to neffFilm do 
			begin
				if (lowerCase(dataFilm[i].Judul) = lowerCase(keyword)) or (lowerCase(dataFilm[i].Genre) = lowerCase(keyword)) or (lowerCase(dataFilm[i].Sinopsis) = lowerCase(keyword)) then 
				begin
					writeln('> ',dataFilm[i].Judul);
				end;
			end;
		end;
		
	procedure selectMovie (dataFilm:arrayFilm; var tab : arrayKapasitas;var neffKapasitas:LongInt; var tab2 : arrayPemesanan ;var neffPemesanan:LongInt);
		var
		i : integer; {index}
		j:integer; {index untuk arrayFilm}
		b : integer; {tiket yang dipesan}
		a : boolean;
		x,y : string; {nama film}
		dd : integer; mm : integer; yy : integer; {tanggal}
		jam : string; {jam tayang}
		durasi : string; {durasi film}
		
		begin
		
			write('> Film : ');readln(x);
			repeat 
				write('> Tanggal tayang (dd-mm-yy) : ');
				readln (y);
				dd := konversiTanggal(y).Tanggal;
				mm := konversiTanggal(y).Bulan;
				yy := konversiTanggal(y).Tahun;
				if (isDateValid (dd,mm,yy) = False) then writeln ('> Input tanggal salah. Masukkan kembali'); 
			until isDateValid (dd,mm,yy) = True; {tanggal sudah valid}
				
				repeat
					write('> Jam tayang : ');
					readln(jam);
					if (IsJamValid(konversiJam(jam)) = False) then writeln ('> Input jam salah. Masukkan kembali'); 
				until IsJamValid (konversiJam(jam)) = True;
				
			a := False; {inisiasi awal}
			{looping untuk pengecekan nama film, tanggal tayang serta jam tayang}
			for j:=1 to jumlahFilm do
				if (lowerCase (dataFilm[j].Judul) = lowerCase (x)) then
				durasi := dataFilm[j].Durasi;
			for i:=1 to neffKapasitas do
				begin
					if (lowerCase (tab[i].NamaFilm) = lowerCase (x)) and 
					(tab[i].Tanggal = dd) and (tab[i].Bulan = mm) and (tab[i].Tahun = yy)
					and (JumlahJam(konversiJam(tab[i].JamTayang)) <= JumlahJam (konversiJam(jam))) and 
					(JumlahJam (konversiJam(jam)) < JumlahJam (konversiJam(tab[i].JamTayang)) + konversiDurasi(durasi).minute) then  
						begin
							a:= a or True;
							if (tab[i].SisaKursi=0) then writeln('> Pemesanan sudah tidak bisa dilakukan karena kursi sudah penuh') else
							begin
								writeln ('> Kapasitas tersisa : ', tab[i].SisaKursi);
								write ('> Masukkan jumlah tiket yang ingin dibeli : ');
								repeat
									readln (b);
									if (b >= tab[i].SisaKursi) then write ('> Sisa kursi tidak mencukupi. Masukkan kembali : ')
									else if (b<1) then write ('> Jumlah kursi yang diminta tidak valid. Masukkan kembali : ');
								until (b<=tab[i].SisaKursi) and (b>=1);	
								tab[i].SisaKursi := tab[i].SisaKursi - b;
								neffPemesanan:=neffPemesanan+1;
								tab2[neffPemesanan].No := neffPemesanan;
								tab2[neffPemesanan].NamaFilm := tab[i].NamaFilm;
								tab2[neffPemesanan].Tanggal := tab[i].Tanggal;
								tab2[neffPemesanan].Bulan := tab[i].Bulan;
								tab2[neffPemesanan].Tahun := tab[i].Tahun;
								tab2[neffPemesanan].JamTayang := tab[i].JamTayang;
								tab2[neffPemesanan].JumlahKursi := b;
								write ('> Pemesanan berhasil. Nomor pemesanan anda : ');
								case tab2[neffPemesanan].No of
									1..9 : writeln ('00',tab2[neffPemesanan].No);
									10..99 : writeln ('0',tab2[neffPemesanan].No);
									100..999 : writeln (tab2[neffPemesanan].No);
								end;
								for j:=1 to jumlahFilm do
									if (lowerCase (dataFilm[j].Judul) = lowerCase (x)) then
									begin
										if (JumlahHari(yy,mm,dd) mod 7 = 1) or (JumlahHari(yy,mm,dd) mod 7 = 2) then
										tab2[neffPemesanan].Total:=b*dataFilm[j].HargaWeekend else
										tab2[neffPemesanan].Total:=b*dataFilm[j].HargaWeekdays;	
									end;	
							tab2[neffPemesanan].JenisPembayaran := 'Belum dibayar';
							end;
						end else a := a or False;
				end;
			if (not a) then writeln ('> Tidak ada penayangan film ',x ,' pada tanggal dan jam tayang yang diminta');
	end;
	
	procedure showMovie(var tab:arrayFilm;neffFilm:LongInt);
	var
	i : integer;
	x : string;
	found:boolean;
	{ALGORITMA}
	begin
		found:=false;
		write('> Input Nama Film : '); readln(x);
		for i:=1 to neffFilm do
		begin
			if (lowerCase(tab[i].Judul) = lowerCase(x)) then 
			begin
				found:=true;
				writeln ('> Judul : ',tab [i].Judul);
				writeln ('> Genre : ',tab [i].Genre);
				writeln ('> Rating: ',tab [i].Rating);
				writeln ('> Durasi: ',tab [i].Durasi);
				writeln ('> Sinopsis:');
				writeln (tab [i].Sinopsis);
				writeln ('> Harga Weekdays: ',tab [i].HargaWeekdays);
				writeln ('> Harga Weekend : ',tab [i].HargaWeekend);
			end; 
		end;
		if (found=false) then writeln ('> Tidak ada Data Film ',x);
	end;

	procedure showNextDay(var dataTayang:arrayTayang;neffTayang:LongInt;var today:Tanggal);
		var
			i:integer;
			date:Tanggal;
			pilihan:string;
		begin
			pilihan:='shownextday';
			for i:=1 to neffTayang do begin
				date.Tanggal:=dataTayang[i].Tanggal;
				date.Bulan:=dataTayang[i].Bulan;
				date.Tahun:=dataTayang[i].Tahun;
				if include(today,date,dataTayang[i].Lama,pilihan) then 
					writeln('> ',dataTayang[i].NamaFilm);
			end;
		end;
end.
