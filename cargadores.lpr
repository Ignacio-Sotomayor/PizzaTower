
Program cargadores;

Uses Tipos;

Type 
  archTip =   FILE Of tProducts;
Procedure cargadorStock(Var output:archTip; Var input:text);

Var 
  actual,centinela:   tProducts;
Begin
  Assign(input,'Stock.txt');
  Assign(output,'Stock.dat');
  Reset(input);
  Reset(output);
  centinela.idProd := 'ZZZZZ';
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

Var 
  input:   text;
  stock:   archTip;
Begin
  cargadorStock(stock,input);

End.
