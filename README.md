# Jardineria
## 1.4.5 CONSULTAS MULTITABLA (INNER JOIN)
RESULVA TODAS LAS CONSULTAS UTILIZANDO LAS SINTAXIS DE SQL1 Y SQL2. LAS CONSULTAS CON SINTAXIS DE SQL2 SE DEBEN RESOLVER CON INNER JOIN Y NATURAL JOIN.
1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
```SQL
 Select c.nombre_cliente, e.nombre, e.apellido1 
 FROM cliente c 
 JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas;
```

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
```SQL
SELECT DISTINCT c.codigo_cliente, c.nombre_cliente, e.nombre FROM cliente c
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN pago p ON p.codigo_cliente = c.codigo_cliente;
```

`Puse DISTINCT porque si no se pone el distinct, se mostrarían como tal los pagos realizados y por ende, se repetirian clientes que han hecho más de un pago, cosa que no se pide, el distinct es para mostrar el cliente y ya.`
3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
```SQL
    SELECT DISTINCT c.nombre_cliente, e.nombre, e.codigo_empleado
    FROM cliente c
    JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    WHERE c.codigo_cliente NOT IN (select p.codigo_cliente from pago p);
```

4.Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la
oficina a la que pertenece el representante.

```SQL
SELECT DISTINCT c.codigo_cliente, c.nombre_cliente, e.nombre, f.ciudad;
FROM empleado e
JOIN cliente c ON  e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN oficina f ON e.codigo_oficina = f.codigo_oficina
WHERE c.codigo_cliente IN (select p.codigo_cliente from pago p)
ORDER BY codigo_cliente ASC;
```
 
5.  Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de
la oficina a la que el representante.
```SQL
SELECT DISTINCT c.codigo_cliente, c.nombre_cliente, e.nombre, f.ciudad
FROM empleado e
JOIN cliente c ON  e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN oficina f ON e.codigo_oficina = f.codigo_oficina
WHERE c.codigo_cliente NOT IN (select p.codigo_cliente from pago p)
ORDER BY codigo_cliente ASC;
```

6.Lista la dirección de las oficinas que tengan clientes en Fuenlabrada .
```SQL
 SELECT DISTINCT concat(f.linea_direccion1,' ',linea_direccion2) as DIRECCIÓN_OFICINA
FROM empleado e
join oficina f on e.codigo_oficina = f.codigo_oficina
WHERE e.codigo_empleado in (select c.codigo_empleado_rep_ventas from cliente c Where c.ciudad = 'Fuenlabrada');
```

7.Devuelve el nombre de los clientes y el nombre de sus representantes junto con la Ciudad de la oficina a la que pertenece
el representante.

```SQL
 SELECT c.nombre_cliente, e.nombre AS NOMBRE_EMPLEADO, f.ciudad
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina f ON e.codigo_oficina = f.codigo_oficina
ORDER BY c.nombre_cliente ASC;
```

8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
```SQL
SELECT e.nombre,e.codigo_jefe, sj.nombre, sj.codigo_empleado FROM empleado e
JOIN empleado sj ON e.codigo_jefe = sj.codigo_empleado;
```

9.Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
```SQL
SELECT e.nombre,e.codigo_jefe, sj.nombre,sj.codigo_empleado, sj.codigo_jefe,  j.nombre, j.codigo_empleado FROM empleado e
JOIN empleado sj ON e.codigo_jefe = sj.codigo_empleado
JOIN empleado j ON sj.codigo_jefe = j.codigo_empleado;
```

10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
```SQL
select c.nombre_cliente from pedido p
join cliente c ON p.codigo_cliente = c.codigo_cliente
WHERE DATE(fecha_esperada) < DATE(fecha_entrega)
ORDER BY c.nombre_cliente ASC;
```

11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
```SQL
SELECT c.codigo_cliente, c.nombre_cliente,  GROUP_CONCAT( DISTINCT gp.gama) AS Gamas_Compradas
FROM detalle_pedido dp
JOIN pedido p ON dp.codigo_pedido = p.codigo_pedido
JOIN cliente c ON p.codigo_cliente = c.codigo_cliente
JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
JOIN gama_producto gp ON pr.gama = gp.gama
GROUP BY c.codigo_cliente
ORDER BY c.nombre_cliente;
```

