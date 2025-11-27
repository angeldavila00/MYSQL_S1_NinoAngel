
mysql> delimiter //
mysql> jekjwrhwekjrewbr;
    -> //
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'jekjwrhwekjrewbr' at line 1
mysql> create procedure mostrardetallecompra()
    -> begin
    -> seledfjdf 
    -> ^C
mysql> select * from detalle_compra;
    -> //
+----+-------------+----------+----------+-----------+
| id | producto_id | cantidad | subtotal | compra_id |
+----+-------------+----------+----------+-----------+
|  1 |           3 |        2 |    90000 |         1 |
|  2 |           1 |       10 |   150000 |         1 |
|  3 |           4 |        2 |    76000 |         2 |
|  4 |           5 |        5 |    60000 |         2 |
|  5 |           8 |       10 |    80000 |         3 |
|  6 |           2 |       20 |   100000 |         3 |
|  7 |           6 |        1 |   120000 |         4 |
|  8 |           7 |        1 |   160000 |         4 |
|  9 |          10 |        2 |    56000 |         5 |
| 10 |           9 |        3 |    66000 |         5 |
| 11 |           3 |        1 |    45000 |         6 |
| 12 |           1 |        5 |    75000 |         6 |
| 13 |           5 |        2 |    24000 |         7 |
| 14 |           2 |       10 |    50000 |         7 |
| 15 |           4 |        1 |    38000 |         8 |
| 16 |           8 |        5 |    60000 |         8 |
| 17 |           9 |        2 |    44000 |         9 |
| 18 |          10 |        1 |    28000 |         9 |
| 19 |           7 |        1 |   160000 |        10 |
| 20 |           6 |        1 |   120000 |        10 |
+----+-------------+----------+----------+-----------+
20 rows in set (0,00 sec)

mysql> describe producto_id
    -> //
ERROR 1146 (42S02): Table 'veterinaria.producto_id' doesn't exist
mysql> describe producto;//
+---------------+--------------+------+-----+---------+----------------+
| Field         | Type         | Null | Key | Default | Extra          |
+---------------+--------------+------+-----+---------+----------------+
| id            | int          | NO   | PRI | NULL    | auto_increment |
| nombre        | varchar(45)  | NO   |     | NULL    |                |
| descripcion   | varchar(150) | NO   |     | NULL    |                |
| precio_compra | double       | NO   |     | NULL    |                |
| stock         | int          | NO   |     | NULL    |                |
+---------------+--------------+------+-----+---------+----------------+
5 rows in set (0,00 sec)

mysql> delimiter ;
mysql> select c.id, p.nombre, c.cantidad, c.subtotal, c.compra_id from compra c left join producto p on c.producto_id=p.id;
ERROR 1054 (42S22): Unknown column 'c.cantidad' in 'field list'
mysql> select c.id, p.nombre, c.cantidad, c.subtotal, c.compra_id from detalle_compra c left join producto p on c.producto_id=p.id;
+----+--------------------------+----------+----------+-----------+
| id | nombre                   | cantidad | subtotal | compra_id |
+----+--------------------------+----------+----------+-----------+
|  1 | Concentrado Adulto 10kg  |        2 |    90000 |         1 |
|  2 | Vacuna Rabia             |       10 |   150000 |         1 |
|  3 | Concentrado Gato 5kg     |        2 |    76000 |         2 |
|  4 | Shampoo Antipulgas 500ml |        5 |    60000 |         2 |
|  5 | Juguete Pelota           |       10 |    80000 |         3 |
|  6 | Desparasitante Interno   |       20 |   100000 |         3 |
|  7 | Cama Mediana             |        1 |   120000 |         4 |
|  8 | Transportadora Pequeña   |        1 |   160000 |         4 |
|  9 | Arena Sanitaria 10kg     |        2 |    56000 |         5 |
| 10 | Plato Antideslizante     |        3 |    66000 |         5 |
| 11 | Concentrado Adulto 10kg  |        1 |    45000 |         6 |
| 12 | Vacuna Rabia             |        5 |    75000 |         6 |
| 13 | Shampoo Antipulgas 500ml |        2 |    24000 |         7 |
| 14 | Desparasitante Interno   |       10 |    50000 |         7 |
| 15 | Concentrado Gato 5kg     |        1 |    38000 |         8 |
| 16 | Juguete Pelota           |        5 |    60000 |         8 |
| 17 | Plato Antideslizante     |        2 |    44000 |         9 |
| 18 | Arena Sanitaria 10kg     |        1 |    28000 |         9 |
| 19 | Transportadora Pequeña   |        1 |   160000 |        10 |
| 20 | Cama Mediana             |        1 |   120000 |        10 |
+----+--------------------------+----------+----------+-----------+
20 rows in set (0,00 sec)

