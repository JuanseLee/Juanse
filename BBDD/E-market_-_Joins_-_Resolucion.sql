-- JOINS
-- Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
-- Id de la factura, fecha de la factura, empresa de correo, nombre del cliente, categoría del producto vendido, nombre del producto, precio unitario y cantidad.

SELECT f.FacturaID, FechaFactura, o.Compania as correo, Contacto as cliente, CategoriaNombre, ProductoNombre, d.PrecioUnitario, Cantidad
FROM facturas f
JOIN correos o ON f.enviovia = o.correoID
JOIN clientes l ON f.ClienteID = l.ClienteID 
JOIN facturadetalle d ON f.FacturaID = d.FacturaID
JOIN productos p ON d.ProductoID = p.ProductoID
JOIN categorias c ON p.CategoriaID = c.CategoriaID
ORDER BY f.FacturaID, CategoriaNombre, ProductoNombre;


-- Listar todas las categorías junto con información de sus productos. Incluir todas las categorías aunque no tengan productos.
SELECT CategoriaNombre, ProductoId, ProductoNombre, CantidadPorUnidad, PrecioUnitario
FROM categorias
LEFT JOIN productos
ON categorias.CategoriaID = productos.CategoriaID;

-- Listar la información de contacto de los clientes que no hayan comprado nunca en emarket.
SELECT clientes.ClienteID, Contacto, Telefono
FROM clientes
LEFT JOIN facturas
ON facturas.ClienteID = clientes.ClienteID
WHERE facturas.ClienteID IS NULL;

-- Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y la información de contacto de su proveedor. Tener en cuenta que puede haber productos para los cuales no se indicó quién es el proveedor.
SELECT productoNombre, c.CategoriaNombre, prov.Contacto, prov.Telefono
FROM productos p
INNER JOIN categorias c ON c.CategoriaID = p.CategoriaID
LEFT JOIN proveedores prov on p.ProveedorID = prov.ProveedorID;

-- Para cada categoría listar el promedio del precio unitario de sus productos.
SELECT CategoriaNombre, avg(PrecioUnitario)
FROM categorias c
LEFT JOIN productos p
ON c.CategoriaID = p.CategoriaID
GROUP BY CategoriaNombre;

-- Para cada cliente, indicar la última factura de compra. Incluir los clientes que nunca hayan comprado en e-market.
SELECT clientes.ClienteId,
       max(fechafactura) as ultima_factura
FROM clientes
LEFT JOIN facturas
ON facturas.ClienteID = clientes.ClienteID
GROUP BY clientes.ClienteId;

-- Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un listado con todas las empresas de correo, y la cantidad de facturas correspondientes. Realizar la consulta utilizando RIGHT JOIN.

SELECT compania, count(facturaID) 
FROM facturas
RIGHT JOIN correos
ON facturas.enviovia = correos.correoID
GROUP BY compania;
