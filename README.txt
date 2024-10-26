program project1;

uses Tipos;

var
  stock,ventas: archTProd;
  ProdACtual,ventaActual: tProducts;
begin
 assign(stock, 'stock.dat');
 reset(stock);

 assign(ventas, 'ventas.dat');
 reset(ventas);

 while not oef(stock) or eof(ventas) do
  begin
   read(stock, ProdACtual.idProd, ProdACtual.nombre, ProdACtual.cantprod);
   read(ventas, ventaActual.idProd, ventaActual.nombre, ventaActual.cantprod);

   if ProdACtual.idProd = ventaActual.idProd then
    begin
     ProdACtual.cantprod -= ventaActual.cantprod;
     write(stock, prodACtual);
     read(stock, prodACtual);
     read(ventas, ventaActual);
     end
    else if ProdACtual.idProd > ventaActual.cantprod then
     read(ventas, ventaActual)
    else
     begin
      //revisar manejo excepcion F: venta de algo que no se tiene
      read(ventas, ventaActual);

     end;

  end;
end.