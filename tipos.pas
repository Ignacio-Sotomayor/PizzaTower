
Unit Tipos;

Interface

Type 
  tProducts =   Record
    idProd:   string[5];
    nombre:   string[10];
    cantProd:   byte;
  End;
  tProveedores = Record
    idProd:   string[5];
    nombre: string[11];
    precio: Word;
    tardanza: byte;
  End;


Implementation
End.
