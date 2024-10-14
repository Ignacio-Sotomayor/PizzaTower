
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
  tMinimos = Record
    idProd = string[5];
    nombre: string[11];
    cantMin = byte;
    cantCrit = byte;
  End;
  tCompras = Record
    idProd : string[5];
    cantProd : byte;
    prioridad : byte;
  End;

Implementation
End.