mysql> delimiter //
mysql> create procedure mostrardetallecompra()
    -> begin
    -> select c.id, p.nombre, c.cantidad, c.subtotal, c.compra_id from detalle_compra c left join producto p on c.producto_id=p.id;
    -> end; //
Query OK, 0 rows affected (0,01 sec)

mysql> show procedure status where db="veterinaria";
    -> //
+-------------+----------------------+-----------+--------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| Db          | Name                 | Type      | Definer      | Modified            | Created             | Security_type | Comment | character_set_client | collation_connection | Database Collation |
+-------------+----------------------+-----------+--------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| veterinaria | mostrardetallecompra | PROCEDURE | campus2023@% | 2025-11-24 06:40:19 | 2025-11-24 06:40:19 | DEFINER       |         | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+-------------+----------------------+-----------+--------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
1 row in set (0,00 sec)

mysql> show create procedure mostrardetallecompra;
    -> //
+----------------------+-----------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+--------------------+
| Procedure            | sql_mode                                                                                                              | Create Procedure                                                                                                                                                                                          | character_set_client | collation_connection | Database Collation |
+----------------------+-----------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+--------------------+
| mostrardetallecompra | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | CREATE DEFINER=`campus2023`@`%` PROCEDURE `mostrardetallecompra`()
begin
select c.id, p.nombre, c.cantidad, c.subtotal, c.compra_id from detalle_compra c left join producto p on c.producto_id=p.id;
end | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+----------------------+-----------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+--------------------+
1 row in set (0,00 sec)

mysql> drop procedure mostrardetallecompra;
    -> //
Query OK, 0 rows affected (0,01 sec)

mysql> delimiter //
mysql> create procedure mostrardetallecompra()
    -> begin
    -> select c.id, p.nombre, c.cantidad, c.subtotal, c.compra_id from detalle_compra c left join producto p on c.producto_id=p.id;
    -> end; //
Query OK, 0 rows affected (0,01 sec)

mysql> delimiter ;
mysql> call mostrardetallecompra();
+----+--------------------------+----------+----------+-----------+
| id | nombre                   | cantidad | subtotal | compra_id |
+----+--------------------------+----------+----------+-----------+
|  1 | Concentrado Adulto 10kg  |        2 |    90000 |         1 |
|  2 | Vacuna Rabia             |       10 |   150000 |         1 |
|  3 | Concentrado Gato 5kg     |        2 |    76000 |         2 |
|  4 | Shampoo Antipulgas 500ml |        5 |    60000 |         2 |
|  5 | Juguete Pelota           |       10 |    80000 |         3 |
|  6 | Desparasitante Interno   |       20 |   100000 |         3 |
|  7 | Cama Mediana             |        1 |   120000 |         4 |
|  8 | Transportadora Pequeña   |        1 |   160000 |         4 |
|  9 | Arena Sanitaria 10kg     |        2 |    56000 |         5 |
| 10 | Plato Antideslizante     |        3 |    66000 |         5 |
| 11 | Concentrado Adulto 10kg  |        1 |    45000 |         6 |
| 12 | Vacuna Rabia             |        5 |    75000 |         6 |
| 13 | Shampoo Antipulgas 500ml |        2 |    24000 |         7 |
| 14 | Desparasitante Interno   |       10 |    50000 |         7 |
| 15 | Concentrado Gato 5kg     |        1 |    38000 |         8 |
| 16 | Juguete Pelota           |        5 |    60000 |         8 |
| 17 | Plato Antideslizante     |        2 |    44000 |         9 |
| 18 | Arena Sanitaria 10kg     |        1 |    28000 |         9 |
| 19 | Transportadora Pequeña   |        1 |   160000 |        10 |
| 20 | Cama Mediana             |        1 |   120000 |        10 |
+----+--------------------------+----------+----------+-----------+
20 rows in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)

mysql> delimiter //
mysql> create procedure mostrardetallecompra_id(in v_id int)
    -> begin
    -> select dc.id, p.nombre, dc.cantidad, dc.subtotal, dc.compra_id from detalle_compra dc left join producto p on c.producto_id=p.id where dc.id=v_id;
    -> end; //
