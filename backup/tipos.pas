
Unit Tipos;

Interface
  CONST
    centinela = 'ZZZ99';
  Type
    str5 = string[5];
    tVecId = Array [1..25] of str5;
    tProducts =   Record
      idProd:   str5;
      nombre:   string[10];
      cantProd:   byte;
    End;
    tProveedores = Record
      idProd:   str5;
      nombreProv: string[11];
      precio: real;
      tardanza: byte;
    End;
    tMinimos = Record
      idProd :      str5;
      cantCrit:     byte;
      cantMin:      byte;
      cantHolgura:  byte;
      cantMax:      byte;
    End;
    tCompras = Record
      idProd : str5;
      cantProd : byte;
      prioridad : byte;
    End;
    vecTProd = Array[1..30] of tProducts;
    archTProd =   FILE Of tProducts;
    archTProv = FILE Of tProveedores;
    archTMins = FILE Of tMinimos;
    archTCompras = FILE Of tCompras;
  Procedure mostrarStock();
  procedure mostrarVentas();
  Procedure mostrarProveedores();
  Procedure mostrarMinimos();
  Procedure MostrarCompras();
Implementation

Procedure mostrarStock();
var
  actual:tProducts;
  stock:archTProd;
begin
  assign(stock,'Stock.dat');
  reset(stock);
  read(stock,actual);
  while(actual.idProd<>'ZZZ99')do
    begin
      writeln(actual.idProd,' ', actual.nombre,' ',actual.cantProd);
      read(stock,actual);
    end;
  close(stock);
end;
Procedure mostrarVentas();
var
  actual:tProducts;
  ventas:archTProd;
begin
   assign(ventas,'Ventas.dat');
  reset(ventas);
  read(ventas,actual);
  while(actual.idProd<>'ZZZ99')do
    begin
      writeln(actual.idProd,' ', actual.nombre,' ',actual.cantProd);
      read(ventas,actual);
    end;
  close(ventas);
end;
Procedure mostrarProveedores();
var
  actual:tProveedores;
  proveedores:archTProv;
begin
  assign(proveedores,'Proveedores.dat');
  reset(proveedores);
  read(proveedores,actual);
  while(actual.idProd<>'ZZZ99')do
    begin
      writeln(actual.idProd,' ', actual.nombreProv,' ',actual.precio,' ',actual.tardanza);
      read(proveedores,actual);
    end;
   close(proveedores);
end;
Procedure mostrarMinimos();
var
  actual:tMinimos;
  reservas:archTMins;
begin
  assign(reservas,'Minimos.dat');
  reset(reservas);
  read(reservas,actual);
  while(actual.idProd<>'ZZZ99')do
    begin
      writeln(actual.idProd,' ',actual.cantCrit,' ',actual.cantMin);
      read(reservas,actual);
    end;
  close(reservas);
end;
Procedure mostrarCompras();
Var
  compras:archTCompras;
  actual:tCompras;
begin
  assign(compras,'Compras.dat');
  reset(compras);
  read(compras,actual);
  while(actual.idProd<>'ZZZ99')DO
    begin
      writeln(actual.idProd,' ',actual.cantProd,' ',actual.prioridad);
      read(compras,actual);
    end;
  close(compras);
end;

End.
