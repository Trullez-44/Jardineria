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

```

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
```SQL

```

12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
```SQL

```

13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
```SQL

```

14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
```SQL

```

15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
```SQL

```

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
```SQL

```
