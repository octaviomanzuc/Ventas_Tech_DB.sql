# RetailPro – Análisis de ventas con SQL Server

Proyecto académico del curso de Data Analytics. Trabaja sobre **RetailPro**, un caso ficticio de una distribuidora de tecnología, y reúne los scripts SQL que crean la base `Ventas_Tech_DB`, la cargan con datos de ejemplo y responden preguntas de negocio.

## Qué contiene este repositorio

| Archivo | Qué hace |
|---|---|
| `Entrega 3 Manzuc .sql` | Crea las 4 tablas (con claves primarias y foráneas) y carga los datos de ejemplo. Se puede volver a ejecutar: empieza con los `DROP TABLE`. |
| `m4_consultas_negocio.sql` | 4 consultas con agregaciones: resumen mensual, Top 5 de productos, clientes recurrentes y productos por encima o por debajo del promedio. |
| `m5_consultas_joins.sql` | 4 consultas con JOINs: vista base de ventas, clientes sin ventas, productos sin ventas y consolidado por período (`UNION ALL`). |

## Modelo de datos

```
categorias (1) ──< productos (1) ──< ventas >── (1) clientes
```

| Tabla | Columnas |
|---|---|
| `categorias` | `id_categoria`, `nombre_categoria`, `descripcion` |
| `clientes` | `id_cliente`, `nombre`, `email`, `ciudad`, `fecha_registro` |
| `productos` | `id_producto`, `nombre_producto`, `id_categoria`, `precio`, `stock`, `activo` |
| `ventas` | `id_venta`, `id_cliente`, `id_producto`, `cantidad`, `precio_unitario`, `fecha_venta` |

## Herramientas

- SQL Server Express y SQL Server Management Studio (SSMS), el entorno del curso. No probé los scripts en otras versiones.
- Power BI Desktop, en las etapas posteriores del curso (este repositorio contiene solo los scripts SQL).
- GitHub, para versionar y entregar.

## Cómo ejecutar los scripts

1. Abrí SSMS y conectate a tu instancia de SQL Server.
2. Creá la base, una sola vez:
   ```sql
   CREATE DATABASE Ventas_Tech_DB;
   GO
   ```
3. Elegí `Ventas_Tech_DB` en el desplegable de la barra superior. Si queda en `master`, SSMS responde que el nombre de objeto no es válido.
4. Abrí `Entrega 3 Manzuc .sql` y ejecutalo con **F5**. Puede correrse varias veces sin errores.
5. Abrí y ejecutá `m4_consultas_negocio.sql` y después `m5_consultas_joins.sql`. Cada consulta se corre por separado, seleccionándola y apretando F5.

## Resultados esperados

Sirven para comprobar que todo corrió bien.

| Paso | Qué tiene que dar |
|---|---|
| Script de la Entrega 3 (`SELECT *` finales) | `categorias` 4 filas, `clientes` 5, `productos` 6, `ventas` 10 |
| M4, Consulta 1 (resumen mensual) | 1 fila: mes 3, total facturado 6.444,00, 10 pedidos, ticket promedio 644,40 |
| M4, Consulta 2 (Top 5) | Productos 1, 3, 5, 6 y 2, con el producto 1 en $3.600 |
| M4, Consulta 3 (clientes recurrentes) | 5 clientes con 2 pedidos cada uno |
| M5, Consulta 1 (vista base) | 10 filas; la suma de `total_venta` es 6.444,00 |
| M5, Consultas 2 y 3 | Sin filas: todos los clientes y productos tuvieron ventas |
| M5, Consulta 4 (por período) | 3.620 (5 al 10 de marzo) y 2.824 (11 al 15 de marzo) |

## Notas

- Los datos son de ejemplo: 10 ventas entre el 5 y el 15 de marzo de 2024. Sirven para practicar, no para sacar tendencias.
- Este README se generó con ayuda de IA (Claude) y fue revisado y editado por el autor.

## Autor

Octavio Manzuc – proyecto del curso de Data Analytics.
