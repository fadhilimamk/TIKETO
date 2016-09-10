{ File	 : umember.pas 																		}
{ Editor : Fadhil Imam Kurnia / 16515183													}
{ Versi	 : 1.0 																				}
{ Tanggal: 20 April 2016																	}
{ Deskrip: File unit untuk aplikasi TIKETO 													}
{ 		   Tubes Daspro 2016 																}


unit umember;
	{ Unit bagian dari program tiketo yang berisi fungsi dan prosedur yang
	  berkaitan dengan member
	  - nowPlaying
	  - login
	  - authLogin
	  - isUsernameUsed
	}
interface
	uses utiketo, md5, crt;

	procedure registerMember(var dataMember:arrayMember; var neffMember:longint);
		{ Prosedur untuk menambahkan Member baru ke database, member baru memiliki username usr, password pass yang di-hash dengan
		  md5, saldo awal yang didapat adalah 100000 
			IS : dataMember sembarang
				 usr berisi nama username baru
				 pass berisi password username baru
			FS : member dalam dataMember bertambah dengan username usr, dan passord pass yang telah di-hash dengan md5
				 member baru tersebut mendapat saldo awal 100000
		}
	function isUsernameUsed(usr:string; var dataMember:arrayMember; var neffMember:longint):Boolean;
		{ menghasilkan true jika username usr telah digunakan oleh user lain}

	function authLogin(usr,pass:string; dataMember:arrayMember; neffMember:longint):longint;
		{ mengembalikan 0 jika gagal login, mengembalikan indeks member dalam dataMember jika berhasil login }

	procedure maskPass(var s:string);
		{ prosedur untuk input password agar menjadi * 
			IS : s sembarang
			FS : s terisi password
		}

	procedure showLogin();
		{ showLogin() merupakan prosedur untuk menampilkan form login }

	procedure doLogin(var usrnm, pass:string);
		{ doLogin(usrnm,pass) merupakan prosedur untuk menginput username dan password
		  ke dalam form login. Username dan password yang telah diinput
		  akan disimpan dalam variabel usrnm dan pass}

	procedure showRegister();
		{ showRegister() merupakan prosedur untuk menampilkan form register member baru }

	procedure doRegister(var usrnm, pass: string);
		{ doRegister() melakukan pembacaan username dan pass untuk member baru
			IS : usrnm, pass sembarang
			FS : usrnm, pass terisi
		}

