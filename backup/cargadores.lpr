
Program cargadores;

Uses tipos;

Type 
  archTProd =   FILE Of tProducts;
  archTProv = FILE Of tProveedores;
  archTMins = FILE Of tMinimos;
Procedure cargadorStock(Var output:archTProd);

Var 
  actual,centinela:   tProducts;
  input: text;
Begin
  Assign(input,'Stock.txt');
  Assign(output,'Stock.dat');
  Reset(input);
  Reset(output);
  centinela.idProd := 'ZZZ99';
  While Not EOf(input) Do
    Begin
      With actual Do
        ReadLn(input,idProd,' ',nombre,' ',cantProd);
      Write(output,actual);
    End;
  Write(output,centinela);
  Close(output);
  Close(input);
End;
Procedure cargadorVentas(Var output: archTProd);

Var 
  carga,actual,centinela:   tProducts;
  input: text;
Begin
  Assign(input,'Ventas.txt');
  Assign(output,'Ventas.dat');
  Reset(input);
  Reset(output);
  centinela.idProd := 'ZZZ99';
  Readln(input,carga.idProd,' ',carga.nombre,' ',carga.cantProd);
  While Not Eof(input) Do
    Begin
      ReadLn(input,actual.idProd,' ',actual.nombre,' ',actual.cantProd);
      If actual.idProd = carga.idProd Then
        carga.cantProd := carga.cantProd + actual.cantProd
      Else
        Begin
          write(output,carga);
          carga := actual;
        End;
    End;
  Write(output, carga);
  Write(output,centinela);
  Close(output);
  Close(input);

End;
Procedure cargadorProveedores(Var output:archTProv);

Var 
  actual,centinela: tProveedores;
  input: text;
Begin
  Assign(input,'Proveedores.txt');
  Assign(output,'Proveedores.dat');
  Reset(input);
  Reset(output);
  centinela.idProd :=  'ZZZ99';
  While Not EoF(input) Do
    Begin
      With actual Do
        Readln(input,idProd,' ',nombre,' ',precio,' ',tardanza);
      write(output,actual);
    End;
  write(output,centinela);
  close(output);
  close(input);
End;
Procedure cargardorMinOpertivo(Var output:archTMins);
Var 
  actual,centinela : tMinimos;
  input: Text;
Begin
  Assign(input,'Minimos.txt');
  Assign(input,'Minimos.dat');
  Reset(input);
  Reset(output);
  centinela.idProd := 'ZZZ99';
  While Not Eof(input) Do
    Begin
      Readln(input,actual.idProd,' ',actual.nombre,' ',actual.cantMin,' ',actual.cantCrit);
      write(output, actual);
    End;
  write(output, centinela);
  close(output);
  close(input);
End;

Var 
  stock,ventas:   archTProd;
  proveedores: archTProv;
Begin
  cargadorStock(stock);
  cargadorVentas(ventas);
  cargadorProveedores(proveedores);
End.
