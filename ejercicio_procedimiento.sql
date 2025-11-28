PROC: info_completa_cliente
Recibe id_cliente (IN) y muestra nombre, apellido y correo; si no existe muestra mensaje apropiado.

delimiter $$
create procedure info_completa_cliente(in p_id_cliente int)
begin
if exists (
    select 1
    from cliente c 
    join persona p on p.id = c.id 
    where c.id= p_id_cliente
) then
select p.nombre, p.apellido, p.correo from cliente c join persona p on p.id= c.id where c.id=p_id_cliente;

else
select concat ('No existe un cliente con ese id' , p_id_cliente) as mensaje;

end if;
end$$
delimiter ;

call info_completa_cliente(2);


drop procedure info_completa_cliente();

------------------------------------------------------------------------
PROC: actualizar_precio_producto
Recibe id y nuevo precio (IN). Si el precio es menor a 0, mostrar mensaje de error; si no, actualizar.

delimiter $$
create procedure actualizar_precio_producto(in p_id_producto int, in p_precio double)
begin 
if p_precio <= 0 then --menor o igual
select 'error: el precio no puede ser 0' as mensaje;
else 
    update producto
    set precio_compra = p_precio where id = p_id_producto;
    select concat ('El precio fue actualizaco con exito ', p_id_producto) as mensaje;
end if;
end$$
delimiter ;

call actualizar_precio_producto(2,1000);

drop procedure actualizar_precio_producto;

------------------------------------------------------------------------


PROC: insertar_o_actualizar_stock
Recibe id_producto y cantidad (IN).
Si no existe, mostrar mensaje; si existe, sumar cantidad al stock.



------------------------------------------------------------------------

PROC: eliminar_cliente_si_no_tiene_ventas
Recibe id_cliente (IN).
Si no tiene ventas asociadas, eliminar; si tiene, mostrar mensaje de bloqueo.

PROC: calcular_total_venta
Recibe id_venta y saca subtotal de cada detalle para luego hacer un SELECT OUT con el total final.

PROC: mostrar_detalles_producto
Recibe id_producto (IN).
Si existe, mostrar todos sus datos; si no, mensaje “no existe”.

PROC: registrar_movimiento_stock
Recibe id_producto, cantidad y tipo ('entrada','salida').
Según el tipo, sumar o restar stock. Validar que no quede negativo.

PROC: evaluar_cliente_por_compras
Recibe id_cliente, suma el total de compras y define en un parámetro OUT el nivel del cliente.

PROC: aumentar_precio_por_categoria
Recibe categoria y porcentaje (IN).
Actualiza todos los productos de esa categoría incrementando su precio.

PROC: buscar_producto_por_nombre
Recibe una palabra IN y muestra todos los productos cuyo nombre la contenga.

PROC: actualizar_estado_usuario
Recibe id_usuario y nuevo_estado (IN).
Si nuevo_estado no es válido ('A' o 'I'), mostrar error.

PROC: registrar_nuevo_cliente
Recibe datos básicos de cliente (IN).
Valida que no esté repetido por documento y luego inserta.

PROC: obtener_suma_y_promedio
Recibe id_producto y un OUT para suma y otro para promedio de ventas.

PROC: controlar_limite_credito
Recibe id_cliente y monto.
Si el cliente supera su límite de crédito tras sumarlo, devolver un OUT indicando “rechazado”.