# Jardineria

1. Select c.nombre_cliente, e.nombre, e.apellido1 FROM cliente c JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

2. SELECT DISTINCT c.codigo_cliente, c.nombre_cliente, e.nombre FROM cliente c
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN pago p ON p.codigo_cliente = c.codigo_cliente; <!-- PUSE UN DISTINCT porque si no se pone el distinct, se mostrarían como tal los pagos realizados y por ende, se repetirian clientes que han hecho más de un pago, cosa que no se pide, el distinct es para mostrar el cliente y ya.-->

3. SELECT DISTINCT c.*, e.nombre, e.codigo_empleado
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.codigo_cliente NOT IN (select p.codigo_cliente from pago p);

4. SELECT DISTINCT c.codigo_cliente, c.nombre_cliente, e.nombre, f.ciudad
FROM empleado e
JOIN cliente c ON  e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN oficina f ON e.codigo_oficina = f.codigo_oficina
WHERE c.codigo_cliente IN (select p.codigo_cliente from pago p)
ORDER BY codigo_cliente ASC;
5. SELECT DISTINCT c.codigo_cliente, c.nombre_cliente, e.nombre, f.ciudad
FROM empleado e
JOIN cliente c ON  e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN oficina f ON e.codigo_oficina = f.codigo_oficina
WHERE c.codigo_cliente NOT IN (select p.codigo_cliente from pago p)
ORDER BY codigo_cliente ASC;
6. SELECT DISTINCT concat(f.linea_direccion1,' ',linea_direccion2) as DIRECCIÓN_OFICINA
FROM empleado e
join oficina f on e.codigo_oficina = f.codigo_oficina
WHERE e.codigo_empleado in (select c.codigo_empleado_rep_ventas from cliente c Where c.ciudad = 'Fuenlabrada');
7. SELECT c.nombre_cliente, e.nombre AS NOMBRE_EMPLEADO, f.ciudad
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina f ON e.codigo_oficina = f.codigo_oficina
ORDER BY c.nombre_cliente ASC;
8. SELECT e.nombre,e.codigo_jefe, sj.nombre, sj.codigo_empleado FROM empleado e
JOIN empleado sj ON e.codigo_jefe = sj.codigo_empleado;
9. SELECT e.nombre,e.codigo_jefe, sj.nombre,sj.codigo_empleado, sj.codigo_jefe,  j.nombre, j.codigo_empleado FROM empleado e
JOIN empleado sj ON e.codigo_jefe = sj.codigo_empleado
JOIN empleado j ON sj.codigo_jefe = j.codigo_empleado;
10. select c.nombre_cliente from pedido p
join cliente c ON p.codigo_cliente = c.codigo_cliente
WHERE DATE(fecha_esperada) < DATE(fecha_entrega)
ORDER BY c.nombre_cliente ASC;
11. 



1.4.6 Consultas multitabla (Composición externa)

Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.

    Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

    Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

    Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.

    Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

    Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

    Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.

    Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

    Devuelve un listado de los productos que nunca han aparecido en un pedido.

    Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.

    Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.

    Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

    Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.