Query OK, 0 rows affected (0,01 sec)

mysql> delimiter ;
mysql> call mostrardetallecompra_id(2);
ERROR 1054 (42S22): Unknown column 'c.producto_id' in 'on clause'
mysql> drop mostrardetallecompra_id;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'mostrardetallecompra_id' at line 1
mysql> drop procedure mostrardetallecompra_id;
Query OK, 0 rows affected (0,00 sec)

mysql> delimiter //
mysql> create procedure mostrardetallecompra_id(in v_id int)
    -> begin
    -> select dc.id, p.nombre, dc.cantidad, dc.subtotal, dc.compra_id from detalle_compra dc left join producto p on dc.producto_id=p.id where dc.id=v_id;
    -> end; //
Query OK, 0 rows affected (0,01 sec)

mysql> delimiter ;
mysql> call mostrardetallecompra_id(2);
+----+--------------+----------+----------+-----------+
| id | nombre       | cantidad | subtotal | compra_id |
+----+--------------+----------+----------+-----------+
|  2 | Vacuna Rabia |       10 |   150000 |         1 |
+----+--------------+----------+----------+-----------+
1 row in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)

mysql> call mostrardetallecompra_id(3);
+----+----------------------+----------+----------+-----------+
| id | nombre               | cantidad | subtotal | compra_id |
+----+----------------------+----------+----------+-----------+
|  3 | Concentrado Gato 5kg |        2 |    76000 |         2 |
+----+----------------------+----------+----------+-----------+
1 row in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)

mysql> call mostrardetallecompra_id(3);
+----+----------------------+----------+----------+-----------+
| id | nombre               | cantidad | subtotal | compra_id |
+----+----------------------+----------+----------+-----------+
|  3 | Concentrado Gato 5kg |        2 |    76000 |         2 |
+----+----------------------+----------+----------+-----------+
1 row in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)

mysql> select * from venta;
+----+------------+------------+-------------+---------------------+--------+
| id | usuario_id | cliente_id | fecha_venta | fecha_ingreso       | total  |
+----+------------+------------+-------------+---------------------+--------+
|  1 |          6 |          1 | 2025-11-01  | 2025-11-01 09:00:00 | 70000  |
|  2 |          6 |          2 | 2025-11-01  | 2025-11-01 10:15:00 | 81000  |
|  3 |          7 |          3 | 2025-11-02  | 2025-11-02 11:30:00 | 165000 |
|  4 |          7 |          4 | 2025-11-03  | 2025-11-03 12:00:00 | 92000  |
|  5 |          8 |          5 | 2025-11-03  | 2025-11-03 15:45:00 | 37000  |
|  6 |          8 |          1 | 2025-11-04  | 2025-11-04 09:20:00 | 250000 |
|  7 |          9 |          2 | 2025-11-04  | 2025-11-04 10:40:00 | 82000  |
|  8 |          9 |          3 | 2025-11-05  | 2025-11-05 13:10:00 | 89000  |
|  9 |         10 |          4 | 2025-11-05  | 2025-11-05 14:50:00 | 205000 |
| 10 |         10 |          5 | 2025-11-06  | 2025-11-06 08:30:00 | 150000 |
| 11 |          6 |          1 | 2025-11-06  | 2025-11-06 09:10:00 | 47000  |
| 12 |          7 |          2 | 2025-11-07  | 2025-11-07 10:00:00 | 109000 |
| 13 |          8 |          3 | 2025-11-07  | 2025-11-07 11:25:00 | 420000 |
| 14 |          9 |          4 | 2025-11-08  | 2025-11-08 12:45:00 | 92000  |
| 15 |         10 |          5 | 2025-11-08  | 2025-11-08 14:00:00 | 17000  |
+----+------------+------------+-------------+---------------------+--------+
15 rows in set (0,00 sec)

mysql> describe cliente;
+-------+------+------+-----+---------+----------------+
| Field | Type | Null | Key | Default | Extra          |
+-------+------+------+-----+---------+----------------+
| id    | int  | NO   | PRI | NULL    | auto_increment |
+-------+------+------+-----+---------+----------------+
1 row in set (0,00 sec)

