Program main;
Uses Tipos;

Procedure controlDeVentas(Var stock:archTProd);

Var 
  n,i: byte;
  prodActual,ventaActual,prodCentinela: tProducts;
  newMaster:vecTProd;
  ventas: archTProd;
Begin
  assign(stock, 'Stock.dat');
  reset(stock);
  assign(ventas, 'Ventas.dat');
  reset(ventas);
  prodCentinela.idProd := 'ZZZ99';
  n:=0;
  read(stock,prodActual);
  read(ventas,ventaActual);
  While ((prodActual.idProd<>centinela) OR (ventaActual.idProd<>centinela)) Do
  Begin
      If (prodActual.idProd = ventaActual.idProd) Then
        Begin
          n:=n+1;
          newMaster[n].idProd:= prodActual.idProd;
          newMaster[n].nombre:= prodActual.nombre;
          if prodActual.cantprod>=ventaActual.cantprod then
            newMaster[n].cantprod := prodActual.cantprod - ventaActual.cantprod
          else
            newMaster[n].cantprod := 0;
          read(stock, prodActual);
          read(ventas, ventaActual);
        End
      else
        begin
          if prodActual.idProd < ventaActual.idProd then
          begin
            n:=n+1;
            newMaster[n].idProd:= prodActual.idProd;
            newMaster[n].nombre:= prodActual.nombre;
            newMaster[n].cantprod := prodActual.cantprod;
            read(stock,prodActual);
          end
          else
            begin
             writeln('Se marco de forma erronea el la venta del producto ',ventaActual.idProd,' pues este no existe en el stock');
             read(ventas,ventaActual);
            end;
        end;
  End;
  Close(ventas);
  rewrite(stock);
  for i:=1 to n do
    write(stock,newMaster[i]);
  write(stock,prodCentinela);
  Close(stock);
  writeln();
End;
Procedure generarListaCompras2(Var compras:archTCompras);
var
  minimos:      archTMins;
  stock:        archTProd;
  minActual:    tMinimos;
  prodActual:   tProducts;
  compraActual: tCompras;
begin
  assign(stock,'Stock.dat');  assign(minimos,'Minimos.dat');  assign(compras,'Compras.dat');
  reset(stock);               reset(minimos);                 reWrite(compras);
  read(stock,prodActual);
  read(minimos,minActual);
  while(prodActual.idProd<>centinela)do
  begin
    if(prodActual.idProd=minActual.idProd)then
      begin
        compraActual.idProd:=prodActual.idProd;
        if prodActual.cantProd<minActual.cantMin then
          begin
            if prodActual.cantProd<minActual.cantCrit then
              begin
                compraActual.prioridad:=1;
                compraActual.cantProd:=minActual.cantHolgura-prodActual.cantProd;
                write(compras,compraActual);
                compraActual.prioridad:=2;
                compraActual.cantProd:=minActual.cantMax-minActual.cantHolgura;
                write(compras,compraActual);
              end
            else
              begin
                compraActual.prioridad:=2;
                compraActual.cantProd:=minActual.cantMax-prodActual.cantProd;
                write(compras,compraActual);
              end;
          end;
        read(stock,prodActual);
        read(minimos,minActual);
      end
    else
    begin
      if(prodActual.idProd>minActual.idProd)then
        begin
          writeln('Existe un producto de id: ',minActual.idProd,' en el archivo de reservas el cual se descontinuo del stock. Elimine el campo erroneo');
          read(minimos,minActual);
        end
      else
        begin
          writeln('EL producto ',prodActual.idProd,' no tiene valores asignados en el archivo de reservas. Agrege los valores que le corresponden');
          read(stock,prodActual);
        end;
    end;
  end;
  writeln();
  close(stock); close(minimos);
  compraActual.idProd:='ZZZ99';{carga del registro centinela}
  write(compras,compraActual);
  close(compras);
end;
Procedure resumenProveedoresOptimos();
var
  compras: archTCompras;
  proveedores: archTProv;
  compraActual,compraSiguiente: tCompras;
  provActual,provElegido: tProveedores;
  posProv:longInt;
  errores:tVecId;
  cantErrores,i:byte;
begin
  assign(compras,'Compras.dat'); assign(proveedores,'Proveedores.dat');
  reset(compras);
  reset(proveedores);
  cantErrores:=0;

  read(compras,compraActual);
  read(proveedores,provElegido);
  if provElegido.idProd = centinela then
    writeln('No hay proveedores disponibles')
  else
  begin
    writeln(' PRODUCTO | PROVEEDOR   | CANTIDAD | TARDANZA |   PRECIO   |');
    while(compraActual.idProd<>centinela)do
    begin
      if(compraActual.idProd = provElegido.idProd)then
        begin
          read(compras,compraSiguiente);{lectura de la proxima compra en caso de compras fragmentadas}
          if(compraActual.idProd=compraSiguiente.idProd)then
            posProv:=FilePos(proveedores);{guardado de la posicion del primer proveedor para el producto para volver a comprar con el siguiente fragmento de la compra}
          read(proveedores,provActual);
          while provElegido.idProd=provActual.idProd do
          begin
            if compraActual.prioridad=1 then
              begin
                if (provElegido.tardanza>provActual.tardanza) OR ((provElegido.tardanza=provActual.tardanza) AND (provElegido.precio>provActual.precio))then
                  provElegido:=provActual;
                read(proveedores,provActual);
              end
            else
              begin
               if(provElegido.precio>provActual.precio)then
                provElegido:=provActual;
               read(proveedores,provActual);
              end;
          end;
          writeln(compraActual.idProd:8,'  | ',provElegido.nombreProv,' | ',compraActual.cantProd:8,' | ',provElegido.tardanza:3,' dias | ',(provElegido.precio*compraActual.cantProd):11:2,'|');
          if(compraActual.idProd=compraSiguiente.idProd)then
            seek(proveedores,posProv);{posicionado en el primer proveedor para el producto fraccionado}
          compraActual:=compraSiguiente;
        end
      else
        if provElegido.idProd>compraActual.idProd then
          begin
            cantErrores+=1;
            errores[cantErrores]:=compraActual.idProd;
            read(compras,compraActual);

          end
        else
          read(proveedores,provElegido);
    end;
  end;
  close(proveedores);
  close(compras);
  writeln();
  for i:=1 to cantErrores do
    writeln('El producto ',errores[i],' no tiene proveedor que lo suministre');
end;

Var
  stock: archTProd;
  compras: archTCompras;
Begin
  cargarArchivos;
  Writeln('-----------------ERRORES------------------------------------------');
  controlDeVentas(stock);
  generarListaCompras2(compras);
  writeln('-----------------------------------------------------------');
  resumenProveedoresOptimos();
  readln();
End.
