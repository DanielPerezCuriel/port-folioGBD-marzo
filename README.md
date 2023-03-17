# Port-folioGBD-marzo
#### En este port folio trataremos acerca de los temarios dados durante la 2º evalucacion


### Resumen de los temas tratados.

·
##### Tema 6 Consultas basicas de SQL
- A lo largo de esta practica vamos a ver una serie de consultar que nos seran de gran utilidad ahora y en un futuro dado que son las consultas basicas que tendriamos que saber de memoria para un correcto funcionamiento de SQL mas adelante 
1. A lo largo de esta practica veremos cosas tan importantes como:
    - Funciones regulares --> Nos ayudaran a realizar consusltar mucho mas complejas logrando mejores consultas con expresiones como:
        - regexp_like : El cual es una version mucho mas completa de like
        - regexp_count : Nos servira para contar las veces que aparece una expresion como tildes y gracias a sus argumentos podremos establecer desde que posicion queremos que empieze a contar 
    - Operar con fechas--> Hacer calculos entre fechas y determinar el tiempo pasado entre un ambito de fechas , fecha del sistema, extraer horas ,ultimo dia del mes ,redondeos y truncamiento etc 
        - Extract ("loquequeremosextraer" from "de donde lo queremos extraer")
        - Least : obtiene la fecha mas antigua
        - Add_months ("donde queremos añadir el mes ","cantidad de meses que queremos añadir")
    - Cambiar el formato de los resultado de nuestra base de datos entre numeros fechas y tetox gracias a la utilidad de :
        - To_char :Convertir una fecha en texto aplicando el formato que nosotros deseamos o un numero al formato de texto que indiquemos 
        - To_number: Convierte el texto a numero siguiendo el formato que queramos y ademas puede convertir el texto a fecha y hora 
    - Uso de los nulos hemos aprendido la gran utilidad de los nulos y la importancia de nuestra sintaxis al escribir relacionado con espacios innecesarios 
        - NVL(donde queremos buscar el null, 'Lo que queremos que sustituya al null'): Si el valor nulo lo sustituira por lo siguiente a la coma 
        - NVL2 (Donde queremos buscar el null , 'si no hay null','si hay null'): Nos servira para si el valor el nulo lo sustituya por el valor de la segunda coma y en caso de tener valor sustituirlo por el valor de la primera coma 
    - Hemos aprendido ademas a realizar calculos mateticos y anidarlos entre ellos 
        - SUM:Para sumar valores 
        - AVG : Para obtener la media 
        - Min : Obtener el minimo ademas mas adelante aprendimos que nos servira como any
        - Max : Obtener el maximo ademas mas adelante aprendimos que nos servira como un all
``` sql
SELECT tipo,modelo, cantidad, SUM(Cantidad)
FROM existencias
GROUP BY tipo,modelo;
```
``` sql
SELECT NVL2(ESTADO,'hay valor','no hay valor')
FROM T_PEDIDOS;
```
``` sql
SELECT to_char(fecha,'Day "del" Month "del año" YYYY');
```

#### Tema 7 Consultar varias tablas 
- A lo largo de este tema hemos aprendido algo que tambien es imprescindible para la correcta utilizacion de SQL y es la combinacion de tablas y sus relaciones para obtener datos combinados de varias tablas 
    - Select datos que queremos con un punto si fuera necesaria para indicar de que tabla estamos hablando esto es debido a que dos columnas pueden tener el mismo nombre de esta manera indicaremos de que tabla hablamos 
    - Usaremos Join para una union normal de una tabla posteriormente usaremos using en caso de que la relacion utulizase la misma clase en caso contrario usaremos on 
    - Ademas tambien tenemos el natural join que relaciona datos de ambas tablas que tienen las misma clave de relacion nos repetira el mismo valor en ambas partes 
    - Tambien tendremos la posibilidad de usar el outer join acompañado de left o right de tal forma que dependiendo de la direccion que indiquemos left(tabla de la izquierda) o right (tabla de la derecha) seleccionaremos la tabla en dicha posicion mostrandonos las consultar aunque no tengan filas relacionadas 
    - Tendremos pa posibilidad de usar productos cruzados mediante el cross joint que nos combinara cada columna de la primera tabla con cada columna de la segunda tabla 
``` sql
SELECT * FROM piezas CROSS JOIN existencias;
```
``` sql
SELECT * FROM piezas
LEFT OUTER JOIN existencias
ON(piezas.tipo=existencias.tipo AND
piezas.modelo=existencias.modelo);
```
#### Reflexiones personales
1. Las partes mas positivas que he podido observar a lo largo de este segundo trimestre son:
   - Aprendizaje de las funciones regulares me parece uno de los temas mas importantes tratados a lo largo de la 2º Evalucion dado que nos permite realizar selecciones muchas mas complejas que anteriormente pudiendo ampliar nuestra gama ampliamente tanto en el apartado de cada columna a mostrar como los where o otras partes de la consulta
