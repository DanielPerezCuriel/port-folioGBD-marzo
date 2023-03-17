--Practica 17--
--1  Mostrar el número de almacén y el tipo y modelo de las piezas cuya cantidad en la tabla de existencias esté entre 2000 y 3000 unidades almacén--
select N_ALMACEN,TIPO,MODELO,CANTIDAD
from EXISTENCIAS
where CANTIDAD between 2000 and 3000
;
-- 2  Mostrar el tipo y modelo de cada pieza, el precio al que la vendemos, el número de cada almacén en los que las tenemos y la cantidad en cada almacén--
select TIPO,MODELO,PRECIO_VENTA,N_ALMACEN,CANTIDAD
from EXISTENCIAS e
join PIEZAS p using (tipo,modelo);
--3  Mostrar el nombre de cada empresa, la localidad en la que está, el tipo, modelo de las piezas que vende y el precio al que lo hace--
select NOMBRE,LOCALIDAD,TIPO,MODELO,PRECIO_COMPRA
from SUMINISTROS s
join EMPRESAS e using (cif);
--4 ] De la consulta anterior mostrar sólo aquellas piezas y proveedores que nos venden a un precio mayor al que nosotros vendemos a los clientes (sólo hay una pieza de un proveedor que nos vende más caro que al precio al que vendemos nosotros)--
select NOMBRE,LOCALIDAD,TIPO,MODELO,PRECIO_COMPRA
from SUMINISTROS s
join EMPRESAS e using (cif)
join PIEZAS using (tipo,modelo)
where PRECIO_COMPRA>precio_venta;
--Preguntar 5 Mostrar el número de cada pedido, el nombre de la empresa al que se refiere el pedido y la fecha del mismo mostrando la fecha en este formato, ejemplo: Jueves 10 de Marzo del año 2022--
select N_PEDIDO,nombre,to_char(FECHA,'Daydd|de|Month|del año|yyyy')
from PEDIDOS p
join EMPRESAS e using (cif);
--Preguntar 6 Realizar la misma consulta mostrando la fecha en el formato:Trimestre 1 jue 10#3#2022--
select N_PEDIDO,nombre,to_char(FECHA,'DayddMonthyyyy')
from PEDIDOS p
join EMPRESAS e using (cif);
--7 Mostrar el nombre de las empresas y el número de teléfono de las empresas cuyo número de teléfono termine por 1,3,5 ó 6--
select nombre,TELEFONO
from EMPRESAS
where TELEFONO like '%1'
   or TELEFONO like '%3'
   or TELEFONO like '%5'
   or TELEFONO like '%6';
--8 Mostrar el nombre de la empresas y el número de teléfono de las empresas cuya tercera cifra en el teléfono sea par--
select nombre,TELEFONO from EMPRESAS where TELEFONO like '%%2%'
--9 Mostrar el nombre de las provincias en las que hay empresas. Cada provincia debe aparecer una sola vez (y solo de aquellas en las que sí hay empresas)--
select distinct PROVINCIA from EMPRESAS where nombre is not null;
--10Mostrar el tipo y modelo de cada pieza y después el precio de venta y el precio de venta con IVA (IVA al 21%). Los precios deben aparecer sólo con 3 decimales. Primeras filas:--
select TIPO,MODELO,
       to_char(PRECIO_VENTA,'9G990D000L'),
       to_char(PRECIO_VENTA+(PRECIO_VENTA*0.21),'9G990D000L')
from PIEZAS;
--11  Mostrar la descripción de cada almacén, la cantidad, tipo, modelo, precio de venta de cada pieza en cada almacén y el número de almacén, pero sabiendo que hay tres almacenes, mostrar el número como texto: sería “Primer almacén”, “Segundo almacén” y “Tercer almacén”. Ordenar por número de almacén, tipo y modelo de pieza--
select a.DESCRIPCION,CANTIDAD,TIPO,MODELO,p.PRECIO_VENTA,
       case N_ALMACEN
        when 1 then 'Primer Almacen'
        when 2 then 'Segundo Almacen'
        else 'Tercer almacen'
        end as numero_de_almacen
from ALMACENES a
join EXISTENCIAS e using (n_almacen)
join PIEZAS p using (tipo,modelo);
--12 Mostrar el nombre y teléfono de empresas con número de teléfono incorrecto (un teléfono es correcto si empieza por 6, 7 o 9 y además tiene nueve números en total--
select NOMBRE,TELEFONO from EMPRESAS
where not regexp_like(telefono,'^[679][0-9]{8}$');
--13 Mostrar el tipo y modelo de piezas que no tenemos en ningún almacén, aunque sí están en la tabla de piezas--
select TIPO,MODELO,CANTIDAD,N_ALMACEN
from EXISTENCIAS
right outer join PIEZAS using(tipo,modelo)
where N_ALMACEN is null ;
--14  Mostrar el tipo, modelo de todas las piezas y cada número de almacén en el que se guardan. Si no se guardan en ninguno indicarlo con el texto “No están en ningún almacén”. Ordena por tipo, modelo y n_almacen. Ejemplo de salida (primeras filas):--
select TIPO,MODELO,CANTIDAD,N_ALMACEN,
       case
           when N_ALMACEN=1 then 'Almacen 1'
           when N_ALMACEN is null then 'No estan en ningun almacen'
           when N_ALMACEN=2 then 'Almacen 2'
           else 'Almacen 3'
        end
from EXISTENCIAS
right outer join PIEZAS using(tipo,modelo);
--15  Mostrar el nombre de las empresas que están en la misma provincia. Resultadocompleto:--
select distinct e1.NOMBRE,e2.NOMBRE,e1.PROVINCIA,e2.PROVINCIA
from EMPRESAS e1
cross join EMPRESAS e2
where e1.PROVINCIA=e2.PROVINCIA;