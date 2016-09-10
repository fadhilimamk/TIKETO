program TIKETO;
	{Aplikasi TIKETO untuk mempermudah pembelian tiket bioskop}
uses
	utiketo,
	uload,
	umovie,
	umember,
	utransaksi,
	usnack;

{KAMUS}
	var
		dataFilm		:arrayFilm;
		neffFilm		:longint;
		dataTayang		:arrayTayang;
		neffTayang		:longint;
		dataKapasitas	:arrayKapasitas;
		neffKapasitas	:longint;
		dataPemesanan	:arrayPemesanan;
		neffPemesanan	:longint;
		dataMember		:arrayMember;
		neffMember		:longint;
		today			:Tanggal;
		pilihan			:string;

		dataSnack		:arraySnack;
		neffSnack		:longint;
		dataPemesananSnack : arrayPemesananSnack;
		neffPemesananSnack : longint;


	procedure doLoad();
		begin
			load(
				dataFilm,
				dataTayang,
				dataKapasitas,
				dataPemesanan,neffPemesanan,
				dataMember,neffMember,
				today);
			neffFilm:=jumlahFilm();			neffTayang:=jumlahTayang();
			neffKapasitas:=jumlahKapasitas();

			getDataSnack(dataSnack, neffSnack, dataPemesananSnack, neffPemesananSnack);
		end;	
	procedure doExit();
		begin 
			exit(
				dataFilm,
				dataTayang,
				dataKapasitas,
				dataPemesanan,neffPemesanan,
				dataMember,neffMember);
			
			simpanDataSnack(dataSnack, neffSnack, dataPemesananSnack, neffPemesananSnack);
		end;	



begin
	//inisialisasi
	showHeader;
	doLoad;
	write('menu > ');readln(pilihan);
	pilihan:=lowerCase(pilihan);
	while (pilihan<>'exit') do begin
		if (isMenu(pilihan)) then begin {jika menu yang diinput benar}
			{mengecek tiap menu}
			case pilihan of
				'nowplaying'	: nowPlaying(dataTayang,neffTayang,today);
				'upcoming'		: upcoming(dataTayang,neffTayang,today);
				'schedule'		: schedule(dataTayang);
				'genrefilter'	: genrefilter(dataFilm);
				'ratingfilter'	: ratingfilter(dataFilm);	
				'searchmovie' 	: getJudulFilm(dataFilm,neffFilm);
				'showmovie'   	: showMovie (dataFilm, neffFilm);
				'shownextday'	: showNextDay(dataTayang,neffTayang,today);
				'selectmovie'  	: selectMovie (dataFilm,dataKapasitas,neffKapasitas,dataPemesanan,neffPemesanan);
				'paymember'    	: payMember(dataMember,neffMember,dataPemesanan,neffPemesanan);				
				'paycreditcard'	: paycreditcard(dataPemesanan,neffPemesanan); 								 
				'buysnack'		: buysnack(dataSnack, neffSnack, dataPemesananSnack, neffPemesananSnack, dataMember, neffMember);
				'registermember': registermember(dataMember,neffMember);
				'help'			: help;
				'about'			: about;
			end;
			write('menu > ');readln(pilihan);
			showHeader();
			writeln('menu > ',pilihan);
			pilihan:=lowerCase(pilihan);
		end else begin 					{jika tidak termasuk menu}
			showHeader;
			writeln('menu > ',pilihan);
			writeln('Tidak ada menu "',pilihan,'" ketik "help" untuk info bantuan');
			write('menu > ');readln(pilihan);
			pilihan:=lowerCase(pilihan);
		end;
	end;
	doExit;
end.