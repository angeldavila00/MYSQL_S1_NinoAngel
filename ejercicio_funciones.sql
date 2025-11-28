1. Función que calcule el precio final de un producto aplicando IVA y descuento por cantidad

Dada un id_detalle, obtenga precio_unitario y cantidad, calcule el subtotal, agrégele IVA del 19% y si la cantidad es mayor a 10 aplique 10% de descuento adicional. Retorne el total final.
--------------------------------------------------------------------------------------------------------------------------

delimiter $$
create function ejercicio (p_id_detalle int)
returns double
deterministic
begin
declare v_subtotal double;
declare v_cantidad int;
declare v_total_iva double;
declare v_total_final double;
declare v_descuento double;

select subtotal, cantidad into v_subtotal, v_cantidad from detalle_venta where id = p_id_detalle;

set v_total_iva = v_subtotal*1.19;

if v_cantidad > 10 then
	set v_descuento = v_total_iva* 0.10;
	set v_total_final = v_total_iva - v_descuento;
else 
	set v_total_final = v_total_iva ;
end if;
return v_total_final;
end $$

delimiter ;

select subtotal,cantidad,ejercicio(id) as iva from detalle_venta; 
select id,subtotal, cantidad,ejercicio(id)- subtotal as total_iva_y_descuento from detalle_venta;
select ejercicio(2):
--------------------------------------------------------------------------------------------------------------------------

2. Función que devuelva el nivel de stock según la cantidad en inventario

Recibe id_producto. Obtiene stock_actual.
Si es ≥ 50 → retorna 3 (alto).
Si está entre 20 y 49 → retorna 2 (medio).
Si es < 20 → retorna 1 (bajo).

delimiter $$
create function stock_producto(p_id_producto int)
returns int
deterministic
begin

declare v_stock_actual int;
declare v_nivel int;

select stock into v_stock_actual from producto where id= p_id_producto;

if v_stock_actual >= 50 then 
set v_nivel = 3;

elseif v_stock_actual between 20 and 49 then 
set v_nivel = 2;

else 
set v_nivel = 1;


end if ;

return v_nivel;

end$$
delimiter ;

select stock_producto(2) as nivel from producto;
--------------------------------------------------------------------------------------------------------------------------

3. Función que calcule la comisión de un vendedor

Recibe id_vendedor e id_venta.
Obtiene total de la venta.
Si total > 1,000 → comisión 8%
Si total entre 500 y 1,000 → 5%
Si menor → 2%
Retorna el valor de la comisión.

delimiter $$

create function calcular_comision(p_id_venta int, p_id_vendedor int)
returns double
deterministic
begin

declare v_total double;
declare v_comision double;

select total into v_total from venta where id =p_id_venta and usuario_id=p_id_vendedor;

if v_total > 1000 then
    set v_comision = V_total*0.08;
elseif v_total between 500 and 1000 then 
    set v_comision = v_total*0.05;

else 
set v_comision = v_total*0.02;
end if;
return v_comision;
end$$

delimiter ;

select id, total, calcular_comision(id,usuario_id) as comisión from venta;

--------------------------------------------------------------------------------------------------------------------------
4. Función que determine el tipo de cliente según número de compras

Recibe id_cliente.
Cuenta cuántas ventas tiene.
Si ≥ 30 → retorna 'VIP'.
Si entre 10 y 29 → 'Frecuente'.
Si menos → 'Ocasional'.

delimiter $$
create function tipo_cliente(p_cliente_id int)
returns varchar(50)
deterministic
begin
declare v_cant_venta int;
declare v_tipo varchar(50);

select count(*) into v_cant_venta from venta where cliente_id=p_cliente_id;

if v_cant_venta >= 30 then 
    set v_tipo = 'VIP';

elseif v_cant_venta between 10 and 29 then
    set v_tipo = 'Frecuente';

else 
set v_tipo= 'Ocasional';

end if;

return v_tipo;

end$$
delimiter ;

SELECT id, tipo_cliente(id) AS tipo FROM cliente;
--------------------------------------------------------------------------------------------------------------------------
5. Función que calcule el costo de envío según peso

Recibe id_envio.
Obtiene peso.
Si pesa menos de 2 kg → costo 5.000
Si pesa entre 2 y 5 → costo 10.000
Si pesa más → 18.000
Retorna el costo.

delimiter $$

create function calcular_costo_envio(p_id_producto int)
returns varchar(50)
deterministic
begin

declare v_peso int;
declare v_costo varchar(50);

select peso into v_peso from  producto where id = p_id_producto;

if v_peso < 2 then 
    set v_costo = 'Envio 5.000';