implementation

	procedure registerMember(var dataMember:arrayMember; var neffMember:longint);
		var
			found:Boolean;
			username, password: string;
		begin
			showRegister;
			username:='';password:='';
			doRegister(username,password);
			// mengecek apakah username usr sudah dipakai
			found:=isUsernameUsed(username, dataMember, neffMember);
			if (not found)and(username<>'')and(password<>'') then begin
				neffMember:=neffMember+1;
				dataMember[neffMember].Username:=username;
				dataMember[neffMember].Password:=MD5Print(MD5String(password));
				dataMember[neffMember].Saldo:=100000;
				clrscr;
				showHeader;
				writeln('>  Sukses menambah member');
			end else begin
				clrscr;
				showHeader;	
				writeln('>  Error : Gagal menambah user, username sudah digunakan user lain!');
			end;
		end;

	function isUsernameUsed(usr:string; var dataMember:arrayMember; var neffMember:longint):Boolean;
		var
			i:integer;
		begin
			isUsernameUsed:=false;
			for i:=1 to neffMember do begin
				if (dataMember[i].Username=usr) then begin
					isUsernameUsed:=true;
					break;
				end;
			end;
		end;

	function authLogin(usr,pass:string; dataMember:arrayMember; neffMember:longint):longint;
		var
			i:longint;
		begin
			authLogin:=0; //inisialisasi
			for i:=1 to neffMember do begin
				if (dataMember[i].Username=usr)and(dataMember[i].Password=MD5Print(MD5String(pass))) then begin
					authLogin:=i;
					break;
				end;
			end;
		end;

	procedure maskPass(var s:string);
		var
			c:char;
		begin
			c:=ReadKey;s:=c;
			while c <> #13 do begin 
				s:=s+c;
				c:=ReadKey;
			end;
		end;



	// -----------------------------------------------------------------------------------------------------------------	showLogin
	procedure showLogin();
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
	    gotoxy(marginL,10);write('                                                                                ');
		{Login Panel }
		TextBackground(LightGreen);
		marginL:=21;
		gotoxy(marginL,12);	write(' +- Aplikasi Penjualan Tiket Bioskop -+ ');
		TextBackground(Black);
		gotoxy(marginL,13);	write('               Login Member             ');
		TextBackground(LightGreen);
		gotoxy(marginL,14);	write('+--------------------------------------+');
		gotoxy(marginL,15);	write('| Username :                           |');
		gotoxy(marginL,16);	write('| Password :                           |');
		gotoxy(marginL,17);	write('+--------------------------------------+');
		TextBackground(Black);
		marginL:=17;
		gotoxy(marginL,22);	write('Masukan username dan password akun member Anda');
		gotoxy(marginL,23);	write('   untuk membeli item  dengan aplikasi ini!   ');
		gotoxy(marginL,24);	write('                 kembali: Esc                 ');
		gotoxy(1,25); // menempatkan kursor di ujung layar
	end;

	// -----------------------------------------------------------------------------------------------------------------	doLogin
	procedure doLogin(var usrnm, pass:string);
	var
		c:char;
		isUsrnameDone:Boolean;
		xPos:integer;
	begin
		TextBackground(LightGreen);
		gotoxy(34,15);
		xPos:=34;
		// inisiasi variable untuk username
		usrnm:=''; pass:='';isUsrnameDone:=false;

		// membaca username dan menunggu Esc ditekan
		c:=#0; // inisiasi awal
		while (c<>#27) do begin
			//membaca inputan keyboard
			c:=ReadKey;
			if (not isUsrnameDone) then begin
				// menulis username
				if (c<>#13) then begin						// handling enter
					if(c<>#8)and(xPos<54) then begin		// handling backspace
						usrnm:=usrnm+c;
						write(c);
						xPos:=xPos+1;
					end else begin
						if (xPos>34) then begin
							xPos:=xPos-1;
							gotoxy(xPos,15);
							write(' ');
							delete(usrnm,length(usrnm),1);
							gotoxy(xPos,15);
						end;
					end;
				end else begin
					gotoxy(34,16);
					isUsrnameDone:=true;
					xPos:=34;
				end;
			end else begin
				// menulis password
				if (c<>#13) then begin
					if (c<>#8)and(xPos<54) then begin
						pass:=pass+c;
						write('*');
						xPos:=xPos+1;
					end else begin
						if (xPos>34) then begin
							xPos:=xPos-1;
							gotoxy(xPos,16);
							write(' ');
							delete(pass,length(pass),1);
							gotoxy(xPos,16);
						end;						
					end;
				end else begin
					break;
				end;			
			end;
		end;

		// menempatkan kursor di ujung layar
		TextBackground(Black);
		gotoxy(1,25);
	end;

	// -----------------------------------------------------------------------------------------------------------------	authLogin
	function authLogin(username, password: string; dataMember: array of string; totMember:integer):Boolean;
	var
		str: string;
		found:Boolean;
		i:integer;
	begin
		str:= username+' | '+password+' | ';
		// Mengecek apakah user ada dalam data
		// inisiasi sebelum looping
		found:=false;i:=0;
		while (not found)and(i<totMember) do begin
			if (Pos(str, dataMember[i])>0) then begin
				found:=true;
			end else begin
				i:=i+1;
			end;
		end;
		authLogin:=found;
	end;

	// -----------------------------------------------------------------------------------------------------------------	showRegister
	procedure showRegister();
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
	    gotoxy(marginL,10);write('                                                                                ');
		{Login Panel }
		TextBackground(LightGreen);
		marginL:=21;
		gotoxy(marginL,12);	write(' +- Aplikasi Penjualan Tiket Bioskop -+ ');
		TextBackground(Black);
		gotoxy(marginL,13);	write('         Registrasi Member Baru         ');
		TextBackground(LightGreen);
		gotoxy(marginL,14);	write('+--------------------------------------+');
		gotoxy(marginL,15);	write('| Username    :                        |');
		gotoxy(marginL,16);	write('| Password    :                        |');
		gotoxy(marginL,17);	write('| re-Password :                        |');
		gotoxy(marginL,18);	write('+--------------------------------------+');
		TextBackground(Black);
		marginL:=17;
		gotoxy(marginL,22);	write('Masukan username dan password untuk akun member');
		gotoxy(marginL,23);	write('                  baru Anda!                   ');
		gotoxy(marginL,24);	write('                 kembali: Esc                  ');
		gotoxy(1,25); // menempatkan kursor di ujung layar
	end;

	// -----------------------------------------------------------------------------------------------------------------	doRegister
	procedure doRegister(var usrnm, pass: string);
	var
		c:char;
		isUsrnameDone,isPassDone:Boolean;
		xPos:integer;
		repass:string;
		isOver:Boolean;
	begin
		TextBackground(LightGreen);
		isOver:=false;
		while (not isOver) do begin
			// Membersihkan form
			TextBackground(LightGreen);
			gotoxy(37,15);write('                        ');
			gotoxy(37,16);write('                        ');
			gotoxy(37,17);write('                        ');
			gotoxy(37,15);
			xPos:=37;
			// inisiasi variable untuk username
			usrnm:=''; pass:='';repass:='';isUsrnameDone:=false;isPassDone:=false;

			// membaca username dan menunggu Esc ditekan
			c:=#0; // inisiasi awal
			while (c<>#27) do begin
				//membaca inputan keyboard
				c:=ReadKey;
				if (not isUsrnameDone)and(not isPassDone) then begin
					// menulis username
					if (c<>#13) then begin						// handling enter
						if(c<>#8)and(xPos<54) then begin		// handling backspace
							usrnm:=usrnm+c;
							write(c);
							xPos:=xPos+1;
						end else begin
							if (xPos>37) then begin
								xPos:=xPos-1;
								gotoxy(xPos,15);
								write(' ');
								delete(usrnm,length(usrnm),1);
								gotoxy(xPos,15);
							end;
						end;
					end else begin
						gotoxy(37,16);
						isUsrnameDone:=true;
						xPos:=37;
					end;
				end else if (isUsrnameDone)and(not isPassDone) then begin
					// menulis password
					if (c<>#13) then begin
						if (c<>#8)and(xPos<54) then begin
							pass:=pass+c;
							write('*');
							xPos:=xPos+1;
						end else begin
							if (xPos>37) then begin
								xPos:=xPos-1;
								gotoxy(xPos,16);
								write(' ');
								delete(pass,length(pass),1);
								gotoxy(xPos,16);
							end;						
						end;
					end else begin
						gotoxy(37,17);
						isPassDone:=true;
						xPos:=37;
					end;			
				end else begin
					// menulis re password
					if (c<>#13) then begin
						if (c<>#8)and(xPos<54) then begin
							repass:=repass+c;
							write('*');
							xPos:=xPos+1;
						end else begin
							if (xPos>37) then begin
								xPos:=xPos-1;
								gotoxy(xPos,17);
								write(' ');
								delete(repass,length(repass),1);
								gotoxy(xPos,17);
							end;						
						end;
					end else begin
						break;
					end;	
				end;
			end;

			if (pass=repass)and((usrnm<>'')or(usrnm<>' '))and((pass<>' ')or(pass<>'')) then
				isOver:=true

			else begin
				TextBackground(Black);
				clrscr;
				writeln('>  Terjadi kesalahan, username salah atau password tidak tepat');
				write(usrnm, pass, repass);
				readln;
				showRegister();
			end;
		end;
		// menempatkan kursor di ujung layar
		TextBackground(Black);
		gotoxy(1,25);
		
	end;
end.