delimiter//
create procedure detalledecompra(in v_id int)
begin,
select dc.id, p.nombre, dc.cantidad,dc.subtotal,dc.compra_id from detalle_compra dc left join producto p on dc.producto_id=v_id;
end//
delimiter ;

delimiter //
create procedure mostrar_cliente_venta_id(in v_id int, out v_cliente varchar(50))
begin 
select concat( c.nombre, ' ', c.apellido) as nombre_cliente into v_cliente from venta v left join persona c on v.cliente_id=c.id where v.id=v_id;
end//
delimiter ;

delimiter //
create procedure calcular_iva(inout total double)
begin 
set total= total*1.19;
end//
delimiter ;

delimiter //
create procedure calcular_iv_venta_id(in v_id int, inout v_total double)
begin
select v_total into inout from venta where id=v_id;
set v_total=v_total*1.19;
end//
delimiter ;

show funtion status where db="veterinaria";



create procedure insertar (in nombre varchar(50), in precio double)
begin 
insert into servicio (nombre,precio)
values(v_nombre,v_precio);
end //
delimiter ;

call insertar("nombre", 3000);

DELIMITER //

CREATE FUNCTION cantidad_mayor(n INT)
RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
BEGIN
    IF n > 5 THEN
        RETURN 'cantidad grande';
    ELSE
        RETURN 'cantidad pequeña';
    END IF;
END //

DELIMITER ;


select id,tipo_venta, codigo, cantidad,subtotal, venta_id, cantidad_mayor(cantidad) from detalle_venta;

delimiter //

create procedure nombreCliente(in v_nombreCliente int)
begin
select c.id,p.nombre from cliente c inner join persona p on c.id=p.id
where p.cliente = v_nombreCliente;

end //

--estudiar eventos