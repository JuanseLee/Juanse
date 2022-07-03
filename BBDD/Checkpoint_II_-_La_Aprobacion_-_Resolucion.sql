-- ========================== PROYECTO - LA APROBACION ========================== --
-- =========================== RESOLUCION CHECKPOINT II ========================== --
-- Base de datos: la_aprobacion.sql
-- Comando para habilitar la eliminación y actualización de registros: SET SQL_SAFE_UPDATES=0;


-- 1. Listar todos los huéspedes cuyo nombre comience con la letra "S". Se debe mostrar id como "Número de huésped", apellido y nombre.
SELECT id AS 'Número de huésped',  apellido, nombre  FROM huesped 
WHERE nombre LIKE 'S%';

-- 2. Mostrar el número de legajo del empleado con domicilio "Av. Rosalind Franklin 600".
SELECT legajo AS 'Número de legajo' FROM empleado 
WHERE domicilio = 'Av. Rosalind Franklin 600';

-- 3. Se requiere saber cuál es el mayor importe registrado en las reservas 
SELECT MAX(importe) AS 'Mayor importe' FROM reserva;

-- 4. Listar las reservas realizadas cuyo id corresponde al valor 15, 19, 21, 35.
SELECT * FROM reserva 
WHERE id IN (15, 19, 21, 35);

-- 5. Calcular el importe total recaudado para la habitación número 40. El reporte debe tener dos columnas denominadas "Número de habitación " y el "Importe Total".
SELECT habitacion_numero AS 'Número de habitación', SUM(importe) AS 'Importe Total' FROM checkin 
WHERE habitacion_numero = 40;

-- 6. Listar de manera ordenada y ascendente por fecha de nacimiento, los empleados que no pertenezcan al sector 3 y que la fecha de nacimiento sea mayor que 3/9/1989 o igual a 7/11/1986.
SELECT * FROM empleado 
WHERE sector_id <> 3 AND (fecha_nacimiento > '1989-09-03' OR fecha_nacimiento = '1986-11-07')
ORDER BY fecha_nacimiento;

-- 7. Listar los importes de las reservas con valor entre $10499,50 a $12000,00 (ordenarlos por el importe de mayor a menor).
SELECT * FROM reserva 
WHERE importe BETWEEN 10499.50 AND 12000.00 
ORDER BY importe DESC;

-- 8. Mostrar el quinto importe del checkin realizado con menor valor.
SELECT * FROM checkin 
ORDER BY importe 
LIMIT 1 OFFSET 4;

-- 9. Mostrar el check-in con mayor importe. Este reporte debe contener el número del check-in, fecha de entrada y el importe.
SELECT id AS 'Número de checkin', fecha_entrada, importe FROM checkin 
ORDER BY importe DESC 
LIMIT 1;

-- 10. Mostrar las diez reservas con menor importe. Este reporte debe contener el número de reserva, importe y el número del servicio.
SELECT id AS numero_reserva, importe, servicio_extra_id AS numero_servicio FROM reserva 
ORDER BY importe 
LIMIT 10;

-- 11. Listar las reservas registradas entre 14/07/21 al 15/08/21 y ordenarlas por fecha teniendo en cuenta un orden de más antigua a reciente.
SELECT * FROM reserva 
WHERE fecha BETWEEN '2021-07-14' AND '2021-08-15' 
ORDER BY fecha;

-- 12. Listar en forma ordenada y descendente los check-in que tengan un importe superior o igual a $34125,00 y con fecha de salida inferior a 26/6/2020. 
SELECT * FROM checkin 
WHERE importe >= 34125.00 AND fecha_salida < '2020-06-26'
ORDER BY importe DESC;

-- 13. Listar todos los empleados cuyo nombre termine con los caracteres "ia". Se debe mostrar el legajo, apellido, nombre y teléfono móvil.
SELECT legajo, apellido, nombre, telefono_movil FROM empleado 
WHERE nombre LIKE '%ia';

-- 14. Se desea conocer cuál es el importe promedio de las reservas que se hayan pagado en efectivo.
SELECT AVG(importe) AS importe_promedio FROM reserva 
WHERE forma_pago_id = 1;

-- 15. Mostrar el tercer check-in con mayor importe pagado con tarjeta de crédito.
SELECT * FROM checkin 
WHERE forma_pago_id = 3
ORDER BY importe DESC 
LIMIT 1 OFFSET 2;

-- 16. Calcular la cantidad de check-in que tiene la habitación número siete. El reporte debe tener dos columnas denominadas "Habitación" y el "Cantidad".
SELECT habitacion_numero AS habitacion, COUNT(*) AS Cantidad FROM checkin 
WHERE habitacion_numero = 7;

-- 17. Mostrar todos los domicilios de los huésped que contengan al menos una palabra de cinco caracteres, pero el tercer carácter debe ser igual a "n".
SELECT * FROM huesped 
WHERE domicilio LIKE '% __n__ %';

-- 18.  Modificar el tipo de decoración "italiana" por "romana"
UPDATE decoracion SET nombre = 'romana' 
WHERE nombre = 'italiana';

-- 19. Agregar al huésped Palermo Díaz Ricardo Omar cuyo pasaporte es 28001555 y fecha de nacimiento 5/1/1980, domiciliado en calle Av. Sarmiento 752 este - Argentina, teléfono móvil +542645667714 y el correo electrónico es pal1980sj@gmail.com.
INSERT INTO huesped (id, apellido, nombre, pasaporte, fecha_nacimiento, domicilio, pais_id, telefono_movil, email) VALUES 
(DEFAULT, 'Palermo Díaz', 'Ricardo Omar', '28001555', '1980-01-05', 'Av. Sarmiento 752 este', 1, '+542645667714', 'pal1980sj@gmail.com');

-- 20. Eliminar el registro del servicio básico número 5
DELETE FROM habitacion_x_servicio_basico WHERE servicio_basico_id = 5;
DELETE FROM servicio_basico WHERE id = 5;