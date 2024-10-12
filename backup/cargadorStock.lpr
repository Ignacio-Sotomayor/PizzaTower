
Program cargadorStock;

Uses Tipos;

Type 
  archTip =   FILE Of tProducts;

Var 
  input:   text;
  actual:   tProducts;
  ouput:   archTip;
Begin
  Assign(input,'Stock.txt');
  Assign(output,'Stock.dat');
  Reset(input);
  Rewrite(output);
  While Not EOf(input) Do
    Begin
      With actual Do
        ReadLn(input,idProd,' ',nombre,' ',cantProd);
      Write(output,actual);
    End;

End.
