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

-- Consulta 2: Clientes sin Ventas (LEFT JOIN): Identifica clientes registrados que aun no han realizado ninguna compra.

SELECT
c.nombre,
c.email,
c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: todos los clientes compraron al menos una vez 

--Consulta 3: Productos sin Ventas (Left Join): Identifca todos aquellos productos que nunca se vendieron

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas AS v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- Hallazgo: todos los productos que tenemos fueron vendidos al menos una vez.

--Consulta 4: Consolidado por canal (UNION ALL)

SELECT canal, SUM(total) AS total_canal
FROM (
SELECT fecha_venta, cantidad * precio_unitario AS total, 'Primer período' AS canal
FROM ventas
WHERE fecha_venta < '2024-03-11'
UNION ALL
SELECT fecha_venta, cantidad * precio_unitario AS total, 'Segundo período' AS canal
FROM ventas
WHERE fecha_venta >= '2024-03-11'
) AS consolidado
GROUP BY canal;