## 1.4.6 CONSULTAS MULTITABLE (COMPOSICIÒN EXTERNA)

Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.
1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
```SQL
SELECT c.* 
    FROM cliente c
    left JOIN pago p ON c.codigo_cliente = p.codigo_cliente
    WHERE p.codigo_cliente is NULL;

```

2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
```SQL
SELECT C.*
FROM cliente C
LEFT JOIN pedido P ON C.cliente = P.pedido
WHERE P.pedido is NULL;
```


3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
```SQL
SELECT * 
FROM cliente c
left JOIN pago pg ON c.codigo_cliente = pg.codigo_cliente
left JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
WHERE pd.codigo_cliente is NULL and pg.codigo_cliente is NULL;
```

4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
```SQL
SELECT e.*
FROM empleado e
LEFT JOIN oficina f ON e.codigo_oficina = f.codigo_oficina
WHERE e.codigo_oficina is NULL;
```

5.  Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
```SQL
SELECT e.*, c.codigo_cliente
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas is NULL;
```

6.  Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
```SQL
SELECT e.*, f.*
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN oficina f ON e.codigo_oficina = f.codigo_oficina
WHERE c.codigo_empleado_rep_ventas is NULL
ORDER BY codigo_empleado ASC;

```

7.  Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
```SQL
SELECT e.*, f.*
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN oficina f ON e.codigo_oficina = f.codigo_oficina
WHERE c.codigo_empleado_rep_ventas is NULL and e.codigo_oficina is NULL
ORDER BY codigo_empleado ASC;
```

8.  Devuelve un listado de los productos que nunca han aparecido en un pedido.
```SQL
SELECT distinct p.codigo_producto, p.nombre, p.gama, p.cantidad_en_stock FROM producto p
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto is NULL;
```

9.  Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.
```SQL
SELECT DISTINCT p.nombre, p.descripcion, gp.imagen
FROM producto p
JOIN gama_producto gp ON p.gama = gp.gama
LEFT join detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto is NULL;


```

10.  Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
```SQL
SELECT distinct f.*
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
JOIN gama_producto gp ON pr.gama = gp.gama
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
RIGHT JOIN oficina f ON e.codigo_oficina = f.codigo_oficina
WHERE gp.gama != 'Frutales';
```

11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
```SQL
SELECT DISTINCT c.*
FROM cliente c
JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente is NULL;
```
###### Diferentes formas, a lo mejor la primera puede tener posibles ocurrencias.
```SQL
SELECT DISTINCT c.*
FROM cliente c
LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente is NULL and pd.codigo_cliente IS NOT NULL;
```

12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
```SQL
SELECT e.*, j.nombre FROM empleado e
LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas is NULL;
```
## CONSULTAS TABLAS INDIVIDUALES

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
```SQL
    SELECT f.codigo_oficina, f.ciudad FROM oficina f;
```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
```SQL
    SELECT f.ciudad, f.telefono FROM oficina f WHERE f.pais = 'Espa├▒a' or f.codigo_oficina LIKE '%ES';
```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
```SQL
    SELECT e.nombre, CONCAT(e.apellido1, ' ',e.apellido2) AS apellidos, e.email, j.nombre as Jefe, j.codigo_empleado as codigo_del_jefe
    FROM empleado e
    JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
    WHERE e.codigo_jefe >= 7;
/* EL JOIN ES OPCIONAL, ES SOLO PARA MOSTRAR CUÁL ES EL JEFE Y SU CODIGO COMO EMPLEADO */
```

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
```SQL
    SELECT e.puesto, e.nombre, CONCAT(e.apellido1, ' ',e.apellido2) AS apellidos, e.email
    FROM empleado e
    WHERE e.codigo_empleado = 1 OR e.puesto = 'Director General';
```

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
```SQL
    SELECT  e.nombre, CONCAT(e.apellido1, ' ',e.apellido2) AS apellidos, e.puesto
    FROM empleado e
    WHERE e.puesto != 'Representante Ventas';
```
6. Devuelve un listado con el nombre de los todos los clientes españoles.
```SQL
SELECT c.*
FROM cliente c
WHERE c.pais = 'Spain';
```

