{* 113 - Gornati Joel, Vega Luis *}
program tp2;

uses crt;

var tablero:array[1..9] of char;
	i: integer;
	celda: integer;
	ficha: char;
	juegaX: boolean;
	ref: integer;
	varGanador, nombreJugador: string;
	juegoTerminado: boolean;
	contJugadas: integer;
	jugador:array[1..2] of string;
	volverMenu: char;
	menuSel: char;
	salir: boolean;
	modoIA: boolean;
	empresa, importe:Integer;
   	continuar:char;

//****************************************
//BLOQUE TATETI 
//****************************************
procedure dibujaFicha(iFicha: integer);
begin
	case tablero[iFicha] of
		'X': textcolor(LightRed);
		'O': textcolor(LightBlue);
		else textcolor(14);
	end;
	write(' ');write(tablero[iFicha]);write(' ');
	NormVideo
end;

procedure holaTateti();
begin
	writeln(' _________  ________  _________  _______  _________  ___     ');
	writeln('|\___   ___|\   __  \|\___   ___|\  ___ \|\___   ___|\  \    ');
	writeln('\|___ \  \_\ \  \|\  \|___ \  \_\ \   __/\|___ \  \_\ \  \   ');
	writeln('     \ \  \ \ \   __  \   \ \  \ \ \  \_|/__  \ \  \ \ \  \  ');
	writeln('      \ \  \ \ \  \ \  \   \ \  \ \ \  \_|\ \  \ \  \ \ \  \ ');
	writeln('       \ \__\ \ \__\ \__\   \ \__\ \ \_______\  \ \__\ \ \__\');
	writeln('        \|__|  \|__|\|__|    \|__|  \|_______|   \|__|  \|__|');
end;
procedure matriz();
begin
	clrscr;
	holaTateti();
	writeln('');
	write(#218);
	for i:= 1 to 3 do
		write(#196);
		write(#194);
	for i:= 1 to 3 do
	 	write(#196);
		write(#194);
	 for i:= 1 to 3 do
		 write(#196);
	writeln(#191);
	write(#179);
	dibujaFicha(7);
	write(#179);
	dibujaFicha(8);
	write(#179);
	dibujaFicha(9);
	writeln(#179);
	write(#195);
	for i:=1 to 3 do
		write(#196);
	write(#197);
	for i:=1 to 3 do
		write(#196);
	write(#197);
	for i:=1 to 3 do
		write(#196);
	writeln(#180);
	write(#179);
	dibujaFicha(4);
	write(#179);
	dibujaFicha(5);
	write(#179);
	dibujaFicha(6);
	writeln(#179);
	write(#195);
	for i:=1 to 3 do
		write(#196);
	write(#197);
	for i:=1 to 3 do
		write(#196);
	write(#197);
	for i:=1 to 3 do
		write(#196);
	writeln(#180);
	write(#179);
	dibujaFicha(1);
	write(#179);
	dibujaFicha(2);
	write(#179);
	dibujaFicha(3);
	writeln(#179);
	write(#192);
	for i:=1 to 3 do
		write(#196);
	write(#193);
	for i:=1 to 3 do
		write(#196);
	write(#193);
	for i:=1 to 3 do
		write(#196);
	writeln(#217);

end;
procedure initMatriz();
begin
	ref := 49;
	for i:= 1 to 9 do
	begin
		tablero[i] := char(ref);
		ref:=ref+1;
	end;
end;

procedure msgError(msg: string);
begin
	TextColor(LightRed+Blink);
	write(msg);
	delay(2000);
	NormVideo;
end;
function ganador():string;
begin
	{* ganador horizontal X *}
	if 	((tablero[1] = 'X') and (tablero[2] = 'X') and (tablero[3] = 'X')) or
		((tablero[4] = 'X') and (tablero[5] = 'X') and (tablero[6] = 'X')) or
		((tablero[7] = 'X') and (tablero[8] = 'X') and (tablero[9] = 'X')) then
		begin
			ganador := 'X';
			juegoTerminado := true;
		end;
	{* ganador horizontal O *}
	if 	((tablero[1] = 'O') and (tablero[2] = 'O') and (tablero[3] = 'O')) or
		((tablero[4] = 'O') and (tablero[5] = 'O') and (tablero[6] = 'O')) or
		((tablero[7] = 'O') and (tablero[8] = 'O') and (tablero[9] = 'O')) then
		begin
			ganador := 'O';
			juegoTerminado := true;
		end;
	{* ganador vertical X *}
	if 	((tablero[1] = 'X') and (tablero[4] = 'X') and (tablero[7] = 'X')) or
		((tablero[2] = 'X') and (tablero[5] = 'X') and (tablero[8] = 'X')) or
		((tablero[3] = 'X') and (tablero[6] = 'X') and (tablero[9] = 'X')) then
		begin
			ganador := 'X';
			juegoTerminado := true;
		end;
	{* ganador vertical O *}
	if 	((tablero[1] = 'O') and (tablero[4] = 'O') and (tablero[7] = 'O')) or
		((tablero[2] = 'O') and (tablero[5] = 'O') and (tablero[8] = 'O')) or
		((tablero[3] = 'O') and (tablero[6] = 'O') and (tablero[9] = 'O')) then
		begin
			ganador := 'O';
			juegoTerminado := true;
		end;
	{* ganador diagonal X *}
	if 	((tablero[1] = 'X') and (tablero[5] = 'X') and (tablero[9] = 'X')) or
		((tablero[3] = 'X') and (tablero[5] = 'X') and (tablero[7] = 'X')) then
		begin
			ganador := 'X';
			juegoTerminado := true;
		end;
	 {* ganador diagonal O *}
	if 	((tablero[1] = 'O') and (tablero[5] = 'O') and (tablero[9] = 'O')) or
		((tablero[3] = 'O') and (tablero[5] = 'O') and (tablero[7] = 'O')) then
		begin
			ganador := 'O';
			juegoTerminado := true;
		end;
end;

procedure dibujaTablero();
begin
	if juegaX = true then
	begin
		ficha:='X';
		nombreJugador := jugador[1];
	end
	else
	begin
		ficha:='O';
		if modoIA = false then
			nombreJugador := jugador[2]
		else
			nombreJugador := 'PC';
	end;
	writeln('');
	writeln('Es el turno de ', nombreJugador, ' ', ficha);
	celda:=random(9);
	if (modoIA = false) or ((modoIA = true) and (juegaX = true)) then
	begin
		write('Ingrese numero de celda a jugar ');
		read(celda);
	end;
	if (celda >= 1) and (celda <= 9) then
	begin
		if (tablero[celda] = 'X') or (tablero[celda] = 'O')then
		begin
			if (modoIA = false) or ((modoIA = true) and (juegaX = true)) then
				msgError('Celda Ocupada');
		end
		else
		begin
			tablero[celda] := ficha;
			contJugadas := contJugadas + 1;
			juegaX := not juegaX;
		end;
	end
	else
	begin
		if (modoIA = false) or ((modoIA = true) and (juegaX = true)) then
			msgError('Ingrese numero correcto');
	end;
	matriz();
	varGanador := ganador();
	if (varGanador = 'X') or (varGanador = 'O') then
		write('el ganador es ', nombreJugador);
	if (varGanador <> 'X') and (varGanador <> 'O') and (contJugadas > 8) then
	begin
		juegoTerminado := true;
		write('Juego terminado, hubo empate');
	end;
end;

procedure modoVs();
var x: integer;
begin
	modoIA := false;
	for x:= 1 to 2 do begin
		Write('Ingrese nombre de jugador ', x,': ');
		ReadLn(jugador[x]);
	end;
end;

procedure modoPc();
begin
	modoIA := true;
	Write('Ingrese nombre de jugador 1: ');
	ReadLn(jugador[1]);
end;

procedure iniciarTateti();
var modoJuego:integer;
begin
	clrscr;
	juegaX := true;
	initMatriz();
	repeat
		clrscr;
		writeln('Modo de juego');
		writeln('1) Jugador 1 vs Jugador 2');
		writeln('2) Jugador 1 vs PC');
		write('Ingrese Modo de juego:');
		readln(modoJuego);
	until (modoJuego = 1) or (modoJuego = 2);

	case modoJuego of
		1:modoVs();
		2:modoPc();
	end;
	 
	matriz();
	contJugadas := 0;
end;

procedure tateti();
begin
iniciarTateti();
repeat
	dibujaTablero();
	if juegoTerminado = true then
	begin
		delay(4000);
		repeat
			clrscr;
			write('Desea volver a jugar?[S/N]');
			read(volverMenu);
		until (volverMenu = 'S') or (volverMenu = 'N');
		if volverMenu = 'S' then
		begin
			writeln('comienzo juego');
			clrscr;
			iniciarTateti();
			juegoTerminado := false;
		end
		else
		begin
			juegoTerminado := true;
		end;
	end;
until juegoTerminado = true;
end;
//**************************************************
//FIN BLOQUE TATETI
//**************************************************

//**************************************************
//BLOQUE CODIGO BARRA
//**************************************************
function ingresoInteger(texto:string; maximo:integer):integer;
var
   ingreso:integer;
begin
     repeat
           write(texto);
           readln(ingreso);
     until ingreso < maximo;
     ingresoInteger:=ingreso;
end;

function integerATextoConCeros(numero, largo:integer):string;
var
   largoNumero, i:integer;
   numeroEnTexto, nuevaCadena:string;
begin
     nuevaCadena:= '';
     Str(numero, numeroEnTexto);
     largoNumero:= Length(numeroEnTexto);
     if largoNumero = largo then
         nuevaCadena:= numeroEnTexto
     else if largoNumero < largo then
          begin
               nuevaCadena:= numeroEnTexto;
               for i:=1 to (largo -largoNumero) do
                   nuevaCadena:= '0' +nuevaCadena;
          end;
     integerATextoConCeros:= nuevaCadena
end;

function sumarDigitos(textoNumerico:string; tipo:integer):integer;
var
   largoNumero, i, suma, numero:integer;
begin
     suma:= 0;
     largoNumero:= Length(textoNumerico);
     for i:=1 to largoNumero do
         begin
              Val(textoNumerico[i], numero);

              if (i mod 2) = tipo then
                 suma:= suma + numero;
         end;
     sumarDigitos:= suma;
end;

function potencia(numero, exponente:integer):real;
var
   i:integer;
   calculo:real;
begin
     calculo:= 1;
     if exponente > 0 then
        begin
             for i:=1 to exponente do
                 calculo:= calculo * numero;
        end;

      potencia:=calculo;
end;

function integerABinario(numero, bits:integer):string;
var
   i, potencia2:integer;
   numeroTexto:string;
begin
     numeroTexto:= '';

     for i:=1 to bits do
        begin
             potencia2:= round(potencia(2, (bits - i)));

             if ((numero - potencia2) >= 0 ) then
                begin
                     numeroTexto:= concat(numeroTexto, '1');
                     numero:= numero - potencia2;
                end
             else
                numeroTexto:= concat(numeroTexto, '0');
        end;

     integerABinario:= numeroTexto;
end;

function codigo(empresa, importe:integer):string;
var
   empresaTexto, importeTexto, verificador:string;
   v1, v2, v3:integer;
begin
    empresaTexto:= integerATextoConCeros(empresa, 3);
    importeTexto:= integerATextoConCeros(importe, 4);

    v1:= sumarDigitos(concat(empresaTexto, importeTexto), 0);
    v2:= sumarDigitos(concat(empresaTexto, importeTexto), 1);
    v3:= (abs(v1-v2) div 10);

    Str(v3, verificador);

    codigo:= Concat(empresaTexto, importeTexto, verificador);
end;

function codigoABinario(codigo:string):string;
var
   largoNumero, numero, i:integer;
   binarioTexto:string;
begin
     binarioTexto:= '';
     largoNumero:= Length(codigo);

     for i:=1 to largoNumero do
         begin
              Val(codigo[i], numero);
              binarioTexto:= binarioTexto +integerABinario(numero, 4);
         end;

     codigoABinario:= binarioTexto;
end;

function codigoBinarioABarras(codigoBinario:string):string;
var
   largoCodigo, i:integer;
   barrasTexto:string;
begin
     barrasTexto:= '';
     largoCodigo:= Length(codigoBinario);

     for i:=1 to largoCodigo do
         begin
              if codigoBinario[i] = '1' then
                  barrasTexto:= concat(barrasTexto, #219)
              else
                  barrasTexto:= concat(barrasTexto, ' ');
         end;

     codigoBinarioABarras:= barrasTexto;
end;

procedure codigoBarra();
begin
clrscr;
randomize;
TextBackground(black);
textcolor(15);
writeln('____________________________________________________');
empresa:=ingresoInteger('Ingrese Codigo de la empresa: ', 1000);
repeat
	clrscr;
	TextBackground(black);
	textcolor(15);
	writeln('____________________________________________________');
	writeln('Empresa ', integerATextoConCeros(empresa, 3));
	importe:=ingresoInteger('Ingrese Importe: ', 10000);
	clrscr;
	gotoxy(20, 9);
	write('Codigo');
	gotoxy(40, 9);
	write('Barcode');
	gotoxy(20,10);
	textcolor(15);
	write(codigo(empresa, importe));
	gotoxy(40,10);
	write(codigoABinario(codigo(empresa, importe)));
	gotoxy(40,12);
	write(codigoBinarioABarras(codigoABinario(codigo(empresa, importe))));
	gotoxy(40,13); write(codigoBinarioABarras(codigoABinario(codigo(empresa, importe))));
	gotoxy(40,14);
	write(codigoBinarioABarras(codigoABinario(codigo(empresa, importe))));
	gotoxy(20,18);
	TextBackground(black);
	textcolor(15);
	writeln('<Presione cualquier tecla para continuar>');
	gotoxy(20,19);
	write('<ESC para salir>');
	continuar := readkey;
until continuar = #27;	
end;

//**************************************************
//FIN BLOQUE CODIGO BARRA
//**************************************************

//**************************************************
//BLOQUE CALENDARIO GRREGRIANO
//**************************************************
procedure calendarioGregoriano();
var diaTxt: array[0..6] of string;
t: array[0..11] of integer;
dia, mes, anio: integer;
h, hAuxInt: integer;
hAux: real;
begin
	diaTxt[0] := 'Domingo';
	diaTxt[1] := 'Lunes';
	diaTxt[2] := 'Martes';
	diaTxt[3] := 'Miercoles';
	diaTxt[4] := 'Jueves';
	diaTxt[5] := 'Viernes';
	diaTxt[6] := 'Sabado';

	t[0] := 0;
	t[1] := 3;
	t[2] := 2;
	t[3] := 5;
	t[4] := 0;
	t[5] := 3;
	t[6] := 5;
	t[7] := 1;
	t[8] := 4;
	t[9] := 6;
	t[10] := 2;
	t[11] := 4;
	repeat
		clrscr;
		write('Ingrese el dia: ');
		readln(dia);
		write('Ingrese el mes: ');
		readln(mes);
		write('Ingrese el anio: ');
		readln(anio);

		if mes < 3 then
			anio := anio - 1;

		hAux := anio + round(anio/4) - round(anio/100) + round(anio/400) + t[mes - 1] + dia;
		hAuxInt := round(hAux);
		h := hAuxInt mod 7;
		writeln('El dia es: ',diaTxt[h]);

		writeln('<Presione cualquier tecla para continuar>');
		write('<ESC para salir>');
		continuar := readkey;
	until continuar = #27;
end;


//**************************************************
//FIN BLOQUE CALENDARIO GRREGRIANO
//**************************************************

procedure bienvenido();
begin
	writeln(' _________  ________    _______     ');
	writeln('|\___   ___|\   __  \  /  ___  \    ');
	writeln('\|___ \  \_\ \  \|\  \/__/|_/  /|   ');
	writeln('     \ \  \ \ \   ____|__|//  / /   ');
	writeln('      \ \  \ \ \  \___|   /  /_/__  ');
	writeln('       \ \__\ \ \__\     |\________\');
	writeln('        \|__|  \|__|      \|_______|');
end;

function menu():char;
var opMenu: char;
begin
	repeat
		clrscr;
		bienvenido();
		writeln('');writeln('');
		writeln('1) TaTeTi');
		writeln('2) Calendario');
		writeln('3) Codigo de barras');
		writeln('4) Salir');
		write('Ingrese opcion');
		opMenu := readkey;
	until (opMenu >= '1') and (opMenu <= '4');
	menu := opMenu;
end;




//main
begin
repeat
	menuSel := menu();
	case menuSel of
		'1': tateti();
		'2': calendarioGregoriano();
		'3': codigoBarra();
		'4': salir:=true;
	end;
until salir = true;

end.