``` sql
SELECT tipo,modelo, cantidad, SUM(Cantidad)
FROM existencias
GROUP BY tipo,modelo;
```
   - Otro punto positivo de esta evaluacion a sido el tratado con calculos el cual tiene una amplia apliquibilidad a un monton de situaciones cotidianas en la mayoria realmente vivimos en un mundo controlado por numeros 
``` sql
SELECT tipo,modelo, cantidad, SUM(Cantidad)
FROM existencias
GROUP BY tipo,modelo;
```
2. Las partes negativas 
    - Una de las partes en mi oponion mas negativa es la de la utilizacion de los parametros de las funciones regulares como por ejemplo [:alpha:] que nos indica que seleccionaremos todos los valores alphanumericos o la ? por ejemplo para indicar un caracter a la izquierda o derecha de este simbolo o por ejemplo el $ para indicar que termina por dicha expresion 
    - Otro punto que me ha parecido dificultosos de esta evaliacion a sido el tema de las fechas que me costo bastante llegarlo a enter como funcionaba para dar los distintos formatos de las fechas como por ejemplo Day con la D mayuscula nos devolvera el dia con la primera letra mayuscula por ejemplo Lunes o que si en los años queremos que nos muestre las dos ultimas cifras unicamente usaremos YY de tal forma que este año por ejeplo seria el 23
        - Lo que mas me costo de las fechas fue la añicion de texto en medio de estas que por alguna razon se me olvidaban las dobles comillas de de dentro de la comilla simple de formato como por ejemplo 'Day "del mes" Month "del año" YY' que nos devolvera como resultado por ejemplo Lunes del mes Marzo del año 2023 
``` sql
SELECT to_char(fecha,'Day "del" Month "del año" YYYY');
```

#### Ejercicios Significativos 
1. Ejercicicio 2 de la practica de 18 greografia en el que se nos pide el nombre de cada provincia y ademas la capital de la misma al no usar la misma clave en la relacion usaremos on envede de using 
``` sql
SELECT p.nombre AS provincia, l.nombre AS capital
FROM PROVINCIAS p
JOIN LOCALIDADES l ON(p.id_capital=l.id_localidad)
```
2. Ejercicio 11 de la practica 18 de geografia en este ejercicio se nos pide motrar el nombre de cada localidad de Castilla y Leon y el nombre de su provincia , ordenada de la que mas poblacion tiene a la que menos usaremos el cross joint 
``` sql
SELECT c1.nombre comunidad1,c2.nombre comunidad2
FROM comunidades c1
CROSS JOIN comunidades c2
WHERE   LENGTH(c1.nombre)=LENGTH(c2.nombre) AND c1.id_comunidad>c2.id_comunidad;
```
3. Ejercicio 3 de la pracrica numero 19 en la que se nos pide añadir a la consulta anterior las personas que no tienen padre o madre en la base de datos podemos observar el uso de un left outer join afectandonos a la tabla de la izquierda seleccionaremos la tabla aqune u en dicha posicion mostrandonos las consultar aunque no tenga filas relacionadas 
``` sql
SELECT DISTINCT h.nombre "Nombre Persona",
       p.nombre "Nombre Padre",
       m.nombre "Nombre Madre"
FROM personas h
left OUTER JOIN personas p on(h.n_padre=p.n_persona)
LEFT OUTER JOIN personas m on(h.n_madre=m.n_persona);
```
4. Ejercicio 5 Practica 19 padres y madres Nombre de las madres que hayan tenido 2 hijas con el having conseguimos que tenga como minimo 2
``` sql
SELECT  m.nombre
FROM personas h
JOIN personas m ON(h.n_madre=m.n_persona)
AND h.sexo='M'
GROUP BY m.nombre
HAVING COUNT(*)=2;
```
5. Ejercicio 1 de la practica 22 sobre toros en la que se nos pide  
``` sql
SELECT  m.nombre
FROM personas h
JOIN personas m ON(h.n_madre=m.n_persona)
AND h.sexo='M'
GROUP BY m.nombre
HAVING COUNT(*)=2;
```
#### Ejercicios de inversion por creacion propia
1. Ejercicio Lupa : En el siguiente ejercicio se piden las personas con su nombre y apellidos que han sido despedidos entre el mes de Diciembre de 2022 y Enero de 2023 
``` sql
SELECT  p.nombre,p.apellido1,p.apellido2,c.fecha_fin
FROM personas p
JOIN contratos using (nif)
where fecha_fin between '01/12/2022' and '01/01/2023'
```
2. Media de los sueldos de los actores de españa con el sueldo mas bajo y ordenar por el sueldo mas bajo
``` sql
SELECT  SELECT a.nombre || ' ' || a.apellido1 || ' ' || a.apellido2 AS nombre_completo , n_actor , (select avg(min(s.sueldo))
from actores a 
join sueldos s using (n_actor)
order by sueldo asc 
```
## Conclusiones
A lo largo de esta trimestre hemos aprendido algo vital para las proximas consultar la mayor dificualtad es como comenter anteriormente parametros por que tenemos muchos y su sintaxis tiene que ser exactas. Lo que mas sencillo fue al final la combinacion de varias tablas con sus relaciones me parece que una vez entiendas el concepto no tendras ninguna duda por si simpleza aunque al principio complejo