mysql> describe persona;
+------------------+-----------------+------+-----+---------+----------------+
| Field            | Type            | Null | Key | Default | Extra          |
+------------------+-----------------+------+-----+---------+----------------+
| id               | int             | NO   | PRI | NULL    | auto_increment |
| tipo_documento   | enum('CC','CE') | NO   |     | NULL    |                |
| documento        | varchar(45)     | NO   | UNI | NULL    |                |
| nombre           | varchar(45)     | NO   |     | NULL    |                |
| apellido         | varchar(45)     | NO   |     | NULL    |                |
| direccion        | varchar(150)    | YES  |     | NULL    |                |
| correo           | varchar(50)     | NO   |     | NULL    |                |
| fecha_nacimiento | date            | NO   |     | NULL    |                |
+------------------+-----------------+------+-----+---------+----------------+
8 rows in set (0,00 sec)

mysql> 
mysql> delimiter // 
mysql> create procedure mostrar_cliente_venta_id(in v_id int, out v_cliente varchar(50))
    -> begin
    -> select concat(c.nombre ,' ',c.apellido) as nombre_cliente into v_cliente from venta v left join persona c on v.cliente_id=c.id where v.id=v_id;
    -> end; //
Query OK, 0 rows affected (0,00 sec)

mysql> delimiter ;
mysql> call mostrar_cliente_venta_id(2,@nombre_cliente);
Query OK, 1 row affected (0,00 sec)

mysql> select 'El nombre del cliente al que se le vendiò es: ',@nombre_cliente;
+-------------------------------------------------+-----------------+
| El nombre del cliente al que se le vendiò es:   | @nombre_cliente |
+-------------------------------------------------+-----------------+
| El nombre del cliente al que se le vendiò es:   | María Gómez     |
+-------------------------------------------------+-----------------+
1 row in set (0,00 sec)

mysql> show pocedure status where db="veterinaria";
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'pocedure status where db="veterinaria"' at line 1
mysql> show procedure status where db="veterinaria";
+-------------+--------------------------+-----------+--------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| Db          | Name                     | Type      | Definer      | Modified            | Created             | Security_type | Comment | character_set_client | collation_connection | Database Collation |
+-------------+--------------------------+-----------+--------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| veterinaria | mostrardetallecompra     | PROCEDURE | campus2023@% | 2025-11-24 06:43:37 | 2025-11-24 06:43:37 | DEFINER       |         | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| veterinaria | mostrardetallecompra_id  | PROCEDURE | campus2023@% | 2025-11-24 06:56:51 | 2025-11-24 06:56:51 | DEFINER       |         | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| veterinaria | mostrar_cliente_venta_id | PROCEDURE | campus2023@% | 2025-11-24 07:10:05 | 2025-11-24 07:10:05 | DEFINER       |         | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+-------------+--------------------------+-----------+--------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
3 rows in set (0,00 sec)

mysql> delimiter //
mysql> create procedure mostrar_cliente_vendedor_venta_id(in v_id int, out v_cliente varchar(50), out v_vendedor varchar(50))
    -> begin
    -> select concat(c.nombre ,' ',c.apellido) as nombre_cliente,concat(v.nombre ,' ',v.apellido) as nombre_vendedor into v_cliente,v_vendedor from venta v left join persona c on v.cliente_id=c.id left join persona v on v.usuario_id=p.id where v.id=v_id;
    -> end; //