7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
```SQL
    SELECT DISTINCT p.estado
    FROM pedido p;
```

8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

- Utilizando la función YEAR de MySQL.
```SQL
    SELECT DISTINCT p.codigo_cliente
    FROM pago p
    WHERE YEAR(p.fecha_pago) = '2008';
```
- Utilizando la función DATE_FORMAT de MySQL.
```SQL
    SELECT DISTINCT p.codigo_cliente
    FROM pago p
    WHERE DATE_FORMAT(p.fecha_pago, '%Y') = '2008';
```
- Sin utilizar ninguna de las funciones anteriores.
```SQL
    SELECT DISTINCT p.codigo_cliente
    FROM pago p
    WHERE p.fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';
```

9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
```SQL
    SELECT p.codigo_pedido, p.codigo_cliente, p.fecha_esperada, p.fecha_entrega
    FROM pedido p
    WHERE p.fecha_esperada< p.fecha_entrega;
```
10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

- Utilizando la función ADDDATE de MySQL.
```SQL
    SELECT
        codigo_pedido,
        codigo_cliente,
        fecha_esperada,
        fecha_entrega
    FROM
        pedido
    WHERE
        fecha_entrega <= ADDDATE(fecha_esperada, -2 );
```
- Utilizando la función DATEDIFF de MySQL.
```SQL
    SELECT
        codigo_pedido,
        codigo_cliente, 
        fecha_esperada,
        fecha_entrega
    FROM
        pedido
    WHERE
        DATEDIFF(fecha_entrega, fecha_esperada) <= -2;
```
- ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta - ?
```SQL
    SELECT
        codigo_pedido,
        codigo_cliente,
        fecha_esperada,
        fecha_entrega
    FROM
        pedido p
    WHERE  p.fecha_entrega - p.fecha_esperada  <= -2;
```

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
```SQL
        SELECT * FROM pedido p
        WHERE p.estado = 'Rechazado' and YEAR(p.fecha_entrega) = '2009';
```

12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
```SQL
    SELECT * FROM pedido p
    WHERE MONTH(p.fecha_entrega) = '01';
```

13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
```SQL
    SELECT * FROM pago p
    WHERE p.forma_pago = 'PayPal'
    ORDER BY p.codigo_cliente ASC;
```

14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
```SQL
    SELECT DISTINCT p.forma_pago FROM pago p
```

15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
```SQL
    SELECT DISTINCT * FROM  producto p
    WHERE p.gama = 'Ornamentales' and p.cantidad_en_stock >= 100
    ORDER BY p.precio_venta DESC;
```

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
```SQL
    SELECT DISTINCT * FROM  cliente c
    WHERE c.ciudad = 'Madrid' AND (c.codigo_empleado_rep_ventas = 11 OR c.codigo_empleado_rep_ventas = 30);
```
## 1.4.8 Subconsultas

### 1.4.8.1 Con operadores básicos de comparación

1. Devuelve el nombre del cliente con mayor límite de crédito.
```SQL
select c.codigo_cliente, c.nombre_cliente, c.limite_credito
from cliente c
WHERE c.limite_credito = (select limite_credito from cliente order by limite_credito DESC LIMIT 1);
```
2. Devuelve el nombre del producto que tenga el precio de venta más caro.
```SQL
select p.nombre, p.precio_venta
from producto p
WHERE p.precio_venta = (select MAX(p.precio_venta) from producto p);
```
3. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla `detalle_pedido`).
```SQL
SELECT p.nombre, p.codigo_producto
FROM producto p
WHERE p.codigo_producto = (select codigo_producto from detalle_pedido group by codigo_producto order by sum(cantidad) desc limit 1);
```
4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar `INNER JOIN`).
```SQL
SELECT * FROM cliente c WHERE c.limite_credito >= (SELECT sum(total) FROM pago WHERE codigo_cliente = cliente.codigo_cliente GROUP BY codigo_cliente);
```
5. Devuelve el producto que más unidades tiene en stock.
```SQL
SELECT p.codigo_producto, p.nombre, p.cantidad_en_stock
FROM producto p
WHERE p.cantidad_en_stock = (select max(cantidad_en_stock) from producto);
```
6. Devuelve el producto que menos unidades tiene en stock.
```SQL
SELECT p.codigo_producto, p.nombre, p.cantidad_en_stock
FROM producto p
WHERE p.cantidad_en_stock = (select min(cantidad_en_stock) from producto);
```
7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de **Alberto Soria**.
```SQL
select e.nombre, e.apellido1, e.email
from empleado e
WHERE e.codigo_jefe = (select codigo_empleado from empleado where empleado.nombre = 'Alberto' AND empleado.apellido1 = 'Soria');
```

