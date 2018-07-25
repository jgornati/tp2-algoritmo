program tictactoe;

uses crt;

var tablero:array[1..9] of char;
    i,iFicha: integer;
    celda: integer;
    ficha: char;
    juegaX: boolean;
    ref: integer;
    varGanador, nombreJugador: string;
    juegoTerminado, volverMenu: boolean;
    contJugadas: integer;
    jugador:array[1..2] of string;
    repetirJuego: string;

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

procedure cabecera();
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
     cabecera();
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
     if ((tablero[1] = 'X') and (tablero[2] = 'X') and (tablero[3] = 'X')) or
        ((tablero[4] = 'X') and (tablero[5] = 'X') and (tablero[6] = 'X')) or
        ((tablero[7] = 'X') and (tablero[8] = 'X') and (tablero[9] = 'X')) then
        begin
             ganador := 'X';
             juegoTerminado := true;
        end;
     {* ganador horizontal O *}
     if ((tablero[1] = 'O') and (tablero[2] = 'O') and (tablero[3] = 'O')) or
        ((tablero[4] = 'O') and (tablero[5] = 'O') and (tablero[6] = 'O')) or
        ((tablero[7] = 'O') and (tablero[8] = 'O') and (tablero[9] = 'O')) then
        begin
             ganador := 'O';
             juegoTerminado := true;
        end;
     {* ganador vertical X *}
     if ((tablero[1] = 'X') and (tablero[4] = 'X') and (tablero[7] = 'X')) or
        ((tablero[2] = 'X') and (tablero[5] = 'X') and (tablero[8] = 'X')) or
        ((tablero[3] = 'X') and (tablero[6] = 'X') and (tablero[9] = 'X')) then
        begin
             ganador := 'X';
             juegoTerminado := true;
        end;
     {* ganador vertical O *}
     if ((tablero[1] = 'O') and (tablero[4] = 'O') and (tablero[7] = 'O')) or
        ((tablero[2] = 'O') and (tablero[5] = 'O') and (tablero[8] = 'O')) or
        ((tablero[3] = 'O') and (tablero[6] = 'O') and (tablero[9] = 'O')) then
        begin
             ganador := 'O';
             juegoTerminado := true;
        end;
     {* ganador diagonal X *}
     if ((tablero[1] = 'X') and (tablero[5] = 'X') and (tablero[9] = 'X')) or
        ((tablero[3] = 'X') and (tablero[5] = 'X') and (tablero[7] = 'X')) then
        begin
             ganador := 'X';
             juegoTerminado := true;
        end;
     {* ganador diagonal O *}
     if ((tablero[1] = 'O') and (tablero[5] = 'O') and (tablero[9] = 'O')) or
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
         nombreJugador := jugador[2];
     end;
     writeln('');
     writeln('Es el turno de ', nombreJugador, ' ', ficha);
     write('Ingrese numero de celda a jugar ');
     read(celda);
     if (celda >= 1) and (celda <= 9) then
     begin
          if (tablero[celda] = 'X') or (tablero[celda] = 'O') then
          begin
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
          msgError('Ingrese numero correcto');
     end;
     matriz();
     varGanador := ganador();
     if (varGanador = 'X') or (varGanador = 'O') then
        write('el ganador es ', nombreJugador);
     if (varGanador <> 'X') and (varGanador <> 'O') and(contJugadas > 8) then
     begin
        juegoTerminado := true;
        write('Juego terminado, hubo empate');
     end;
end;

procedure iniciar();
begin
     juegaX := true;
     initMatriz();
     for i:= 1 to 2 do
     begin
          write('Ingrese nombre de jugador ', i,': ');
          readln(jugador[i]);
     end;
     matriz();
     contJugadas := 0;
end;

begin
iniciar();
repeat
      dibujaTablero();
until juegoTerminado = true;
readkey;

end.
