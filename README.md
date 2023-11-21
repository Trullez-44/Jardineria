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

1.4.6 Consultas multitabla (Composición externa)

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
###### Diferentes formas, a lo mejor la primera puede tener ocurrencias pero no sabrìa cuales.
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