### 1.4.8.2 Subconsultas con ALL y ANY

1. Devuelve el nombre del cliente con mayor límite de crédito.
```SQL
SELECT c.nombre_cliente
FROM cliente c
WHERE c.limite_credito >= ALL(SELECT c.limite_credito FROM cliente c);
```
2. Devuelve el nombre del producto que tenga el precio de venta más caro.
```SQL
SELECT p,nombre, p.precio_venta 
FROM producto p 
WHERE precio_venta >= ALL(SELECT precio_venta FROM producto);
```
3. Devuelve el producto que menos unidades tiene en stock.
```SQL
SELECT * 
FROM producto p
WHERE cantidad_en_stock <= ALL(SELECT cantidad_en_stock FROM producto);
```

### 1.4.8.3 Subconsultas con IN y NOT IN

1. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
```SQL
SELECT e.nombre as nombre, e.apellido1 as apellido1, e.puesto as cargo
FROM empleado e
WHERE e.codigo_empleado NOT IN (SELECT c.codigo_empleado_rep_ventas FROM cliente c);
```
2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
```SQL
SELECT c.* 
FROM cliente c 
WHERE c.codigo_cliente NOT IN (
    SELECT p.codigo_cliente FROM pago p
);

```
3. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
```SQL
SELECT c.* 
FROM cliente c 
WHERE c.codigo_cliente IN (
SELECT p.codigo_cliente FROM pago p
);
```
4. Devuelve un listado de los productos que nunca han aparecido en un pedido.
```SQL
SELECT pr.* 
FROM producto pr
WHERE pr.codigo_producto NOT IN (
SELECT d.codigo_producto
FROM detalle_pedido d
);
```
5. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
```SQL
SELECT e.nombre as nombre, e.apellido1 as apellido1, e.apellido2 as apellido2, e.puesto as puesto, f.telefono as telefono
FROM empleado e
JOIN oficina f ON e.codigo_oficina = f.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);
```
6. Devuelve las oficinas donde **no trabajan** ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama `Frutales`.
```SQL
SELECT * 
FROM oficina
```
7. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
```SQL
SELECT c.*
FROM cliente c
WHERE c.codigo_cliente IN (
    SELECT p.codigo_cliente FROM pedido p
)
AND c.codigo_cliente NOT IN (
    SELECT p.codigo_cliente FROM pago p
);
```

### 1.4.8.4 Subconsultas con EXISTS y NOT EXISTS

1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
```SQL
SELECT *
FROM cliente c
WHERE NOT EXISTS (select 1 from pago p WHERE p.codigo_cliente = c.codigo_cliente);
```
2. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
```SQL
SELECT *
FROM cliente c
WHERE EXISTS (select 1 from pago p WHERE p.codigo_cliente = c.codigo_cliente);
```
3. Devuelve un listado de los productos que nunca han aparecido en un pedido.
```SQL
    SELECT DISTINCT p.* 
    FROM producto p
    WHERE NOT EXISTS (SELECT * FROM detalle_pedido dp WHERE dp.codigo_producto = p.codigo_producto);
```
4. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
```SQL
    SELECT DISTINCT p.* 
    FROM producto p
    WHERE EXISTS (SELECT * FROM detalle_pedido dp WHERE dp.codigo_producto = p.codigo_producto);
```