ERROR 1066 (42000): Not unique table/alias: 'v'
mysql> delimiter ;
mysql> select concat(c.nombre ,' ',c.apellido) as nombre_cliente,concat(v.nombre ,' ',v.apellido) as nombre_vendedor into v_cliente,v_vendedor from venta v left join persona c on v.cliente_id=c.id left join persona v on v.usuario_id=p.id where v.id=v_id;
ERROR 1327 (42000): Undeclared variable: v_cliente
mysql> select concat(c.nombre ,' ',c.apellido) as nombre_cliente,concat(v.nombre ,' ',v.apellido) as nombre_vendedor from venta v left join persona c on v.cliente_id=c.id left join persona v on v.usuario_id=p.id where v.id=v_id;
ERROR 1066 (42000): Not unique table/alias: 'v'
mysql> select concat(c.nombre ,' ',c.apellido) as nombre_cliente,concat(u.nombre ,' ',u.apellido) as nombre_vendedor from venta v left join persona c on v.cliente_id=c.id left join persona u on u.usuario_id=p.id where v.id=v_id;
ERROR 1054 (42S22): Unknown column 'v_id' in 'where clause'
mysql> select concat(c.nombre ,' ',c.apellido) as nombre_cliente,concat(u.nombre ,' ',u.apellido) as nombre_vendedor from venta v left join persona c on v.cliente_id=c.id left join persona u on u.usuario_id=p.id where v.id=3;
ERROR 1054 (42S22): Unknown column 'u.usuario_id' in 'on clause'
mysql> select concat(c.nombre ,' ',c.apellido) as nombre_cliente,concat(u.nombre ,' ',u.apellido) as nombre_vendedor from venta v left join persona c on v.cliente_id=c.id left join persona u on v.usuario_id=p.id where v.id=3;
ERROR 1054 (42S22): Unknown column 'p.id' in 'on clause'
mysql> select concat(c.nombre ,' ',c.apellido) as nombre_cliente,concat(u.nombre ,' ',u.apellido) as nombre_vendedor from venta v left join persona c on v.cliente_id=c.id left join persona u on v.usuario_id=u.id where v.id=3;
+----------------+-----------------+
| nombre_cliente | nombre_vendedor |
+----------------+-----------------+
| Carlos López   | Diego Ruiz      |
+----------------+-----------------+
1 row in set (0,00 sec)

mysql> select concat(c.nombre ,' ',c.apellido) as nombre_cliente,concat(u.nombre ,' ',u.apellido) as nombre_vendedor from venta v left join persona c on v.cliente_id=c.id left join persona u on v.usuario_id=u.id where v.id=3;
+----------------+-----------------+
| nombre_cliente | nombre_vendedor |
+----------------+-----------------+
| Carlos López   | Diego Ruiz      |
+----------------+-----------------+
1 row in set (0,00 sec)

mysql> delimiter // 
mysql> create procedure mostrar_cliente_vendedor_venta_id(in v_id int, out v_cliente varchar(50), out v_vendedor varchar(50))
    -> begin
    -> select concat(c.nombre ,' ',c.apellido) as nombre_cliente,concat(u.nombre ,' ',u.apellido) as nombre_vendedor 
    -> into v_cliente, v_vendedor from venta v left join persona c on v.cliente_id=c.id 
    -> left join persona u on v.usuario_id=u.id where v.id=v_id
    -> end; //
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'end' at line 6
mysql> delimiter ;
mysql> delimiter // 
mysql> create procedure mostrar_cliente_vendedor_venta_id(in v_id int, out v_cliente varchar(50), out v_vendedor varchar(50))
    -> begin
    -> select concat(c.nombre ,' ',c.apellido) as nombre_cliente,concat(u.nombre ,' ',u.apellido) as nombre_vendedor 
    -> into v_cliente, v_vendedor from venta v left join persona c on v.cliente_id=c.id 
    -> left join persona u on v.usuario_id=u.id where v.id=v_id;
    -> end; //
Query OK, 0 rows affected (0,00 sec)

mysql> delimiter ;
mysql> call mostrar_cliente_vendedor_venta_id(1,@cliente, @vendedor);
Query OK, 1 row affected (0,00 sec)

mysql> select @cliente, @vendedor;
+-------------+---------------+
| @cliente    | @vendedor     |
+-------------+---------------+
| Juan Pérez  | Sofía Torres  |
+-------------+---------------+
1 row in set (0,00 sec)

mysql> call mostrar_cliente_vendedor_venta_id(2,@cliente, @vendedor);
Query OK, 1 row affected (0,00 sec)

mysql> select @cliente, @vendedor;
+---------------+---------------+
| @cliente      | @vendedor     |
+---------------+---------------+
| María Gómez   | Sofía Torres  |
+---------------+---------------+
1 row in set (0,00 sec)

mysql> delimiter //
mysql> create procedure calcular_iva_venta_id(in v_id int, inout v_total double)
    -> begin
    -> select total into v_total from venta where id=v_id;
    -> set v_total=v_total*1.19;
    -> end; //
Query OK, 0 rows affected (0,00 sec)

mysql> delimiter ;
mysql> 
mysql> call calcular_iva_venta_id(1, @total);
Query OK, 1 row affected (0,00 sec)

mysql> select @total;
+--------+
| @total |
+--------+
|  83300 |
+--------+
1 row in set (0,00 sec)

mysql> select total from venta where id=1;
+-------+
| total |
+-------+
| 70000 |
+-------+
1 row in set (0,00 sec)

mysql> 


