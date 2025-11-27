-- FUNCIONES

-- SUM()
-- COUNT()
-- AVG()

DELIMITER //
CREATE FUNCTION sumarNumeros(n1 INT, n2 INT)
RETURNS INTO
-- DETERMINISTIC
BEGIN
    RETURN(n1 + n2);
END; //
DELIMITER ;

DELIMITER //
CREATE FUNCTION iva(total DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    SET resultado INT;
    resultado = total * 1.19;
    RETURN resultado;    
END; //
DELIMITER ;

SHOW FUNCTION STATUS WHERE db = "veterinaria";
SHOW CREATE FUNCTION iva;

SELECT iva(10000);
DROP FUNCTION iva;

SELECT total, iva(total) AS iva_aplicado FROM venta;



DELIMITER //
CREATE FUNCTION descuento_cantidad(id_detalle INT)
RETURNS DOUBLE
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_subtotal DOUBLE;
    DECLARE v_cantidad INT;
    DECLARE v_resultado DOUBLE;

    SELECT subtotal, cantidad INTO v_subtotal, v_cantidad FROM detalle_venta WHERE id = id_detalle;

    IF v_cantidad > 2 AND v_cantidad < 4 THEN
        RETURN v_subtotal * 0.8;
    ELSE IF v_cantidad >=  5 AND v_cantidad <= 7 THEN
        RETURN v_subtotal * 0.75;
    ELSE
        RETURN v_subtotal;
    END IF;
END; //
DELIMITER ;


SELECT id, tipo_venta, codigo, cantidad, FORMAT(subtotal, 0) AS subtotal, FORMAT(descuento_cantidad(id), 0) AS descuento_aplicado FROM detalle_venta


UPDATE detalle_venta SET cantidad = 6 WHERE id = 11;


SELECT id, tipo_venta, codigo, cantidad, FORMAT(subtotal, 0) AS subtotal, subtotal - descuento_cantidad(id) AS descuento_aplicado, FORMAT(descuento_cantidad(id), 0) AS descuento_aplicado FROM detalle_venta