elseif v_peso between 2 and 5 then 
    set v_costo = 'Envio 10.000';
else 
set v_costo = 'Envio 18.000';

end if;
    return v_costo;
end$$

delimiter ;

select id,peso, calcular_costo_envio(id) as calcular_envio from producto;


--------------------------------------------------------------------------------------------------------------------------
6. Función que devuelva un mensaje sobre el estado del producto

Recibe id_producto.
Obtiene stock_actual.
Si stock = 0 → “Agotado”
Si entre 1 y 5 → “Últimas unidades”
Si > 5 → “Disponible”.


delimiter $$
create function estado_producto (p_id_producto int)
returns varchar(50)
deterministic
begin

declare v_stock_actual int;
declare v_estado varchar(50);

select stock into v_stock_actual from producto where id = p_id_producto;

if v_stock_actual = 0 then 
set v_estado = 'Agotado';

elseif v_stock_actual between 1 and 5 then 
set v_estado = 'Ultimas Unidades';

else 
set v_estado = 'Disponible';
end if;
return v_estado;
end$$

delimiter ;

select nombre, stock, estado_producto(2) as estado_stock from producto;
--------------------------------------------------------------------------------------------------------------------------
7. Función que calcule un bono por antigüedad

Recibe id_usuario.
Obtiene anhos_servicio (int).
Si ≥ 10 → bono = 800.000
Si entre 5 y 9 → 400.000
Si menos → 100.000
Retorna el valor.
--creacion de tabla alterna
alter table usuario add column anhos_antiguedad int not null;

--update de datos
update usuario set anhos_antiguedad = 15 where id = 1;
update usuario set anhos_antiguedad = 5 where id = 4;
update usuario set anhos_antiguedad = 7 where id = 5;

delimiter $$
create function bono_antiguedad(p_id_usuario int)
returns int
deterministic
begin 

declare v_anhos_servicio int;
declare v_bono int;

select anhos_antiguedad into v_anhos_servicio from usuario where id = p_id_usuario;

if v_anhos_servicio >= 10 then 
set v_bono = '800000';
elseif v_anhos_servicio between 5 and 9 then
set v_bono = '400000';
else 
set v_bono = '100000';

end if;
return v_bono;
end $$

delimiter ;

select usuario, anhos_antiguedad , bono_antiguedad(id) as bono_ganado from usuario;

select bono_antiguedad(4) as bono_ganado;
--------------------------------------------------------------------------------------------------------------------------
8. Función que retorne el valor del impuesto de un producto según categoría

Recibe id_producto.
Obtiene categoria y precio.
Si categoría = ‘lácteo’ → impuesto 5%
Si ‘tecnología’ → 15%
Otros → 8%
Retorna el impuesto calculado.





--------------------------------------------------------------------------------------------------------------------------
9. Función que calcule la mora por pago atrasado

Recibe id_pago.
Obtiene dias_atraso.
Si días = 0 → mora 0
Si entre 1 y 10 → 5.000
Si más de 10 → 20.000
--------------------------------------------------------------------------------------------------------------------------
10. Función que determine si un producto es “económico”, “estándar” o “premium”

Recibe id_producto.
Obtiene precio.
<20.000 → económico
20.000–100.000 → estándar

100.000 → premium
--------------------------------------------------------------------------------------------------------------------------
11. Función que calcule un ajuste porcentual al sueldo

Recibe id_empleado.
Obtiene sueldo.
Si sueldo < 1.200.000 → aumenta 10%
Si entre 1.200.000 y 2.000.000 → 5%
Si más → 2%
Retorna el sueldo ajustado.
--------------------------------------------------------------------------------------------------------------------------
12. Función que determine si un producto tiene utilidad o pérdida

Recibe id_producto.
Obtiene precio_compra y precio_venta.
Retorna 'UTILIDAD', 'PERDIDA' o 'IGUAL'.
--------------------------------------------------------------------------------------------------------------------------
13. Función que retorne el valor total de un pedido

Recibe id_pedido.
Suma cantidad * precio_unitario de su detalle.
Si es NULL → retornar 0.
--------------------------------------------------------------------------------------------------------------------------
14. Función que determine si una compra aplica a promoción

Recibe id_detalle.
Obtiene cantidad y total.
Si cantidad ≥ 3 y total > 50.000 → retorna 1
Si no → retorna 0
--------------------------------------------------------------------------------------------------------------------------
15. Función que calcule el porcentaje de ganancia

Recibe id_producto.
Obtiene precio_compra, precio_venta.
Fórmula:
(precio_venta - precio_compra) / precio_compra * 100
Si compra = 0 → retorna 0
--------------------------------------------------------------------------------------------------------------------------