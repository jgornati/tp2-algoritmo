program codigoDeBarras;
uses crt;
var
   empresa, importe:Integer;
   continuar:char;

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

begin
clrscr;
randomize;

continuar:='y';

TextBackground(black);
textcolor(15);
writeln('____________________________________________________');
empresa:=ingresoInteger('Ingrese Codigo de la empresa: ', 1000);
while continuar <> 'n' do
begin
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
     write('escriba otro importe: ');
     Repeat until keypressed;
end;
End.
