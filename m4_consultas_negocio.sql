-- Consulta 1: Resumen ejecutivo mensual: Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. Devuelve una sola fila 

SELECT
    MONTH(fecha_venta)               AS mes,
    SUM(cantidad * precio_unitario)  AS total_facturado,
    COUNT(*)                        AS cantidad_pedidos,
    AVG(cantidad * precio_unitario)  AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Consulta 2: Ranking de Prodcutos: Top 5 de productos mas vendidos, mostrando la cantidad de unidades vendidas y el total facturado

SELECT TOP 5
id_producto,
SUM(cantidad)                         AS unidades_vendidas,
SUM(cantidad*precio_unitario)         AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC; 

-- Consulta 3: Clientes Recurrentes: Los clientes que hayan realizado mas de un pedido, muestra la cantidad de pedidos y el total gastado/comprado.

SELECT
id_cliente, 
COUNT(*)                              AS cantidad_pedidos,
SUM(cantidad*precio_unitario)         AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT (*) >1
ORDER BY total_gastado DESC; 

-- Consulta 4: Productos por encima/por debajo del promedio: Total facturado por id_producto

WITH facturacion_producto             AS (
SELECT
id_producto,
SUM(cantidad * precio_unitario)       AS total_facturado
FROM ventas
GROUP BY id_producto
)

SELECT
id_producto,
total_facturado,
(SELECT AVG(total_facturado) FROM facturacion_producto) AS promedio_productos,

CASE
WHEN total_facturado > (SELECT AVG(total_facturado) FROM facturacion_producto)
THEN 'Por encima'
ELSE 'Por debajo'
END                                  AS posicion_vs_promedio
FROM facturacion_producto
ORDER BY total_facturado DESC;

-- HALLAZGOS ENCONTRADOS: 
-- 1) El producto 1 concentra el 55,9% de la facturacion total ($3.600 / $6.444). Junto con el producto 3 suman el 76,8% ($4.950).
-- 2) El producto 2 es el mas vendido en unidades (13) pero es el que menos facturacion genero ($364) dando solo el 5,6% de la facturacion total; vender mucho no es igual que generar mucho ingreso 
-- 3) Los 5 clientes hicieron exactamente 2 pedidos cada uno, por lo que todos son recurrentes, siendo: 
-- El cliente 1 el que mas gasto ($2.640)
-- El cliente 4 el que menos ($510)
-- Solo 2 de los 6 productos (1 y 3) superan el promedio de facturacion por producto ($1.074).
    