-- Consulta 1: Vista base del proyecto (INNER JOIN): 

SELECT
v.id_venta,
v.fecha_venta,
c.id_cliente,
c.nombre                        AS cliente,
c.ciudad,
p.nombre_producto               AS producto,
cat.nombre_categoria            AS categoria,
v.cantidad,
v.precio_unitario,
v.cantidad * v.precio_unitario  AS total_venta
FROM ventas                     AS v
INNER JOIN clientes             AS c   ON v.id_cliente   = c.id_cliente
INNER JOIN productos            AS p   ON v.id_producto  = p.id_producto
INNER JOIN categorias           AS cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;

-- Hallazgo: La tabla devolvio las 10 ventas, Computacion concentra 4950 de los 6444 vendidos (77%) y Buenos Aires fue la ciudad donde mas se vendio.

-- Consulta 2: Clientes sin Ventas (LEFT JOIN): Identifica clientes registrados que aun no han realizado ninguna compra.

SELECT
c.nombre,
c.email,
c.fecha_registro
FROM clientes                   AS c
LEFT JOIN ventas                AS v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: todos los clientes compraron al menos una vez. No tenemos que contactarnos con nadie por ahora

--Consulta 3: Productos sin Ventas (Left Join): Identifca todos aquellos productos que nunca se vendieron

SELECT
p.nombre_producto,
cat.nombre_categoria            AS categoria,
p.precio
FROM productos                  AS p
INNER JOIN categorias           AS cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas                AS v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- Hallazgo: todos los productos que tenemos fueron vendidos al menos una vez. Por ahora no tenemos productos que no hayan sido vendidos por lo que podemos mantener los mismos productos en stock para vender y no tenemos por ahora que pensar en traer otro producto.

--Consulta 4: Consolidado por canal (UNION ALL)

SELECT canal, SUM(total)        AS total_canal
FROM (
SELECT fecha_venta, cantidad * precio_unitario AS total, 'Primer período' AS canal
FROM ventas
WHERE fecha_venta < '2024-03-11'
UNION ALL
SELECT fecha_venta, cantidad * precio_unitario AS total, 'Segundo período' AS canal
FROM ventas
WHERE fecha_venta >= '2024-03-11'
)                              AS consolidado
GROUP BY canal;

--Hallazgo: En el primer periodo se vendio 3620 mientras que en el segundo 2824. Puede deberse a que la gente recien cobraba el sueldo entonces le permitio comprar mas. Lo que haria seria intensificar las ofertas en el primer periodo para concentrar la venta ahi.