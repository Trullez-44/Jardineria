# Jardineria

1. Select c.nombre_cliente, e.nombre, e.apellido1 FROM cliente c JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

2. SELECT DISTINCT c.nombre_cliente, e.nombre, e.apellido1 FROM cliente c JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas JOIN pago p ON p.codigo_cliente = c.codigo_cliente;
<!-- PUSE UN DISTINCT porque si no se pone el distinct, se mostrarían como tal los pagos realizados y por ende, se repetirian clientes que han hecho más de un pago, cosa que no se pide, el distinct es para mostrar el cliente y ya.-->

3. 